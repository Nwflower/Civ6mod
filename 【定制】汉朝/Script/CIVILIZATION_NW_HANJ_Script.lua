--  FILE: CIVILIZATION_NW_HANJ_Script.lua
--  VERSION: 1
--  Author: Nwflower
--  Spicial Thanks: Uni
--  Copyright (c) 2025.
--      All rights reserved.
--  DateCreated: 2025/9/15 18:21:35

include('NwflowerMODCore')

-- ===========================================================================


-- 大汉特色单位，替代骑士。若从附近的大将军获得提升，则进攻时有30%的概率不会消耗血量。
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

    -- 逻辑链：假如进攻者是骑士，且进攻者没死，那么有30%的概率回复这次消耗的血量
    -- 还要判断是否有大将军的能力...
    if GameInfo.Units[attUnit:GetType()].UnitType == 'UNIT_NW_YULIN' and (not attUnit:IsDelayedDeath()) and attUnit:GetAbility():GetAbilityCount("ABILITY_GREAT_GENERAL_MOVEMENT") == 1 then
        if Game.GetRandNum(100) % 3 == 0 then
            attUnit:ChangeDamage(- defDamage)
        end
    end
end

function Nw_LC_GetDamage(iPlayer, Params)
	local pUnit = UnitManager.GetUnit(iPlayer, Params.iUnit);
    pUnit:ChangeDamage(-50)
end

function initialize()
    --Events.Combat.Add(onCombat)
	GameEvents.Nw_LC_GetDamage.Add(Nw_LC_GetDamage)
end

Events.LoadScreenClose.Add(initialize);
include('CIVILIZATION_NW_HANJ_Script_',true);
print('CIVILIZATION_NW_HANJ_Script Loaded Success.')