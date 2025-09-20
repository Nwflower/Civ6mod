-- // ----------------------------------------------------------------------------------------------
-- // Author: Sparrow
-- // DateCreated: 01/24/2019 2:27:04 PM
-- // ----------------------------------------------------------------------------------------------


-- // ----------------------------------------------------------------------------------------------
-- // Event Handlers
-- // ----------------------------------------------------------------------------------------------
function ChangeLUXURYResources(playerID, params)
    local pPlayer = Players[playerID]
    local resourceInfo = GameInfo.Resources();
    local playerResources = Players[playerID]:GetResources();
    local iValue = 2;
    for resource in GameInfo.Resources() do
        if resource.ResourceClassType == "RESOURCECLASS_LUXURY" then
            playerResources:ChangeResourceAmount(resource.Index, iValue);
        end
    end
end
function ChangeSTRATEGICResources(playerID)
    local pPlayer = Players[playerID]
    local resourceInfo = GameInfo.Resources();
    local playerResources = Players[playerID]:GetResources();
    local iValue = 2;
    for resource in GameInfo.Resources() do
        if resource.ResourceClassType == "RESOURCECLASS_STRATEGIC" then
            playerResources:ChangeResourceAmount(resource.Index, iValue);
        end
    end
end
function ChangeBONUSResources(playerID)
    local pPlayer = Players[playerID]
    local resourceInfo = GameInfo.Resources();
    local playerResources = Players[playerID]:GetResources();
    local iValue = 2;
    for resource in GameInfo.Resources() do
        if resource.ResourceClassType == "RESOURCECLASS_BONUS" then
            playerResources:ChangeResourceAmount(resource.Index, iValue);
        end
    end
end
function ChangeEraScore(playerID)

    local pPlayer = Players[playerID]
    if (Game.GetEras ~= nil) then
        Game.GetEras():ChangePlayerEraScore(playerID, 10);
    end
end
function ChangeEraScoreBack(playerID)
    if (Game.GetEras ~= nil) then
        Game.GetEras():ChangePlayerEraScore(playerID, -10);
    end
end
function ChangeGold(playerID)
    local pPlayer = Players[playerID]
    local pTreasury = pPlayer:GetTreasury()
    pTreasury:ChangeGoldBalance(10000)
end
function ChangeGoldMore(playerID)
    local pPlayer = Players[playerID]
    local pTreasury = pPlayer:GetTreasury()
    pTreasury:ChangeGoldBalance(100000)
end
function CompleteProduction(playerID, params)
    local pPlayer = Players[playerID]
    local pCity = pPlayer:GetCities():FindID(params.iCity)
    local pCityBuildQueue = pCity:GetBuildQueue();
	pCityBuildQueue:FinishProgress()
end
function CompleteAllResearch(playerID)
    local pPlayer = Players[playerID]
    local pTechs = pPlayer:GetTechs()
    for kTech in GameInfo.Technologies() do
        pTechs:SetResearchProgress(kTech.Index, pTechs:GetResearchCost(kTech.Index))
    end
end
function CompleteAllCivic(playerID)
    local pPlayer = Players[playerID]
    local pTechs = pPlayer:GetCulture()
    for kTech in GameInfo.Civics() do
        pTechs:SetCulturalProgress(kTech.Index, pTechs:GetCultureCost(kTech.Index))
    end
end
function CompleteResearch(playerID, pResearchComplete)
    local pPlayer = Players[playerID]
    local pResearch = pPlayer:GetTechs()
    pResearch:ChangeCurrentResearchProgress(pResearchComplete.pResearchComplete)
end
function CompleteCivic(playerID, pCivicComplete)
    local pPlayer = Players[playerID]
    local pCivics = pPlayer:GetCulture()
    pCivics:ChangeCurrentCulturalProgress(pCivicComplete.pCivicComplete)
end
function ChangeFaith(playerID)
    local pPlayer = Players[playerID]
    local pReligion = pPlayer:GetReligion()
    pReligion:ChangeFaithBalance(20000)
end
function ChangePopulation(playerID, params)
    local pPlayer = Players[playerID]
    local pCity = pPlayer:GetCities():FindID(params.CityID)
    if pCity ~= nil then
        pCity:ChangePopulation(1);
    end
end
function MakeFreeCity(playerID, params)
    local pPlayer = Players[playerID]
	local pCity = pPlayer:GetCities():FindID(params.iCity)
	if pCity ~= nil then
		CityManager.TransferCityToFreeCities(pCity);
	end
end
function RestoreCityHealth(playerID, params)
    local pPlayer = Players[playerID]
	local pCity = pPlayer:GetCities():FindID(params.iCity)
	if (pCity ~= nil) then
		local pCityDistricts = pCity:GetDistricts();
		if (pCityDistricts ~= nil) then
			local pCityCenter = pCityDistricts:GetDistrictAtLocation(pCity:GetX(), pCity:GetY());
			if (pCityCenter ~= nil) then
				pCityCenter:SetDamage(DefenseTypes.DISTRICT_GARRISON, 0);
				pCityCenter:SetDamage(DefenseTypes.DISTRICT_OUTER, 0);
			end
		end
	end
end
function ChangeCityLoyalty(playerID, params)
    local pPlayer = Players[playerID]
	local pCity = pPlayer:GetCities():FindID(params.iCity)
	pCity:ChangeLoyalty(100)
end
function UnitPromote(playerID, params)
    local pUnit = UnitManager.GetUnit(playerID, params.unitID)
    local pUnitExp = pUnit:GetExperience():GetExperienceForNextLevel();
    if pUnitExp > 0 then
        pUnit:GetExperience():ChangeExperience(pUnitExp);
        UnitManager.ChangeMovesRemaining(pUnit, 1);
    end
end
function UnitMovementChange(playerID, params)
    local pUnit = UnitManager.GetUnit(playerID, params.unitID)
    if (pUnit ~= nil) then
        UnitManager.RestoreMovement(pUnit);
        UnitManager.RestoreUnitAttacks(pUnit);
    end
end
function UnitAddMovement(playerID, params)
    local pUnit = UnitManager.GetUnit(playerID, params.unitID)
    if (pUnit ~= nil) then
        UnitManager.ChangeMovesRemaining(pUnit, 5);
        UnitManager.RestoreUnitAttacks(pUnit);
    end
end
function OnDuplicate(playerID, params)
    local DupeUnit = nil;
    local pUnit = UnitManager.GetUnit(playerID, params.unitID);
    local pPlot = Map.GetPlot(pUnit:GetX(), pUnit:GetY());
    if pUnit ~= nil and Players[playerID]:IsHuman() then
        DupeUnit = UnitManager.InitUnitValidAdjacentHex(playerID, params.unitType, pPlot:GetX(), pPlot:GetY(), 1);
    end
end
function UnitHealChange(playerID, params)
    local pUnit = UnitManager.GetUnit(playerID, params.unitID)
    if (pUnit ~= nil) then
        pUnit:SetDamage(0);
    end
end
function UnitFormCorps(playerID, params)
    local pUnit = UnitManager.GetUnit(playerID, params.unitID)
    if (pUnit ~= nil) then
        pUnit:SetMilitaryFormation(MilitaryFormationTypes.CORPS_FORMATION);
    end
end
function UnitFormArmy(playerID, params)
    local pUnit = UnitManager.GetUnit(playerID, params.unitID)
    if (pUnit ~= nil) then
        pUnit:SetMilitaryFormation(MilitaryFormationTypes.ARMY_FORMATION);
    end
end
function ChangeEnvoy(playerID, params)
    local pPlayer = Players[playerID]
    local pEnvoy = pPlayer:GetInfluence()
    pEnvoy:ChangeTokensToGive(params.pNewEnvoy)
end
function ChangeDiplomaticFavor(playerID, params)
    local pPlayer = Players[playerID]
    if pPlayer:GetDiplomacy().ChangeFavor ~= nil then
        pPlayer:GetDiplomacy():ChangeFavor(params.pNewFavor);
    end
end
function ChangeGovPoints(playerID, params)
    local pPlayer = Players[playerID];
    pPlayer:GetGovernors():ChangeGovernorPoints(params.pNewGP);
end
function RevealAll(playerID)
    local eObserverID = Game.GetLocalObserver();
    if (eObserverID == PlayerTypes.OBSERVER) then
        PlayerManager.SetLocalObserverTo(playerID);
    else
        PlayerManager.SetLocalObserverTo(PlayerTypes.OBSERVER);
    end
end

-- // ----------------------------------------------------------------------------------------------
-- // Lua Events
-- // ----------------------------------------------------------------------------------------------
function Initialize()
    GameEvents.ChangeLUXURYResources.Add(ChangeLUXURYResources)
    GameEvents.ChangeSTRATEGICResources.Add(ChangeSTRATEGICResources)
    GameEvents.ChangeBONUSResources.Add(ChangeBONUSResources)
    GameEvents.ChangeEraScore.Add(ChangeEraScore)
    GameEvents.ChangeEraScoreBack.Add(ChangeEraScoreBack)
    GameEvents.ChangeGold.Add(ChangeGold)
    GameEvents.ChangeGoldMore.Add(ChangeGoldMore)
    GameEvents.CompleteProduction.Add(CompleteProduction)
    GameEvents.CompleteAllResearch.Add(CompleteAllResearch)
    GameEvents.CompleteAllCivic.Add(CompleteAllCivic)
    GameEvents.CompleteResearch.Add(CompleteResearch)
    GameEvents.CompleteCivic.Add(CompleteCivic)
    GameEvents.ChangeFaith.Add(ChangeFaith)
    GameEvents.ChangePopulation.Add(ChangePopulation)
    GameEvents.MakeFreeCity.Add(MakeFreeCity)
    GameEvents.RestoreCityHealth.Add(RestoreCityHealth)
    GameEvents.ChangeCityLoyalty.Add(ChangeCityLoyalty)
    GameEvents.UnitPromote.Add(UnitPromote)
    GameEvents.UnitMovementChange.Add(UnitMovementChange)
    GameEvents.UnitAddMovement.Add(UnitAddMovement)
    GameEvents.OnDuplicate.Add(OnDuplicate)
    GameEvents.UnitHealChange.Add(UnitHealChange)
    GameEvents.UnitFormCorps.Add(UnitFormCorps)
    GameEvents.UnitFormArmy.Add(UnitFormArmy)
    GameEvents.ChangeEnvoy.Add(ChangeEnvoy)
    GameEvents.ChangeDiplomaticFavor.Add(ChangeDiplomaticFavor)
    GameEvents.ChangeGovPoints.Add(ChangeGovPoints)
    GameEvents.RevealAll.Add(RevealAll)
    print("Cheat Menu Initialization Started");
end

Initialize();
