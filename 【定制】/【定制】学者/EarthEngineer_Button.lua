-- SCHOLAR_Button
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
        Controls.SCHOLARButtonGrid:ChangeParent(ctrl)
    end
    Controls.SCHOLARButton:RegisterCallback(Mouse.eLClick, OnSCHOLARButtonClicked)
	Controls.SCHOLARButtonGrid:SetHide(IsSCHOLARButtonHide())
end

function IsSCHOLARButtonHide()
	local pUnit = UI.GetHeadSelectedUnit()
	if pUnit == nil then
		return true
	end
	if GameInfo.Units[pUnit:GetType()].UnitType ~= 'UNIT_SCHOLAR' then
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

	-- 单元格必须不是自己
	if not Map.GetPlot(iX,iY):IsOwned() or Map.GetPlot(iX,iY):GetOwner() == Game.GetLocalPlayer()  then
		return true
	end

	return false
	--local eDistrict = Map.GetPlot(iX,iY):GetDistrictType() or -1
	--if eDistrict == GameInfo.Districts['DISTRICT_CAMPUS'].Index  then
	--	return false
	--end
	--return true
end

function Refresh()
	Controls.SCHOLARButtonGrid:SetHide(IsSCHOLARButtonHide())
end

function OnSCHOLARButtonClicked()
	local pUnit = UI.GetHeadSelectedUnit()
	local iX = pUnit:GetX()
	local iY = pUnit:GetY()

	local pPlot = Map.GetPlot(iX,iY)
	local iPlayer = Game.GetLocalPlayer()
	local m_LocalPlayer = Players[iPlayer];
	local m_LocalPlayerTech = m_LocalPlayer:GetTechs()
	local iOtherPlayer = pPlot:GetOwner()

	local flag = false

    for row in GameInfo.Technologies() do
        if (not m_LocalPlayerTech:HasTech(GameInfo.Technologies[row.TechnologyType].Index)) and Players[iOtherPlayer]:GetTechs():HasBoostBeenTriggered(GameInfo.Technologies[row.TechnologyType].Index) then
			local kParam = {
				OnStart = 'SCHOLARGetULK',
				TechID = GameInfo.Technologies[row.TechnologyType].Index
			}
			UI.RequestPlayerOperation(Game.GetLocalPlayer(), PlayerOperations.EXECUTE_SCRIPT, kParam)
			SimUnitSystem.SetAnimationState(pUnit, "ACTION_1", "IDLE");
			flag = true;
			break;
        end
    end
	if flag then
		UI.AddWorldViewText(EventSubTypes.PLOT, "无可提升的科技", iX, iY, 0)
	end
end

function SCHOLAR_Init()
	SetupButton()
	Events.UnitSelectionChanged.Add(Refresh)
	Events.UnitMoveComplete.Add(Refresh)
	Events.UnitMovementPointsChanged.Add(Refresh)
	print('SCHOLARGetULK UI Loaded Success.')
end
Events.LoadGameViewStateDone.Add(SCHOLAR_Init);