-- Penacony_Script
-- Author: Nwflower
-- DateCreated: 2025-5-12 21:51:26
--------------------------------------------------------------
--||=======================include========================||--
include('SardinianPath')

local CityIDs = {}

-- 本地监听自己的事件然后UI发起Request指令，确保同步
function onUIUnitGreatPersonActivated(iPlayer, iUnit, iGPClass, iIndividual)
    if iPlayer ~= Game.GetLocalPlayer() then return end
    local pUnit = UnitManager.GetUnit(iPlayer, iUnit)
    if pUnit then
        local x, y = pUnit:GetX(), pUnit:GetY()
        local pCity = Cities.GetPlotPurchaseCity(Map.GetPlot(x, y))
        if pCity == nil then
            print('监听到伟人在中立领土单元格上激活')
        end
        local extraParam;
        if GameInfo.GreatPersonIndividuals['GREAT_PERSON_INDIVIDUAL_NW_ENGINEER_INDUSTRIAL_1'] and iIndividual == GameInfo.GreatPersonIndividuals['GREAT_PERSON_INDIVIDUAL_NW_ENGINEER_INDUSTRIAL_1'].Index then
            extraParam = GetRoutePlots(iPlayer, pCity, iGPClass, iIndividual,x, y)
        end
        if GameInfo.GreatPersonIndividuals['GREAT_PERSON_INDIVIDUAL_NW_ENGINEER_INDUSTRIAL_2'] and iIndividual == GameInfo.GreatPersonIndividuals['GREAT_PERSON_INDIVIDUAL_NW_ENGINEER_INDUSTRIAL_2'].Index then
            table.insert(CityIDs,pCity:GetID())
            print('添加了城市',pCity:GetID())
            Events.PlayerTurnActivated.Add(onPlayerTurnActivated)
        end
        UI.RequestPlayerOperation(Game.GetLocalPlayer(),
            PlayerOperations.EXECUTE_SCRIPT, {
                iCity = pCity and pCity:GetID() or -1,
                iGPClass = iGPClass,
                iIndividual = iIndividual,
                iX = x,
                iY = y,
                extraParam = extraParam,
                OnStart = 'Nw_TPMG_GreatPersonActivated'
            }
        );
        Network.BroadcastPlayerInfo();
    end
end

-- 詹天佑
function GetRoutePlots(iPlayer, pCity, iGPClass, iIndividual,x, y)
    local pPlayer = Players[iPlayer]
    local playerCities = pPlayer:GetCities()
    local pCapital = playerCities:GetCapitalCity()
    if not pCapital or not pCity then return {} end
    if pCapital == pCity then return {} end

    local plots = {}
    local cX, cY = pCapital:GetX(), pCapital:GetY()
    local tx, ty = pCity:GetX(), pCity:GetY()
    local path = SardinianPath:AStar(cX, cY, tx, ty, iPlayer)
    for _, plotIndex in ipairs(path) do
        local plot = Map.GetPlotByIndex(plotIndex)
        local currentRouteType = plot:GetRouteType()
        if currentRouteType == -1 or GameInfo.Routes['ROUTE_RAILROAD'].PlacementValue > GameInfo.Routes[currentRouteType].PlacementValue then
            table.insert(plots, plotIndex)
        end
    end
    if #plots > 0 then
        return plots, { pCity:GetName(), pCapital:GetName() }
    end
    return {}
end

-- 法拉第：15回合监听
function onPlayerTurnActivated(iPlayer, bIsFirstTime)
    if iPlayer ~= Game.GetLocalPlayer() then return end
    if not bIsFirstTime then return end
    if not CityIDs then return end
    local pPlayer = Players[iPlayer]
    local NowTurn = Game.GetCurrentGameTurn()
    for _,iCity in ipairs(CityIDs) do
        local pCity = pPlayer:GetCities():FindID(iCity)
        local OldTurn = pCity:GetProperty('FALADI_POWER_START') or 9999;
        if OldTurn + 15 <= NowTurn then
            UI.RequestPlayerOperation(Game.GetLocalPlayer(),
                PlayerOperations.EXECUTE_SCRIPT, {
                    iCity = iCity,
                    OnStart = 'FaladiTurnEnd'
                }
            );
            Network.BroadcastPlayerInfo();
            for i = #CityIDs, 1, -1 do
                if CityIDs[i] == iCity then
                    table.remove(CityIDs, i)
                end
            end
            if #CityIDs == 0 then
                Events.PlayerTurnActivated.Remove(onPlayerTurnActivated)
            end
        end
    end
end

-- =====================================================================
-- INIT
-- =====================================================================

Events.UnitGreatPersonActivated.Add(onUIUnitGreatPersonActivated)
print('onUIUnitGreatPersonActivated Succussful')