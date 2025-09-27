
-- local TYPE_U0007_2 = "UNIT_SIQI_U0007_2" -- 特拉达帆船

-- function SiqiOnUnitKilledInCombat(killedPlayerID, killedUnitID, playerID, unitID)
--     print("战斗中单位被击杀了喵~：", killedPlayerID, killedUnitID, playerID, unitID)
--     local pKilledUnit = UnitManager.GetUnit(killedPlayerID, killedUnitID)
--     if not pKilledUnit then return; end
--     local unitInfo = GameInfo.Units[pKilledUnit:GetType()];
--     if not unitInfo or unitInfo.UnitType ~= TYPE_U0007_2 then return; end
--     local Units = {}
--     local iX, iY = pKilledUnit:GetX(), pKilledUnit:GetY()
--     -- local kplot = Map.GetNeighborPlots(iX, iY, 1)
--     -- for i, plot in ipairs(kplot) do
--     --     for loop, unit in ipairs(Units.GetUnitsInPlot(plot)) do
--     --         table.insert(Units, {playerID = unit:GetOwner(), unitID = unit:GetID()})
--     --     end
--     -- end
--     for iDirection = 0, 5 do
--         local pPlot = Map.GetAdjacentPlot(iX, iY, iDirection)
--         for loop, unit in ipairs(Units.GetUnitsInPlot(pPlot)) do
--              table.insert(Units, {playerID = unit:GetOwner(), unitID = unit:GetID()})
--         end
--     end
--     print("位置是：", iX, iY, "附近单位数量：", #Units)
--     if #Units <= 0 then return; end
--     UI.RequestPlayerOperation(playerID, PlayerOperations.EXECUTE_SCRIPT, {OnStart = 'SiqiU0007_2_OnKilledInCombat',
--         Units = Units
--     }) -- 请求执行脚本
-- end 

-- function SiqiOnCombat(pCombatResult)
--     --攻击者
-- 	local attacker = pCombatResult[CombatResultParameters.ATTACKER]
-- 	local attInfo = attacker[CombatResultParameters.ID]
-- 	local attUnit = UnitManager.GetUnit(attInfo.player, attInfo.id)
-- 	--防御者
-- 	local defender = pCombatResult[CombatResultParameters.DEFENDER]
-- 	local defInfo = defender[CombatResultParameters.ID]
-- 	local defUnit = UnitManager.GetUnit(defInfo.player, defInfo.id)

--     if attUnit then
--         local maxDamage = attUnit:GetMaxDamage() or 100
--         local nowDamge = attUnit:GetDamage() or 0
--         local UnitInfo = GameInfo.Units[attUnit:GetType()];
--         if nowDamge >= maxDamage and UnitInfo and UnitInfo.UnitType == TYPE_U0007_2 then
--             SiqiOnUnitKilledInCombat(attUnit:GetX(), attUnit:GetY(), attUnit:GetOwner())
--         end
--     end
--     if defUnit then
--         local maxDamage = defUnit:GetMaxDamage() or 100
--         local nowDamge = defUnit:GetDamage() or 0
--         local UnitInfo = GameInfo.Units[defUnit:GetType()];
--         if nowDamge >= maxDamage and UnitInfo and UnitInfo.UnitType == TYPE_U0007_2 then
--             SiqiOnUnitKilledInCombat(defUnit:GetX(), defUnit:GetY(), defUnit:GetOwner())
--         end
--     end
-- end



-- function Initialize()
--     --print("Siqi_Leaders_0007_UI.lua 启动了喵~")
--     -- Events.Combat.Add( SiqiOnCombat )
--     --Events.UnitKilledInCombat.Add(SiqiOnUnitKilledInCombat)
-- end

-- Events.LoadGameViewStateDone.Add(Initialize)
