-- Script
-- Author: Nwflower
-- DateCreated: 2025-9-14 17:54:01
--------------------------------------------------------------
--||=======================include========================||--

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

-- ===========================================================================
-- 城市获得虚拟建筑
function Nw_DTMS_CityGotBuilding(iPlayerID, params)
	local pCity = CityManager.GetCity(iPlayerID, params.iCity)
	if not pCity then return end
	if not (pCity:GetBuildings():HasBuilding(params.iBuilding)) then
		pCity:GetBuildQueue():CreateBuilding(params.iBuilding);
	end
end
-- 城市获得虚拟建筑
function Nw_DTMS_PLAYER_ATTACH(iPlayerID, params)
	local pPlayer = Players[params.iPlayer];
	if not pPlayer then return end
	local ePro = pPlayer:GetProperty('MODIFIER_ATTACHED_'..params.ModifierID) or 0
	if ePro == 0 then
		pPlayer:SetProperty('MODIFIER_ATTACHED_'..params.ModifierID, ePro + 1);
		pPlayer:AttachModifierByID(params.ModifierID);
	end
end


-- ===========================================================================
-- 马其顿：激活亚历山大
function Nw_DTMS_PLAYER_ALEXANDER(iPlayerID, params)
	local pPlayer = Players[iPlayerID];
	if not pPlayer then return end
	for tRow in GameInfo.NW_TMPG_SUZERAIN() do
		if (tRow.LeaderType == params.sLeader) then
			pPlayer:AttachModifierByID(tRow.ModifierId)
		end
	end
end
-- ===========================================================================
-- 巴比伦：激活法典
function Nw_DTMS_HAMMURABI_LAW(iPlayerID, params)
	local pPlayer = Players[params.iPlayer];
	if not pPlayer then return end
	local iCivic = GameInfo.Civics['CIVIC_CODE_OF_LAWS'].Index
    pPlayer:GetCulture():SetCulturalProgress(iCivic,pPlayer:GetCulture():GetCultureCost(iCivic))
end

-- 文件初始化
function Initialize()
    GameEvents.Nw_DTMS_PLAYER_ALEXANDER.Add(Nw_DTMS_PLAYER_ALEXANDER);
    GameEvents.Nw_DTMS_CityGotBuilding.Add(Nw_DTMS_CityGotBuilding);
    GameEvents.Nw_DTMS_PLAYER_ATTACH.Add(Nw_DTMS_PLAYER_ATTACH);
    GameEvents.Nw_DTMS_HAMMURABI_LAW.Add(Nw_DTMS_HAMMURABI_LAW);
	print('DTMS Script Loaded Succeed.')
end
Events.LoadGameViewStateDone.Add(Initialize)