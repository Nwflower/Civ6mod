--  FILE: CIVILIZATION_GUMOON_Script.lua
--  VERSION: 1
--  Author: Nwflower
--  Spicial Thanks: Uni
--  Copyright (c) 2025.
--      All rights reserved.
--  DateCreated: 2025/9/24 19:28:22

include('NwflowerMODCore')

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

function initialize()
    GameEvents.EarthEngineer_CreateResource.Add(EarthEngineer_CreateResource);
end

Events.LoadScreenClose.Add(initialize);
include('CIVILIZATION_GUMOON_Script_',true);
print('CIVILIZATION_GUMOON_Script Loaded Success.')