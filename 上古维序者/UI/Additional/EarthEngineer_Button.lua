-- EarthEngineer_Button
-- Author: Ophidy
-- DateCreated: 3/14/2024 7:47:53 PM
--------------------------------------------------------------



-- =====================================================================
-- Register Button
-- =====================================================================
function SetupButton()
    local path = '/InGame/UnitPanel/StandardActionsStack'
    local ctrl = ContextPtr:LookUpControl(path)
    if ctrl ~= nil then
        Controls.EarthEngineerButtonGrid:ChangeParent(ctrl)
    end
    Controls.EarthEngineerButton:RegisterCallback(Mouse.eLClick, OnEarthEngineerButtonClicked)
	Controls.EarthEngineerButtonGrid:SetHide(IsEarthEngineerButtonHide())
end

function IsEarthEngineerButtonHide()
	local pUnit = UI.GetHeadSelectedUnit()
	if pUnit == nil then
		return true
	end
	if pUnit:GetMovementMovesRemaining() == 0 then
		return true
	end
	local iX = pUnit:GetX()
	local iY = pUnit:GetY()
	if not Players[Game.GetLocalPlayer()]:IsTurnActive() then
		return true
	end
	
	local ePro = pUnit:GetProperty('PROPERTY_EARTHENGINEER_RANDOM_RESOURCE') or 0
	-- 单元格必须无主
	-- 检查中立领土
	if Map.GetPlot(iX,iY):IsOwned() then
		return true
	end

	-- 空白单元格：单元格没有区域、没有资源
	local eDistrict = Map.GetPlot(iX,iY):GetDistrictID() or -1
	local eResource = Map.GetPlot(iX,iY):GetResourceType() or -1
	local eImprovement = Map.GetPlot(iX,iY):GetImprovementType() or -1
	if ePro ~= 0 and eDistrict < 0 and eResource < 0 and eImprovement < 0 then
		return false
	end
	return true
end

function Refresh()
	Controls.EarthEngineerButtonGrid:SetHide(IsEarthEngineerButtonHide())
end

function OnEarthEngineerButtonClicked()
	local pUnit = UI.GetHeadSelectedUnit()
	local iX = pUnit:GetX()
	local iY = pUnit:GetY()

	local pPlot = Map.GetPlot(iX,iY)
	local iFeature = pPlot:GetFeatureType() or -1
	local iTerrain = pPlot:GetTerrainType()

	local Resources = {}
	if iFeature > -1 then
		local sFeature = GameInfo.Features[iFeature].FeatureType
		for row in GameInfo.NW_TABLE_BASE_RANDOM_RESOURCES() do
			if row.FeatureType == sFeature then
				Resources[row.ResourceType] = 1;
			end
		end
	else
		local sTerrain = GameInfo.Terrains[iTerrain].TerrainType
		for row in GameInfo.NW_TABLE_BASE_RANDOM_RESOURCES() do
			if row.TerrainType == sTerrain then
				Resources[row.ResourceType] = 1;
			end
		end
	end

	local iResources = {}
	for key, value in pairs(Resources) do
		table.insert(iResources,key);
	end

	if #iResources == 0 then
		UI.AddWorldViewText(0, Locale.Lookup('LOC_NW_SSO_RESOURCE_DISABLED'), iX, iY, 0);
	else
		local ResourceType = iResources[math.random(#iResources)]
		print(ResourceType)

		local kParam = {
			OnStart = 'EarthEngineer_CreateResource',
			iX = iX,
			iY = iY,
			iUnit = pUnit:GetID(),
			ResourceType = ResourceType
		}

		UI.RequestPlayerOperation(Game.GetLocalPlayer(), PlayerOperations.EXECUTE_SCRIPT, kParam)
		SimUnitSystem.SetAnimationState(pUnit, "ACTION_1", "IDLE");
	end
end

function EarthEngineer_Init()
	SetupButton()
	Events.UnitSelectionChanged.Add(Refresh)
	Events.UnitMoveComplete.Add(Refresh)
	Events.UnitMovementPointsChanged.Add(Refresh)
end

Events.LoadGameViewStateDone.Add(EarthEngineer_Init);