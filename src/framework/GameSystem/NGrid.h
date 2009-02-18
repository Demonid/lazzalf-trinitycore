/*
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 *
 * Copyright (C) 2008-2009 Trinity <http://www.trinitycore.org/>
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
 */

#ifndef TRINITY_NGRID_H
#define TRINITY_NGRID_H

/** NGrid is nothing more than a wrapper of the Grid with an NxN cells
 */

#include "GameSystem/Grid.h"
#include "GameSystem/GridReference.h"
#include "Timer.h"

class GridInfo
{
public:
    GridInfo() : i_timer(0) {}
    GridInfo(time_t expiry, bool unload = true ) : i_timer(expiry), i_unloadflag(unload) {}
    const TimeTracker& getTimeTracker() const { return i_timer; }
    bool getUnloadFlag() const { return i_unloadflag; }
    void setUnloadFlag( bool pFlag) { i_unloadflag = pFlag; }
    void setTimer(const TimeTracker& pTimer) { i_timer = pTimer; }
    void ResetTimeTracker(time_t interval) { i_timer.Reset(interval); }
    void UpdateTimeTracker(time_t diff) { i_timer.Update(diff); }

private:
    TimeTracker i_timer;
    bool i_unloadflag;
};

typedef enum
{
    GRID_STATE_INVALID = 0,
    GRID_STATE_ACTIVE = 1,
    GRID_STATE_IDLE = 2,
    GRID_STATE_REMOVAL= 3,
    MAX_GRID_STATE = 4
} grid_state_t;

template
<
unsigned int N,
class ACTIVE_OBJECT,
class WORLD_OBJECT_TYPES,
class GRID_OBJECT_TYPES,
class ThreadModel = Trinity::SingleThreaded<ACTIVE_OBJECT>
>
class TRINITY_DLL_DECL NGrid
{
    public:

        typedef Grid<ACTIVE_OBJECT, WORLD_OBJECT_TYPES, GRID_OBJECT_TYPES, ThreadModel> GridType;
        NGrid(uint32 id, int32 x, int32 y, time_t expiry, bool unload = true) :
            i_gridId(id), i_cellstate(GRID_STATE_INVALID), i_x(x), i_y(y), i_GridObjectDataLoaded(false)
            {
                i_GridInfo = GridInfo(expiry, unload);
            }

        const GridType& operator()(unsigned short x, unsigned short y) const { return i_cells[x][y]; }
        GridType& operator()(unsigned short x, unsigned short y) { return i_cells[x][y]; }

        const uint32& GetGridId(void) const { return i_gridId; }
        void SetGridId(const uint32 id) const { i_gridId = id; }
        grid_state_t GetGridState(void) const { return i_cellstate; }
        void SetGridState(grid_state_t s) { i_cellstate = s; }
        int32 getX() const { return i_x; }
        int32 getY() const { return i_y; }

        void link(GridRefManager<NGrid<N, ACTIVE_OBJECT, WORLD_OBJECT_TYPES, GRID_OBJECT_TYPES, ThreadModel> >* pTo)
        {
            i_Reference.link(pTo, this);
        }
        bool isGridObjectDataLoaded() const { return i_GridObjectDataLoaded; }
        void setGridObjectDataLoaded(bool pLoaded) { i_GridObjectDataLoaded = pLoaded; }

        GridInfo* getGridInfoRef() { return &i_GridInfo; }
        const TimeTracker& getTimeTracker() const { return i_GridInfo.getTimeTracker(); }
        bool getUnloadFlag() const { return i_GridInfo.getUnloadFlag(); }
        void setUnloadFlag( bool pFlag) { i_GridInfo.setUnloadFlag(pFlag); }
        void ResetTimeTracker(time_t interval) { i_GridInfo.ResetTimeTracker(interval); }
        void UpdateTimeTracker(time_t diff) { i_GridInfo.UpdateTimeTracker(diff); }

        template<class SPECIFIC_OBJECT> void AddWorldObject(const uint32 x, const uint32 y, SPECIFIC_OBJECT *obj, OBJECT_HANDLE hdl)
        {
            i_cells[x][y].AddWorldObject(obj, hdl);
        }

        template<class SPECIFIC_OBJECT> void RemoveWorldObject(const uint32 x, const uint32 y, SPECIFIC_OBJECT *obj, OBJECT_HANDLE hdl)
        {
            i_cells[x][y].RemoveWorldObject(obj, hdl);
        }

        template<class T, class TT> void Visit(TypeContainerVisitor<T, TypeMapContainer<TT> > &visitor)
        {
            for(unsigned int x=0; x < N; ++x)
                for(unsigned int y=0; y < N; ++y)
                    i_cells[x][y].Visit(visitor);
        }

        template<class T, class TT> void Visit(const uint32 &x, const uint32 &y, TypeContainerVisitor<T, TypeMapContainer<TT> > &visitor)
        {
            i_cells[x][y].Visit(visitor);
        }

        unsigned int ActiveObjectsInGrid(void) const
        {
            unsigned int count=0;
            for(unsigned int x=0; x < N; ++x)
                for(unsigned int y=0; y < N; ++y)
                    count += i_cells[x][y].ActiveObjectsInGrid();
            return count;
        }

        template<class SPECIFIC_OBJECT> const SPECIFIC_OBJECT* GetGridObject(const uint32 x, const uint32 y, OBJECT_HANDLE hdl) const
        {
            return i_cells[x][y].template GetGridObject<SPECIFIC_OBJECT>(hdl);
        }

        template<class SPECIFIC_OBJECT> SPECIFIC_OBJECT* GetGridObject(const uint32 x, const uint32 y, OBJECT_HANDLE hdl)
        {
            return i_cells[x][y].template GetGridObject<SPECIFIC_OBJECT>(hdl);
        }

        template<class SPECIFIC_OBJECT> bool AddGridObject(const uint32 x, const uint32 y, SPECIFIC_OBJECT *obj, OBJECT_HANDLE hdl)
        {
            return i_cells[x][y].AddGridObject(hdl, obj);
        }

        template<class SPECIFIC_OBJECT> bool RemoveGridObject(const uint32 x, const uint32 y, SPECIFIC_OBJECT *obj, OBJECT_HANDLE hdl)
        {
            return i_cells[x][y].RemoveGridObject(obj, hdl);
        }

    private:

        uint32 i_gridId;
        GridInfo i_GridInfo;
        GridReference<NGrid<N, ACTIVE_OBJECT, WORLD_OBJECT_TYPES, GRID_OBJECT_TYPES, ThreadModel> > i_Reference;
        int32 i_x;
        int32 i_y;
        grid_state_t i_cellstate;
        GridType i_cells[N][N];
        bool i_GridObjectDataLoaded;
};
#endif

