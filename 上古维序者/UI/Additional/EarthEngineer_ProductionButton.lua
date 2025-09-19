-- EarthEngineer_Button
-- Author: Ophidy
-- DateCreated: 3/14/2024 7:47:53 PM
--------------------------------------------------------------
-- =====================================================================
-- Base Object
-- =====================================================================
local GAME_SPEED = GameConfiguration.GetGameSpeedType();
local GAME_SPEED_MULTIPLIER = GameInfo.GameSpeeds[GAME_SPEED] and GameInfo.GameSpeeds[GAME_SPEED].CostMultiplier / 100 or 1;

OldRuleProduction = {
    DISTRICT_AQUEDUCT = function(Index, ProductionDetail)
        if ProductionDetail.ItemType == 'DISTRICT_AQUEDUCT' then
            return 60
        end
        return 0
    end,
    DISTRICT_DAM = function(Index, ProductionDetail)
        if ProductionDetail.ItemType == 'DISTRICT_DAM' then
            return 60
        end
        return 0
    end,
    DISTRICT_CANAL = function(Index, ProductionDetail)
        if ProductionDetail.ItemType == 'DISTRICT_CANAL' then
            return 60
        end
        return 0
    end,
    DISTRICT_NEIGHBORHOOD = function(Index, ProductionDetail)
        if ProductionDetail.ItemType == 'DISTRICT_NEIGHBORHOOD' then
            return 60
        end
        return 0
    end,
    DISTRICT_SPACEPORT = function(Index, ProductionDetail)
        if ProductionDetail.ItemType == 'DISTRICT_SPACEPORT' and Index >= 3 then
            return 11
        end
        return 0
    end,
    DISTRICT_CITY_CENTER = function(Index, ProductionDetail)
        if ProductionDetail.ItemType == 'PROJECT_MANHATTAN_PROJECT' and Index >= 3 then
            return 11
        end
        return 0
    end,
}


-- 获取城市生产详细信息 (UI)
function OldRuleProduction:GetProductionDetail(city)
    local details = { --城市生产详细信息
        --项目哈希值
        Hash = 0,
        --城市是否进行生产
        Producting = false,
        --是否是建筑
        IsBuilding = false,
        --是否是奇观
        IsWonder = false,
        --是否是区域
        IsDistrict = false,
        --是否是单位
        IsUnit = false,
        --是否是项目
        IsProject = false,
        --生产项目类型
        ItemType = 'NONE',
        --生产项目名字
        ItemName = 'NONE',
        --生产项目索引
        ItemIndex = -1,
        --生产进度
        Progress = 0,
        --生产成本
        TotalCost = 0,
        --生产所需回合
        TurnsLeft = 0
    };
    if not city then
        return details
    end
    --获取城市生产队列，判断是否在生产
    local cityBuildQueue = city:GetBuildQueue()
    local productionHash = cityBuildQueue:GetCurrentProductionTypeHash()
    if productionHash ~= 0 then
        details.Hash = productionHash
        details.Producting = true
        --建筑、区域、单位、项目
        local pBuildingDef = GameInfo.Buildings[productionHash]
        local pDistrictDef = GameInfo.Districts[productionHash]
        local pUnitDef = GameInfo.Units[productionHash]
        local pProjectDef = GameInfo.Projects[productionHash]
        --判断城市当前进行的生产
        if pBuildingDef ~= nil then
            --获取索引，方便后续获取进度和总成本
            local index = pBuildingDef.Index
            --城市正在生产建筑
            details.IsBuilding = true
            --城市生产的建筑是奇观还是普通建筑
            details.IsWonder = pBuildingDef.IsWonder
            --城市生产的建筑类型
            details.ItemType = pBuildingDef.BuildingType
            --城市生产的建筑名称
            details.ItemName = Locale.Lookup(pBuildingDef.Name)
            --城市生产的建筑索引
            details.ItemIndex = index
            --生产进度和总成本
            details.Progress = cityBuildQueue:GetBuildingProgress(index)
            details.TotalCost = cityBuildQueue:GetBuildingCost(index)
        elseif pDistrictDef ~= nil then
            --获取索引，方便后续获取进度和总成本
            local index = pDistrictDef.Index
            --城市正在生产区域
            details.IsDistrict = true
            --城市生产的区域类型
            details.ItemType = pDistrictDef.DistrictType
            --城市生产的区域名称
            details.ItemName = Locale.Lookup(pDistrictDef.Name)
            --城市生产的区域索引
            details.ItemIndex = index
            --生产进度和总成本
            details.Progress = cityBuildQueue:GetDistrictProgress(index)
            details.TotalCost = cityBuildQueue:GetDistrictCost(index)
        elseif pUnitDef ~= nil then
            --获取索引，方便后续获取进度和总成本
            local index = pUnitDef.Index
            --城市正在生产单位
            details.IsUnit = true
            --城市生产的单位类型
            details.ItemType = pUnitDef.UnitType
            --城市生产的单位名称
            details.ItemName = Locale.Lookup(pUnitDef.Name)
            --城市生产的单位索引
            details.ItemIndex = index
            --生产进度
            details.Progress = cityBuildQueue:GetUnitProgress(index)
            --获取当前单位的军事形式，计算总成本
            local formation = cityBuildQueue:GetCurrentProductionTypeModifier()
            --是标准
            if formation == MilitaryFormationTypes.STANDARD_FORMATION then
                details.TotalCost = cityBuildQueue:GetUnitCost(index)
                --是军团
            elseif formation == MilitaryFormationTypes.CORPS_FORMATION then
                details.TotalCost = cityBuildQueue:GetUnitCorpsCost(index)
                --更新单位名称
                if pUnitDef.Domain == 'DOMAIN_SEA' then
                    details.ItemName = details.ItemName .. " " .. Locale.Lookup("LOC_UNITFLAG_FLEET_SUFFIX")
                else
                    details.ItemName = details.ItemName .. " " .. Locale.Lookup("LOC_UNITFLAG_CORPS_SUFFIX")
                end
                --是军队
            elseif formation == MilitaryFormationTypes.ARMY_FORMATION then
                details.TotalCost = cityBuildQueue:GetUnitArmyCost(index)
                --更新单位名称
                if pUnitDef.Domain == 'DOMAIN_SEA' then
                    details.ItemName = details.ItemName .. " " .. Locale.Lookup("LOC_UNITFLAG_ARMADA_SUFFIX")
                else
                    details.ItemName = details.ItemName .. " " .. Locale.Lookup("LOC_UNITFLAG_ARMY_SUFFIX")
                end
            end
        elseif pProjectDef ~= nil then
            --获取索引，方便后续获取进度和总成本
            local index = pProjectDef.Index
            --城市正在生产项目
            details.IsProject = true
            --城市生产的项目类型
            details.ItemType = pProjectDef.ProjectType
            --城市生产的项目名称
            details.ItemName = Locale.Lookup(pProjectDef.Name)
            --城市生产的项目索引
            details.ItemIndex = index
            --生产进度和总成本
            details.Progress = cityBuildQueue:GetProjectProgress(index)
            details.TotalCost = cityBuildQueue:GetProjectCost(index)
        end
        --生产所需回合
        details.TurnsLeft = cityBuildQueue:GetTurnsLeft()
    end
    return details
end


-- =====================================================================
-- Register Button
-- =====================================================================
function SetupButton()
    local path = '/InGame/UnitPanel/StandardActionsStack'
    local ctrl = ContextPtr:LookUpControl(path)
    if ctrl ~= nil then
        Controls.EarthEngineerProductionButtonGrid:ChangeParent(ctrl)
    end
    Controls.EarthEngineerProductionButton:RegisterCallback(Mouse.eLClick, OnEarthEngineerProductionButtonClicked)
    Controls.EarthEngineerProductionButtonGrid:SetHide(IsEarthEngineerProductionButtonHide())
end

function IsEarthEngineerProductionButtonHide()
    local pUnit = UI.GetHeadSelectedUnit()
    if pUnit == nil then
        return true
    end
    if pUnit:GetMovementMovesRemaining() == 0 then
        return true
    end
    local iX = pUnit:GetX()
    local iY = pUnit:GetY()
    local pPlot = Map.GetPlot(iX, iY)
    if not Players[Game.GetLocalPlayer()]:IsTurnActive() then
        return true
    end

    local ePro = pUnit:GetProperty('PROPERTY_EARTHENGINEER_RANDOM_RESOURCE') or 0
    if ePro == 0 then
        return true
    end
    local index = 1;
    if pUnit:GetProperty('PROPERTY_EARTHENGINEER_RANDOM_RESOURCE_3') then
        index = 3;
    end
    local pCity = Cities.GetPlotPurchaseCity(pPlot)

    local pCityProduction = OldRuleProduction:GetProductionDetail(pCity)
    local eDistrict = pPlot:GetDistrictType() or -1
    if eDistrict > -1 then
        eDistrict = GameInfo.Districts[eDistrict].DistrictType
        for row in GameInfo.DistrictReplaces() do
            if row.CivUniqueDistrictType == eDistrict then
                eDistrict = row.ReplacesDistrictType;
            end
        end
    end

    -- 获得可以推进城市项目的百分比
    if OldRuleProduction[eDistrict] and OldRuleProduction[eDistrict](index, pCityProduction) > 0 then
        return false
    end
    return true
end

function Refresh()
    Controls.EarthEngineerProductionButtonGrid:SetHide(IsEarthEngineerProductionButtonHide())
end

function OnEarthEngineerProductionButtonClicked()
    local pUnit = UI.GetHeadSelectedUnit()
    local iX = pUnit:GetX()
    local iY = pUnit:GetY()

    local pPlot = Map.GetPlot(iX, iY)

    local index = 1;
    if pUnit:GetProperty('PROPERTY_EARTHENGINEER_RANDOM_RESOURCE_3') then
        index = 3;
    end
    local pCity = Cities.GetPlotPurchaseCity(pPlot)

    local pCityProduction = OldRuleProduction:GetProductionDetail(pCity)
    local eDistrict = pPlot:GetDistrictType() or -1
    if eDistrict > -1 then
        eDistrict = GameInfo.Districts[eDistrict].DistrictType
        for row in GameInfo.DistrictReplaces() do
            if row.CivUniqueDistrictType == eDistrict then
                eDistrict = row.ReplacesDistrictType;
            end
        end
    end

    print(eDistrict)
    -- 获得可以推进城市项目的百分比
    if OldRuleProduction[eDistrict] then
        local productionPercent = OldRuleProduction[eDistrict](index, pCityProduction)
        print(pCityProduction.TotalCost)
        if productionPercent > 0 then
            local kParam = {
                OnStart = 'EarthEngineer_AddProduction',
                iCity = pCity:GetID(),
		        iUnit = pUnit:GetID(),
                Production = pCityProduction.TotalCost * productionPercent / 100
            }
            UI.RequestPlayerOperation(Game.GetLocalPlayer(), PlayerOperations.EXECUTE_SCRIPT, kParam)
            SimUnitSystem.SetAnimationState(pUnit, "ACTION_1", "IDLE");
        end
    end

end

function EarthEngineer_Init()
    SetupButton()
	Events.CityProductionChanged.Add(Refresh)
    Events.UnitSelectionChanged.Add(Refresh)
    Events.UnitMoveComplete.Add(Refresh)
    Events.UnitMovementPointsChanged.Add(Refresh)
end

Events.LoadGameViewStateDone.Add(EarthEngineer_Init);