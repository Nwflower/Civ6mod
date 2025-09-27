local TYPE_U0007_2 = "UNIT_SIQI_U0007_2" -- 特拉达帆船
local TYPE_VAMPIRE = "UNIT_VAMPIRE"

function SiqiU0007_2_OnKilledInCombat(Units)
    -- local Units = params.Units or {}
    if not Units or #Units <= 0 then return; end
    for i, pUnit in ipairs(Units) do
        local maxDamage = pUnit:GetMaxDamage()
        local nowDamge = pUnit:GetDamage()
        local UnitInfo = GameInfo.Units[pUnit:GetType()];     
        if nowDamge + 10 >= maxDamage then
            if UnitInfo and UnitInfo.UnitType ~= TYPE_VAMPIRE then
                UnitManager.Kill(pUnit)
            else
                pUnit:SetDamage(99)
            end
        else
            if UnitInfo and UnitInfo.Domain ~= "DOMAIN_AIR" then
                pUnit:ChangeDamage(10)
            end
        end
    end
end




function Siqi_FindUnitEnemy(iX, iY)
    local unittable = {}
    for iDirection = 0, 5 do
        local pPlot = Map.GetAdjacentPlot(iX, iY, iDirection)
        for loop, unit in ipairs(Units.GetUnitsInPlot(pPlot)) do
            table.insert(unittable, unit)
        end
    end
    return unittable
end

function SiqiOnUnitKilledInCombat(iX, iY)
    local Units = Siqi_FindUnitEnemy(iX, iY)
    if #Units <= 0 then return; end
    SiqiU0007_2_OnKilledInCombat(Units) -- 执行脚本
end 

function SiqiOnCombat(pCombatResult)
    --攻击者
	local attacker = pCombatResult[CombatResultParameters.ATTACKER]
	local attInfo = attacker[CombatResultParameters.ID]
	local attUnit = UnitManager.GetUnit(attInfo.player, attInfo.id)
	--防御者
	local defender = pCombatResult[CombatResultParameters.DEFENDER]
	local defInfo = defender[CombatResultParameters.ID]
	local defUnit = UnitManager.GetUnit(defInfo.player, defInfo.id)

    if attUnit then
        local maxDamage = attUnit:GetMaxDamage() or 100
        local nowDamge = attUnit:GetDamage() or 0
        local UnitInfo = GameInfo.Units[attUnit:GetType()];
        local xy = attacker[CombatResultParameters.LOCATION]
        if nowDamge >= maxDamage and UnitInfo and UnitInfo.UnitType == TYPE_U0007_2 then
            SiqiOnUnitKilledInCombat(xy.x, xy.y)
        end
    end
    if defUnit then
        local maxDamage = defUnit:GetMaxDamage() or 100
        local nowDamge = defUnit:GetDamage() or 0
        local UnitInfo = GameInfo.Units[defUnit:GetType()];
        local xy = defender[CombatResultParameters.LOCATION]
        if nowDamge >= maxDamage and UnitInfo and UnitInfo.UnitType == TYPE_U0007_2 then
            SiqiOnUnitKilledInCombat(xy.x, xy.y)
        end
    end
end

function Initialize()
    -- GameEvents.SiqiU0007_2_OnKilledInCombat.Add(SiqiU0007_2_OnKilledInCombat)
    -- Events.UnitKilledInCombat.Add(SiqiOnUnitKilledInCombat)
    Events.Combat.Add( SiqiOnCombat )
end

Events.LoadGameViewStateDone.Add(Initialize)

