
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

-- 阿拉伯传教
function onCityReligionChanged(playerID,cityID,eVisibility, city)
    if playerID ~= m_iCurrentPlayerID then return end
	-- 本城是否有主流宗教
	local pCity = CityManager.GetCity(playerID, cityID);
	local pCityReligionID = pCity:GetReligion():GetMajorityReligion();
	if pCityReligionID == nil then return end

	-- 寻找宗教创建者
	local religions = Game.GetReligion():GetReligions();
	local ModifierID = 'MODIFIER_BUILDING_NW_ALBERT_HOLY_CITY_CAPACITY';
	for i, religion in ipairs(religions) do
		if IPlayerHasTrait(religion.Founder,"TRAIT_CIVILIZATION_LAST_PROPHET") and pCityReligionID == religion.Religion then
			local pPlayer = Players[religion.Founder];
			local ePro  = pPlayer:GetProperty('MODIFIER_ATTACHED_'..ModifierID) or 0
			if ePro == 0 then
				UI.RequestPlayerOperation(pPlayer, PlayerOperations.EXECUTE_SCRIPT, {
					OnStart = "Nw_DTMS_PLAYER_ATTACH",
					iPlayer = religion.Founder,
					ModifierID = ModifierID
				});
			end
		end
	end
end

-- ===========================================================================

-- ===========================================================================
-- 文件初始化
function Initialize()
	Events.UnitGreatPersonActivated.Add(AlbertCreateReligion)
    Events.CityReligionChanged.Add( onCityReligionChanged );
	print('DTMS UIScript Loaded Succeed.');
end
Events.LoadGameViewStateDone.Add(Initialize);
