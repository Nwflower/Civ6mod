-- Ottoman_TransferButton
-- Author: Nwflower
-- DateCreated: 2025-6-11 17:08:53

local m_iCurrentPlayerID = Game.GetLocalPlayer()
local m_pCurrentPlayer = Players[m_iCurrentPlayerID]

----------------------------------------------------
-- 按钮是否激活，即是否有合适的单元格可供扬帆或者登陆
-- -1:非法单位
-- 0:非指定单位或已无移动力，建议不予显示
-- 1:陆军但无登舰点
-- 2:海军但无登陆点
-- 3:陆军有登舰点
-- 4:海军有登陆点
function IsButtonActive(pUnit)
    local unitInfo = GameInfo.Units[pUnit:GetType()]
	if unitInfo == nil then return -1 end

	local plots = Map.GetAdjacentPlots(pUnit:GetX(), pUnit:GetY())


	-- 如果是有行动力的陆军单位
	-- 如果相邻可通行水域就return false
	if unitInfo.PromotionClass == 'PROMOTION_CLASS_MELEE' and pUnit:GetMovementMovesRemaining() > 0 then
		for _, pNeighborPlot in ipairs(plots) do
			if pNeighborPlot:IsWater() then
				-- 看一下该单元格是否可以扬帆
				local flat = false;
				for loop, ppUnit in ipairs(Units.GetUnitsInPlot(pNeighborPlot)) do
					if(ppUnit ~= nil) then
						if ppUnit:GetOwner() ~= pUnit:GetOwner() then
							flat = true
						end
					end
				end
				if flat == false then
					return 3
				end
			end
		end
		return 1
	end

	-- 如果是有行动力的海军单位
	if unitInfo.PromotionClass == 'PROMOTION_CLASS_NAVAL_MELEE' and pUnit:GetMovementMovesRemaining() > 0 then
		for _, pNeighborPlot in ipairs(plots) do
			if (not pNeighborPlot:IsWater() and not pNeighborPlot:IsMountain()) then
				-- 看一下该单元格是否可以登陆
				local flat = false;
				for loop, ppUnit in ipairs(Units.GetUnitsInPlot(pNeighborPlot)) do
					if(ppUnit ~= nil) then
						if ppUnit:GetOwner() ~= pUnit:GetOwner() then
							flat = true
						end
					end
				end
				if flat == false then
					return 4
				end
			end
		end
		return 2
	end

	return 0
end

-- 单位移动完成时刷新界面
function OnUnitMoveComplete(playerID, unitID, iX, iY)
	if playerID ~= m_iCurrentPlayerID then
		return
	end
	Refresh(playerID)
end

-- 单位选择变化时刷新界面
function OnUnitSelectionChanged(playerID, unitID, plotX, plotY, plotZ, bSelected, bEditable)
	if playerID ~= m_iCurrentPlayerID then
		return
	end
    if bSelected then
        Refresh(playerID)
    end
end

-- 刷新按钮状态
function Refresh(playerID)
    local pUnit = UI.GetHeadSelectedUnit()
	if pUnit == nil then return end

	-- 状态码
	local state = IsButtonActive(pUnit)
    if state <= 0 then
		Controls.OttomanTransferButtonActionGrid:SetHide(true)
	else
		Controls.OttomanTransferButtonActionGrid:SetHide(false)
		-- 如果按钮未激活，则附上TOOLTIP
		-- 如果按钮激活，则附上TOOLTIP+单击事件
		if state == 1 then
    		Controls.OttomanTransferButtonActionButton:SetEnabled(false)
			--Controls.OttomanTransferButtonActionButton:RegisterCallback(Mouse.eLClick, function()  end)
			Controls.OttomanTransferButtonActionButton:SetToolTipString(Locale.Lookup('LOC_OTTOMAN_LAND_ACTION_BAN_TOOLTIP'))
		elseif state == 2 then
    		Controls.OttomanTransferButtonActionButton:SetEnabled(false)
			--Controls.OttomanTransferButtonActionButton:RegisterCallback(Mouse.eLClick, function()  end)
			Controls.OttomanTransferButtonActionButton:SetToolTipString(Locale.Lookup('LOC_OTTOMAN_SEA_ACTION_BAN_TOOLTIP'))
		elseif state == 3 then
    		Controls.OttomanTransferButtonActionButton:SetEnabled(true)
			Controls.OttomanTransferButtonActionButton:RegisterCallback(Mouse.eLClick, OnOttomanTransferButtonActionButtonClicked)
			Controls.OttomanTransferButtonActionButton:SetToolTipString(Locale.Lookup('LOC_OTTOMAN_LAND_ACTION_TOOLTIP'))
		elseif state == 4 then
    		Controls.OttomanTransferButtonActionButton:SetEnabled(true)
			Controls.OttomanTransferButtonActionButton:RegisterCallback(Mouse.eLClick, OnOttomanTransferButtonActionButtonClicked)
			Controls.OttomanTransferButtonActionButton:SetToolTipString(Locale.Lookup('LOC_OTTOMAN_SEA_ACTION_TOOLTIP'))
		end
    end
end

-- 按钮被点击之后
function OnOttomanTransferButtonActionButtonClicked()
    local pUnit = UI.GetHeadSelectedUnit()
    local iX = pUnit:GetX()
    local iY = pUnit:GetY()
	local kParameters = {};
	kParameters.OnStart = "NWAmericanTransfer";
	kParameters.iX = iX;
	kParameters.iY = iY;
	kParameters.activeUnit = pUnit:GetID();
	UI.RequestPlayerOperation(m_pCurrentPlayer, PlayerOperations.EXECUTE_SCRIPT, kParameters);
end


local iImprovement1 = GameInfo.Improvements['IMPROVEMENT_OIL_WELL'].Index
local iImprovement2 = GameInfo.Improvements['IMPROVEMENT_OFFSHORE_OIL_RIG'].Index
function OnImprovementAddedToMap(PlotX, PlotY, ImprovementID, PlayerID, ResourceID, Unknown1, Unknown2)
	if (ImprovementID == iImprovement1 or ImprovementID == iImprovement2) then
		local kParameters = {};
		kParameters.OnStart = "NWAmericanGetSight";
		kParameters.PlotX = PlotX;
		kParameters.PlotY = PlotY;
		UI.RequestPlayerOperation(m_pCurrentPlayer, PlayerOperations.EXECUTE_SCRIPT, kParameters);
	end
end

function OnDistrictAddedToMap(playerID, districtID, cityID, iX, iY, districtType, percentComplete)		-- 拍区域盖住了未解锁的资源？
	if (districtType == GameInfo.Districts['DISTRICT_AERODROME'].Index) then
		local kParameters = {};
		kParameters.OnStart = "NWAmericanGetSight";
		kParameters.PlotX = iX;
		kParameters.PlotY = iY;
		UI.RequestPlayerOperation(m_pCurrentPlayer, PlayerOperations.EXECUTE_SCRIPT, kParameters);
	end
end


function Initialize()
	if m_pCurrentPlayer:GetProperty('PROPERTY_TRAIT_CIVILIZATION_NW_AMERICA_FREEDOM') then
		-- 如果玩家是
		local pContext = ContextPtr:LookUpControl("/InGame/UnitPanel/StandardActionsStack")
		if pContext ~= nil then
			Controls.OttomanTransferButtonActionGrid:ChangeParent(pContext)
		end
		Events.UnitSelectionChanged.Add(OnUnitSelectionChanged)
		Events.UnitMoveComplete.Add(OnUnitMoveComplete)
		Events.ImprovementAddedToMap.Add(OnImprovementAddedToMap)
		Events.DistrictAddedToMap.Add(OnDistrictAddedToMap)
	end
end

Events.LoadGameViewStateDone.Add(Initialize)