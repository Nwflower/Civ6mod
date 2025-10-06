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
	local kPlayers = PlayerManager.GetAliveMajors()
	for _, m_pPlayer in ipairs(kPlayers) do
		if m_pPlayer:GetID() ~= playerID then
			local pCities = m_pPlayer:GetCities();
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

function Initialize()
	if m_pCurrentPlayer:GetProperty('PROPERTY_TRAIT_CIVILIZATION_MILKD_NW251006') then
    	Events.CityReligionChanged.Add( onCityReligionChanged );
		print('TRAIT_CIVILIZATION_MILKD_NW251006 Success.')
	end
end

Events.LoadGameViewStateDone.Add(Initialize)