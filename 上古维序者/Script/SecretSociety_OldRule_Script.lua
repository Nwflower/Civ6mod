--  FILE: SecretSociety_OldRule_Script.lua
--  VERSION: 1
--  Author: Nwflower
--  Spicial Thanks: Uni
--  Copyright (c) 2025.
--  All rights reserved.
--  DateCreated: 2025/7/3 11:22:01
-- ===========================================================================
function EarthEngineer_CreateResource(iPlayer, Param)
	local pPlayer = Players[iPlayer]
	local pPlot = Map.GetPlot(Param.iX,Param.iY)
	local pUnit = UnitManager.GetUnit(iPlayer,Param.iUnit)

    if GameInfo.Resources[Param.ResourceType] and ResourceBuilder.CanHaveResource(pPlot,GameInfo.Resources[Param.ResourceType].Index) then
        ResourceBuilder.SetResourceType(pPlot, GameInfo.Resources[Param.ResourceType].Index, 1)
        pUnit:ChangeActionCharges(-1)
        UnitManager.FinishMoves(pUnit)
        if pUnit:IsDelayedDeath() or pUnit:GetActionCharges() <= 0 then
            UnitManager.Kill(pUnit)
        end
    else
		local messageData = {
			MessageType = 0;
			MessageText = Locale.Lookup('LOC_NW_SSO_RESOURCE_DISABLED');
			PlotX = Param.iX;
			PlotY = Param.iY;
			Visibility = RevealedState.VISIBLE;
		}
		Game.AddWorldViewText(messageData);
    end
end

function EarthEngineer_AddProduction(iPlayer, Param)
	local pCity = Players[iPlayer]:GetCities():FindID(Param.iCity);
	local pUnit = UnitManager.GetUnit(iPlayer,Param.iUnit)
    pCity:GetBuildQueue():AddProgress(Param.Production);
    pUnit:ChangeActionCharges(-1)
    UnitManager.FinishMoves(pUnit)
    if pUnit:IsDelayedDeath() or pUnit:GetActionCharges() <= 0 then
        UnitManager.Kill(pUnit)
    end
end

function OldRule_BuildingCompleted(iPlayer, Param)
    local pPlayer = Players[iPlayer]
    pPlayer:GetCulture():TriggerBoost(Param.iC, 1);
end


function initialize()
    GameEvents.OldRule_BuildingCompleted.Add(OldRule_BuildingCompleted)
    GameEvents.EarthEngineer_CreateResource.Add(EarthEngineer_CreateResource);
    GameEvents.EarthEngineer_AddProduction.Add(EarthEngineer_AddProduction);
end

Events.LoadScreenClose.Add(initialize);
include('SecretSociety_OldRule_Script_',true);
print('SecretSociety_OldRule_Script Loaded Success.')