-- // ----------------------------------------------------------------------------------------------
-- // Author: Sparrow
-- // DateCreated: 01/24/2019 2:27:04 PM
-- // ----------------------------------------------------------------------------------------------
include("Civ6Common");
include("InstanceManager");
include("SupportFunctions");
include("PopupDialog");
include("AnimSidePanelSupport");
include("Cheat_Menu_CityBannerManager");
include( "CitySupport" );

local playerID 						= Game.GetLocalPlayer();
local pPlayer 						= Players[playerID];
local pTreasury 					= pPlayer:GetTreasury();
local pReligion 					= pPlayer:GetReligion();
local pEnvoy 						= pPlayer:GetInfluence();
local pVis 							= PlayersVisibility[playerID];
local pNewGP 						= 1;
local pNewEnvoy 					= 5;
local pNewReligion 					= 1000;
local pNewFavor						= 100;
local pNewPopulation				= 1;
local m_hideCheatPanel				= false;
local m_IsLoading			= false;
local m_IsAttached			= false;

-- // ----------------------------------------------------------------------------------------------
-- // MENU BUTTON FUNCTIONS
-- // ----------------------------------------------------------------------------------------------

function ChangeLUXURYResources(playerID)
 	if pPlayer:IsHuman() then
        UI.RequestPlayerOperation(pPlayer, PlayerOperations.EXECUTE_SCRIPT, {
            OnStart = "ChangeLUXURYResources"
        });
	end
end
function ChangeSTRATEGICResources(playerID)
 	if pPlayer:IsHuman() then		
        UI.RequestPlayerOperation(pPlayer, PlayerOperations.EXECUTE_SCRIPT, {
            OnStart = "ChangeSTRATEGICResources"
        });
	end
end
function ChangeBONUSResources(playerID)
 	if pPlayer:IsHuman() then		
        UI.RequestPlayerOperation(pPlayer, PlayerOperations.EXECUTE_SCRIPT, {
            OnStart = "ChangeBONUSResources"
        });
	end
end
function ChangeEraScore()
	if pPlayer:IsHuman() then
        UI.RequestPlayerOperation(pPlayer, PlayerOperations.EXECUTE_SCRIPT, {
            OnStart = "ChangeEraScore"
        });
    end
	RefreshActionPanel();
end
function ChangeEraScoreBack()
	if pPlayer:IsHuman() then
        UI.RequestPlayerOperation(pPlayer, PlayerOperations.EXECUTE_SCRIPT, {
            OnStart = "ChangeEraScoreBack"
        });
    end
	RefreshActionPanel();
end
function ChangeGold()
	if pPlayer:IsHuman() then
        UI.RequestPlayerOperation(pPlayer, PlayerOperations.EXECUTE_SCRIPT, {
            OnStart = "ChangeGold"
        });
    end
end
function ChangeGoldMore()
	if pPlayer:IsHuman() then
        UI.RequestPlayerOperation(pPlayer, PlayerOperations.EXECUTE_SCRIPT, {
            OnStart = "ChangeGoldMore"
        });
    end
end
function CompleteProduction()
 	local pCity = UI.GetHeadSelectedCity();
	if pPlayer:IsHuman() then
        UI.RequestPlayerOperation(pPlayer, PlayerOperations.EXECUTE_SCRIPT, {
            OnStart = "CompleteProduction",
			iCity = pCity:GetID()
        });
	end
end
function CompleteAllResearch()
 	local pTechs = pPlayer:GetTechs()
	if pPlayer:IsHuman() then
        UI.RequestPlayerOperation(pPlayer, PlayerOperations.EXECUTE_SCRIPT, {
            OnStart = "CompleteAllResearch"
        });
	end		
end
function CompleteAllCivic()
 	local pTechs = pPlayer:GetCulture()
	if pPlayer:IsHuman() then		
        UI.RequestPlayerOperation(pPlayer, PlayerOperations.EXECUTE_SCRIPT, {
            OnStart = "CompleteAllCivic"
        });
	end		
end
function CompleteResearch()
 	local pTechs = pPlayer:GetTechs()
	local pRTech = pTechs:GetResearchingTech()	
	if pRTech >= 0 then
		local pCost = pTechs:GetResearchCost(pRTech)	
		local pProgress = pTechs:GetResearchProgress(pRTech)
		local pResearchComplete = (pCost - pProgress)
		if pPlayer:IsHuman() then
			UI.RequestPlayerOperation(pPlayer, PlayerOperations.EXECUTE_SCRIPT, {
				OnStart = "CompleteResearch",
				pResearchComplete = pResearchComplete
			});
		end		
	end
end
function CompleteCivic()
 	local pCivics = pPlayer:GetCulture()
	local pRCivic = pCivics:GetProgressingCivic()
	if pRCivic >= 0 then		
		local pCost = pCivics:GetCultureCost(pRCivic)	
		local pProgress = pCivics:GetCulturalProgress(pRCivic)
		local pCivicComplete = (pCost - pProgress)
		if pPlayer:IsHuman() then
			UI.RequestPlayerOperation(pPlayer, PlayerOperations.EXECUTE_SCRIPT, {
				OnStart = "CompleteCivic",
				pCivicComplete = pCivicComplete
			});
		end
	end	
end
function ChangeFaith()
	if pPlayer:IsHuman() then
		UI.RequestPlayerOperation(pPlayer, PlayerOperations.EXECUTE_SCRIPT, {
			OnStart = "ChangeFaith"
		});
    end
end
function ChangePopulation()
 	local pCity = UI.GetHeadSelectedCity();
	if pCity ~= nil and pPlayer:IsHuman() then
		UI.RequestPlayerOperation(pPlayer, PlayerOperations.EXECUTE_SCRIPT, {
			OnStart = "ChangePopulation",
			City = pCity:GetID()
		});
	end
end
function RestoreCityHealth()
 	local pCity = UI.GetHeadSelectedCity();
 	if pPlayer:IsHuman() then
		UI.RequestPlayerOperation(pPlayer, PlayerOperations.EXECUTE_SCRIPT, {
			OnStart = "RestoreCityHealth",
			iCity = pCity:GetID()
		});
	end
end
function ChangeCityLoyalty()
 	local pCity = UI.GetHeadSelectedCity();
 	if pPlayer:IsHuman() then
		UI.RequestPlayerOperation(pPlayer, PlayerOperations.EXECUTE_SCRIPT, {
			OnStart = "ChangeCityLoyalty",
			iCity = pCity:GetID()
		});
	end
end
function DestroyCity()
	local pCity = UI.GetHeadSelectedCity();
	if pCity ~= nil and pPlayer:IsHuman() then
		local pCityName = Locale.Lookup(pCity:GetName());
		local pCityPop = Locale.Lookup(pCity:GetPopulation());
		UI.RequestPlayerOperation(pPlayer, PlayerOperations.EXECUTE_SCRIPT, {
			OnStart = "DestroyCity",
			iCity = pCity:GetID()
		});
	end
end
function UnitPromote()
	local pUnit = UI.GetHeadSelectedUnit();
    if pUnit ~= nil and pPlayer:IsHuman() then
		local unitID = pUnit:GetID();
		UI.RequestPlayerOperation(pPlayer, PlayerOperations.EXECUTE_SCRIPT, {
			OnStart = "UnitPromote",
			unitID = unitID
		});
	end
end
function UnitMovementChange()
	local pUnit = UI.GetHeadSelectedUnit();
    if pUnit ~= nil and pPlayer:IsHuman() then
		local unitID = pUnit:GetID();
		UI.RequestPlayerOperation(pPlayer, PlayerOperations.EXECUTE_SCRIPT, {
			OnStart = "UnitMovementChange",
			unitID = unitID
		});
	end
end
function UnitAddMovement()
	local pUnit = UI.GetHeadSelectedUnit();
    if pUnit ~= nil and pPlayer:IsHuman() then
		local unitID = pUnit:GetID();
		UI.RequestPlayerOperation(pPlayer, PlayerOperations.EXECUTE_SCRIPT, {
			OnStart = "UnitAddMovement",
			unitID = unitID
		});
    end
end
function OnDuplicate()
	local pUnit = UI.GetHeadSelectedUnit();
	if pUnit ~= nil and pPlayer:IsHuman() then
		local unitID = pUnit:GetID();
		local unitType = GameInfo.Units[pUnit:GetUnitType()].UnitType;
		UI.RequestPlayerOperation(pPlayer, PlayerOperations.EXECUTE_SCRIPT, {
			OnStart = "OnDuplicate",
			unitID = unitID,
			unitType = unitType
		});
    end
end
function UnitHealChange()
	local pUnit = UI.GetHeadSelectedUnit();
    if pUnit ~= nil and pPlayer:IsHuman() then
		local unitID = pUnit:GetID();
		UI.RequestPlayerOperation(pPlayer, PlayerOperations.EXECUTE_SCRIPT, {
			OnStart = "UnitHealChange",
			unitID = unitID
		});
	end
end
function UnitFormCorps()
	local pUnit = UI.GetHeadSelectedUnit();
    if pUnit ~= nil and pPlayer:IsHuman() then
		local unitID = pUnit:GetID();
		UI.RequestPlayerOperation(pPlayer, PlayerOperations.EXECUTE_SCRIPT, {
			OnStart = "UnitFormCorps",
			unitID = unitID
		});
	end
end
function UnitFormArmy()
	local pUnit = UI.GetHeadSelectedUnit();
    if pUnit ~= nil and pPlayer:IsHuman() then
		local unitID = pUnit:GetID();
		UI.RequestPlayerOperation(pPlayer, PlayerOperations.EXECUTE_SCRIPT, {
			OnStart = "UnitFormArmy",
			unitID = unitID
		});
	end
end
function MakeFreeCity()
	local pCity = UI.GetHeadSelectedCity();
	if pPlayer:IsHuman() then
		UI.RequestPlayerOperation(pPlayer, PlayerOperations.EXECUTE_SCRIPT, {
			OnStart = "MakeFreeCity",
			iCity = pCity:GetID()
		});
    end
end
function ChangeEnvoy()
	if pPlayer:IsHuman() then
		UI.RequestPlayerOperation(pPlayer, PlayerOperations.EXECUTE_SCRIPT, {
			OnStart = "ChangeEnvoy",
			pNewEnvoy = pNewEnvoy
		});
    end
end
function ChangeDiplomaticFavor()
	if pPlayer:IsHuman() then
		UI.RequestPlayerOperation(pPlayer, PlayerOperations.EXECUTE_SCRIPT, {
			OnStart = "ChangeDiplomaticFavor",
			pNewFavor = pNewFavor
		});
    end
end
function ChangeGovPoints()
	if pPlayer:IsHuman() then
		UI.RequestPlayerOperation(pPlayer, PlayerOperations.EXECUTE_SCRIPT, {
			OnStart = "ChangeGovPoints",
			pNewGP = pNewGP
		});
    end
end
function RevealAll()
	if pPlayer:IsHuman() then		
		LuaEvents.ChangeFOW(playerID)
		UI.RequestPlayerOperation(pPlayer, PlayerOperations.EXECUTE_SCRIPT, {
			OnStart = "RevealAll"
		});
	end		
end

function RefreshActionPanel()
	if pPlayer:IsHuman() then
		local UPContextPtr = ContextPtr:LookUpControl("/InGame/ActionPanel");
		if UPContextPtr ~= nil then
			UPContextPtr:RequestRefresh(); 
		end
	end
	ContextPtr:RequestRefresh(); 
end

-- // ----------------------------------------------------------------------------------------------
-- // HOTKEYS
-- // ----------------------------------------------------------------------------------------------
function OnInputActionTriggered( actionId )
	if ( actionId == Input.GetActionId("ToggleGold") ) then
		ChangeGold();
	end
	if ( actionId == Input.GetActionId("ToggleGoldMore") ) then
		ChangeGoldMore();
	end
	if ( actionId == Input.GetActionId("ToggleFaith") ) then
		ChangeFaith();
	end
	if ( actionId == Input.GetActionId("ToggleCProduction") ) then
		CompleteProduction();
	end
	if ( actionId == Input.GetActionId("ToggleCCivic") ) then
		CompleteCivic();
	end
	if ( actionId == Input.GetActionId("ToggleCResearch") ) then
		CompleteResearch();
	end
	if ( actionId == Input.GetActionId("ToggleEnvoy") ) then
		ChangeEnvoy();
	end
	if ( actionId == Input.GetActionId("ToggleEra") ) then
		ChangeEraScore();
	end
	if ( actionId == Input.GetActionId("ToggleObs") ) then
		RevealAll();
	end
	if ( actionId == Input.GetActionId("ToggleUnitMovementChange") ) then
		UnitMovementChange();
	end
	if ( actionId == Input.GetActionId("ToggleUnitHealChange") ) then
		UnitHealChange();
	end
	if ( actionId == Input.GetActionId("ToggleUnitPromote") ) then
		UnitPromote();
	end
	if ( actionId == Input.GetActionId("ToggleDuplicate") ) then
		OnDuplicateUnit();
	end
	if ( actionId == Input.GetActionId("ToggleChangePopulation") ) then
		ChangePopulation();
	end
	if ( actionId == Input.GetActionId("ToggleChangeCityLoyalty") ) then
		ChangeCityLoyalty();
	end
	if ( actionId == Input.GetActionId("ToggleCompleteAllResearch") ) then
		CompleteAllResearch();
	end
	if ( actionId == Input.GetActionId("ToggleCompleteAllCivic") ) then
		CompleteAllCivic();
	end
	if ( actionId == Input.GetActionId("ToggleMenu") ) then
		OnMenuButtonToggle();
	end
	if ( actionId == Input.GetActionId("ToggleDiplomaticFavor") ) then
		ChangeDiplomaticFavor();
	end
end

