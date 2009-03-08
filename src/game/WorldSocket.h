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
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 */

/** \addtogroup u2w User to World Communication
 * @{
 * \file WorldSocket.h
 * \author Derex <derex101@gmail.com>
 */

#ifndef _WORLDSOCKET_H
#define _WORLDSOCKET_H

#include <ace/Basic_Types.h>
#include <ace/Synch_Traits.h>
#include <ace/Svc_Handler.h>
#include <ace/SOCK_Stream.h>
#include <ace/SOCK_Acceptor.h>
#include <ace/Acceptor.h>
#include <ace/Thread_Mutex.h>
#include <ace/Guard_T.h>
#include <ace/Unbounded_Queue.h>
#include <ace/Message_Block.h>

#if !defined (ACE_LACKS_PRAGMA_ONCE)
#pragma once
#endif /* ACE_LACKS_PRAGMA_ONCE */

#include "Common.h"
#include "Auth/AuthCrypt.h"

class ACE_Message_Block;
class WorldPacket;
class WorldSession;

/// Handler that can communicate over stream sockets.
typedef ACE_Svc_Handler<ACE_SOCK_STREAM, ACE_NULL_SYNCH> WorldHandler;

/**
 * WorldSocket.
 *
 * This class is responsible for the communication with
 * remote clients.
 * Most methods return -1 on failure.
 * The class uses reference counting.
 *
 * For output the class uses one buffer (64K usually) and
 * a queue where it stores packet if there is no place on
 * the queue. The reason this is done, is because the server
 * does really a lot of small-size writes to it, and it doesn't
 * scale well to allocate memory for every. When something is
 * written to the output buffer the socket is not immediately
 * activated for output (again for the same reason), there
 * is 10ms celling (thats why there is Update() method).
 * This concept is similar to TCP_CORK, but TCP_CORK
 * uses 200ms celling. As result overhead generated by
 * sending packets from "producer" threads is minimal,
 * and doing a lot of writes with small size is tolerated.
 *
 * The calls to Update () method are managed by WorldSocketMgr
 * and ReactorRunnable.
 *
 * For input ,the class uses one 1024 bytes buffer on stack
 * to which it does recv() calls. And then received data is
 * distributed where its needed. 1024 matches pretty well the
 * traffic generated by client for now.
 *
 * The input/output do speculative reads/writes (AKA it tryes
 * to read all data available in the kernel buffer or tryes to
 * write everything available in userspace buffer),
 * which is ok for using with Level and Edge Triggered IO
 * notification.
 *
 */
class WorldSocket : protected WorldHandler
{
    public:
        /// Declare some friends
        friend class ACE_Acceptor< WorldSocket, ACE_SOCK_ACCEPTOR >;
        friend class WorldSocketMgr;
        friend class ReactorRunnable;

        /// Declare the acceptor for this class
        typedef ACE_Acceptor< WorldSocket, ACE_SOCK_ACCEPTOR > Acceptor;

        /// Mutex type used for various synchronizations.
        typedef ACE_Thread_Mutex LockType;
        typedef ACE_Guard<LockType> GuardType;

        /// Check if socket is closed.
        bool IsClosed (void) const;

        /// Close the socket.
        void CloseSocket (void);

        /// Get address of connected peer.
        const std::string& GetRemoteAddress (void) const;

        /// Send A packet on the socket, this function is reentrant.
        /// @param pct packet to send
        /// @return -1 of failure
        int SendPacket (const WorldPacket& pct);

        /// Add reference to this object.
        long AddReference (void);

        /// Remove reference to this object.
        long RemoveReference (void);

    protected:
        /// things called by ACE framework.
        WorldSocket (void);
        virtual ~WorldSocket (void);

        /// Called on open ,the void* is the acceptor.
        virtual int open (void *);

        /// Called on failures inside of the acceptor, don't call from your code.
        virtual int close (int);

        /// Called when we can read from the socket.
        virtual int handle_input (ACE_HANDLE = ACE_INVALID_HANDLE);

        /// Called when the socket can write.
        virtual int handle_output (ACE_HANDLE = ACE_INVALID_HANDLE);

        /// Called when connection is closed or error happens.
        virtual int handle_close (ACE_HANDLE = ACE_INVALID_HANDLE,
            ACE_Reactor_Mask = ACE_Event_Handler::ALL_EVENTS_MASK);

        /// Called by WorldSocketMgr/ReactorRunnable.
        int Update (void);

    private:
        /// Helper functions for processing incoming data.
        int handle_input_header (void);
        int handle_input_payload (void);
        int handle_input_missing_data (void);

        /// Help functions to mark/unmark the socket for output.
        /// @param g the guard is for m_OutBufferLock, the function will release it
        int cancel_wakeup_output (GuardType& g);
        int schedule_wakeup_output (GuardType& g);

        /// Drain the queue if its not empty.
        int handle_output_queue (GuardType& g);

        /// process one incoming packet.
        /// @param new_pct received packet ,note that you need to delete it.
        int ProcessIncoming (WorldPacket* new_pct);

        /// Called by ProcessIncoming() on CMSG_AUTH_SESSION.
        int HandleAuthSession (WorldPacket& recvPacket);

        /// Called by ProcessIncoming() on CMSG_PING.
        int HandlePing (WorldPacket& recvPacket);

    private:
        /// Time in which the last ping was received
        ACE_Time_Value m_LastPingTime;

        /// Keep track of over-speed pings ,to prevent ping flood.
        uint32 m_OverSpeedPings;

        /// Address of the remote peer
        std::string m_Address;

        /// Class used for managing encryption of the headers
        AuthCrypt m_Crypt;

        /// Mutex lock to protect m_Session
        LockType m_SessionLock;

        /// Session to which received packets are routed
        WorldSession* m_Session;

        /// here are stored the fragments of the received data
        WorldPacket* m_RecvWPct;

        /// This block actually refers to m_RecvWPct contents,
        /// which allows easy and safe writing to it.
        /// It wont free memory when its deleted. m_RecvWPct takes care of freeing.
        ACE_Message_Block m_RecvPct;

        /// Fragment of the received header.
        ACE_Message_Block m_Header;

        /// Mutex for protecting output related data.
        LockType m_OutBufferLock;

        /// Buffer used for writing output.
        ACE_Message_Block *m_OutBuffer;

        /// Size of the m_OutBuffer.
        size_t m_OutBufferSize;

        /// True if the socket is registered with the reactor for output
        bool m_OutActive;

        uint32 m_Seed;
};

#endif  /* _WORLDSOCKET_H */

/// @}

