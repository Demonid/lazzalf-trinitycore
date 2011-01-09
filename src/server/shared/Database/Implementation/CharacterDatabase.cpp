/*
 * Copyright (C) 2008-2011 TrinityCore <http://www.trinitycore.org/>
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the
 * Free Software Foundation; either version 2 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include "CharacterDatabase.h"

bool CharacterDatabaseConnection::Open()
{
    if (!MySQLConnection::Open())
        return false;

    if (!m_reconnecting)
        m_stmts.resize(MAX_CHARACTERDATABASE_STATEMENTS);

    for (uint32 index = 0; index < MAX_CHARACTERDATABASE_STATEMENTS; ++index)
    {
        PreparedStatementTable const& pst = CharacterDatabasePreparedStatements[index];        
        PrepareStatement(pst.index, pst.query, pst.type);
    }
    PrepareStatement(CHAR_DEL_GUILD_GUILDHOUSE, "DELETE FROM gh_guildadd WHERE guildId = ?"); // 0: uint32

    m_statementTable = CharacterDatabasePreparedStatements;

    return true;
}
