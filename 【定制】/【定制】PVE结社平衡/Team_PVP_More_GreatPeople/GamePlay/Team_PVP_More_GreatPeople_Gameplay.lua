-- Penacony_Script
-- Author: Nwflower
-- DateCreated: 2025-5-12 21:51:26
--------------------------------------------------------------
--||=======================include========================||--

GreatPersonActivatedManager = {}


GreatPersonActivatedManager.Effect = {
    -- 大工程师
    GREAT_PERSON_CLASS_ENGINEER = {
        -- 李冰完成水利区域
        GREAT_PERSON_INDIVIDUAL_NW_ENGINEER_CLASSICAL_1 = function(iPlayer, iCity, iX, iY)
            local pPlayer = Players[iPlayer]
            local city = pPlayer:GetCities():FindID(iCity)
            if not city then return end

            local buildQueue = city:GetBuildQueue()
            if not buildQueue then return end

            local currentProduction = buildQueue:CurrentlyBuilding()
            if not currentProduction then return end

            -- 检查是否为水利区域
            local districtInfo = GameInfo.Districts[currentProduction];
            if not districtInfo then return end
            local NWDistrictInfo = GameInfo.DISTRICT_GREAT_PERSON_INDIVIDUAL_NW_ENGINEER_CLASSICAL_1[districtInfo.DistrictType];
            if not NWDistrictInfo then return end
            -- 立即完成建造
            buildQueue:FinishProgress()
            return true
        end,
        -- 25%奇观
        GREAT_PERSON_INDIVIDUAL_NW_ENGINEER_RENAISSANCE_1 = function(iPlayer, iCity, iX, iY)
            local pPlayer = Players[iPlayer]
            local city = pPlayer:GetCities():FindID(iCity)
            if not city then return end

            local buildQueue = city:GetBuildQueue()
            if not buildQueue then return end

            local currentProduction = buildQueue:CurrentlyBuilding()
            if not currentProduction then return end

            -- 检查是否为奇观
            local BuildingInfo = GameInfo.Buildings[currentProduction];
            if not BuildingInfo.IsWonder then return end
            local GAME_SPEED = GameConfiguration.GetGameSpeedType();
            local GAME_SPEED_MULTIPLIER = GameInfo.GameSpeeds[GAME_SPEED] and GameInfo.GameSpeeds[GAME_SPEED].CostMultiplier / 100 or 1;
            local ProductionNum = BuildingInfo.Cost * 0.25 * GAME_SPEED_MULTIPLIER

            local NWBuildingInfo = GameInfo.NW_TABLE_GREAT_PERSON_INDIVIDUAL_NW_ENGINEER_RENAISSANCE_1[BuildingInfo.BuildingType];
            if NWBuildingInfo then
                buildQueue:AddProgress(ProductionNum * 2);
            else
                buildQueue:AddProgress(ProductionNum);
            end
            return true
        end,
        -- 铁路连接首都
        GREAT_PERSON_INDIVIDUAL_NW_ENGINEER_INDUSTRIAL_1 = function(iPlayer, iCity, iX, iY,Plots)
            for _, plot in ipairs(Plots) do
                local pPlot = Map.GetPlotByIndex(plot)
                local currentRouteType = pPlot:GetRouteType()
                if currentRouteType == -1 or GameInfo.Routes['ROUTE_RAILROAD'].PlacementValue > GameInfo.Routes[currentRouteType].PlacementValue then
                    RouteBuilder.SetRouteType(plot, GameInfo.Routes['ROUTE_RAILROAD'].Index)
                end
            end
            return true
        end,
        -- 法拉第：记录回合数+建筑
        GREAT_PERSON_INDIVIDUAL_NW_ENGINEER_INDUSTRIAL_2 = function(iPlayer, iCity, iX, iY)
            local pPlayer = Players[iPlayer]
            local pCity = pPlayer:GetCities():FindID(iCity)
            local iBuilding = GameInfo.Buildings['BUILDING_GREAT_PERSON_INDIVIDUAL_NW_ENGINEER_INDUSTRIAL_2'].Index;
            if not (pCity:GetBuildings():HasBuilding(iBuilding)) then
                pCity:GetBuildQueue():CreateBuilding(iBuilding);
            end
            pCity:SetProperty('FALADI_POWER_START',Game.GetCurrentGameTurn())
            return true
        end,
        GREAT_PERSON_INDIVIDUAL_NW_ENGINEER_MODERN_1 = function(iPlayer, iCity, iX, iY)
            local pPlayer = Players[iPlayer]
            local city = pPlayer:GetCities():FindID(iCity)
            if not city then return end

            local buildQueue = city:GetBuildQueue()
            if not buildQueue then return end

            local currentProduction = buildQueue:CurrentlyBuilding()
            if not currentProduction then return end

            -- 检查是否为水上奇观
            local BuildingInfo = GameInfo.Buildings[currentProduction];
            local NWBuildingInfo = GameInfo.NW_TABLE_GREAT_PERSON_INDIVIDUAL_NW_ENGINEER_MODERN_1[BuildingInfo.BuildingType];
            if NWBuildingInfo then
                buildQueue:FinishProgress()
                return true
            end
        end,
    },
    GREAT_PERSON_CLASS_MERCHANT = {
        -- 科西莫・梅第奇：奢侈品重复宜居度
        GREAT_PERSON_INDIVIDUAL_NW_MERCHANT_RENAISSANCE_1 = function(iPlayer, iCity, iX, iY)
            local pPlayer = Players[iPlayer]
            local pPlot = Map.GetPlot(iX, iY)
            if GameInfo.Resources[pPlot:GetResourceType()] then
                local ResourceType = GameInfo.Resources[pPlot:GetResourceType()].ResourceType
                pPlayer:AttachModifierByID('MODIFIER_PLAYER_GRANT_REPEAT_RESOURCE_AMEN_'..ResourceType)
                return true
            end
        end,
        -- 顾维钧：为玩家提供该城邦的宗主国能力
        GREAT_PERSON_INDIVIDUAL_NW_MERCHANT_INDUSTRIAL_2 = function(iPlayer, iCity, iX, iY)
            local pPlayer = Players[iPlayer]
            local pCity = Cities.GetPlotPurchaseCity(Map.GetPlot(iX, iY))
            local playerConfig = PlayerConfigurations[pCity:GetOwner()]
            -- 查询城邦Leader
            local sLeader = playerConfig:GetLeaderTypeName()
            for tRow in GameInfo.NW_TMPG_SUZERAIN() do
                if (tRow.LeaderType == sLeader) then
                    pPlayer:AttachModifierByID(tRow.ModifierId)
                end
            end
            return true
        end
    },
    GREAT_PERSON_CLASS_SCIENTIST = {
        GREAT_PERSON_INDIVIDUAL_NW_SCIENTIST_INDUSTRIAL_2 = function(iPlayer, iCity, iX, iY)
            local pPlayer = Players[iPlayer]
            local playerTechs = pPlayer:GetTechs();
            playerTechs:ChangeCurrentResearchProgress(playerTechs:GetScienceYield());
            return true
        end,
    }
}

function onUnitGreatPersonActivated(iPlayer, Params)
    local pPlayer = Players[iPlayer];
    local iCity = Params.iCity;
    local iGPClass = GameInfo.GreatPersonClasses[Params.iGPClass].GreatPersonClassType;
    local iIndividual = GameInfo.GreatPersonIndividuals[Params.iIndividual].GreatPersonIndividualType;
    local iX = Params.iX;
    local iY = Params.iY;
    print('Get',iGPClass,iIndividual,'指令')
    if GreatPersonActivatedManager.Effect[iGPClass] and GreatPersonActivatedManager.Effect[iGPClass][iIndividual] then
        local b_Activated = GreatPersonActivatedManager.Effect[iGPClass][iIndividual](iPlayer, iCity, iX, iY,Params.extraParam);
        if b_Activated then
            print('伟人',iGPClass,iIndividual,'的LUA效果执行完毕')
        end
    end
end


function onFaladiTurnEnd(iPlayer, Params)
    local pPlayer = Players[iPlayer];
    local pCity = pPlayer:GetCities():FindID(Params.iCity)
    if pCity:GetBuildings():HasBuilding(GameInfo.Buildings['BUILDING_GREAT_PERSON_INDIVIDUAL_NW_ENGINEER_INDUSTRIAL_2'].Index) then
        pCity:GetBuildings():RemoveBuilding(GameInfo.Buildings['BUILDING_GREAT_PERSON_INDIVIDUAL_NW_ENGINEER_INDUSTRIAL_2'].Index);
    end
end

-- =====================================================================
-- INIT
-- =====================================================================
function initialize()
    GameEvents.Nw_TPMG_GreatPersonActivated.Add(onUnitGreatPersonActivated)
    GameEvents.FaladiTurnEnd.Add(onFaladiTurnEnd)
end

Events.LoadScreenClose.Add(initialize)
print('GreatPersonActivatedManager 载入完毕')