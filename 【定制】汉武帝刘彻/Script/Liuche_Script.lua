--  FILE: Liuche_Script.lua
--  VERSION: 1
--  Author: Nwflower
--  Spicial Thanks: Uni
--  Copyright (c) 2025.
--      All rights reserved.
--  DateCreated: 2025/9/9 21:08:06

include('NwflowerMODCore')

-- ===========================================================================
local HanCombat = Game.GetProperty('NwHanCombat') or {}

function HasTrait_Property(sTrait, iPlayer)
	local pPlayer = Players[iPlayer];
	if pPlayer then
		local ePro = pPlayer:GetProperty('PROPERTY_'..sTrait) or 0
		if ePro > 0 then
			return true
		end
	end
	return false
end


function onCombat(pCombatResult)
	-- 攻击者
	local attacker = pCombatResult[CombatResultParameters.ATTACKER]
	local attInfo = attacker[CombatResultParameters.ID]
	local attUnit = UnitManager.GetUnit(attInfo.player, attInfo.id)
	local attDamage = attacker[CombatResultParameters.DAMAGE_TO]
	-- 防御者
	local defender = pCombatResult[CombatResultParameters.DEFENDER]
	local defInfo = defender[CombatResultParameters.ID]
	local defUnit = UnitManager.GetUnit(defInfo.player, defInfo.id)
	local defDamage = defender[CombatResultParameters.DAMAGE_TO]

	-- 击败后+1移动力
	if HasTrait_Property('TRAIT_LEADER_MUST_KILL', attInfo.player) and attUnit and ( not attUnit:GetProperty("HasKilled")) then
		if (not defUnit) or defUnit:GetDamage() >= 100 then
			attUnit:ChangeExtraMoves(1)
			attUnit:SetProperty("HasKilled",true)
		end
	end
	if HasTrait_Property('TRAIT_LEADER_MUST_KILL', defInfo.player) and defUnit and ( not defUnit:GetProperty("HasKilled")) then
		if (not attUnit) or attUnit:GetDamage() >= 100 then
			defUnit:ChangeExtraMoves(1)
			defUnit:SetProperty("HasKilled",true)
		end
	end

	if HanCombat[defInfo.player] and HanCombat[defInfo.player][attInfo.player] then
		attUnit:ChangeDamage(2);
	end
	if HanCombat[attInfo.player] and HanCombat[attInfo.player][defInfo.player] then
		defUnit:ChangeDamage(2);
	end

	-- 额外2伤害
	if HasTrait_Property('TRAIT_LEADER_MUST_KILL', defInfo.player) and defUnit and defUnit:GetDamage() >= 100 and (not HanCombat[defInfo.player][attInfo.player]) then
		HanCombat[defInfo.player][attInfo.player] = true;
		print('HanCombat',defInfo.player,attInfo.player)
		Game.SetProperty('NwHanCombat', HanCombat);
	end
	if HasTrait_Property('TRAIT_LEADER_MUST_KILL', attInfo.player) and attUnit and attUnit:GetDamage() >= 100 and (not HanCombat[attInfo.player][defInfo.player]) then
		HanCombat[attInfo.player][defInfo.player] = true;
		Game.SetProperty('NwHanCombat', HanCombat);
		print('HanCombat',attInfo.player,defInfo.player)
	end

end

function initialize()
	if not HanCombat or #HanCombat == 0 then
		local iPlayers = PlayerManager.GetAliveMajorIDs()
		for _, iPlayer in ipairs(iPlayers) do
			HanCombat[iPlayer] = {}
		end
		Game.SetProperty('NwHanCombat', HanCombat)
	end

    Events.Combat.Add(onCombat)
end

Events.LoadScreenClose.Add(initialize);
include('Liuche_Script_',true);
print('Liuche_Script Loaded Success.')