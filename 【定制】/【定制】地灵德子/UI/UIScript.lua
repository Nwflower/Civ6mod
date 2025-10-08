-- Ottoman_TransferButton
-- Author: Nwflower
-- DateCreated: 2025-6-11 17:08:53

local m_iCurrentPlayerID = Game.GetLocalPlayer()
local m_pCurrentPlayer = Players[m_iCurrentPlayerID]

local m_pGameReligion = Game.GetReligion();

function GetHash()
	if not m_pGameReligion:IsInSomePantheon(GameInfo.Beliefs['BELIEF_KONGBAI'].Index) then
		return GameInfo.Beliefs['BELIEF_KONGBAI'].Hash;
	elseif  not m_pGameReligion:IsInSomePantheon(GameInfo.Beliefs['BELIEF_KONGBAI2'].Index) then
		return GameInfo.Beliefs['BELIEF_KONGBAI2'].Hash;
	elseif  not m_pGameReligion:IsInSomePantheon(GameInfo.Beliefs['BELIEF_KONGBAI3'].Index) then
		return GameInfo.Beliefs['BELIEF_KONGBAI3'].Hash;
	elseif  not m_pGameReligion:IsInSomePantheon(GameInfo.Beliefs['BELIEF_KONGBAI4'].Index) then
		return GameInfo.Beliefs['BELIEF_KONGBAI4'].Hash;
	elseif  not m_pGameReligion:IsInSomePantheon(GameInfo.Beliefs['BELIEF_KONGBAI5'].Index) then
		return GameInfo.Beliefs['BELIEF_KONGBAI5'].Hash;
	end
	return GameInfo.Beliefs['BELIEF_KONGBAI6'].Hash;
end

function Open()
	local tParameters = {};
	tParameters[PlayerOperations.PARAM_BELIEF_TYPE] = GetHash();
	tParameters[PlayerOperations.PARAM_INSERT_MODE] = PlayerOperations.VALUE_EXCLUSIVE;
	UI.RequestPlayerOperation(Game.GetLocalPlayer(), PlayerOperations.FOUND_PANTHEON, tParameters);
	UI.PlaySound("Confirm_Religion");
	LuaEvents.LaunchBar_ClosePantheonChooser()
end


function Initialize()
	if m_pCurrentPlayer:GetProperty('PROPERTY_TRAIT_LEADER_HOLY_ROMAN_EMPEROR_ALT') then
		LuaEvents.LaunchBar_OpenPantheonChooser.Add( Open );
		print('0923 Success.')
	end
end

Events.LoadGameViewStateDone.Add(Initialize)