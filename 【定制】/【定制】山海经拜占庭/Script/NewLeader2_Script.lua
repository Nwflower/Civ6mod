include("SupportFunctions");
-- ===========================================================================
--	Constants
-- ===========================================================================
local iReligion_ScientificDecay = 0;
local iReligion_DecayTech = GameInfo.Technologies["TECH_SCIENTIFIC_THEORY"].Index

local iReligion_ByzantiumRange = 90; -- In tiles covered, 90 tiles covered = 5 tiles radius 
local iReligion_ByzantiumMultiplier = 5; -- multipler X unit base combat strength

local iTrait_GilgameshPillageRange = 6; -- In Radius 6 anything less than 6 excluding 6
local iTrait_GilgameshXPRange = 6; -- In Radius 6 anything less than 6 excluding 6

local iDomination_level = 0.60;

local NO_TEAM = -1;
local NO_PLAYER = -1;
local NO_PLOT = -1;
local NO_UNIT = -1;
local NO_DISTRICT = -1;
local NO_IMPROVEMENT = -1;
local NO_BUILDING = -1;

function OnCombatOccurred(attackerPlayerID, attackerUnitID, defenderPlayerID, defenderUnitID, attackerDistrictID, defenderDistrictID)
    if (attackerPlayerID == NO_PLAYER
            or defenderPlayerID == NO_PLAYER) then
        return ;
    end

    local pAttackerPlayer = Players[attackerPlayerID];
    local pAttackerReligion = pAttackerPlayer:GetReligion()
    local pAttackerLeader = PlayerConfigurations[attackerPlayerID]:GetLeaderTypeName()
    local pDefenderPlayer = Players[defenderPlayerID];
    local pAttackingUnit = attackerUnitID ~= NO_UNIT and pAttackerPlayer:GetUnits():FindID(attackerUnitID) or nil;
    local pDefendingUnit = defenderUnitID ~= NO_UNIT and pDefenderPlayer:GetUnits():FindID(defenderUnitID) or nil;
    local pAttackingDistrict = attackerDistrictID ~= NO_DISTRICT and pAttackerPlayer:GetDistricts():FindID(attackerDistrictID) or nil;
    local pDefendingDistrict = defenderDistrictID ~= NO_DISTRICT and pDefenderPlayer:GetDistricts():FindID(defenderDistrictID) or nil;

    -- Attacker died to defender.
    if (pAttackingUnit ~= nil and pDefendingUnit ~= nil and (pDefendingUnit:IsDead() or pDefendingUnit:IsDelayedDeath())) then
        if pAttackerLeader == "LEADER_BASIL_ALT" then
            local x = pAttackingUnit:GetX()
            local y = pAttackingUnit:GetY()
            local power = pDefendingUnit:GetCombat()
            local religionType = pAttackerReligion:GetReligionTypeCreated()
            if x ~= nil and y ~= nil and power ~= nil and religionType ~= nil and religionType ~= -1 then
                ApplyByzantiumTrait(x, y, power, religionType, attackerPlayerID)
            end
        end
    end

end

-- ===========================================================================
--	Bizantium
-- ===========================================================================
function ApplyByzantiumTrait(x, y, power, religionType, playerID)
    if x == nil or y == nil or power == nil or religionType == nil then
        return
    end
    local religionInfo = GameInfo.Religions[religionType]

    local pPlot = Map.GetPlot(x, y)
    for i = 1, iReligion_ByzantiumRange do
        local plotScanned = GetAdjacentTiles(pPlot, i)
        if plotScanned ~= nil then
            if plotScanned:IsCity() then
                local pCity = Cities.GetCityInPlot(plotScanned)
                local pCityReligion = pCity:GetReligion()
                local impact = 125--power * iReligion_ByzantiumMultiplier
                print("playerID " .. tostring(playerID))
                print("playerID " .. tostring(religionType))
                print("playerID " .. tostring(impact))
                pCityReligion:AddReligiousPressure(playerID, religionType, impact, -1);
                print("Added Religious Pressure", impact, pCity:GetName())
                local message = "+" .. tostring(impact)
                if religionInfo ~= nil then
                    message = message .. " " .. tostring("[ICON_Religion]")
                else
                    message = message .. " [ICON_Religion]"
                end
                Game.AddWorldViewText(0, message, pCity:GetX(), pCity:GetY());
            end
        end
    end
end

function GetAdjacentTiles(plot, index)
    -- This is an extended version of Firaxis, moving like a clockwise snail on the hexagon grids
    local gridWidth, gridHeight = Map.GetGridSize();
    local count = 0;
    local k = 0;
    local adjacentPlot = nil;
    local adjacentPlot2 = nil;
    local adjacentPlot3 = nil;
    local adjacentPlot4 = nil;
    local adjacentPlot5 = nil;


    -- Return Spawn if index < 0
    if (plot ~= nil and index ~= nil) then
        if (index < 0) then
            return plot;
        end

    else

        __Debug("GetAdjacentTiles: Invalid Arguments");
        return nil;
    end



    -- Return Starting City Circle if index between #0 to #5 (like Firaxis' GetAdjacentPlot)
    for i = 0, 5 do
        if (plot:GetX() >= 0 and plot:GetY() < gridHeight) then
            adjacentPlot = Map.GetAdjacentPlot(plot:GetX(), plot:GetY(), i);
            if (adjacentPlot ~= nil and index == i) then
                return adjacentPlot
            end
        end
    end

    -- Return Inner City Circle if index between #6 to #17

    count = 5;
    for i = 0, 5 do
        if (plot:GetX() >= 0 and plot:GetY() < gridHeight) then
            adjacentPlot2 = Map.GetAdjacentPlot(plot:GetX(), plot:GetY(), i);
        end

        for j = i, i + 1 do
            --__Debug(i, j)
            k = j;
            count = count + 1;

            if (k == 6) then
                k = 0;
            end

            if (adjacentPlot2 ~= nil) then
                if (adjacentPlot2:GetX() >= 0 and adjacentPlot2:GetY() < gridHeight) then
                    adjacentPlot = Map.GetAdjacentPlot(adjacentPlot2:GetX(), adjacentPlot2:GetY(), k);

                else

                    adjacentPlot = nil;
                end
            end

            if (adjacentPlot ~= nil) then
                if (index == count) then
                    return adjacentPlot
                end
            end

        end
    end

    -- #18 to #35 Outer city circle
    count = 0;
    for i = 0, 5 do
        if (plot:GetX() >= 0 and plot:GetY() < gridHeight) then
            adjacentPlot = Map.GetAdjacentPlot(plot:GetX(), plot:GetY(), i);
            adjacentPlot2 = nil;
            adjacentPlot3 = nil;
        else
            adjacentPlot = nil;
            adjacentPlot2 = nil;
            adjacentPlot3 = nil;
        end
        if (adjacentPlot ~= nil) then
            if (adjacentPlot:GetX() >= 0 and adjacentPlot:GetY() < gridHeight) then
                adjacentPlot3 = Map.GetAdjacentPlot(adjacentPlot:GetX(), adjacentPlot:GetY(), i);
            end
            if (adjacentPlot3 ~= nil) then
                if (adjacentPlot3:GetX() >= 0 and adjacentPlot3:GetY() < gridHeight) then
                    adjacentPlot2 = Map.GetAdjacentPlot(adjacentPlot3:GetX(), adjacentPlot3:GetY(), i);
                end
            end
        end

        if (adjacentPlot2 ~= nil) then
            count = 18 + i * 3;
            if (index == count) then
                return adjacentPlot2
            end
        end

        adjacentPlot2 = nil;

        if (adjacentPlot3 ~= nil) then
            if (i + 1) == 6 then
                if (adjacentPlot3:GetX() >= 0 and adjacentPlot3:GetY() < gridHeight) then
                    adjacentPlot2 = Map.GetAdjacentPlot(adjacentPlot3:GetX(), adjacentPlot3:GetY(), 0);
                end
            else
                if (adjacentPlot3:GetX() >= 0 and adjacentPlot3:GetY() < gridHeight) then
                    adjacentPlot2 = Map.GetAdjacentPlot(adjacentPlot3:GetX(), adjacentPlot3:GetY(), i + 1);
                end
            end
        end

        if (adjacentPlot2 ~= nil) then
            count = 18 + i * 3 + 1;
            if (index == count) then
                return adjacentPlot2
            end
        end

        adjacentPlot2 = nil;

        if (adjacentPlot ~= nil) then
            if (i + 1 == 6) then
                if (adjacentPlot:GetX() >= 0 and adjacentPlot:GetY() < gridHeight) then
                    adjacentPlot3 = Map.GetAdjacentPlot(adjacentPlot:GetX(), adjacentPlot:GetY(), 0);
                end
                if (adjacentPlot3 ~= nil) then
                    if (adjacentPlot3:GetX() >= 0 and adjacentPlot3:GetY() < gridHeight) then
                        adjacentPlot2 = Map.GetAdjacentPlot(adjacentPlot3:GetX(), adjacentPlot3:GetY(), 0);
                    end
                end
            else
                if (adjacentPlot:GetX() >= 0 and adjacentPlot:GetY() < gridHeight) then
                    adjacentPlot3 = Map.GetAdjacentPlot(adjacentPlot:GetX(), adjacentPlot:GetY(), i + 1);
                end
                if (adjacentPlot3 ~= nil) then
                    if (adjacentPlot3:GetX() >= 0 and adjacentPlot3:GetY() < gridHeight) then
                        adjacentPlot2 = Map.GetAdjacentPlot(adjacentPlot3:GetX(), adjacentPlot3:GetY(), i + 1);
                    end
                end
            end
        end

        if (adjacentPlot2 ~= nil) then
            count = 18 + i * 3 + 2;
            if (index == count) then
                return adjacentPlot2;
            end
        end

    end

    --  #35 #59 These tiles are outside the workable radius of the city
    local count = 0
    for i = 0, 5 do
        if (plot:GetX() >= 0 and plot:GetY() < gridHeight) then
            adjacentPlot = Map.GetAdjacentPlot(plot:GetX(), plot:GetY(), i);
            adjacentPlot2 = nil;
            adjacentPlot3 = nil;
            adjacentPlot4 = nil;
        else
            adjacentPlot = nil;
            adjacentPlot2 = nil;
            adjacentPlot3 = nil;
            adjacentPlot4 = nil;
        end
        if (adjacentPlot ~= nil) then
            if (adjacentPlot:GetX() >= 0 and adjacentPlot:GetY() < gridHeight) then
                adjacentPlot3 = Map.GetAdjacentPlot(adjacentPlot:GetX(), adjacentPlot:GetY(), i);
            end
            if (adjacentPlot3 ~= nil) then
                if (adjacentPlot3:GetX() >= 0 and adjacentPlot3:GetY() < gridHeight) then
                    adjacentPlot4 = Map.GetAdjacentPlot(adjacentPlot3:GetX(), adjacentPlot3:GetY(), i);
                    if (adjacentPlot4 ~= nil) then
                        if (adjacentPlot4:GetX() >= 0 and adjacentPlot4:GetY() < gridHeight) then
                            adjacentPlot2 = Map.GetAdjacentPlot(adjacentPlot4:GetX(), adjacentPlot4:GetY(), i);
                        end
                    end
                end
            end
        end

        if (adjacentPlot2 ~= nil) then
            terrainType = adjacentPlot2:GetTerrainType();
            if (adjacentPlot2 ~= nil) then
                count = 36 + i * 4;
                if (index == count) then
                    return adjacentPlot2;
                end
            end

        end

        if (adjacentPlot3 ~= nil) then
            if (i + 1) == 6 then
                if (adjacentPlot3:GetX() >= 0 and adjacentPlot3:GetY() < gridHeight) then
                    adjacentPlot4 = Map.GetAdjacentPlot(adjacentPlot3:GetX(), adjacentPlot3:GetY(), 0);
                end
            else
                if (adjacentPlot3:GetX() >= 0 and adjacentPlot3:GetY() < gridHeight) then
                    adjacentPlot4 = Map.GetAdjacentPlot(adjacentPlot3:GetX(), adjacentPlot3:GetY(), i + 1);
                end
            end
        end

        if (adjacentPlot4 ~= nil) then
            if (adjacentPlot4:GetX() >= 0 and adjacentPlot4:GetY() < gridHeight) then
                adjacentPlot2 = Map.GetAdjacentPlot(adjacentPlot4:GetX(), adjacentPlot4:GetY(), i);
                if (adjacentPlot2 ~= nil) then
                    count = 36 + i * 4 + 1;
                    if (index == count) then
                        return adjacentPlot2;
                    end
                end
            end


        end

        adjacentPlot4 = nil;

        if (adjacentPlot ~= nil) then
            if (i + 1 == 6) then
                if (adjacentPlot:GetX() >= 0 and adjacentPlot:GetY() < gridHeight) then
                    adjacentPlot3 = Map.GetAdjacentPlot(adjacentPlot:GetX(), adjacentPlot:GetY(), 0);
                end
                if (adjacentPlot3 ~= nil) then
                    if (adjacentPlot3:GetX() >= 0 and adjacentPlot3:GetY() < gridHeight) then
                        adjacentPlot4 = Map.GetAdjacentPlot(adjacentPlot3:GetX(), adjacentPlot3:GetY(), 0);
                    end
                end
            else
                if (adjacentPlot:GetX() >= 0 and adjacentPlot:GetY() < gridHeight) then
                    adjacentPlot3 = Map.GetAdjacentPlot(adjacentPlot:GetX(), adjacentPlot:GetY(), i + 1);
                end
                if (adjacentPlot3 ~= nil) then
                    if (adjacentPlot3:GetX() >= 0 and adjacentPlot3:GetY() < gridHeight) then
                        adjacentPlot4 = Map.GetAdjacentPlot(adjacentPlot3:GetX(), adjacentPlot3:GetY(), i + 1);
                    end
                end
            end
        end

        if (adjacentPlot4 ~= nil) then
            if (adjacentPlot4:GetX() >= 0 and adjacentPlot4:GetY() < gridHeight) then
                adjacentPlot2 = Map.GetAdjacentPlot(adjacentPlot4:GetX(), adjacentPlot4:GetY(), i);
                if (adjacentPlot2 ~= nil) then
                    count = 36 + i * 4 + 2;
                    if (index == count) then
                        return adjacentPlot2;
                    end

                end
            end

        end

        adjacentPlot4 = nil;

        if (adjacentPlot ~= nil) then
            if (i + 1 == 6) then
                if (adjacentPlot:GetX() >= 0 and adjacentPlot:GetY() < gridHeight) then
                    adjacentPlot3 = Map.GetAdjacentPlot(adjacentPlot:GetX(), adjacentPlot:GetY(), 0);
                end
                if (adjacentPlot3 ~= nil) then
                    if (adjacentPlot3:GetX() >= 0 and adjacentPlot3:GetY() < gridHeight) then
                        adjacentPlot4 = Map.GetAdjacentPlot(adjacentPlot3:GetX(), adjacentPlot3:GetY(), 0);
                    end
                end
            else
                if (adjacentPlot:GetX() >= 0 and adjacentPlot:GetY() < gridHeight) then
                    adjacentPlot3 = Map.GetAdjacentPlot(adjacentPlot:GetX(), adjacentPlot:GetY(), i + 1);
                end
                if (adjacentPlot3 ~= nil) then
                    if (adjacentPlot3:GetX() >= 0 and adjacentPlot3:GetY() < gridHeight) then
                        adjacentPlot4 = Map.GetAdjacentPlot(adjacentPlot3:GetX(), adjacentPlot3:GetY(), i + 1);
                    end
                end
            end
        end

        if (adjacentPlot4 ~= nil) then
            if (adjacentPlot4:GetX() >= 0 and adjacentPlot4:GetY() < gridHeight) then
                if (i + 1 == 6) then
                    adjacentPlot2 = Map.GetAdjacentPlot(adjacentPlot4:GetX(), adjacentPlot4:GetY(), 0);
                else
                    adjacentPlot2 = Map.GetAdjacentPlot(adjacentPlot4:GetX(), adjacentPlot4:GetY(), i + 1);
                end
                if (adjacentPlot2 ~= nil) then
                    count = 36 + i * 4 + 3;
                    if (index == count) then
                        return adjacentPlot2;
                    end

                end
            end

        end

    end

    --  > #60 to #90

    local count = 0
    for i = 0, 5 do
        if (plot:GetX() >= 0 and plot:GetY() < gridHeight) then
            adjacentPlot = Map.GetAdjacentPlot(plot:GetX(), plot:GetY(), i); --first ring
            adjacentPlot2 = nil;
            adjacentPlot3 = nil;
            adjacentPlot4 = nil;
            adjacentPlot5 = nil;
        else
            adjacentPlot = nil;
            adjacentPlot2 = nil;
            adjacentPlot3 = nil;
            adjacentPlot4 = nil;
            adjacentPlot5 = nil;
        end
        if (adjacentPlot ~= nil) then
            if (adjacentPlot:GetX() >= 0 and adjacentPlot:GetY() < gridHeight) then
                adjacentPlot3 = Map.GetAdjacentPlot(adjacentPlot:GetX(), adjacentPlot:GetY(), i); --2nd ring
            end
            if (adjacentPlot3 ~= nil) then
                if (adjacentPlot3:GetX() >= 0 and adjacentPlot3:GetY() < gridHeight) then
                    adjacentPlot4 = Map.GetAdjacentPlot(adjacentPlot3:GetX(), adjacentPlot3:GetY(), i); --3rd ring
                    if (adjacentPlot4 ~= nil) then
                        if (adjacentPlot4:GetX() >= 0 and adjacentPlot4:GetY() < gridHeight) then
                            adjacentPlot5 = Map.GetAdjacentPlot(adjacentPlot4:GetX(), adjacentPlot4:GetY(), i); --4th ring
                            if (adjacentPlot5 ~= nil) then
                                if (adjacentPlot5:GetX() >= 0 and adjacentPlot5:GetY() < gridHeight) then
                                    adjacentPlot2 = Map.GetAdjacentPlot(adjacentPlot5:GetX(), adjacentPlot5:GetY(), i); --5th ring
                                end
                            end
                        end
                    end
                end
            end
        end

        if (adjacentPlot2 ~= nil) then
            count = 60 + i * 5;
            if (index == count) then
                return adjacentPlot2; --5th ring
            end
        end

        adjacentPlot2 = nil;

        if (adjacentPlot5 ~= nil) then
            if (i + 1) == 6 then
                if (adjacentPlot5:GetX() >= 0 and adjacentPlot5:GetY() < gridHeight) then
                    adjacentPlot2 = Map.GetAdjacentPlot(adjacentPlot5:GetX(), adjacentPlot5:GetY(), 0);
                end
            else
                if (adjacentPlot5:GetX() >= 0 and adjacentPlot5:GetY() < gridHeight) then
                    adjacentPlot2 = Map.GetAdjacentPlot(adjacentPlot5:GetX(), adjacentPlot5:GetY(), i + 1);
                end
            end
        end

        if (adjacentPlot2 ~= nil) then
            count = 60 + i * 5 + 1;
            if (index == count) then
                return adjacentPlot2;
            end

        end

        adjacentPlot2 = nil;

        if (adjacentPlot ~= nil) then
            if (adjacentPlot:GetX() >= 0 and adjacentPlot:GetY() < gridHeight) then
                adjacentPlot3 = Map.GetAdjacentPlot(adjacentPlot:GetX(), adjacentPlot:GetY(), i);
            end
            if (adjacentPlot3 ~= nil) then
                if (adjacentPlot3:GetX() >= 0 and adjacentPlot3:GetY() < gridHeight) then
                    adjacentPlot4 = Map.GetAdjacentPlot(adjacentPlot3:GetX(), adjacentPlot3:GetY(), i);
                    if (adjacentPlot4 ~= nil) then
                        if (adjacentPlot4:GetX() >= 0 and adjacentPlot4:GetY() < gridHeight) then
                            if (i + 1 == 6) then
                                adjacentPlot5 = Map.GetAdjacentPlot(adjacentPlot4:GetX(), adjacentPlot4:GetY(), 0);
                            else
                                adjacentPlot5 = Map.GetAdjacentPlot(adjacentPlot4:GetX(), adjacentPlot4:GetY(), i + 1);
                            end
                            if (adjacentPlot5 ~= nil) then
                                if (adjacentPlot5:GetX() >= 0 and adjacentPlot5:GetY() < gridHeight) then
                                    if (i + 1 == 6) then
                                        adjacentPlot2 = Map.GetAdjacentPlot(adjacentPlot5:GetX(), adjacentPlot5:GetY(), 0);
                                    else
                                        adjacentPlot2 = Map.GetAdjacentPlot(adjacentPlot5:GetX(), adjacentPlot5:GetY(), i + 1);
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end

        if (adjacentPlot2 ~= nil) then
            count = 60 + i * 5 + 2;
            if (index == count) then
                return adjacentPlot2;
            end

        end

        if (adjacentPlot ~= nil) then
            if (adjacentPlot:GetX() >= 0 and adjacentPlot:GetY() < gridHeight) then
                if (i + 1 == 6) then
                    adjacentPlot3 = Map.GetAdjacentPlot(adjacentPlot:GetX(), adjacentPlot:GetY(), 0); -- 2 ring
                else
                    adjacentPlot3 = Map.GetAdjacentPlot(adjacentPlot:GetX(), adjacentPlot:GetY(), i + 1); -- 2 ring
                end
            end
            if (adjacentPlot3 ~= nil) then
                if (adjacentPlot3:GetX() >= 0 and adjacentPlot3:GetY() < gridHeight) then
                    if (i + 1 == 6) then
                        adjacentPlot4 = Map.GetAdjacentPlot(adjacentPlot3:GetX(), adjacentPlot3:GetY(), 0); -- 3ring
                    else
                        adjacentPlot4 = Map.GetAdjacentPlot(adjacentPlot3:GetX(), adjacentPlot3:GetY(), i + 1); -- 3ring

                    end
                    if (adjacentPlot4 ~= nil) then
                        if (adjacentPlot4:GetX() >= 0 and adjacentPlot4:GetY() < gridHeight) then
                            if (i + 1 == 6) then
                                adjacentPlot5 = Map.GetAdjacentPlot(adjacentPlot4:GetX(), adjacentPlot4:GetY(), 0); --4th ring
                            else
                                adjacentPlot5 = Map.GetAdjacentPlot(adjacentPlot4:GetX(), adjacentPlot4:GetY(), i + 1); --4th ring
                            end
                            if (adjacentPlot5 ~= nil) then
                                if (adjacentPlot5:GetX() >= 0 and adjacentPlot5:GetY() < gridHeight) then
                                    adjacentPlot2 = Map.GetAdjacentPlot(adjacentPlot5:GetX(), adjacentPlot5:GetY(), i); --5th ring
                                end
                            end
                        end
                    end
                end
            end
        end

        if (adjacentPlot2 ~= nil) then
            count = 60 + i * 5 + 3;
            if (index == count) then
                return adjacentPlot2;
            end

        end

        adjacentPlot2 = nil

        if (adjacentPlot ~= nil) then
            if (adjacentPlot:GetX() >= 0 and adjacentPlot:GetY() < gridHeight) then
                if (i + 1 == 6) then
                    adjacentPlot3 = Map.GetAdjacentPlot(adjacentPlot:GetX(), adjacentPlot:GetY(), 0); -- 2 ring
                else
                    adjacentPlot3 = Map.GetAdjacentPlot(adjacentPlot:GetX(), adjacentPlot:GetY(), i + 1); -- 2 ring
                end
            end
            if (adjacentPlot3 ~= nil) then
                if (adjacentPlot3:GetX() >= 0 and adjacentPlot3:GetY() < gridHeight) then
                    if (i + 1 == 6) then
                        adjacentPlot4 = Map.GetAdjacentPlot(adjacentPlot3:GetX(), adjacentPlot3:GetY(), 0); -- 3ring
                    else
                        adjacentPlot4 = Map.GetAdjacentPlot(adjacentPlot3:GetX(), adjacentPlot3:GetY(), i + 1); -- 3ring

                    end
                    if (adjacentPlot4 ~= nil) then
                        if (adjacentPlot4:GetX() >= 0 and adjacentPlot4:GetY() < gridHeight) then
                            if (i + 1 == 6) then
                                adjacentPlot5 = Map.GetAdjacentPlot(adjacentPlot4:GetX(), adjacentPlot4:GetY(), 0); --4th ring
                            else
                                adjacentPlot5 = Map.GetAdjacentPlot(adjacentPlot4:GetX(), adjacentPlot4:GetY(), i + 1); --4th ring
                            end
                            if (adjacentPlot5 ~= nil) then
                                if (adjacentPlot5:GetX() >= 0 and adjacentPlot5:GetY() < gridHeight) then
                                    if (i + 1 == 6) then
                                        adjacentPlot2 = Map.GetAdjacentPlot(adjacentPlot5:GetX(), adjacentPlot5:GetY(), 0); --5th ring
                                    else
                                        adjacentPlot2 = Map.GetAdjacentPlot(adjacentPlot5:GetX(), adjacentPlot5:GetY(), i + 1); --5th ring
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end

        if (adjacentPlot2 ~= nil) then
            count = 60 + i * 5 + 4;
            if (index == count) then
                return adjacentPlot2;
            end

        end

    end

end


function Initialize()
	GameEvents.OnCombatOccurred.Add(OnCombatOccurred);
end

Initialize();