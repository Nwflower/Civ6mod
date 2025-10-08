-- Ottoman_TransferButton
-- Author: Nwflower
-- DateCreated: 2025-6-11 17:08:53

local m_iCurrentPlayerID = Game.GetLocalPlayer()
local m_pCurrentPlayer = Players[m_iCurrentPlayerID]



-- 奶龙
function onCityReligionChanged(playerID,cityID,eVisibility, city)
	local i_LocalReligion;
	local religions = Game.GetReligion():GetReligions();
	for i, religion in ipairs(religions) do
		if religion.Founder == m_iCurrentPlayerID then
			i_LocalReligion = religion.Religion;
			break;
		end
	end
	local NumReligion = 0 ;
	local iPlayers = PlayerManager.GetAliveIDs()
	for _, m_pPlayer in ipairs(iPlayers) do
		if m_pPlayer ~= m_iCurrentPlayerID then
			local pCities = Players[m_pPlayer]:GetCities();
			for _, pCity in pCities:Members() do
				local pCityReligionID = pCity:GetReligion():GetMajorityReligion();
				if pCityReligionID ~= nil and pCityReligionID == i_LocalReligion then
					NumReligion = NumReligion + 1
				end
			end
		end
	end
	print('信仰奶龙宗教的外国城市数量：', NumReligion)
	local NaiLongPP = m_pCurrentPlayer:GetProperty('NL_PP') or 0
	if NaiLongPP ~= NumReligion then
		local kParam = {
			OnStart = 'NaiLongPP',
			NumReligion = NumReligion
		}
		UI.RequestPlayerOperation(Game.GetLocalPlayer(), PlayerOperations.EXECUTE_SCRIPT, kParam)
	end
end


function OnImprovementChanged(iX,iY,improvementType, improvementOwner,resource, isPillaged, isWorked)
	if isPillaged and improvementType then
		for loop, pUnit in ipairs(Units.GetUnitsInPlot(Map.GetPlot(iX, iY))) do
			if(pUnit ~= nil) then
				if pUnit:GetOwner() == m_iCurrentPlayerID and GameInfo.Units[pUnit:GetType()].UnitType == "UNIT_QZJ_NLDD" then
					UI.RequestPlayerOperation(m_iCurrentPlayerID, PlayerOperations.EXECUTE_SCRIPT, {
						OnStart = "Nw_NL_GetDamage",
						iUnit = pUnit:GetID()
					});
				end
			end
		end
	end
end

function Initialize()
	if m_pCurrentPlayer:GetProperty('PROPERTY_TRAIT_CIVILIZATION_MILKD_NW251006') then
    	Events.CityReligionChanged.Add( onCityReligionChanged );
		Events.ImprovementChanged.Add(OnImprovementChanged);
		print('TRAIT_CIVILIZATION_MILKD_NW251006 Success.')
	end
end

Events.LoadGameViewStateDone.Add(Initialize)