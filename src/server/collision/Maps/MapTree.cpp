/*
 * Copyright (C) 2005-2010 MaNGOS <http://getmangos.com/>
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 */

#include "MapTree.h"
#include "ModelInstance.h"
#include "VMapManager2.h"
#include "VMapDefinitions.h"
#include "Log.h"

#include <string>
#include <sstream>
#include <iomanip>
#include <limits>

#ifndef NO_CORE_FUNCS
    #include "Errors.h"
#else
    #define ASSERT(x)
#endif

using G3D::Vector3;

namespace VMAP
{

    class MapRayCallback
    {
        public:
            MapRayCallback(ModelInstance *val): prims(val) {}
            ModelInstance *prims;
            bool operator()(const G3D::Ray& ray, uint32 entry, float& distance, bool pStopAtFirstHit=true)
            {
                return prims[entry].intersectRay(ray, distance, pStopAtFirstHit);
                //std::cout << "trying to intersect '" << entity->name << "'\n";
            }
    };

    class AreaInfoCallback
    {
        public:
            AreaInfoCallback(ModelInstance *val): prims(val) {}
            void operator()(const Vector3& point, uint32 entry)
            {
#ifdef VMAP_DEBUG
                sLog.outDebug("trying to intersect '%s'", prims[entry].name.c_str());
#endif
                prims[entry].intersectPoint(point, aInfo);
            }

            ModelInstance *prims;
            AreaInfo aInfo;
    };

    class LocationInfoCallback
    {
        public:
            LocationInfoCallback(ModelInstance *val, LocationInfo &info): prims(val), locInfo(info), result(false) {}
            void operator()(const Vector3& point, uint32 entry)
            {
#ifdef VMAP_DEBUG
                sLog.outDebug("trying to intersect '%s'", prims[entry].name.c_str());
#endif
                if (prims[entry].GetLocationInfo(point, locInfo))
                    result = true;
            }

            ModelInstance *prims;
            LocationInfo &locInfo;
            bool result;
    };


    //=========================================================

    std::string StaticMapTree::getTileFileName(uint32 mapID, uint32 tileX, uint32 tileY)
    {
        std::stringstream tilefilename;
        tilefilename.fill('0');
        tilefilename << std::setw(3) << mapID << "_";
        //tilefilename << std::setw(2) << tileX << "_" << std::setw(2) << tileY << ".vmtile";
        tilefilename << std::setw(2) << tileY << "_" << std::setw(2) << tileX << ".vmtile";
        return tilefilename.str();
    }

    bool StaticMapTree::getAreaInfo(Vector3 &pos, uint32 &flags, int32 &adtId, int32 &rootId, int32 &groupId) const
    {
        AreaInfoCallback intersectionCallBack(iTreeValues);
        iTree.intersectPoint(pos, intersectionCallBack);
        if (intersectionCallBack.aInfo.result)
        {
            flags = intersectionCallBack.aInfo.flags;
            adtId = intersectionCallBack.aInfo.adtId;
            rootId = intersectionCallBack.aInfo.rootId;
            groupId = intersectionCallBack.aInfo.groupId;
            pos.z = intersectionCallBack.aInfo.ground_Z;
            return true;
        }
        return false;
    }

    bool StaticMapTree::GetLocationInfo(const Vector3 &pos, LocationInfo &info) const
    {
        LocationInfoCallback intersectionCallBack(iTreeValues, info);
        iTree.intersectPoint(pos, intersectionCallBack);
        return intersectionCallBack.result;
    }

    StaticMapTree::StaticMapTree(uint32 mapID, const std::string &basePath):
        iMapID(mapID), /* iTree(0), */ iTreeValues(0), iBasePath(basePath)
    {
        if (iBasePath.length() > 0 && (iBasePath[iBasePath.length()-1] != '/' || iBasePath[iBasePath.length()-1] != '\\'))
        {
            iBasePath.append("/");
        }
    }

    //=========================================================
    //! Make sure to call unloadMap() to unregister acquired model references before destroying
    StaticMapTree::~StaticMapTree()
    {
        delete[] iTreeValues;
    }

    //=========================================================
    /**
    return dist to hit or inf() if no hit
    */

    float StaticMapTree::getIntersectionTime(const G3D::Ray& pRay, float pMaxDist, bool pStopAtFirstHit) const
    {
        float distance = pMaxDist;
        MapRayCallback intersectionCallBack(iTreeValues);
        iTree.intersectRay(pRay, intersectionCallBack, distance, pStopAtFirstHit);
        return distance;
    }
    //=========================================================

    bool StaticMapTree::isInLineOfSight(const Vector3& pos1, const Vector3& pos2) const
    {
        bool result = true;
        float maxDist = (pos2 - pos1).magnitude();
        // valid map coords should *never ever* produce float overflow, but this would produce NaNs too
        ASSERT(maxDist < std::numeric_limits<float>::max());
        // prevent NaN values which can cause BIH intersection to enter infinite loop
        if (maxDist < 1e-10f)
            return true;
        // direction with length of 1
        G3D::Ray ray = G3D::Ray::fromOriginAndDirection(pos1, (pos2 - pos1)/maxDist);
        float resultDist = getIntersectionTime(ray, maxDist, true);
        if (resultDist < maxDist)
        {
            result = false;
        }
        return result;
    }
    //=========================================================
    /**
    When moving from pos1 to pos2 check if we hit an object. Return true and the position if we hit one
    Return the hit pos or the original dest pos
    */

    bool StaticMapTree::getObjectHitPos(const Vector3& pPos1, const Vector3& pPos2, Vector3& pResultHitPos, float pModifyDist) const
    {
        bool result=false;
        float maxDist = (pPos2 - pPos1).magnitude();
        // valid map coords should *never ever* produce float overflow, but this would produce NaNs too
        ASSERT(maxDist < std::numeric_limits<float>::max());
        // prevent NaN values which can cause BIH intersection to enter infinite loop
        if (maxDist < 1e-10f)
        {
            pResultHitPos = pPos2;
            return false;
        }
        Vector3 dir = (pPos2 - pPos1)/maxDist;              // direction with length of 1
        G3D::Ray ray(pPos1, dir);
        float dist = getIntersectionTime(ray, maxDist, false);
        if (dist < maxDist)
        {
            pResultHitPos = pPos1 + dir * dist;
            if (pModifyDist < 0)
            {
                if ((pResultHitPos - pPos1).magnitude() > -pModifyDist)
                {
                    pResultHitPos = pResultHitPos + dir*pModifyDist;
                }
                else
                {
                    pResultHitPos = pPos1;
                }
            }
            else
            {
                pResultHitPos = pResultHitPos + dir*pModifyDist;
            }
            result = true;
        }
        else
        {
            pResultHitPos = pPos2;
            result = false;
        }
        return result;
    }

    //=========================================================

    float StaticMapTree::getHeight(const Vector3& pPos) const
    {
        float height = G3D::inf();
        Vector3 dir = Vector3(0,0,-1);
        G3D::Ray ray(pPos, dir);   // direction with length of 1
        float maxDist = VMapDefinitions::getMaxCanFallDistance();
        float dist = getIntersectionTime(ray, maxDist, false);
        if (dist < maxDist)
        {
            height = pPos.z - dist;
        }
        return(height);
    }

    //=========================================================

    bool StaticMapTree::CanLoadMap(const std::string &vmapPath, uint32 mapID, uint32 tileX, uint32 tileY)
    {
        std::string basePath = vmapPath;
        if (basePath.length() > 0 && (basePath[basePath.length()-1] != '/' || basePath[basePath.length()-1] != '\\'))
            basePath.append("/");
        std::string fullname = basePath + VMapManager2::getMapFileName(mapID);
        bool success = true;
        FILE *rf = fopen(fullname.c_str(), "rb");
        if (!rf)
            return false;
        // TODO: check magic number when implemented...
        char tiled;
        char chunk[8];
        if (!readChunk(rf, chunk, VMAP_MAGIC, 8) || fread(&tiled, sizeof(char), 1, rf) != 1)
        {
            fclose(rf);
            return false;
        }
        if (tiled)
        {
            std::string tilefile = basePath + getTileFileName(mapID, tileX, tileY);
            FILE* tf = fopen(tilefile.c_str(), "rb");
            if (!tf)
                success = false;
            else
                fclose(tf);
        }
        fclose(rf);
        return success;
    }

    //=========================================================

    bool StaticMapTree::InitMap(const std::string &fname, VMapManager2 *vm)
    {
        sLog.outDebug("Initializing StaticMapTree '%s'", fname.c_str());
        bool success = true;
        std::string fullname = iBasePath + fname;
        FILE *rf = fopen(fullname.c_str(), "rb");
        if (!rf)
            return false;
        else
        {
            char chunk[8];
            //general info
            if (!readChunk(rf, chunk, VMAP_MAGIC, 8)) success = false;
            char tiled;
            if (success && fread(&tiled, sizeof(char), 1, rf) != 1) success = false;
            iIsTiled = bool(tiled);
            // Nodes
            if (success && !readChunk(rf, chunk, "NODE", 4)) success = false;
            if (success) success = iTree.readFromFile(rf);
            if (success)
            {
                iNTreeValues = iTree.primCount();
                iTreeValues = new ModelInstance[iNTreeValues];
            }

            if (success && !readChunk(rf, chunk, "GOBJ", 4)) success = false;
            // global model spawns
            // only non-tiled maps have them, and if so exactly one (so far at least...)
            ModelSpawn spawn;
#ifdef VMAP_DEBUG
            sLog.outDebug("Map isTiled: %u", static_cast<uint32>(iIsTiled));
#endif
            if (!iIsTiled && ModelSpawn::readFromFile(rf, spawn))
            {
                WorldModel *model = vm->acquireModelInstance(iBasePath, spawn.name);
                sLog.outDebug("StaticMapTree::InitMap(): loading %s", spawn.name.c_str());
                if (model)
                {
                    // assume that global model always is the first and only tree value (could be improved...)
                    iTreeValues[0] = ModelInstance(spawn, model);
                    iLoadedSpawns[0] = 1;
                }
                else
                {
                    success = false;
                    sLog.outError("Could not acquire WorldModel pointer!");
                }
            }

            fclose(rf);
        }
        return success;
    }

    //=========================================================

    void StaticMapTree::UnloadMap(VMapManager2 *vm)
    {
        for (loadedSpawnMap::iterator i = iLoadedSpawns.begin(); i != iLoadedSpawns.end(); ++i)
        {
            iTreeValues[i->first].setUnloaded();
            for (uint32 refCount = 0; refCount < i->second; ++refCount)
                vm->releaseModelInstance(iTreeValues[i->first].name);
        }
        iLoadedSpawns.clear();
        iLoadedTiles.clear();
    }

    //=========================================================

    bool StaticMapTree::LoadMapTile(uint32 tileX, uint32 tileY, VMapManager2 *vm)
    {
        if (!iIsTiled)
        {
            // currently, core creates grids for all maps, whether it has terrain tiles or not
            // so we need "fake" tile loads to know when we can unload map geometry
            iLoadedTiles[packTileID(tileX, tileY)] = false;
            return true;
        }
        if (!iTreeValues)
        {
            sLog.outError("Tree has not been initialized! [%u,%u]", tileX, tileY);
            return false;
        }
        bool result = true;

        std::string tilefile = iBasePath + getTileFileName(iMapID, tileX, tileY);
        FILE* tf = fopen(tilefile.c_str(), "rb");
        if (tf)
        {
            uint32 numSpawns;
            if (fread(&numSpawns, sizeof(uint32), 1, tf) != 1)
                result = false;
            for (uint32 i=0; i<numSpawns && result; ++i)
            {
                // read model spawns
                ModelSpawn spawn;
                result = ModelSpawn::readFromFile(tf, spawn);
                if (result)
                {
                    // acquire model instance
                    WorldModel *model = vm->acquireModelInstance(iBasePath, spawn.name);
                    if (!model)
                        sLog.outError("error: could not acquire WorldModel pointer! [%u,%u]", tileX, tileY);

                    // update tree
                    uint32 referencedVal;

                    fread(&referencedVal, sizeof(uint32), 1, tf);
                    if (!iLoadedSpawns.count(referencedVal))
                    {
#ifdef VMAP_DEBUG
                        if (referencedVal > iNTreeValues)
                        {
                            sLog.outDebug("invalid tree element! (%u/%u)", referencedVal, iNTreeValues);
                            continue;
                        }
#endif
                        iTreeValues[referencedVal] = ModelInstance(spawn, model);
                        iLoadedSpawns[referencedVal] = 1;
                    }
                    else
                    {
                        ++iLoadedSpawns[referencedVal];
#ifdef VMAP_DEBUG
                        if (iTreeValues[referencedVal].ID != spawn.ID)
                            sLog.outDebug("error: trying to load wrong spawn in node!");
                        else if (iTreeValues[referencedVal].name != spawn.name)
                            sLog.outDebug("error: name collision on GUID=%u", spawn.ID);
#endif
                    }
                }
            }
            iLoadedTiles[packTileID(tileX, tileY)] = true;
            fclose(tf);
        }
        else
            iLoadedTiles[packTileID(tileX, tileY)] = false;
        return result;
    }

    //=========================================================

    void StaticMapTree::UnloadMapTile(uint32 tileX, uint32 tileY, VMapManager2 *vm)
    {
        uint32 tileID = packTileID(tileX, tileY);
        loadedTileMap::iterator tile = iLoadedTiles.find(tileID);
        if (tile == iLoadedTiles.end())
        {
            sLog.outError("WARNING: trying to unload non-loaded tile. Map:%u X:%u Y:%u", iMapID, tileX, tileY);
            return;
        }
        if (tile->second) // file associated with tile
        {
            std::string tilefile = iBasePath + getTileFileName(iMapID, tileX, tileY);
            FILE* tf = fopen(tilefile.c_str(), "rb");
            if (tf)
            {
                bool result=true;
                uint32 numSpawns;
                if (fread(&numSpawns, sizeof(uint32), 1, tf) != 1)
                    result = false;
                for (uint32 i=0; i<numSpawns && result; ++i)
                {
                    // read model spawns
                    ModelSpawn spawn;
                    result = ModelSpawn::readFromFile(tf, spawn);
                    if (result)
                    {
                        // release model instance
                        vm->releaseModelInstance(spawn.name);

                        // update tree
                        uint32 referencedNode;

                        fread(&referencedNode, sizeof(uint32), 1, tf);
                        if (!iLoadedSpawns.count(referencedNode))
                        {
                            sLog.outError("Trying to unload non-referenced model '%s' (ID:%u)", spawn.name.c_str(), spawn.ID);
                        }
                        else if (--iLoadedSpawns[referencedNode] == 0)
                        {
                            //std::cout << "MapTree: removing '" << spawn.name << "' from tree\n";
                            iTreeValues[referencedNode].setUnloaded();
                            iLoadedSpawns.erase(referencedNode);
                        }
                    }
                }
                fclose(tf);
            }
        }
        iLoadedTiles.erase(tile);
    }

}
