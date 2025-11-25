
-- ===========================================================================
-- 变量定义
local m_iCurrentPlayerID = Game.GetLocalPlayer()
local m_pCurrentPlayer = Players[m_iCurrentPlayerID]
local Debug_mode = 1;
-- ===========================================================================
function HasTrait_Property(sTrait, iPlayer)
	local pPlayer = Players[iPlayer];
	local ePro = pPlayer:GetProperty('PROPERTY_'..sTrait) or 0
	if ePro > 0 then
		return true
	end
	return false
end
-- ===========================================================================
function __DEBUG(...)
	if Debug_mode then
		print(...)
	end
end

-- 阿拉伯发酵：圣城获得对应虚拟建筑
function AlbertCreateReligion(iPlayer, iUnit, iGPClass, iIndividual)
    if iPlayer ~= m_iCurrentPlayerID or not HasTrait_Property('TRAIT_CIVILIZATION_LAST_PROPHET', iPlayer) then return end
    local pPlayer = Players[iPlayer]
    local pUnit = UnitManager.GetUnit(iPlayer, iUnit)
    if pUnit and iGPClass == GameInfo.GreatPersonClasses['GREAT_PERSON_CLASS_PROPHET'].Index then
        local x, y = pUnit:GetX(), pUnit:GetY()
        local pPlot = Map.GetPlot(x, y);
		local pCity = Cities.GetPlotPurchaseCity(pPlot)
        UI.RequestPlayerOperation(pPlayer, PlayerOperations.EXECUTE_SCRIPT, {
            OnStart = "Nw_DTMS_CityGotBuilding",
            iCity = pCity:GetID(),
			iBuilding = GameInfo.Buildings['BUILDING_NW_ALBERT_HOLY_CITY'].Index
        });
    end
end

-- ===========================================================================
-- 马其顿：激活亚历山大
function onUnitGreatPersonActivated(iPlayer, iUnit, iGPClass, iIndividual)
    if iPlayer ~= m_iCurrentPlayerID then return end
    local pUnit = UnitManager.GetUnit(iPlayer, iUnit)
    if pUnit and iGPClass == GameInfo.GreatPersonClasses['GREAT_PERSON_CLASS_ALEXANDER'].Index then
        local x, y = pUnit:GetX(), pUnit:GetY()
        local pCity = Cities.GetPlotPurchaseCity(Map.GetPlot(x, y))
        if pCity then
			local pPlayer = Players[iPlayer]
			local playerConfig = PlayerConfigurations[pCity:GetOwner()]
			-- 查询城邦Leader
			local sLeader = playerConfig:GetLeaderTypeName()
			UI.RequestPlayerOperation(pPlayer, PlayerOperations.EXECUTE_SCRIPT, {
				OnStart = "Nw_DTMS_PLAYER_ALEXANDER",
				sLeader = sLeader
			});
        end
    end
end
-- ===========================================================================
-- 玛雅：长纪历回合
-- 该写法可对AI正常生效
function onPlayerTurnActivated_Maya(playerID, isFirst)
	if m_iCurrentPlayerID == playerID and m_iCurrentPlayerID == 0 and isFirst then
		-- 遍历文明
		if GameInfo.NW_MAYA_BAKTUN['BAKTUN_'..Game.GetCurrentGameTurn()] then
			local kPlayers = PlayerManager.GetAliveMajors()
			for _, pPlayer in ipairs(kPlayers) do
				local iPlayer = pPlayer:GetID()
				if (HasTrait_Property('TRAIT_LEADER_MUTAL',iPlayer)) then
					UI.RequestPlayerOperation(m_pCurrentPlayer, PlayerOperations.EXECUTE_SCRIPT, {
						OnStart = "Nw_DTMS_MAYA_GRANT_FAITH",
						iPlayer = iPlayer
					});
				end
			end
		end
	end
end

-- ===========================================================================
-- 文件初始化
function Initialize()
	Events.UnitGreatPersonActivated.Add(onUnitGreatPersonActivated)
	Events.UnitGreatPersonActivated.Add(AlbertCreateReligion)
	Events.PlayerTurnActivated.Add(onPlayerTurnActivated_Maya);
	print('DTMS UIScript Loaded Succeed.');
end
Events.LoadGameViewStateDone.Add(Initialize);
