--  FILE: NL_Script.lua
--  VERSION: 1
--  Author: Nwflower
--  Spicial Thanks: Uni
--  Copyright (c) 2025.
--      All rights reserved.
--  DateCreated: 2025/10/6 11:26:46

include('NwflowerMODCore')

-- ===========================================================================

-- 小七
function OnCivicCompleted(iPlayer,iCivic,bCancelled)
	local XIAOQIHasCreated = Game.GetProperty("XIAOQIHasCreated") or 0
	if Players[iPlayer]:GetProperty('PROPERTY_TRAIT_CIVILIZATION_MILKD_NW251006') and iCivic == GameInfo.Civics['CIVIC_CODE_OF_LAWS'].Index and XIAOQIHasCreated == 0 then
		print('XIAOQIHasCreated',XIAOQIHasCreated)
		local individual = GameInfo.GreatPersonIndividuals['GREAT_PERSON_INDIVIDUAL_XIAOQI_0'].Hash;
		local class = GameInfo.GreatPersonClasses["GREAT_PERSON_CLASS_XIAOQI"].Hash;
		local era = GameInfo.Eras["ERA_ANCIENT"].Hash;
		local cost = 0;
	    Game.GetGreatPeople():GrantPerson(individual, class, era, cost, iPlayer, false);
        Game.SetProperty("XIAOQIHasCreated", 1)
	end
end

function NaiLongPP(iPlayer, Param)
    local NumReligion = Param.NumReligion
	print('NaiLongPP:信仰奶龙宗教的外国城市数量：', NumReligion)
    local pPlayer = Players[iPlayer]
    pPlayer:SetProperty("NL_PP", NumReligion)
	for i, unit in pPlayer:GetUnits():Members() do
		local unitInfo = GameInfo.Units[unit:GetType()];
    	local unitTypeName = unitInfo.UnitType;
        if unitTypeName == "UNIT_QZJ_NLDD" then
            unit:SetProperty("ABILITY_UNIT_QZJ_NLDD", math.floor(NumReligion/2))
            break
        end
	end
	if NumReligion >= 5 then
		NaiLongBT(iPlayer,  {
			OnStart = 'NaiLongBT',
			NumReligion = NumReligion
		})
	end
end

function NaiLongBT(iPlayer, Param)
    local NumReligion = Param.NumReligion
    local pPlayer = Players[iPlayer]
	local pCity = pPlayer:GetCities():GetCapitalCity()
	if not pCity then return end
	print('NaiLongBT:信仰奶龙宗教的外国城市数量：', NumReligion)
	if NumReligion >= 5 then
		pCity:GetBuildQueue():CreateBuilding(GameInfo.Buildings['BUILDING_5_CITY_FOLLOWS_NL_RELIGION'].Index)
	elseif NumReligion >= 12 then
		pCity:GetBuildQueue():CreateBuilding(GameInfo.Buildings['BUILDING_12_CITY_FOLLOWS_NL_RELIGION'].Index)
	end
end

function Nw_NL_GetDamage(iPlayer, Params)
	local pUnit = UnitManager.GetUnit(iPlayer, Params.iUnit);
    pUnit:ChangeDamage(-50)
end


function initialize()
    Events.CivicCompleted.Add( OnCivicCompleted );
    GameEvents.NaiLongPP.Add(NaiLongPP);
	GameEvents.Nw_NL_GetDamage.Add(Nw_NL_GetDamage)
end

Events.LoadScreenClose.Add(initialize);
include('NL_Script_',true);
print('NL_Script Loaded Success.')