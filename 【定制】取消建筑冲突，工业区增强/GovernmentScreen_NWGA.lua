-- Copyright 2020, Firaxis Games
include("GovernmentScreen_Expansion2");

XP2_GetPolicyBGTexture = GetPolicyBGTexture;
XP2_PopulateLivePlayerData = PopulateLivePlayerData;
XP2_RealizeFilterTabs = RealizeFilterTabs;
XP2_SortPolicies = SortPolicies;

-- ===========================================================================
function FilterGoldenPolicies(policy)
    local policyDef = GameInfo.Policies_XP1[policy.PolicyHash];
    if policyDef ~= nil and policyDef.RequiresGoldenAge then
        return true;
    end
    return false;
end

-- ===========================================================================
function GetPolicyBGTexture(policyType)
	local expansionPolicy = GameInfo.Policies_XP1[policyType];
	if expansionPolicy and expansionPolicy.RequiresGoldenAge then
		return "Governments_GoldenCard";
	end
	return XP2_GetPolicyBGTexture(policyType);
end

-- ===========================================================================
function PopulateLivePlayerData( ePlayer )
	
	if ePlayer == PlayerTypes.NONE then
		return;
	end

	XP2_PopulateLivePlayerData(ePlayer);

	if(ePlayer == Game.GetLocalPlayer() and m_kUnlockedPolicies) then
		local eraTable = Game.GetEras();
		if eraTable:HasDarkAge(ePlayer) and Game.GetCurrentGameTurn() == eraTable:GetCurrentEraStartTurn() then
			for policyType, isUnlocked in pairs(m_kUnlockedPolicies) do
				if isUnlocked then
					local expansionPolicy = GameInfo.Policies_XP1[policyType];
					if expansionPolicy and expansionPolicy.RequiresDarkAge then
						m_kNewPoliciesThisTurn[policyType] = true;
					end
				end
			end
		end
	end 
end

-- ===========================================================================
--	Sort function used on policy catalog
-- ===========================================================================
function SortPolicies( typeA, typeB )
	local a  = GameInfo.Policies_XP1[typeA];
	local b  = GameInfo.Policies_XP1[typeB];
	if a and a.RequiresGoldenAge then
		return 1>2
	end
	if b and b.RequiresGoldenAge then
		return 1<2
	end
	if a and a.RequiresDarkAge then
		return 1>2
	end
	if b and b.RequiresDarkAge then
		return 1<2
	end
	return XP2_SortPolicies( typeA, typeB );
end

-- ===========================================================================
function RealizeFilterTabs()
	XP2_RealizeFilterTabs();
    CreatePolicyTabButton("LOC_GOVT_FILTER_GOLDEN", FilterGoldenPolicies);
end
