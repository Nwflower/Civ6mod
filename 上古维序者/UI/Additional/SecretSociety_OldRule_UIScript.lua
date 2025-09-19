--  FILE: SecretSociety_OldRule_UIScript.lua
--  VERSION: 1
--  Author: Nwflower
--  Spicial Thanks: Uni
--  Copyright (c) 2025.
--  All rights reserved.
--  DateCreated: 2025/7/3 11:22:01
-- ===========================================================================


function OldRule_BuildingCompleted(iPlayer, iCity, Order, iType, bCanceled)
	if iPlayer ~= Game.GetLocalPlayer() then return end
    local pPlayer = Players[iPlayer]
    local pPlayerCulture = pPlayer:GetCulture()
    -- Order:0单位 1建筑 2区域
    if iType == GameInfo.Buildings['BUILDING_BIOLOGY_MUSEUM'].Index and Order == 1 then
        local civics = {}
        table.insert(civics,GameInfo.Civics['CIVIC_MEDIEVAL_FAIRES'].Index)
        table.insert(civics,GameInfo.Civics['CIVIC_HUMANISM'].Index)
        table.insert(civics,GameInfo.Civics['CIVIC_MERCANTILISM'].Index)
        table.insert(civics,GameInfo.Civics['CIVIC_COLONIALISM'].Index)
        table.insert(civics,GameInfo.Civics['CIVIC_NATURAL_HISTORY'].Index)
        for _,iCivic in ipairs(civics) do
            if (not pPlayerCulture:HasBoostBeenTriggered(iCivic)) then
                UI.RequestPlayerOperation(Game.GetLocalPlayer(), PlayerOperations.EXECUTE_SCRIPT, {
                    OnStart = 'OldRule_BuildingCompleted',
                    iC = iCivic,
                })
            end
        end
    end
end

function initialize()
    Events.CityProductionCompleted.Add(OldRule_BuildingCompleted)
end

Events.LoadScreenClose.Add(initialize);
include('SecretSociety_OldRule_UIScript_',true);
print('SecretSociety_OldRule_UIScript Loaded Success.')