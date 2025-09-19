------------------------------------------------------------------------------
--	FILE:	BBS_AssignStartingPlot.lua    -- 1.4
--	AUTHOR:  D. / Jack The Narrator, Kilua
--	PURPOSE: Custom Spawn Placement Script
------------------------------------------------------------------------------
--	Copyright (c) 2014 Firaxis Games, Inc. All rights reserved.
------------------------------------------------------------------------------
include( "MapEnums" );
include( "MapUtilities" );
include( "FeatureGenerator" );
include( "TerrainGenerator" );
include( "NaturalWonderGenerator" );
include( "ResourceGenerator" );
include ( "AssignStartingPlots" );

local bError_major = false;
local bError_minor = false;
local bError_proximity = false;
local bError_shit_settle = false;
local bRepeatPlacement = false;
local b_debug_region = false
local b_north_biased = false
local Teamers_Config = 0
local isStartCheck = false;
local isCanRandom = false;
local reStartCount = 1;
local Teamers_Ref_team = nil
local Teamers_Ref_team_overturn = nil

------------------------------------------------------------------------------
BBS_AssignStartingPlots = {};
------------------------------------------------------------------------------
function BBS_AssignStartingPlots.Create(args)
	if (GameConfiguration.GetValue("SpawnRecalculation") == nil) then
		print("BBS_AssignStartingPlots: Map Type Not Supported!")
		Game:SetProperty("BBS_RESPAWN",false)
		return AssignStartingPlots.Create(args)
	end
	print("BBS_AssignStartingPlots: BBS Settings:", GameConfiguration.GetValue("SpawnRecalculation"));
	if (GameConfiguration.GetValue("SpawnRecalculation") == false) then 
		print("BBS_AssignStartingPlots: BBS Spawn Placement has been Desactivated.")
		Game:SetProperty("BBS_RESPAWN",false)
		return AssignStartingPlots.Create(args)
	end
	
	if MapConfiguration.GetValue("BBS_Team_Spawn") ~= nil then
		Teamers_Config = MapConfiguration.GetValue("BBS_Team_Spawn")
	end
	

	local Major_Distance_Target = 19
	local instance = {}
	--if MapConfiguration.GetValue("MAP_SCRIPT") == "Pangaea.lua" then
	--	Major_Distance_Target = 20
	--end	
	if MapConfiguration.GetValue("MAP_SCRIPT") == "Terra.lua" then
		Major_Distance_Target = 17
	end
	if Teamers_Config == 0 then
		Major_Distance_Target = Major_Distance_Target - 3 
	end
	
	if Map.GetMapSize() == 5 and  PlayerManager.GetAliveMajorsCount() > 10 then
		Major_Distance_Target = Major_Distance_Target - 2
	end
	if Map.GetMapSize() == 5 and  PlayerManager.GetAliveMajorsCount() < 8 then
		Major_Distance_Target = Major_Distance_Target + 2
	end	
	
	if Map.GetMapSize() == 4 and  PlayerManager.GetAliveMajorsCount() > 10 then
		Major_Distance_Target = Major_Distance_Target - 2
	end
	if Map.GetMapSize() == 4 and  PlayerManager.GetAliveMajorsCount() < 8 then
		Major_Distance_Target = Major_Distance_Target + 2
	end	
	
	if Map.GetMapSize() == 3 and  PlayerManager.GetAliveMajorsCount() > 7 then
		Major_Distance_Target = Major_Distance_Target - 3
	end
	if Map.GetMapSize() == 3 and  PlayerManager.GetAliveMajorsCount() < 8 then
		Major_Distance_Target = Major_Distance_Target 
	end	
	
	if Map.GetMapSize() == 2 and  PlayerManager.GetAliveMajorsCount() > 5 then
		Major_Distance_Target = Major_Distance_Target - 4
	end
	if Map.GetMapSize() == 2 and  PlayerManager.GetAliveMajorsCount() < 6 then
		Major_Distance_Target = Major_Distance_Target - 2
	end	
	
	if Map.GetMapSize() == 1 and  PlayerManager.GetAliveMajorsCount() > 5 then
		Major_Distance_Target = Major_Distance_Target - 5
	end
	if Map.GetMapSize() == 1 and  PlayerManager.GetAliveMajorsCount() < 6 then
		Major_Distance_Target = Major_Distance_Target - 3
	end	
	
	if Map.GetMapSize() == 0 and  PlayerManager.GetAliveMajorsCount() > 2  then
		Major_Distance_Target = 15
	end	
	
	if Map.GetMapSize() == 0 and  PlayerManager.GetAliveMajorsCount() == 2  then
		Major_Distance_Target = 18
	end	
	
	
	for i = 1,20 do
		instance = {}
		bError_shit_settle = false
		bError_major = false;
		bError_proximity = false;
		bError_minor = false;
		print("Attempt #",i,"Distance",Major_Distance_Target)
	instance  = {
        -- Core Process member methods
        __Debug								= BBS_AssignStartingPlots.__Debug,
        __InitStartingData					= BBS_AssignStartingPlots.__InitStartingData,
        __FilterStart                       = BBS_AssignStartingPlots.__FilterStart,
        __SetStartBias                      = BBS_AssignStartingPlots.__SetStartBias,
        __BiasRoutine                       = BBS_AssignStartingPlots.__BiasRoutine,
        __FindBias                          = BBS_AssignStartingPlots.__FindBias,
        __RateBiasPlots                     = BBS_AssignStartingPlots.__RateBiasPlots,
        __SettlePlot                   = BBS_AssignStartingPlots.__SettlePlot,
        __CountAdjacentTerrainsInRange      = BBS_AssignStartingPlots.__CountAdjacentTerrainsInRange,
        __CountAdjacentTerrainsInOneRangeTMP= BBS_AssignStartingPlots.__CountAdjacentTerrainsInOneRangeTMP,
        __ScoreAdjacent    = BBS_AssignStartingPlots.__ScoreAdjacent,
        __CountAdjacentFeaturesInRange      = BBS_AssignStartingPlots.__CountAdjacentFeaturesInRange,
        __CountAdjacentResourcesInRange     = BBS_AssignStartingPlots.__CountAdjacentResourcesInRange,
        __CountAdjacentYieldsInRange        = BBS_AssignStartingPlots.__CountAdjacentYieldsInRange,
        __GetTerrainIndex                   = BBS_AssignStartingPlots.__GetTerrainIndex,
        __GetFeatureIndex                   = BBS_AssignStartingPlots.__GetFeatureIndex,
        __GetResourceIndex                  = BBS_AssignStartingPlots.__GetResourceIndex,
        __NaturalWonderBuffer				= BBS_AssignStartingPlots.__NaturalWonderBuffer,
        __LuxuryBuffer				        = BBS_AssignStartingPlots.__LuxuryBuffer,
		__LuxuryCount						= BBS_AssignStartingPlots.__LuxuryCount,
        __TryToRemoveBonusResource			= BBS_AssignStartingPlots.__TryToRemoveBonusResource,
        __MajorCivBuffer					= BBS_AssignStartingPlots.__MajorCivBuffer,
        __MinorMajorCivBuffer				= BBS_AssignStartingPlots.__MinorMajorCivBuffer,
        __MinorMinorCivBuffer				= BBS_AssignStartingPlots.__MinorMinorCivBuffer,
        __BaseFertility						= BBS_AssignStartingPlots.__BaseFertility,
        __AddBonusFoodProduction			= BBS_AssignStartingPlots.__AddBonusFoodProduction,
        __AddFood							= BBS_AssignStartingPlots.__AddFood,
        __AddProduction						= BBS_AssignStartingPlots.__AddProduction,
        __AddResourcesBalanced				= BBS_AssignStartingPlots.__AddResourcesBalanced,
        __AddResourcesLegendary				= BBS_AssignStartingPlots.__AddResourcesLegendary,
        __BalancedStrategic					= BBS_AssignStartingPlots.__BalancedStrategic,
        __FindSpecificStrategic				= BBS_AssignStartingPlots.__FindSpecificStrategic,
        __AddStrategic						= BBS_AssignStartingPlots.__AddStrategic,
        __AddLuxury							= BBS_AssignStartingPlots.__AddLuxury,
		__AddLeyLine						= BBS_AssignStartingPlots.__AddLeyLine,
        __AddBonus							= BBS_AssignStartingPlots.__AddBonus,
        __IsContinentalDivide				= BBS_AssignStartingPlots.__IsContinentalDivide,
        __RemoveBonus						= BBS_AssignStartingPlots.__RemoveBonus,
        __TableSize						    = BBS_AssignStartingPlots.__TableSize,
        __GetValidAdjacent					= BBS_AssignStartingPlots.__GetValidAdjacent,
		__GetShuffledCiv					= BBS_AssignStartingPlots.__GetShuffledCiv,
		__CountAdjacentContinentsInRange	= BBS_AssignStartingPlots.__CountAdjacentContinentsInRange,
        __CountAdjacentContinentsInRangeTwo = BBS_AssignStartingPlots.__CountAdjacentContinentsInRangeTwo,

        iNumMajorCivs = 0,
		iNumSpecMajorCivs = 0,
        iNumWaterMajorCivs = 0,
        iNumMinorCivs = 0,
        iNumRegions		= 0,
        iDefaultNumberMajor = 0,
        iDefaultNumberMinor = 0,
		iTeamPlacement = Teamers_Config,
        uiMinMajorCivFertility = args.MIN_MAJOR_CIV_FERTILITY or 0,
        uiMinMinorCivFertility = args.MIN_MINOR_CIV_FERTILITY or 0,
        uiStartMinY = args.START_MIN_Y or 0,
        uiStartMaxY = args.START_MAX_Y or 0,
        uiStartConfig = args.START_CONFIG or 2,
        waterMap  = args.WATER or false,
        landMap  = args.LAND or false,
        noStartBiases = args.IGNORESTARTBIAS or false,
        startAllOnLand = args.STARTALLONLAND or false,
        startLargestLandmassOnly = args.START_LARGEST_LANDMASS_ONLY or false,
        majorStartPlots = {},
		majorStartPlotsTeam = {},
        minorStartPlots = {},
		minorStartPlotsID = {},
        majorList = {},
        minorList = {},
        playerStarts = {},
		regionTracker = {},
        aBonusFood = {},
        aBonusProd = {},
        rBonus = {},
        rLuxury = {},
        rStrategic = {},
        aMajorStartPlotIndices = {},
        fallbackPlots = {},
        tierMax = 0,
		iHard_Major = Major_Distance_Target,
		iDistance = 0,
		iDistance_minor = 0,
		iDistance_minor_minor = 5,
		iMinorAttempts = 0,
        -- Team info variables (not used in the core process, but necessary to many Multiplayer map scripts)
    }
    print("TeamPVP __InitStartingData i:",i);
		instance:__InitStartingData()
	
		if bError_major == false and bError_proximity == false and bError_shit_settle == false then
			print("BBS_AssignStartingPlots: Successfully ran!")
			if  (bError_minor == true) then
				print("BBS_AssignStartingPlots: An error has occured: A city-state is missing.")
			end
			Game:SetProperty("BBS_RESPAWN",true)
			return instance
		else
			Major_Distance_Target = Major_Distance_Target - 1
			if Major_Distance_Target < 9 then
				Major_Distance_Target = 9
				bRepeatPlacement = true
			end
            if i >= 12 then
                isStartCheck = true;
                reStartCount=1;--初始为1
            end
            if i >= 6 then
                isCanRandom = true;
                reStartCount=1;
            end
            reStartCount = reStartCount+1;
            --print("teamPVP start count isStartCheck:",isStartCheck,";isCanRandom:",isCanRandom,";reStartCount:",reStartCount);
		end
	end
	
	
	print("BBS_AssignStartingPlots: To Many Attempts Failed - Go to Firaxis Placement")
	Game:SetProperty("BBS_RESPAWN",false)
	return AssignStartingPlots.Create(args)

end
------------------------------------------------------------------------------
function BBS_AssignStartingPlots:__Debug(...)
    --print (...);
end
------------------------------------------------------------------------------
function BBS_AssignStartingPlots:__InitStartingData()
   	print("BBS_AssignStartingPlots: Start:", os.date("%c"));
    if(self.uiMinMajorCivFertility <= 0) then
        self.uiMinMajorCivFertility = 110;
    end
    if(self.uiMinMinorCivFertility <= 0) then
        self.uiMinMinorCivFertility = 25;
    end
	local rng = 0
	rng = TerrainBuilder.GetRandomNumber(100,"North Test")/100;
	if rng > 0.5 then
		b_north_biased = true
	end
    --Find Default Number
    local MapSizeTypes = {};
    for row in GameInfo.Maps() do
        MapSizeTypes[row.RowId] = row.DefaultPlayers;
    end
    local sizekey = Map.GetMapSize() + 1;
    local iDefaultNumberPlayers = MapSizeTypes[sizekey] or 8;
    self.iDefaultNumberMajor = iDefaultNumberPlayers ;
    self.iDefaultNumberMinor = math.floor(iDefaultNumberPlayers * 1.5);

    --Init Resources List
    for row in GameInfo.Resources() do
        if (row.ResourceClassType  == "RESOURCECLASS_BONUS") then
            table.insert(self.rBonus, row);
            for row2 in GameInfo.TypeTags() do
                if(GameInfo.Resources[row2.Type] ~= nil and GameInfo.Resources[row2.Type].Hash == row.Hash) then
                    if(row2.Tag=="CLASS_FOOD" and row.Name ~= "LOC_RESOURCE_CRABS_NAME") then
                        table.insert(self.aBonusFood, row);
                    elseif(row2.Tag=="CLASS_PRODUCTION" and row.Name ~= "LOC_RESOURCE_COPPER_NAME") then
                        table.insert(self.aBonusProd, row);
                    end
                end
            end
        elseif (row.ResourceClassType == "RESOURCECLASS_LUXURY") then
            table.insert(self.rLuxury, row);
        elseif (row.ResourceClassType  == "RESOURCECLASS_STRATEGIC") then
            table.insert(self.rStrategic, row);
        end
    end

    for row in GameInfo.StartBiasResources() do
        if(row.Tier > self.tierMax) then
            self.tierMax = row.Tier;
        end
    end
    for row in GameInfo.StartBiasFeatures() do
        if(row.Tier > self.tierMax) then
            self.tierMax = row.Tier;
        end
    end
    for row in GameInfo.StartBiasTerrains() do
        if(row.Tier > self.tierMax) then
            self.tierMax = row.Tier;
        end
    end
    for row in GameInfo.StartBiasRivers() do
        if(row.Tier > self.tierMax) then
            self.tierMax = row.Tier;
        end
    end
	
	if b_debug_region == true then
		for iPlotIndex = 0, Map.GetPlotCount()-1, 1 do
			local pPlot = Map.GetPlotByIndex(iPlotIndex)
			if (pPlot ~= nil) then
				TerrainBuilder.SetFeatureType(pPlot,-1);
			end
		end		
	end

    -- See if there are any civs starting out in the water
    local tempMajorList = {};
    self.majorList = {};
    self.waterMajorList = {};
    self.specMajorList = {};
    self.iNumMajorCivs = 0;
    self.iNumSpecMajorCivs = 0;
    self.iNumWaterMajorCivs = 0;

    tempMajorList = PlayerManager.GetAliveMajorIDs();
	
    
    for i = 1, PlayerManager.GetAliveMajorsCount() do
        local leaderType = PlayerConfigurations[tempMajorList[i]]:GetLeaderTypeName();
        if (not self.startAllOnLand and GameInfo.Leaders_XP2[leaderType] ~= nil and GameInfo.Leaders_XP2[leaderType].OceanStart) then
            table.insert(self.waterMajorList, tempMajorList[i]);
            self.iNumWaterMajorCivs = self.iNumWaterMajorCivs + 1;
            self:__Debug ("Found the Maori");
        elseif ( PlayerConfigurations[tempMajorList[i]]:GetLeaderTypeName() == "LEADER_SPECTATOR" or PlayerConfigurations[tempMajorList[i]]:GetHandicapTypeID() == 2021024770) then
		table.insert(self.specMajorList, tempMajorList[i]);
		self.iNumSpecMajorCivs = self.iNumSpecMajorCivs + 1;
		self:__Debug ("Found a Spectator");
	else
            table.insert(self.majorList, tempMajorList[i]);
            self.iNumMajorCivs = self.iNumMajorCivs + 1;
        end
    end

    -- Do we have enough water on this map for the number of water civs specified?
    local TILES_NEEDED_FOR_WATER_START = 8;
    if (self.waterMap) then
        TILES_NEEDED_FOR_WATER_START = 1;
    end
    local iCandidateWaterTiles = StartPositioner.GetTotalOceanStartCandidates(self.waterMap);
    if (iCandidateWaterTiles < (TILES_NEEDED_FOR_WATER_START * self.iNumWaterMajorCivs)) then
        -- Not enough so reset so all civs start on land
        self.iNumMajorCivs = 0;
        self.majorList = {};
        for i = 1, PlayerManager.GetAliveMajorsCount() do
            table.insert(self.majorList, tempMajorList[i]);
            self.iNumMajorCivs = self.iNumMajorCivs + 1;
        end
    end

    self.iNumMinorCivs = PlayerManager.GetAliveMinorsCount();
    self.minorList = PlayerManager.GetAliveMinorIDs();
    self.iNumRegions = self.iNumMajorCivs + self.iNumMinorCivs;

    StartPositioner.DivideMapIntoMajorRegions(self.iNumMajorCivs, self.uiMinMajorCivFertility, self.uiMinMinorCivFertility, self.startLargestLandmassOnly);
    local majorStartPlots = {};
    for i = self.iNumMajorCivs - 1, 0, - 1 do
        local plots = StartPositioner.GetMajorCivStartPlots(i);
		table.insert(majorStartPlots, self:__FilterStart(plots, i, true));
    end

    self.playerStarts = {};
    self.aMajorStartPlotIndices = {};
    self:__SetStartBias(majorStartPlots, self.iNumMajorCivs, self.majorList,true);

    if(self.uiStartConfig == -999 ) then
        --self:__AddResourcesBalanced();
    elseif(self.uiStartConfig == 3 ) then
        --self:__AddResourcesLegendary();
    end


    StartPositioner.DivideMapIntoMinorRegions(self.iNumMinorCivs);
    local minorStartPlots = {};
    for i = self.iNumMinorCivs - 1, 0, - 1 do
        local plots = StartPositioner.GetMinorCivStartPlots(i);
        table.insert(minorStartPlots, self:__FilterStart(plots, i, false));
    end

    self:__SetStartBias(minorStartPlots, self.iNumMinorCivs, self.minorList,false);

    -- Finally place the ocean civs
    if (self.iNumWaterMajorCivs > 0) then
        local iWaterCivs = StartPositioner.PlaceOceanStartCivs(self.waterMap, self.iNumWaterMajorCivs, self.aMajorStartPlotIndices);
        for i = 1, iWaterCivs do
            local waterPlayer = Players[self.waterMajorList[i]]
            local iStartIndex = StartPositioner.GetOceanStartTile(i - 1);  -- Indices start at 0 here
            local pStartPlot = Map.GetPlotByIndex(iStartIndex);
            waterPlayer:SetStartingPlot(pStartPlot);
            self:__Debug("Water Start X: ", pStartPlot:GetX(), "Water Start Y: ", pStartPlot:GetY());
        end
        if (iWaterCivs < self.iNumWaterMajorCivs) then
            self:__Debug("FAILURE PLACING WATER CIVS - Missing civs: " .. tostring(self.iNumWaterMajorCivs - iWaterCivs));
        end
    end

	-- Place the spectator
    if (self.iNumSpecMajorCivs > 0) then
        for i = 1, self.iNumSpecMajorCivs do
            local specPlayer = Players[self.specMajorList[i]]
            local pStartPlot = Map.GetPlotByIndex(0+self.iNumSpecMajorCivs);
            specPlayer:SetStartingPlot(pStartPlot);
            self:__Debug("Spec Start X: ", pStartPlot:GetX(), "Spec Start Y: ", pStartPlot:GetY());
        end
    end

	-- Sanity check

	for i = 1, PlayerManager.GetAliveMajorsCount() do
		local startPlot = Players[tempMajorList[i]]:GetStartingPlot();
		if (startPlot == nil) then
			bError_major = true
			--self:__Debug("Error Major Player is missing:", tempMajorList[i]);
			print("Error Major Player is missing:", tempMajorList[i]);
			else
			self:__Debug("Major Start X: ", startPlot:GetX(), "Major Start Y: ", startPlot:GetY(), "ID:",tempMajorList[i]);
		end
	end

	if (Game:GetProperty("BBS_MINOR_FAILING_TOTAL") == nil) then
		local count = 0
		for i = 1, PlayerManager.GetAliveMinorsCount() do
		
			local startPlot = Players[self.minorList[i]]:GetStartingPlot();
			print(i, count)
			if (startPlot == nil) then
				print("Error Minor Player is missing:", self.minorList[i]);
				count = count + 1
				Game:SetProperty("BBS_MINOR_FAILING_ID_"..count,self.minorList[i])
				startPlot = Map.GetPlotByIndex(PlayerManager.GetAliveMajorsCount()+PlayerManager.GetAliveMinorsCount()+count);
				local minPlayer = Players[self.minorList[i]]
				minPlayer:SetStartingPlot(startPlot);
				self:__Debug("Minor Temp Start X: ", startPlot:GetX(), "Y: ", startPlot:GetY());
				else
				print("Minor", PlayerConfigurations[self.minorList[i]]:GetCivilizationTypeName(), "Start X: ", startPlot:GetX(), "Y: ", startPlot:GetY());
			end
		end

		Game:SetProperty("BBS_MINOR_FAILING_TOTAL",count)
	end

	self:__Debug(Game:GetProperty("BBS_MINOR_FAILING_TOTAL"),"Minor Players are missing");

	if (Game:GetProperty("BBS_MINOR_FAILING_TOTAL") > 0) then
		bError_minor = true
		else
		bError_minor = false
	end
	local count = 0
	if Game:GetProperty("BBS_MINOR_FAILING_TOTAL") ~= nil then
		count = Game:GetProperty("BBS_MINOR_FAILING_TOTAL")
	end
	if (bError_major ~= true) then
		for i = 1, PlayerManager.GetAliveMajorsCount() do
			if (PlayerConfigurations[tempMajorList[i]]:GetLeaderTypeName() ~= "LEADER_SPECTATOR" and PlayerConfigurations[tempMajorList[i]]:GetHandicapTypeID() ~= 2021024770 and PlayerConfigurations[tempMajorList[i]]:GetLeaderTypeName() ~= "LEADER_KUPE") then
				local pStartPlot_i = Players[tempMajorList[i]]:GetStartingPlot()
				for j = 1, PlayerManager.GetAliveMajorsCount() do
					if (PlayerConfigurations[tempMajorList[j]]:GetLeaderTypeName() ~= "LEADER_SPECTATOR" and PlayerConfigurations[tempMajorList[j]]:GetHandicapTypeID() ~= 2021024770 and PlayerConfigurations[tempMajorList[j]]:GetLeaderTypeName() ~= "LEADER_KUPE" and tempMajorList[j] ~= tempMajorList[i]) then
						local pStartPlot_j = Players[tempMajorList[j]]:GetStartingPlot()
						if (pStartPlot_j ~= nil) then
							local distance = Map.GetPlotDistance(pStartPlot_i:GetIndex(),pStartPlot_j:GetIndex())
							self:__Debug("I:", tempMajorList[i],"J:", tempMajorList[j],"Distance:",distance)
							if (distance < 9 ) then
								bError_proximity = true;
								print("Proximity Error:",distance)
							end
						end
					end
				end
				for k = 1, PlayerManager.GetAliveMinorsCount() do
					if (Players[self.minorList[k]] ~= nil ) then
						local pStartPlot_k = Players[self.minorList[k]]:GetStartingPlot()
						if (pStartPlot_k ~= nil) then
							local distance = Map.GetPlotDistance(pStartPlot_i:GetIndex(),pStartPlot_k:GetIndex())
							self:__Debug("I:", tempMajorList[i],"K:", self.minorList[k],"Distance:",distance)
							if (distance < 6 or pStartPlot_i:GetIndex() == pStartPlot_k:GetIndex()) then
								self:__Debug("Error Minor Player is missing:", self.minorList[k]);
								count = count + 1
								Game:SetProperty("BBS_MINOR_FAILING_ID_"..count,self.minorList[k])
								startPlot = Map.GetPlotByIndex(PlayerManager.GetAliveMajorsCount()+PlayerManager.GetAliveMinorsCount()+count);
								local minPlayer = Players[self.minorList[k]]
								minPlayer:SetStartingPlot(startPlot);
								self:__Debug("Minor Temp Start X: ", startPlot:GetX(), "Y: ", startPlot:GetY());
							end
						end
					end					
				end
			end
		end
	end
	Game:SetProperty("BBS_MINOR_FAILING_TOTAL",count)

    print("BBS_AssignStartingPlots: Completed", os.date("%c"));
end
------------------------------------------------------------------------------
function BBS_AssignStartingPlots:__FilterStart(plots, index, major)
    local sortedPlots = {};
    local atLeastOneValidPlot = false;
    for i, row in ipairs(plots) do
        local plot = Map.GetPlotByIndex(row);
        if (plot:IsImpassable() == false and plot:IsWater() == false and self:__GetValidAdjacent(plot, major)) or b_debug_region == true then
            atLeastOneValidPlot = true;
            table.insert(sortedPlots, plot);
        end
    end
    if (atLeastOneValidPlot == true) then
        if (major == true) then
            StartPositioner.MarkMajorRegionUsed(index);
        end
    end
    return sortedPlots;
end
------------------------------------------------------------------------------
function BBS_AssignStartingPlots:__SetStartBias(startPlots, iNumberCiv, playersList, major)
    local civs = {};
	local tierOrder = {};
	self.regionTracker = {};
	local count = 0;
	for i, region in ipairs(startPlots) do
		count = count + 1;
		self.regionTracker[i] = i;
	end
	self:__Debug("Set Start Bias: Total Region", count);
    for i = 1, iNumberCiv do
        local civ = {};
        civ.Type = PlayerConfigurations[playersList[i]]:GetCivilizationTypeName();

        civ.Index = i;
        local biases = self:__FindBias(civ.Type);
        --[[if (self:__TableSize(biases) > 0) then
            civ.Tier = biases[1].Tier;
        else
            civ.Tier = self.tierMax + 1;
        end--]]
        if (self:__TableSize(biases) > 0) then
            local civIsTerrainsBiases = false;
            for j, biasesObject in ipairs(biases) do
                if (biasesObject.Type == "TERRAINS" and (biasesObject.Value == g_TERRAIN_TYPE_TUNDRA or biasesObject.Value == g_TERRAIN_TYPE_SNOW)) then
                    civ.Tier = -4;
                    civIsTerrainsBiases = true;
                    break;
                elseif(civ.Type == "CIVILIZATION_SPAIN")then
                    civ.Tier = -3;
                    civIsTerrainsBiases = true;
                    --print("CIVILIZATION_SPAIN set civIsTerrainsBiases");
                    break;
                elseif (biasesObject.Type == "FEATURES" and (biasesObject.Value == g_FEATURE_FLOODPLAINS_PLAINS or biasesObject.Value == g_FEATURE_FLOODPLAINS_GRASSLAND)) then
                    civ.Tier = -2;
                    civIsTerrainsBiases = true;
                    break;
                elseif(biasesObject.Type == "TERRAINS" and biasesObject.Value == g_TERRAIN_TYPE_COAST) then
                    civ.Tier = -1;
                    civIsTerrainsBiases = true;
                    break;
                elseif (biasesObject.Type == "RIVERS") then
                    civ.Tier = 0;
                    civIsTerrainsBiases = true;
                    break;
                end
            end
            if(civIsTerrainsBiases == false)then
                civ.Tier = biases[1].Tier;
            end
        else
            civ.Tier = self.tierMax + 1;
        end
        table.insert(civs, civ);
    end
    for i = -4, self.tierMax + 1 do
        tierOrder = {};
        for j, civ in ipairs(civs) do
            if (civ.Tier == i) then
                table.insert(tierOrder, civ);
            end
        end
        local shuffledCiv = GetShuffledCopyOfTable(tierOrder);
		--[[if isStartCheck == true then
			if self.iHard_Major ~= nil then
				print("Reshuffling Civ Order")
				shuffledCiv = self:__GetShuffledCiv(tierOrder,self.iHard_Major);
				else
				print("Error: Hard Major Limit ")
			end
		end--]]
        for k, civ in ipairs(shuffledCiv) do
            self:__Debug("SetStartBias for", civ.Type);
			print("SetStartBias for", civ.Type,playersList[civ.Index]);
            self:__BiasRoutine(civ.Type, startPlots, civ.Index, playersList, major, false);
        end
    end
end
------------------------------------------------------------------------------
function BBS_AssignStartingPlots:__BiasRoutine(civilizationType, startPlots, index, playersList, major)
    local biases = self:__FindBias(civilizationType);
    local ratedBiases = nil;
    local regionIndex = 0;
    local settled = false;

    print("__TableSize startPlots:",self:__TableSize(startPlots));
    for i, region in ipairs(startPlots) do
        --print("Bias Routine: Analysing Region index", i, "Tracker",self.regionTracker[i]," ;region",region);
        if (self.regionTracker[i] ~= -1) then
            if (region ~= nil and self:__TableSize(region) > 0) then
                local tempBiases = self:__RateBiasPlots(biases, region, major, i,civilizationType,playersList[index]);

                if (    (ratedBiases == nil or ratedBiases[1].Score < tempBiases[1].Score) and
                        (tempBiases[1].Score > 0 or major == false or (bRepeatPlacement == true and tempBiases[1].Score > -500) ) ) then
                    ratedBiases = tempBiases;
                    regionIndex = i;
                    if(ratedBiases==nil)then
                        print("__BiasRoutine regionIndex first success:",regionIndex);
                    end
                end
            else
                regionIndex = i;
                self.regionTracker[regionIndex] = -1;
                print("Bias Routine: Remove Region index: Empty Region", regionIndex);
            end

        end

    end

    print("__BiasRoutine check ratedBiases:",ratedBiases,";regionIndex:",regionIndex);
    if (ratedBiases ~= nil and regionIndex > 0) then
        settled = self:__SettlePlot(ratedBiases, index, Players[playersList[index]], major, regionIndex, civilizationType);


        if (settled == false and major == true) then

            print("Failed to settled in assigned region, reduce the distance by one and retry.",playersList[index],civilizationType);

            if (major == true) then
                if (self.iDistance_minor == 0) then
                    self.iDistance_minor = -1;
                    self:__Debug("BBS_AssignStartingPlots: Reducing Minor Distance by 1");
                end

            else

                if (self.iDistance_minor == 0) then
                    self.iDistance_minor = -1;
                    self:__Debug("BBS_AssignStartingPlots: Reducing Minor Distance by 1");
                end
                self:__Debug("BBS_AssignStartingPlots: Minor-Minor Distance Buffer is ",self.iDistance_minor_minor);
                if (self.iDistance_minor_minor > -1) then
                    self.iDistance_minor_minor = self.iDistance_minor_minor -1;
                    self:__Debug("BBS_AssignStartingPlots: Reducing Minor-Minor Distance Buffer to ", self.iDistance_minor_minor);
                end
            end

            settled = self:__SettlePlot(ratedBiases, index, Players[playersList[index]], major, regionIndex,civilizationType);

            if (settled == false) then
                print("Failed to settled in assigned region, use fallbacks.",Players[playersList[index]],civilizationType);
                if (self:__TableSize(self.fallbackPlots) > 0 and isStartCheck==true) then
                    ratedBiases = self:__RateBiasPlots(biases, self.fallbackPlots, major);
                    settled = self:__SettlePlot(ratedBiases, index, Players[playersList[index]], major, -1,civilizationType);
                    if (settled == false) then
                        print("Failed to place",playersList[index],civilizationType)
                    end
                else
                    print("Failed to place",Players[playersList[index]],civilizationType)
                    return
                end

            else -- Placement successful

                --self.regionTracker[regionIndex] = -1;
                self:__Debug("Bias Routine: Remove Region index: Successful Placement post distance reduction", regionIndex);
            end

        else -- Placement successful
            if(major == false)then
                self.regionTracker[regionIndex] = -1;
            end
            --self.regionTracker[regionIndex] = -1;
            self:__Debug("Bias Routine: Remove Region index: Successful Placement", regionIndex);

        end

    elseif (major == true) and (self:__TableSize(self.fallbackPlots) > 0) then
        print("Attempt to place using fallback",playersList[index],civilizationType)
        ratedBiases = self:__RateBiasPlots(biases, self.fallbackPlots, major);
        settled = self:__SettlePlot(ratedBiases, index, Players[playersList[index]], major, -1,civilizationType);

        if (settled == false) then
            print("Failed to place",playersList[index],civilizationType)
        end

    end
end
------------------------------------------------------------------------------
function BBS_AssignStartingPlots:__FindBias(civilizationType)
    local biases = {};
    for row in GameInfo.StartBiasResources() do
        if(row.CivilizationType == civilizationType) then
            local bias = {};
            bias.Tier = row.Tier;
            bias.Type = "RESOURCES";
            bias.Value = self:__GetResourceIndex(row.ResourceType);
            self:__Debug("BBS_AssignStartingPlots: Add Bias : Civilization",civilizationType,"Bias Type:", bias.Type, "Tier :", bias.Tier, "Type :", bias.Value);
            table.insert(biases, bias);
        end
    end
    for row in GameInfo.StartBiasFeatures() do
        if(row.CivilizationType == civilizationType) then
            local bias = {};
            bias.Tier = row.Tier;
            bias.Type = "FEATURES";
            bias.Value = self:__GetFeatureIndex(row.FeatureType);
            self:__Debug("BBS_AssignStartingPlots: Add Bias : Civilization",civilizationType,"Bias Type:", bias.Type, "Tier :", bias.Tier, "Type :", bias.Value);
            table.insert(biases, bias);
        end
    end
    for row in GameInfo.StartBiasTerrains() do
        if(row.CivilizationType == civilizationType) then
            local bias = {};
            bias.Tier = row.Tier;
            bias.Type = "TERRAINS";
            bias.Value = self:__GetTerrainIndex(row.TerrainType);
            self:__Debug("BBS_AssignStartingPlots: Add Bias : Civilization",civilizationType,"Bias Type:", bias.Type, "Tier :", bias.Tier, "Type :", bias.Value);
            table.insert(biases, bias);
        end
    end
    for row in GameInfo.StartBiasRivers() do
        if(row.CivilizationType == civilizationType) then
            local bias = {};
            bias.Tier = row.Tier;
            bias.Type = "RIVERS";
            bias.Value = nil;
            self:__Debug("BBS_AssignStartingPlots: Add Bias : Civilization",civilizationType,"Bias Type:", bias.Type, "Tier :", bias.Tier, "Type :", bias.Value);
            table.insert(biases, bias);
        end
    end
    table.sort(biases, function(a, b) return a.Tier < b.Tier; end);
    return biases;
end
------------------------------------------------------------------------------
--[[必要关联：
冻土反关联 10。000。000
南北 东西出生 10。000。000 成功+100。000 失败扣全 多次失败后扣分将至0
地形关联 海岸、冻土、泛滥（特殊） 1000。000 多次失败扣分降低至 10% 100。000
异大陆关联 1000。000

重要关联：
河流关联 100。000 90%
沙漠、冻土、泛滥反关联 70% 10.000
陆地（非冻土）文明周围海岸格子判断 30% 10.000
地貌关联 森林、雨林 30% 1000
资源关联 30% 1000

不重要关联：
山脉关联 delete
特殊沿海判断 delete
淡水判断 delete

随机关联：
随机出生 100 多次出生失败提升至1000--]]
function BBS_AssignStartingPlots:__RateBiasPlots(biases, startPlots, major, region_index, civilizationType,iPlayer)
    local ratedPlots = {};
	local region_bonus = 0
	 local gridWidth, gridHeight = Map.GetGridSize();


	if civilizationType == "CIVILIZATION_SPAIN" or civilizationType == "CIVILIZATION_AUSTRALIA" or civilizationType == "CIVILIZATION_BRAZIL" or civilizationType == "CIVILIZATION_INCA" or civilizationType == "CIVILIZATION_MAPUCHE" or civilizationType == "CIVILIZATION_EGYPT" or civilizationType == "CIVILIZATION_CANADA" or civilizationType == "CIVILIZATION_RUSSIA" then
		local count = 0
		for i, plot in ipairs(startPlots) do
			if civilizationType == "CIVILIZATION_SPAIN" then
				local continent = nil
				local multi_continent = false
				if continent == nil then
					continent = plot:GetContinentType()
					else
					if plot:GetContinentType() ~= continent then
						multi_continent = true
						region_bonus = 50
						break
					end
				end
			end
			if civilizationType == "CIVILIZATION_BRAZIL"  then
				if  plot:GetFeatureType() == "FEATURE_JUNGLE" then
					count = count + 1
				end
				if  plot:GetFeatureType() == "FEATURE_FOREST" then
					count = count - 1
				end
			end
			if civilizationType == "CIVILIZATION_AUSTRALIA" or civilizationType == "CIVILIZATION_MAPUCHE" then
				if  plot:GetFeatureType() == "FEATURE_JUNGLE" or plot:GetFeatureType() == "FEATURE_FLOODPLAINS" or plot:GetFeatureType() == "FEATURE_FLOODPLAINS_PLAINS" or plot:GetFeatureType() == "FEATURE_FLOODPLAINS_GRASSLAND" then
					count = count + 1
				end
			end
			if civilizationType == "CIVILIZATION_EGYPT" then
				if  plot:GetFeatureType() == "FEATURE_FLOODPLAINS" or plot:GetFeatureType() == "FEATURE_FLOODPLAINS_PLAINS" or plot:GetFeatureType() == "FEATURE_FLOODPLAINS_GRASSLAND" then
					count = count + 1
				end
			end
			if civilizationType == "CIVILIZATION_INCA" then
				if  plot:GetTerrainType() == 2 or plot:GetTerrainType() == 5 then
					count = count + 1
				end
			end
			if civilizationType == "CIVILIZATION_RUSSIA" or civilizationType == "CIVILIZATION_CANADA" then
				if  plot:GetTerrainType() > 8 and plot:GetTerrainType() < 15 then
					count = count + 1
				end
			end
		end
		
		if (civilizationType == "CIVILIZATION_AUSTRALIA" or civilizationType == "CIVILIZATION_MAPUCHE") and count > 20 then 
			region_bonus = -200
		end
		if civilizationType == "CIVILIZATION_EGYPT" and count > 20 then 
			region_bonus = 150
		end
		if civilizationType == "CIVILIZATION_BRAZIL" and count > 1 then 
			region_bonus = 150
		end
		if civilizationType == "CIVILIZATION_INCA" and count > 15 then 
			if  count > 15 then
				region_bonus = 100
				else
				region_bonus = -300				
			end
		end
		if civilizationType == "CIVILIZATION_RUSSIA" or civilizationType == "CIVILIZATION_CANADA" then
			if  count > 15 then
				region_bonus = 250
				else
				region_bonus = -250				
			end
		end
	end
	
    for i, plot in ipairs(startPlots) do
        local ratedPlot = {};
        local foundBiasDesert = false;
        local foundBiasToundra = false;
		local foundBiasFloodPlains = false;
		local foundBiasCoast = false;
        ratedPlot.Plot = plot;
        ratedPlot.Score = 0 + region_bonus;
        ratedPlot.Index = i;
        if (biases ~= nil) then
            for j, bias in ipairs(biases) do
                --self:__Debug("Rate Plot:", plot:GetX(), ":", plot:GetY(), "For Bias :", bias.Type, "value :", bias.Value);
                if (bias.Type == "TERRAINS") then
					if bias.Value == g_TERRAIN_TYPE_COAST then
						foundBiasCoast = true;
                        local COASTCount = self:__CountAdjacentTerrainsInOneRangeTMP(ratedPlot.Plot, bias.Value, major);
                        local isCoast =self:__CountAdjacentTerrainsInRange(ratedPlot.Plot, bias.Value, major);
                        if COASTCount >= 5 and COASTCount<=10 and isCoast>=1 then
                            ratedPlot.Score = ratedPlot.Score + 3000000;
                        elseif COASTCount == 4 and isCoast>=1 then
                            ratedPlot.Score = ratedPlot.Score + 2000000;
                        elseif COASTCount > 0 and COASTCount<=10 and isCoast>=1 then
                            ratedPlot.Score = ratedPlot.Score + 1000000;
                        else
                            if isStartCheck == true then
                                if(COASTCount>10)then
                                    ratedPlot.Score = ratedPlot.Score - 90000000;
                                elseif civilizationType == "CIVILIZATION_SPAIN" then
                                    ratedPlot.Score = ratedPlot.Score;
                                else
                                    ratedPlot.Score = ratedPlot.Score - 100000;
                                end
                            else
                                if civilizationType == "CIVILIZATION_SPAIN" then
                                    ratedPlot.Score = ratedPlot.Score;
                                else
                                    ratedPlot.Score = ratedPlot.Score - 90000000;
                                end
                            end   
                            --[[if isStartCheck == true then
                                ratedPlot.Score = ratedPlot.Score - 2000;
                            else
                                ratedPlot.Score = ratedPlot.Score + self:__ScoreAdjacent(self:__CountAdjacentTerrainsInRange(ratedPlot.Plot, bias.Value, major), bias.Tier);
                            end--]]
                        end
                        --判断捞鱼4、5环及以内没有冻土
                        --[[for dir = 36,90 - 1,1 do
                            local adjacentPlot = GetAdjacentTiles(ratedPlot.Plot, dir);
                            if(adjacentPlot ~= nil and adjacentPlot:GetTerrainType() == g_TERRAIN_TYPE_TUNDRA or adjacentPlot:GetTerrainType() == g_TERRAIN_TYPE_TUNDRA_HILLS) then
                                ratedPlot.Score = ratedPlot.Score - 1000000;
                                break;
                            end
                        end]]
					end
                    if (bias.Value == g_TERRAIN_TYPE_DESERT) then
                        foundBiasDesert = true;
                    end
                    if (bias.Value == g_TERRAIN_TYPE_TUNDRA or bias.Value == g_TERRAIN_TYPE_SNOW) then
                        foundBiasToundra = true;
                    end
                elseif (bias.Type == "FEATURES") then
                    ratedPlot.Score = ratedPlot.Score + 1000 + self:__ScoreAdjacent(self:__CountAdjacentFeaturesInRange(ratedPlot.Plot, bias.Value, major), bias.Tier);
					if (bias.Value == g_FEATURE_FLOODPLAINS or bias.Value == g_FEATURE_FLOODPLAINS_PLAINS or bias.Value == g_FEATURE_FLOODPLAINS_GRASSLAND) then
                        foundBiasFloodPlains = true;
                    end
                elseif (bias.Type == "RIVERS" and ratedPlot.Plot:IsRiver()) then
                    ratedPlot.Score = ratedPlot.Score + 100000 + self:__ScoreAdjacent(1, bias.Tier);
                elseif (bias.Type == "RESOURCES") then
                    ratedPlot.Score = ratedPlot.Score + 1000 + self:__ScoreAdjacent(self:__CountAdjacentResourcesInRange(ratedPlot.Plot, bias.Value, major), bias.Tier);
                end
            end
        end
        if (major) then
			--[[if self.uiStartConfig ~= 3 then
				-- luxury fix
				local luxcount =  self:__LuxuryCount(ratedPlot.Plot)
				if luxcount == 1 then
					ratedPlot.Score = ratedPlot.Score + 25--25

				elseif luxcount > 1 then
					ratedPlot.Score = ratedPlot.Score - 25 * luxcount
                    if civilizationType == "CIVILIZATION_MAYA" then
                        ratedPlot.Score = ratedPlot.Score + 25
                    end
                    if civilizationType == "CIVILIZATION_FRANCE" then
                        ratedPlot.Score = ratedPlot.Score + 50
                    end			
				else
                    ratedPlot.Score = ratedPlot.Score - 100
                    if civilizationType == "CIVILIZATION_MAYA" then
                        ratedPlot.Score = ratedPlot.Score - 200
                    end
                    if civilizationType == "CIVILIZATION_FRANCE" then
                        ratedPlot.Score = ratedPlot.Score -200
                    end
                end	
					
			end--]]
            --
            --[[local seaLeftCount =0;
            local seaRightCount =0;
            for dir = 60, 75 , 1 do
                local adjacentPlotTemp = Map.GetAdjacentPlot(ratedPlot.Plot:GetX(), ratedPlot.Plot:GetY(), dir);
                if(adjacentPlotTemp ~= nil and adjacentPlotTemp:GetTerrainType() == g_TERRAIN_TYPE_COAST) then
                    if (not adjacentPlotTemp:IsLake()) then
                        seaLeftCount = seaLeftCount + 1;
                    end
                end
            end
            for dir = 75, 90 , 1 do
                local adjacentPlotTemp = Map.GetAdjacentPlot(ratedPlot.Plot:GetX(), ratedPlot.Plot:GetY(), dir);
                if(adjacentPlotTemp ~= nil and adjacentPlotTemp:GetTerrainType() == g_TERRAIN_TYPE_COAST) then
                    if (not adjacentPlotTemp:IsLake()) then
                        seaRightCount = seaRightCount + 1;
                    end
                end
            end
            if seaLeftCount>=5 and seaRightCount>=5 then
                ratedPlot.Score = ratedPlot.Score - 2000;
            end--]]
            --
            local plotX = ratedPlot.Plot:GetX();
            local plotY = ratedPlot.Plot:GetY();

            local XWaterCheck = 0;
            for dx = -3, 0, 1 do
                local adjacentPlot = Map.GetPlotXYWithRangeCheck(plotX, plotY, dx, 0, 3);
                if(adjacentPlot ~= nil and adjacentPlot:IsWater() == true) then
                    XWaterCheck = XWaterCheck + 1;
                    break;
                end
            end

            for dx = 0, 3, 1 do
                local adjacentPlot = Map.GetPlotXYWithRangeCheck(plotX, plotY, dx, 0, 3);
                if(adjacentPlot ~= nil and adjacentPlot:IsWater() == true) then
                    XWaterCheck = XWaterCheck + 1;
                    break;
                end
            end

            local Y1WaterCheck = 0;
            for dy = -3, 0, 1 do
                local adjacentPlot = Map.GetPlotXYWithRangeCheck(plotX, plotY, 1, dy, 3);
                if(adjacentPlot ~= nil and adjacentPlot:IsWater() == true) then
                    Y1WaterCheck = Y1WaterCheck + 1;
                    break;
                end
            end

            for dy = 0, 3, 1 do
                local adjacentPlot = Map.GetPlotXYWithRangeCheck(plotX, plotY, 1, dy, 3);
                if(adjacentPlot ~= nil and adjacentPlot:IsWater() == true) then
                    Y1WaterCheck = Y1WaterCheck + 1;
                    break;
                end
            end

            local Y2WaterCheck = 0;
            for dy = -3, 0, 1 do
                local adjacentPlot = Map.GetPlotXYWithRangeCheck(plotX, plotY, -1, dy, 3);
                if(adjacentPlot ~= nil and adjacentPlot:IsWater() == true) then
                    Y2WaterCheck = Y2WaterCheck + 1;
                    break;
                end
            end

            for dy = 0, 3, 1 do
                local adjacentPlot = Map.GetPlotXYWithRangeCheck(plotX, plotY, -1, dy, 3);
                if(adjacentPlot ~= nil and adjacentPlot:IsWater() == true) then
                    Y2WaterCheck = Y2WaterCheck + 1;
                    break;
                end
            end

            local YWaterCheck = 0;
            for dy = -3, 0, 1 do
                local adjacentPlot = Map.GetPlotXYWithRangeCheck(plotX, plotY, 0, dy, 3);
                if(adjacentPlot ~= nil and adjacentPlot:IsWater() == true) then
                    YWaterCheck = YWaterCheck + 1;
                    break;
                end
            end

            for dy = 0, 3, 1 do
                local adjacentPlot = Map.GetPlotXYWithRangeCheck(plotX, plotY, 0, dy, 3);
                if(adjacentPlot ~= nil and adjacentPlot:IsWater() == true) then
                    YWaterCheck = YWaterCheck + 1;
                    break;
                end
            end

            if(XWaterCheck==2 or (Y2WaterCheck==2 and Y1WaterCheck == 2) or YWaterCheck==2)then
                ratedPlot.Score = ratedPlot.Score - 90000000;
            end

			if self.waterMap == false and foundBiasCoast == false then
				local water_tiles = self:__CountAdjacentTerrainsInRange(ratedPlot.Plot, nil, true, true)
				if water_tiles < 4 then
                    if(isStartCheck==true)then
                        ratedPlot.Score = ratedPlot.Score + 30000 - water_tiles * 30000;
                    else
                        ratedPlot.Score = ratedPlot.Score + 30000 - water_tiles * 10000;
                    end
				end
                local COASTCount = self:__CountAdjacentTerrainsInOneRangeTMP(ratedPlot.Plot, g_TERRAIN_TYPE_COAST, major);
                if COASTCount > 10 then
                    if isStartCheck == true then
                        ratedPlot.Score = ratedPlot.Score - 90000000;
                    else
                        ratedPlot.Score = ratedPlot.Score - 90000000;
                    end
                end
			end
			--[[if civilizationType ~= "CIVILIZATION_INCA" then
			    local Mountain_plains = self:__CountAdjacentTerrainsInRange(ratedPlot.Plot, 5, false);
                local Mountain_grass = self:__CountAdjacentTerrainsInRange(ratedPlot.Plot, 2, false);
				if Mountain_plains ~= nil and Mountain_grass ~= nil then
					if (Mountain_plains + Mountain_grass) > 0 and (Mountain_plains + Mountain_grass) < 5 then
						ratedPlot.Score = ratedPlot.Score + 5*(Mountain_plains + Mountain_grass)
					end
				end	
			end--]]
            --印加、美国、玛雅不允许出生在海边
            if civilizationType == "CIVILIZATION_INCA" or civilizationType == "CIVILIZATION_MAYA" or civilizationType == "CIVILIZATION_AMERICA" or civilizationType == "CIVILIZATION_MALI" then
                local isCoast =self:__CountAdjacentTerrainsInRange(ratedPlot.Plot, g_TERRAIN_TYPE_COAST, major);
                if(isCoast>=1)then
                    if isStartCheck == true then
                        ratedPlot.Score = ratedPlot.Score;
                    else
                        ratedPlot.Score = ratedPlot.Score - 90000000;
                    end
                end
            end
            
            local Civ_Coast_Level = 5
            for row in GameInfo.StartBiasTerrains() do		-- 减少文明沿海概率
				if(row.CivilizationType == civilizationType) then
					if row.TerrainType == "TERRAIN_COAST" then
						if row.Tier < Civ_Coast_Level then
							Civ_Coast_Level = row.Tier
						end
					end
				end
            end
            
            if Civ_Coast_Level >= 2 then	-- 降低沿海评分
				local isCoast =self:__CountAdjacentTerrainsInRange(ratedPlot.Plot, g_TERRAIN_TYPE_COAST, major);
                if(isCoast>=1)then
                    if isStartCheck == true then
                        ratedPlot.Score = ratedPlot.Score;
                    else
                        ratedPlot.Score = ratedPlot.Score - 9000000;
                    end
                end
            end

			if ratedPlot.Plot:IsRiver() then
				ratedPlot.Score = ratedPlot.Score + 600000;
				if foundBiasCoast == false then
				    ratedPlot.Score = ratedPlot.Score + 100000;
				end
				if civilizationType == "CIVILIZATION_MALI" then
					ratedPlot.Score = ratedPlot.Score + 100000;
				end
                --[[if civilizationType == "CIVILIZATION_MAYA" then
                    ratedPlot.Score = ratedPlot.Score - 10000;
                end--]]
            else
                if isCanRandom == true then
                    if isStartCheck == true then
                        ratedPlot.Score = ratedPlot.Score;
                    else
                        ratedPlot.Score = ratedPlot.Score - 800000;
                    end
                else
                    ratedPlot.Score = ratedPlot.Score - 90000000;
                end
			end

            local civBadBias = false;
            local civBadBiasCount = 0;
            if (not foundBiasDesert) then
                local tempDesert = self:__CountAdjacentTerrainsInRange(ratedPlot.Plot, g_TERRAIN_TYPE_DESERT, true);
                local tempDesertHill = self:__CountAdjacentTerrainsInRange(ratedPlot.Plot, g_TERRAIN_TYPE_DESERT_HILLS, true);
                if ((tempDesert + tempDesertHill) > 0 ) then
                    --self:__Debug("No Desert Bias found, reduce adjacent Desert Terrain for Plot :", ratedPlot.Plot:GetX(), ratedPlot.Plot:GetY());
                    civBadBias=true;
                    civBadBiasCount = civBadBiasCount +(tempDesert + tempDesertHill);
                end
            end

			if (not foundBiasFloodPlains) then
                local tempFlood = self:__CountAdjacentFeaturesInRange(ratedPlot.Plot, g_FEATURE_FLOODPLAINS, true) 
								+ self:__CountAdjacentFeaturesInRange(ratedPlot.Plot, g_FEATURE_FLOODPLAINS_PLAINS, true)
								+ self:__CountAdjacentFeaturesInRange(ratedPlot.Plot, g_FEATURE_FLOODPLAINS_GRASSLAND, true);
                if (tempFlood > 0 ) then
                    --self:__Debug("No Floodplains Bias found, reduce adjacent floodplains for Plot :", ratedPlot.Plot:GetX(), ratedPlot.Plot:GetY());
                    --ratedPlot.Score = ratedPlot.Score - (tempFlood) * 100;
                    if (tempFlood <= 3) then
                        civBadBias=true;
                        civBadBiasCount = civBadBiasCount +(tempFlood);
                    else
                        --大于等于4时，不允许出生
                        if isStartCheck == true then
                            ratedPlot.Score = ratedPlot.Score - 90000000;
                        else
                            ratedPlot.Score = ratedPlot.Score - 90000000;
                        end
                    end
                end
            else
                local tempFlood = self:__CountAdjacentFeaturesInRange(ratedPlot.Plot, g_FEATURE_FLOODPLAINS, true) 
                                + self:__CountAdjacentFeaturesInRange(ratedPlot.Plot, g_FEATURE_FLOODPLAINS_PLAINS, true)
                                + self:__CountAdjacentFeaturesInRange(ratedPlot.Plot, g_FEATURE_FLOODPLAINS_GRASSLAND, true);
                if (tempFlood >= 3 and tempFlood <= 6 ) then
                    --self:__Debug("No Floodplains Bias found, reduce adjacent floodplains for Plot :", ratedPlot.Plot:GetX(), ratedPlot.Plot:GetY());
                    --ratedPlot.Score = ratedPlot.Score + 200;
                    ratedPlot.Score = ratedPlot.Score + 1000000 + 1000000*tempFlood;
                else
                    if isStartCheck == true then
                        ratedPlot.Score = ratedPlot.Score - 100000;
                    else
                        ratedPlot.Score = ratedPlot.Score - 90000000;
                    end
                end
            end

            if (not foundBiasToundra) then
                local tempTundra = self:__CountAdjacentTerrainsInRange(ratedPlot.Plot, g_TERRAIN_TYPE_TUNDRA, true);
                local tempTundraHill = self:__CountAdjacentTerrainsInRange(ratedPlot.Plot, g_TERRAIN_TYPE_TUNDRA_HILLS, true);
                if ((tempTundra + tempTundraHill) > 0) then
                    --self:__Debug("No Toundra Bias found, reduce adjacent Toundra and Snow Terrain for Plot :", ratedPlot.Plot:GetX(), ratedPlot.Plot:GetY());
                    --ratedPlot.Score = ratedPlot.Score - (tempTundra + tempTundraHill) * 400;
                    civBadBias=true;
                    civBadBiasCount = civBadBiasCount +(tempTundra + tempTundraHill);
                    if isStartCheck == true then
                        ratedPlot.Score = ratedPlot.Score - 90000000;
                    else
                        ratedPlot.Score = ratedPlot.Score - 90000000;
                    end
                end
			--[[else
				if ratedPlot.Plot:GetIndex() > Map.GetPlotCount() / 2 then
							--self:__Debug("Rate Plot:", plot:GetX(), ":", plot:GetY(), "Polarity Bias b_north_biased",b_north_biased,"We are North");
					if b_north_biased == true then
						ratedPlot.Score = ratedPlot.Score + 500
						else
						ratedPlot.Score = ratedPlot.Score - 500
					end
					else
							--self:__Debug("Rate Plot:", plot:GetX(), ":", plot:GetY(), "Polarity Bias b_north_biased",b_north_biased,"We are South");
					if b_north_biased == false then
						ratedPlot.Score = ratedPlot.Score + 500
						else
						ratedPlot.Score = ratedPlot.Score - 500
					end
				end--]]
            end
            --总结恶劣地形
            if(civBadBias == false)then
                ratedPlot.Score = ratedPlot.Score + 70000;
            else
                if(civBadBiasCount<7)then
                    ratedPlot.Score = ratedPlot.Score + 70000 - civBadBiasCount*10000;
                end
            end
            if (civilizationType == "CIVILIZATION_RUSSIA" or civilizationType == "CIVILIZATION_CANADA" or civilizationType == "CIVILIZATION_KJERAG") then
                local tempTundra = self:__CountAdjacentTerrainsInRange(ratedPlot.Plot, g_TERRAIN_TYPE_TUNDRA, true);
                local tempTundraHill = self:__CountAdjacentTerrainsInRange(ratedPlot.Plot, g_TERRAIN_TYPE_TUNDRA_HILLS, true);
                if (tempTundra + tempTundraHill >= 16) then
                    --self:__Debug("No Toundra Bias found, reduce adjacent Toundra and Snow Terrain for Plot :", ratedPlot.Plot:GetX(), ratedPlot.Plot:GetY());
                    ratedPlot.Score = ratedPlot.Score + 9000000;
                    --print("CIVILIZATION_RUSSIA or CIVILIZATION_CANADA ratedPlot.Score Successful:",ratedPlot.Score);
                elseif(tempTundra + tempTundraHill > 0)then
                    local tempTundraCountRatio = tempTundra + tempTundraHill;
                    if(tempTundraCountRatio>16)then
                        tempTundraCountRatio=16;
                    end
                    ratedPlot.Score = ratedPlot.Score + 1000000*math.floor(tempTundraCountRatio*0.56);
                        --print("CIVILIZATION_RUSSIA or CIVILIZATION_CANADA ratedPlot.Score 小冻土:",ratedPlot.Score);
                else
                    if isStartCheck == true then
                        ratedPlot.Score = ratedPlot.Score - 100000;
                    else
                        ratedPlot.Score = ratedPlot.Score - 90000000;
                    end
                    --print("CIVILIZATION_RUSSIA or CIVILIZATION_CANADA ratedPlot.Score:",ratedPlot.Score);
                end
                
            end
			if civilizationType == "CIVILIZATION_SPAIN" then
				local continent = self:__CountAdjacentContinentsInRange(ratedPlot.Plot, major);
                local continentTwo = self:__CountAdjacentContinentsInRangeTwo(ratedPlot.Plot, major);
                --print("CIVILIZATION_SPAIN isCanRandom -90000000 ratedPlot.Score:",ratedPlot.Score,";  i:",i);
                --print("CIVILIZATION_SPAIN isCanRandom -90000000 continent:",continent,";continentTwo",continentTwo);
                if continentTwo >0 then
                    ratedPlot.Score = ratedPlot.Score + 5000000;
                end
				if continent >0 then
					ratedPlot.Score = ratedPlot.Score + 2000000;
                else
                    if isCanRandom == false and reStartCount <=3 then
                        ratedPlot.Score = ratedPlot.Score - 90000000;
                    else
                        ratedPlot.Score = ratedPlot.Score;
                    end 
				end
			end
			
			-- Placement
			if MapConfiguration.GetValue("MAP_SCRIPT") ~= "Tilted_Axis.lua" and civilizationType ~= "CIVILIZATION_RUSSIA" and civilizationType ~= "CIVILIZATION_CANADA" then
			    local max = 0;
				local min = 0;
				if Map.GetMapSize() == 4 then
					max = 12 -- math.ceil(0.5*gridHeight * self.uiStartMaxY / 100);
					min = 12 -- math.ceil(0.5*gridHeight * self.uiStartMinY / 100);
					elseif Map.GetMapSize() == 5 then
					max = 14
					min = 14
					elseif Map.GetMapSize() == 3 then
					max = 10
					min = 10	
					else
					max = 8
					min = 8
				end	


				if(plot:GetY() <= min or plot:GetY() > gridHeight - max) then
					ratedPlot.Score = ratedPlot.Score - 1000
					elseif(plot:GetY() <= min + 1 or plot:GetY() > gridHeight - max - 1) then 
					ratedPlot.Score = ratedPlot.Score - 500
					elseif(plot:GetY() <= min + 2 or plot:GetY() > gridHeight - max - 2) then 
					ratedPlot.Score = ratedPlot.Score - 75
				end	
			end
			
			-- 排除非海洋文明靠近边界
			local d_ban = 6
			local d_water_W = 15 + d_ban
			local d_water_H = 6 + d_ban
			
			if not (plot:IsCoastalLand() or plot:IsWater()) then		-- 非海洋出生位
				if plot:GetX() < d_water_W or plot:GetX() >= gridWidth - d_water_W then
					ratedPlot.Score = ratedPlot.Score - 5000000
				end
				if plot:GetY() < d_water_H or plot:GetY() >= gridHeight - d_water_H then
					ratedPlot.Score = ratedPlot.Score - 5000000
				end
			end
	
            local iTeamPlacementScoreRatio = 1;
			if(isStartCheck == true)then
                iTeamPlacementScoreRatio = 0;
            end
			if self.iTeamPlacement == 1 then
				-- East vs. West	
				local Lv_0 = (gridWidth * 0.5 + 9) / gridWidth;
				local Lv_1 = (gridWidth * 0.5 + 6) / gridWidth;
				local Lv_2 = (gridWidth * 0.5 + 5) / gridWidth;
				local Lv_3 = (gridWidth * 0.5 + 3) / gridWidth;
				local Lv_4 = (gridWidth * 0.5 + 1) / gridWidth;
				local Lv_5 = (gridWidth * 0.5 - 3) / gridWidth;

				if plot:IsCoastalLand() or plot:IsWater() then
					Lv_0 = 1
				end

				if Players[iPlayer] ~= nil then
					if Teamers_Ref_team == nil then
						Teamers_Ref_team = Players[iPlayer]:GetTeam()
					end
                    if Teamers_Ref_team_overturn == nil then
                         local Teamers_Ref_team_overturn_random = TerrainBuilder.GetRandomNumber(100, "Teamers_Ref_team_overturn - Lua");
                         if(Teamers_Ref_team_overturn_random>=50)then
                            Teamers_Ref_team_overturn=true
                         else
                            Teamers_Ref_team_overturn=false
                         end
                    end
                    if(Teamers_Ref_team_overturn==true)then
                        if Players[iPlayer]:GetTeam() == Teamers_Ref_team then
                            if plot:GetX() > gridWidth*(Lv_1) then
                                ratedPlot.Score = ratedPlot.Score + iTeamPlacementScoreRatio*10000000 + 100000*7;
                                if plot:GetX() > gridWidth*(Lv_0) then
									ratedPlot.Score = ratedPlot.Score - 1000000
                                end
                            elseif plot:GetX() > gridWidth*(Lv_2) then
                                ratedPlot.Score = ratedPlot.Score + iTeamPlacementScoreRatio*10000000 + 100000*8;
                            elseif plot:GetX() > gridWidth*(Lv_3) then
                                if(reStartCount>=2)then
                                    ratedPlot.Score = ratedPlot.Score + iTeamPlacementScoreRatio*10000000 + 100000*9;
                                end
                            elseif plot:GetX() > gridWidth*(Lv_4) then
                                if(reStartCount>=4)then
                                    ratedPlot.Score = ratedPlot.Score + iTeamPlacementScoreRatio*10000000 + 100000*5;
                                end
                            elseif plot:GetX() > gridWidth*(Lv_5) then
                                if(reStartCount>=6)then
                                    ratedPlot.Score = ratedPlot.Score + iTeamPlacementScoreRatio*10000000 + 100000*1;
                                end
                            else
                                if isStartCheck == true and reStartCount>=4 then
                                    ratedPlot.Score = ratedPlot.Score;
                                else
                                    ratedPlot.Score = ratedPlot.Score - 90000000;
                                end
                            end
                        else
                            if plot:GetX() < gridWidth*(1-Lv_1) then
                                ratedPlot.Score = ratedPlot.Score + iTeamPlacementScoreRatio*10000000 + 100000*7;
								if plot:GetX() < gridWidth*(1-Lv_0) then
									ratedPlot.Score = ratedPlot.Score - 1000000
								end
                            elseif plot:GetX() < gridWidth*(1-Lv_2) then
                                ratedPlot.Score = ratedPlot.Score + iTeamPlacementScoreRatio*10000000 + 100000*8;
                            elseif plot:GetX() < gridWidth*(1-Lv_3) then
                                if(reStartCount>=2)then
                                    ratedPlot.Score = ratedPlot.Score + iTeamPlacementScoreRatio*10000000 + 100000*9;
                                end
                            elseif plot:GetX() < gridWidth*(1-Lv_4) then
                                if(reStartCount>=4)then
                                    ratedPlot.Score = ratedPlot.Score + iTeamPlacementScoreRatio*10000000 + 100000*5;
                                end
                            elseif plot:GetX() < gridWidth*(1-Lv_5) then
                                if(reStartCount>=6)then
                                    ratedPlot.Score = ratedPlot.Score + iTeamPlacementScoreRatio*10000000 + 100000*1;
                                end
                            else
                                if isStartCheck == true and reStartCount>=4 then
                                    ratedPlot.Score = ratedPlot.Score;
                                else
                                    ratedPlot.Score = ratedPlot.Score - 90000000;
                                end
                            end
                        end
                    else
                        if Players[iPlayer]:GetTeam() ~= Teamers_Ref_team then
                            if plot:GetX() > gridWidth*(Lv_1) then
                                ratedPlot.Score = ratedPlot.Score + iTeamPlacementScoreRatio*10000000 + 100000*7;
                                if plot:GetX() > gridWidth*(Lv_0) then
									ratedPlot.Score = ratedPlot.Score - 1000000
                                end
                            elseif plot:GetX() > gridWidth*(Lv_2) then
                                ratedPlot.Score = ratedPlot.Score + iTeamPlacementScoreRatio*10000000 + 100000*8;
                            elseif plot:GetX() > gridWidth*(Lv_3) then
                                if(reStartCount>=2)then
                                    ratedPlot.Score = ratedPlot.Score + iTeamPlacementScoreRatio*10000000 + 100000*9;
                                end
                            elseif plot:GetX() > gridWidth*(Lv_4) then
                                if(reStartCount>=4)then
                                    ratedPlot.Score = ratedPlot.Score + iTeamPlacementScoreRatio*10000000 + 100000*5;
                                end
                            elseif plot:GetX() > gridWidth*(Lv_5) then
                                if(reStartCount>=6)then
                                    ratedPlot.Score = ratedPlot.Score + iTeamPlacementScoreRatio*10000000 + 100000*1;
                                end
                            else
                                if isStartCheck == true and reStartCount>=4 then
                                    ratedPlot.Score = ratedPlot.Score;
                                else
                                    ratedPlot.Score = ratedPlot.Score - 90000000;
                                end
                            end
                        else
                            if plot:GetX() < gridWidth*(1-Lv_1) then
                                ratedPlot.Score = ratedPlot.Score + iTeamPlacementScoreRatio*10000000 + 100000*7;
								if plot:GetX() < gridWidth*(1-Lv_0) then
									ratedPlot.Score = ratedPlot.Score - 1000000
								end
                            elseif plot:GetX() < gridWidth*(1-Lv_2) then
                                ratedPlot.Score = ratedPlot.Score + iTeamPlacementScoreRatio*10000000 + 100000*8;
                            elseif plot:GetX() < gridWidth*(1-Lv_3) then
                                if(reStartCount>=2)then
                                    ratedPlot.Score = ratedPlot.Score + iTeamPlacementScoreRatio*10000000 + 100000*9;
                                end
                            elseif plot:GetX() < gridWidth*(1-Lv_4) then
                                if(reStartCount>=4)then
                                    ratedPlot.Score = ratedPlot.Score + iTeamPlacementScoreRatio*10000000 + 100000*5;
                                end
                            elseif plot:GetX() < gridWidth*(1-Lv_5) then
                                if(reStartCount>=6)then
                                    ratedPlot.Score = ratedPlot.Score + iTeamPlacementScoreRatio*10000000 + 100000*1;
                                end
                            else
                                if isStartCheck == true and reStartCount>=4 then
                                    ratedPlot.Score = ratedPlot.Score;
                                else
                                    ratedPlot.Score = ratedPlot.Score - 90000000;
                                end
                            end
                        end
                    end
					
				end	
				
				-- North vs. South
			elseif self.iTeamPlacement == 2 then
				if Players[iPlayer] ~= nil then
					if Teamers_Ref_team == nil then
						Teamers_Ref_team = Players[iPlayer]:GetTeam()
					end
                    if Teamers_Ref_team_overturn == nil then
                         local Teamers_Ref_team_overturn_random = TerrainBuilder.GetRandomNumber(100, "Teamers_Ref_team_overturn - Lua");
                         if(Teamers_Ref_team_overturn_random>=50)then
                            Teamers_Ref_team_overturn=true
                         else
                            Teamers_Ref_team_overturn=false
                         end
                    end
                    if(Teamers_Ref_team_overturn==true)then
                        if Players[iPlayer]:GetTeam() == Teamers_Ref_team then
                            if plot:GetY() > gridWidth*(1/1.8) then
                                ratedPlot.Score = ratedPlot.Score + iTeamPlacementScoreRatio*10000000 + 100000*9;
                            elseif plot:GetY() > gridWidth*(1/1.9) then
                                ratedPlot.Score = ratedPlot.Score + iTeamPlacementScoreRatio*10000000 + 100000*8;
                            elseif plot:GetY() > gridWidth*(1/2) then
                                if(reStartCount>=2)then
                                    ratedPlot.Score = ratedPlot.Score + iTeamPlacementScoreRatio*10000000 + 100000*7;
                                end
                            elseif plot:GetY() > gridWidth*(1/2.1) then
                                if(reStartCount>=4)then
                                    ratedPlot.Score = ratedPlot.Score + iTeamPlacementScoreRatio*10000000 + 100000*5;
                                end
                            elseif plot:GetY() > gridWidth*(1/2.2) then
                                if(reStartCount>=6)then
                                    ratedPlot.Score = ratedPlot.Score + iTeamPlacementScoreRatio*10000000 + 100000*1;
                                end
                            else
                                if isStartCheck == true and reStartCount>=4 then
                                    ratedPlot.Score = ratedPlot.Score;
                                else
                                    ratedPlot.Score = ratedPlot.Score - 90000000;
                                end
                            end
                        else
                            if plot:GetY() < gridWidth*(1-1/1.8) then
                                ratedPlot.Score = ratedPlot.Score + iTeamPlacementScoreRatio*10000000 + 100000*9;
                            elseif plot:GetY() < gridWidth*(1-1/1.9) then
                                ratedPlot.Score = ratedPlot.Score + iTeamPlacementScoreRatio*10000000 + 100000*8;
                            elseif plot:GetY() < gridWidth*(1-1/2) then
                                if(reStartCount>=2)then
                                    ratedPlot.Score = ratedPlot.Score + iTeamPlacementScoreRatio*10000000 + 100000*7;
                                end
                            elseif plot:GetY() < gridWidth*(1-1/2.1) then
                                if(reStartCount>=4)then
                                    ratedPlot.Score = ratedPlot.Score + iTeamPlacementScoreRatio*10000000 + 100000*5;
                                end
                            elseif plot:GetY() < gridWidth*(1-1/2.2) then
                                if(reStartCount>=6)then
                                    ratedPlot.Score = ratedPlot.Score + iTeamPlacementScoreRatio*10000000 + 100000*1;
                                end
                            else
                                if isStartCheck == true and reStartCount>=4 then
                                    ratedPlot.Score = ratedPlot.Score;
                                else
                                    ratedPlot.Score = ratedPlot.Score - 90000000;
                                end
                            end
                        end
                    else
                        if Players[iPlayer]:GetTeam() ~= Teamers_Ref_team then
                            if plot:GetY() > gridWidth*(1/1.8) then
                                ratedPlot.Score = ratedPlot.Score + iTeamPlacementScoreRatio*10000000 + 100000*9;
                            elseif plot:GetY() > gridWidth*(1/1.9) then
                                ratedPlot.Score = ratedPlot.Score + iTeamPlacementScoreRatio*10000000 + 100000*8;
                            elseif plot:GetY() > gridWidth*(1/2) then
                                if(reStartCount>=2)then
                                    ratedPlot.Score = ratedPlot.Score + iTeamPlacementScoreRatio*10000000 + 100000*7;
                                end
                            elseif plot:GetY() > gridWidth*(1/2.1) then
                                if(reStartCount>=4)then
                                    ratedPlot.Score = ratedPlot.Score + iTeamPlacementScoreRatio*10000000 + 100000*5;
                                end
                            elseif plot:GetY() > gridWidth*(1/2.2) then
                                if(reStartCount>=6)then
                                    ratedPlot.Score = ratedPlot.Score + iTeamPlacementScoreRatio*10000000 + 100000*1;
                                end
                            else
                                if isStartCheck == true and reStartCount>=4 then
                                    ratedPlot.Score = ratedPlot.Score;
                                else
                                    ratedPlot.Score = ratedPlot.Score - 90000000;
                                end
                            end
                        else
                            if plot:GetY() < gridWidth*(1-1/1.8) then
                                ratedPlot.Score = ratedPlot.Score + iTeamPlacementScoreRatio*10000000 + 100000*9;
                            elseif plot:GetY() < gridWidth*(1-1/1.9) then
                                ratedPlot.Score = ratedPlot.Score + iTeamPlacementScoreRatio*10000000 + 100000*8;
                            elseif plot:GetY() < gridWidth*(1-1/2) then
                                if(reStartCount>=2)then
                                    ratedPlot.Score = ratedPlot.Score + iTeamPlacementScoreRatio*10000000 + 100000*7;
                                end
                            elseif plot:GetY() < gridWidth*(1-1/2.1) then
                                if(reStartCount>=4)then
                                    ratedPlot.Score = ratedPlot.Score + iTeamPlacementScoreRatio*10000000 + 100000*5;
                                end
                            elseif plot:GetY() < gridWidth*(1-1/2.2) then
                                if(reStartCount>=6)then
                                    ratedPlot.Score = ratedPlot.Score + iTeamPlacementScoreRatio*10000000 + 100000*1;
                                end
                            else
                                if isStartCheck == true and reStartCount>=4 then
                                    ratedPlot.Score = ratedPlot.Score;
                                else
                                    ratedPlot.Score = ratedPlot.Score - 90000000;
                                end
                            end
                        end
                    end
				end	
				
			end
		end

		if (plot:GetFeatureType() == g_FEATURE_OASIS) then
			ratedPlot.Score = ratedPlot.Score -250;
		end
        --ratedPlot.Score = ratedPlot.Score + self:__CountAdjacentYieldsInRange(plot, major);
		if self.waterMap == true and plot:IsCoastalLand() == false then
			ratedPlot.Score = ratedPlot.Score - 250;
		end
		
		if (civilizationType ~= "CIVILIZATION_MAYA" or self.waterMap == true) and plot:IsCoastalLand() == true then
			ratedPlot.Score = ratedPlot.Score + 25;
			else
			ratedPlot.Score = ratedPlot.Score - 100;
		end

		if (plot:IsFreshWater() == true and civilizationType ~= "CIVILIZATION_MAYA") then
			ratedPlot.Score = ratedPlot.Score + 50;
			if foundBiasCoast == false then
				ratedPlot.Score = ratedPlot.Score + 25;
			end
		end
		if Players[iPlayer] ~= nil then
			if self:__MajorCivBuffer(plot,Players[iPlayer]:GetTeam()) == false then
				ratedPlot.Score = ratedPlot.Score - 90000000;
			end
		end
        if isCanRandom == true then
            ratedPlot.Score = ratedPlot.Score+TerrainBuilder.GetRandomNumber(10000, "Shuffling table entry - Lua");
        else
            ratedPlot.Score = ratedPlot.Score+TerrainBuilder.GetRandomNumber(1000, "Shuffling table entry - Lua");
        end
		ratedPlot.Score = math.floor(ratedPlot.Score);
        self:__Debug("Plot :", plot:GetX(), ":", plot:GetY(), "Score :", ratedPlot.Score, "North Biased:",b_north_biased, "Type:",plot:GetTerrainType());
		if Players[iPlayer] ~= nil and major then
			self:__Debug("Plot :", plot:GetX(), ":", plot:GetY(), "Region:",region_index,"Score :", ratedPlot.Score, "Civilization:",civilizationType, "Team",Players[iPlayer]:GetTeam(),"Type:",plot:GetTerrainType());
		end
        --print("CIVILIZATION_SPAIN isCanRandom -90000000 ratedPlot.Score:",ratedPlot.Score,";  i:",i);
		table.insert(ratedPlots, ratedPlot);

    end
    table.sort(ratedPlots, function(a, b) return a.Score > b.Score; end);
    return ratedPlots;
end
------------------------------------------------------------------------------
function BBS_AssignStartingPlots:__SettlePlot(ratedBiases, index, player, major, regionIndex, civilizationType)
    local settled = false;
	if (regionIndex == -1) then
		self:__Debug("BBS_AssignStartingPlots: Attempt to place a Player using the Fallback plots.");
		else
		self:__Debug("BBS_AssignStartingPlots: Attempt to place a Player using region ", regionIndex)
	end

    for j, ratedBias in ipairs(ratedBiases) do
        if (not settled) then
            --self:__Debug("Rated Bias Plot:", ratedBias.Plot:GetX(), ":", ratedBias.Plot:GetY(), "Score :", ratedBias.Score);
            if (major) then
                self.playerStarts[index] = {};
                if (self:__MajorCivBuffer(ratedBias.Plot,player:GetTeam())) then
                    self:__Debug("Settled plot :", ratedBias.Plot:GetX(), ":", ratedBias.Plot:GetY(), "Score :", ratedBias.Score, "Player:",player:GetID(),"Region:",regionIndex);
					print("Settled Score :", ratedBias.Score, "Player:",player:GetID(),"Region:",regionIndex)
					if ratedBias.Score < - 500 then
						bError_shit_settle = true
					end
                    settled = true;
                    table.insert(self.playerStarts[index], ratedBias.Plot);
                    table.insert(self.majorStartPlots, ratedBias.Plot);
					table.insert(self.majorStartPlotsTeam, player:GetTeam());
                    table.insert(self.aMajorStartPlotIndices, ratedBias.Plot:GetIndex());
                    self:__TryToRemoveBonusResource(ratedBias.Plot);
                    player:SetStartingPlot(ratedBias.Plot);
					--self:__AddLeyLine(ratedBias.Plot); 
					-- Tundra Sharing
					if ratedBias.Plot:GetTerrainType() > 8 and major == true then
						self:__Debug("BBS Placement: Flip the North Switch",b_north_biased,"to",not b_north_biased);
						b_north_biased = not b_north_biased
					end
                else
                    self:__Debug("Bias plot :", ratedBias.Plot:GetX(), ":", ratedBias.Plot:GetY(), "score :", ratedBias.Score, "Region :", regionIndex, "too near other Civ");
                end
            else
                self.playerStarts[index + self.iNumMajorCivs] = {};
                if ( self:__MinorMajorCivBuffer(ratedBias.Plot) and self:__MinorMinorCivBuffer(ratedBias.Plot,player:GetID()) ) then
                    print("Settled plot :", ratedBias.Plot:GetX(), ":", ratedBias.Plot:GetY(), "Score :", ratedBias.Score, "Player:",player:GetID(),"Region:",regionIndex);
                    settled = true;
                    table.insert(self.playerStarts[index + self.iNumMajorCivs], ratedBias.Plot);
                    table.insert(self.minorStartPlots, ratedBias.Plot)
					local tmp = {}
					tmp = {ID = player:GetID(), Plot = ratedBias.Plot}
					table.insert(self.minorStartPlotsID, tmp)
                    player:SetStartingPlot(ratedBias.Plot);

                else
                    --print("Bias plot :", ratedBias.Plot:GetX(), ":", ratedBias.Plot:GetY(), "score :", ratedBias.Score, "Region :", regionIndex, "too near other Civ");
                end
            end
            if (regionIndex == -1 and settled) then
                table.remove(self.fallbackPlots, ratedBias.Index)
            end
        elseif (regionIndex ~= -1) then
            table.insert(self.fallbackPlots, ratedBias.Plot);
        end
    end

    return settled;

end

------------------------------------------------------------------------------
function BBS_AssignStartingPlots:__AddLeyLine(plot)
	local iResourcesInDB = 0;
	eResourceType	= {};
	eResourceClassType = {};
	aBonus = {};

	for row in GameInfo.Resources() do
		eResourceType[iResourcesInDB] = row.Hash;
		eResourceClassType[iResourcesInDB] = row.ResourceClassType;
	    iResourcesInDB = iResourcesInDB + 1;
	end

	for row = 0, iResourcesInDB do
		if (eResourceClassType[row] == "RESOURCECLASS_LEY_LINE") then
			if(eResourceType[row] ~= nil) then
				table.insert(aBonus, eResourceType[row]);
			end
		end
	end

	local plotX = plot:GetX();
	local plotY = plot:GetY();
	
	aShuffledBonus =  GetShuffledCopyOfTable(aBonus);
	for i, resource in ipairs(aShuffledBonus) do
		for dx = -2, 2, 1 do
			for dy = -2,2, 1 do
				local otherPlot = Map.GetPlotXY(plotX, plotY, dx, dy, 2);
				if(otherPlot) then
					if(ResourceBuilder.CanHaveResource(otherPlot, resource) and otherPlot:GetIndex() ~= plot:GetIndex()) then
						ResourceBuilder.SetResourceType(otherPlot, resource, 1);
						return;
					end
				end
			end
		end 
	end
end
------------------------------------------------------------------------------
function BBS_AssignStartingPlots:__CountAdjacentTerrainsInRange(plot, terrainType, major,watercheck:boolean)
    local count = 0;
    local plotX = plot:GetX();
    local plotY = plot:GetY();
	if (not watercheck) then
		if (not major) then
			for dir = 0, DirectionTypes.NUM_DIRECTION_TYPES - 1, 1 do
				local adjacentPlot = Map.GetAdjacentPlot(plotX, plotY, dir);
				if(adjacentPlot ~= nil and adjacentPlot:GetTerrainType() == terrainType) then
                count = count + 1;
				end
			end
			elseif (terrainType == g_TERRAIN_TYPE_COAST) then
			-- At least one adjacent coast but that is not a lake and not more than one
			for dir = 0, DirectionTypes.NUM_DIRECTION_TYPES - 1, 1 do
            local adjacentPlot = Map.GetAdjacentPlot(plotX, plotY, dir);
				if(adjacentPlot ~= nil and adjacentPlot:GetTerrainType() == terrainType) then
					if (not adjacentPlot:IsLake() and count < 1) then
                    count = count + 1;
					end
				end
			end
			else
			for dx = -2, 2, 1 do
				for dy = -2, 2, 1 do
					local adjacentPlot = Map.GetPlotXYWithRangeCheck(plotX, plotY, dx, dy, 2);
					if(adjacentPlot ~= nil and adjacentPlot:GetTerrainType() == terrainType) then
                    count = count + 1;
					end
				end
			end
		end
		return count;
		
		else
		
	    for dx = -3, 3, 1 do
            for dy = -3, 3, 1 do
                local adjacentPlot = Map.GetPlotXYWithRangeCheck(plotX, plotY, dx, dy, 3);
                if(adjacentPlot ~= nil and adjacentPlot:IsWater() == true) then
                    count = count + 1;
                end
            end
        end

		return count
	end
end
------------------------------------------------------------------------------
function BBS_AssignStartingPlots:__CountAdjacentTerrainsInOneRangeTMP(plot, terrainType, major,watercheck:boolean)
    local count = 0;
    local plotX = plot:GetX();
    local plotY = plot:GetY();
    if (not watercheck) then
        if (not major) then
            for dir = 0, DirectionTypes.NUM_DIRECTION_TYPES - 1, 1 do
                local adjacentPlot = Map.GetAdjacentPlot(plotX, plotY, dir);
                if(adjacentPlot ~= nil and adjacentPlot:GetTerrainType() == terrainType) then
                    count = count + 1;
                end
            end
        elseif (terrainType == g_TERRAIN_TYPE_COAST) then
            -- At least one adjacent coast but that is not a lake and not more than one
            for dir = 0, 18 - 1, 1 do
                local adjacentPlot = GetAdjacentTiles(plot, dir);
                if(adjacentPlot ~= nil and adjacentPlot:GetTerrainType() == terrainType) then
                    if (not adjacentPlot:IsLake()) then
                        count = count + 1;
                    end
                end
            end
        else
            for dx = -1, 1, 1 do
                for dy = -1, 1, 1 do
                    local adjacentPlot = Map.GetPlotXYWithRangeCheck(plotX, plotY, dx, dy, 1);
                    if(adjacentPlot ~= nil and adjacentPlot:GetTerrainType() == terrainType) then
                        count = count + 1;
                    end
                end
            end
        end

        return count;

    else

        for dx = -1, 1, 1 do
            for dy = -1, 1, 1 do
                local adjacentPlot = Map.GetPlotXYWithRangeCheck(plotX, plotY, dx, dy, 1);
                if(adjacentPlot ~= nil and adjacentPlot:IsWater() == true) then
                    count = count + 1;
                end
            end
        end
        return count
    end
end
------------------------------------------------------------------------------
function BBS_AssignStartingPlots:__ScoreAdjacent(count, tier)
    local score = 0;
    local adjust = self.tierMax + 2 - tier;
    score = count * adjust * 100;
    if(score>=5000)then
        score=5000;
    end
    return score;
end
------------------------------------------------------------------------------
function BBS_AssignStartingPlots:__CountAdjacentFeaturesInRange(plot, featureType, major)
    local count = 0;
    local plotX = plot:GetX();
    local plotY = plot:GetY();
    if(not major) then
        for dir = 0, DirectionTypes.NUM_DIRECTION_TYPES - 1, 1 do
            local adjacentPlot = Map.GetAdjacentPlot(plotX, plotY, dir);
            if(adjacentPlot ~= nil and adjacentPlot:GetFeatureType() == featureType) then
                count = count + 1;
            end
        end
    else
        for dx = -2, 2, 1 do
            for dy = -2, 2, 1 do
                local adjacentPlot = Map.GetPlotXYWithRangeCheck(plotX, plotY, dx, dy, 2);
                if(adjacentPlot ~= nil and adjacentPlot:GetFeatureType() == featureType) then
                    count = count + 1;
                end
            end
        end
    end
    return count;
end
------------------------------------------------------------------------------
function BBS_AssignStartingPlots:__CountAdjacentContinentsInRange(plot, major)
    local count = 0;
    local plotX = plot:GetX();
    local plotY = plot:GetY();
	local continent = plot:GetContinentType()
    if(not major) then
        for dir = 0, DirectionTypes.NUM_DIRECTION_TYPES - 1, 1 do
            local adjacentPlot = Map.GetAdjacentPlot(plotX, plotY, dir);
            if(adjacentPlot ~= nil and adjacentPlot:GetContinentType() ~= continent) then
                count = count + 1;
            end
        end
    else
        for dx = -3, 3, 1 do
            for dy = -3, 3, 1 do
                local adjacentPlot = Map.GetPlotXYWithRangeCheck(plotX, plotY, dx, dy, 3);
                if(adjacentPlot ~= nil and adjacentPlot:GetContinentType() ~= continent and adjacentPlot:IsWater() == false) then
                    count = count + 1;
                end
            end
        end
    end
    return count;
end
------------------------------------------------------------------------------
function BBS_AssignStartingPlots:__CountAdjacentContinentsInRangeTwo(plot, major)
    local count = 0;
    local plotX = plot:GetX();
    local plotY = plot:GetY();
    local continent = plot:GetContinentType()
    if(not major) then
        for dir = 0, DirectionTypes.NUM_DIRECTION_TYPES - 1, 1 do
            local adjacentPlot = Map.GetAdjacentPlot(plotX, plotY, dir);
            if(adjacentPlot ~= nil and adjacentPlot:GetContinentType() ~= continent) then
                count = count + 1;
            end
        end
    else
        for dx = -2, 2, 1 do
            for dy = -2, 2, 1 do
                local adjacentPlot = Map.GetPlotXYWithRangeCheck(plotX, plotY, dx, dy, 2);
                if(adjacentPlot ~= nil and adjacentPlot:GetContinentType() ~= continent and adjacentPlot:IsWater() == false) then
                    count = count + 1;
                end
            end
        end
    end
    return count;
end
------------------------------------------------------------------------------
function BBS_AssignStartingPlots:__CountAdjacentResourcesInRange(plot, resourceType, major)
    local count = 0;
    local plotX = plot:GetX();
    local plotY = plot:GetY();
    if(not major) then
        for dir = 0, DirectionTypes.NUM_DIRECTION_TYPES - 1, 1 do
            local adjacentPlot = Map.GetAdjacentPlot(plotX, plotY, dir);
            if(adjacentPlot ~= nil and adjacentPlot:GetResourceType() == resourceType) then
                count = count + 1;
            end
        end
    else
        for dx = -2, 2, 1 do
            for dy = -2, 2, 1 do
                local adjacentPlot = Map.GetPlotXYWithRangeCheck(plotX, plotY, dx, dy, 2);
                if(adjacentPlot ~= nil and adjacentPlot:GetResourceType() == resourceType) then
                    count = count + 1;
                end
            end
        end
    end
    return count;
end
------------------------------------------------------------------------------
function BBS_AssignStartingPlots:__CountAdjacentYieldsInRange(plot)
    local score = 0;
    local food = 0;
    local prod = 0;
    local plotX = plot:GetX();
    local plotY = plot:GetY();
    for dir = 0, DirectionTypes.NUM_DIRECTION_TYPES - 1, 1 do
        local adjacentPlot = Map.GetAdjacentPlot(plotX, plotY, dir);
        if(adjacentPlot ~= nil) then
            local foodTemp = 0;
            local prodTemp = 0;
            if (adjacentPlot:GetResourceType() ~= nil) then
                -- Coal or Uranium
                if (adjacentPlot:GetResourceType() == 41 or adjacentPlot:GetResourceType() == 46) then
                    prod = prod - 2;
                -- Horses or Niter
                elseif (adjacentPlot:GetResourceType() == 42 or adjacentPlot:GetResourceType() == 44) then
                    food = food - 1;
                    prod = prod - 1;
                -- Oil
                elseif (adjacentPlot:GetResourceType() == 45) then
                    prod = prod - 3;
                end
            end
            foodTemp = adjacentPlot:GetYield(g_YIELD_FOOD);
            prodTemp = adjacentPlot:GetYield(g_YIELD_PRODUCTION);
            if (foodTemp >= 2 and prodTemp >= 2) then
                score = score + 5;
            end
            food = food + foodTemp;
            prod = prod + prodTemp;
        end
    end
    score = score + food + prod;
    --if (prod == 0) then
    --    score = score - 5;
    --end
    return score;
end
------------------------------------------------------------------------------
function BBS_AssignStartingPlots:__GetTerrainIndex(terrainType)
    if (terrainType == "TERRAIN_COAST") then
        return g_TERRAIN_TYPE_COAST;
    elseif (terrainType == "TERRAIN_DESERT") then
        return g_TERRAIN_TYPE_DESERT;
    elseif (terrainType == "TERRAIN_TUNDRA") then
        return g_TERRAIN_TYPE_TUNDRA;
    elseif (terrainType == "TERRAIN_SNOW") then
        return g_TERRAIN_TYPE_SNOW;
    elseif (terrainType == "TERRAIN_PLAINS") then
        return g_TERRAIN_TYPE_PLAINS;
    elseif (terrainType == "TERRAIN_GRASS") then
        return g_TERRAIN_TYPE_GRASS;
    elseif (terrainType == "TERRAIN_DESERT_HILLS") then
        return g_TERRAIN_TYPE_DESERT_HILLS;
    elseif (terrainType == "TERRAIN_TUNDRA_HILLS") then
        return g_TERRAIN_TYPE_TUNDRA_HILLS;
    elseif (terrainType == "TERRAIN_SNOW_HILLS") then
        return g_TERRAIN_TYPE_SNOW_HILLS;
    elseif (terrainType == "TERRAIN_PLAINS_HILLS") then
        return g_TERRAIN_TYPE_PLAINS_HILLS;
    elseif (terrainType == "TERRAIN_GRASS_HILLS") then
        return g_TERRAIN_TYPE_GRASS_HILLS;
    elseif (terrainType == "TERRAIN_GRASS_MOUNTAIN") then
        return g_TERRAIN_TYPE_GRASS_MOUNTAIN;
    elseif (terrainType == "TERRAIN_PLAINS_MOUNTAIN") then
        return g_TERRAIN_TYPE_PLAINS_MOUNTAIN;
    elseif (terrainType == "TERRAIN_DESERT_MOUNTAIN") then
        return g_TERRAIN_TYPE_DESERT_MOUNTAIN;
    end
end
------------------------------------------------------------------------------
function BBS_AssignStartingPlots:__GetFeatureIndex(featureType)
    if (featureType == "FEATURE_VOLCANO") then
        return g_FEATURE_VOLCANO;
    elseif (featureType == "FEATURE_JUNGLE") then
        return g_FEATURE_JUNGLE;
    elseif (featureType == "FEATURE_FOREST") then
        return g_FEATURE_FOREST;
    elseif (featureType == "FEATURE_FLOODPLAINS") then
        return g_FEATURE_FLOODPLAINS;
    elseif (featureType == "FEATURE_FLOODPLAINS_PLAINS") then
        return g_FEATURE_FLOODPLAINS_PLAINS;
    elseif (featureType == "FEATURE_FLOODPLAINS_GRASSLAND") then
        return g_FEATURE_FLOODPLAINS_GRASSLAND;
    elseif (featureType == "FEATURE_GEOTHERMAL_FISSURE") then
        return g_FEATURE_GEOTHERMAL_FISSURE;
    end
end
------------------------------------------------------------------------------
function BBS_AssignStartingPlots:__GetResourceIndex(resourceType)
    local resourceTypeName = "LOC_" .. resourceType .. "_NAME";
    for row in GameInfo.Resources() do
        if (row.Name == resourceTypeName) then
            return row.Index;
        end
    end
end
------------------------------------------------------------------------------
function BBS_AssignStartingPlots:__BaseFertility(plot)
    -- Calculate the fertility of the starting plot
    local pPlot = Map.GetPlotByIndex(plot);
    local iFertility = StartPositioner.GetPlotFertility(pPlot:GetIndex(), -1);
    return iFertility;
end
------------------------------------------------------------------------------
function BBS_AssignStartingPlots:__NaturalWonderBuffer(plot, major)
    -- Returns false if the player can start because there is a natural wonder too close.
    -- If Start position config equals legendary you can start near Natural wonders
    if(self.uiStartConfig == 3) then
        return true;
    end

    local iMaxNW = 4;

    if(major == false) then
        iMaxNW = GlobalParameters.START_DISTANCE_MINOR_NATURAL_WONDER or 3;
    else
        iMaxNW = GlobalParameters.START_DISTANCE_MAJOR_NATURAL_WONDER or 4;
    end

    local plotX = plot:GetX();
    local plotY = plot:GetY();
    for dx = -iMaxNW, iMaxNW do
        for dy = -iMaxNW, iMaxNW do
            local otherPlot = Map.GetPlotXYWithRangeCheck(plotX, plotY, dx, dy, iMaxNW);
            if(otherPlot and otherPlot:IsNaturalWonder()) then
                return false;
            end
        end
    end
    return true;
end
------------------------------------------------------------------------------
function BBS_AssignStartingPlots:__LuxuryBuffer(plot, major)
    -- Checks to see if there are luxuries in the given distance
    if (major and math.ceil(self.iDefaultNumberMajor * 1.25) + self.iDefaultNumberMinor > self.iNumMinorCivs + self.iNumMajorCivs) then
        local plotX = plot:GetX();
        local plotY = plot:GetY();
        for dx = -2, 2 do
            for dy = -2, 2 do
                local otherPlot = Map.GetPlotXYWithRangeCheck(plotX, plotY, dx, dy, 2);
                if(otherPlot) then
                    if(otherPlot:GetResourceCount() > 0) then
                        for _, row in ipairs(self.rLuxury) do 
                            if(row.Index == otherPlot:GetResourceType()) then
                                return true;
                            end
                        end
                    end
                end
            end
        end
        return false;
    end
    return true;
end
------------------------------------------------------------------------------
function BBS_AssignStartingPlots:__LuxuryCount(plot)
    -- Checks to see if there are luxuries in the given distance
		local count = 0
        local plotX = plot:GetX();
        local plotY = plot:GetY();
        for dx = -2, 2 do
            for dy = -2, 2 do
                local otherPlot = Map.GetPlotXYWithRangeCheck(plotX, plotY, dx, dy, 2);
                if(otherPlot) then
                    if(otherPlot:GetResourceCount() > 0) then
                        for _, row in ipairs(self.rLuxury) do 
                            if(row.Index == otherPlot:GetResourceType()) then
                                count = count + 1
                            end
                        end
                    end
                end
            end
        end
		return count

end

------------------------------------------------------------------------------
function BBS_AssignStartingPlots:__TryToRemoveBonusResource(plot)
    --Removes Bonus Resources underneath starting players
    for row in GameInfo.Resources() do
        if (row.ResourceClassType == "RESOURCECLASS_BONUS") then
            if(row.Index == plot:GetResourceType()) then
                ResourceBuilder.SetResourceType(plot, -1);
            end
        end
    end
end
------------------------------------------------------------------------------
function BBS_AssignStartingPlots:__MajorCivBuffer(plot,team)
    -- Checks to see if there are major civs in the given distance for this major civ
    local iMaxStart = GlobalParameters.START_DISTANCE_MAJOR_CIVILIZATION or 12;
    if(self.waterMap) then
        iMaxStart = iMaxStart - 3;
    end
    iMaxStart = iMaxStart - GlobalParameters.START_DISTANCE_RANGE_MAJOR or 2;
    --local iMaxStart = 10;
    iMaxStart = 12 ;
    --如果多次重启，允许主要文明距离-1=11
    if (isCanRandom == true) then
        iMaxStart = iMaxStart-1;
    end
    local iSourceIndex = plot:GetIndex();
    for i, majorPlot in ipairs(self.majorStartPlots) do
		if majorPlot == plot then
			return false;
		end
		if team ~= nil and self.majorStartPlotsTeam[i] ~= nil then
            if self.majorStartPlotsTeam[i] == team  then

                if ( Map.GetPlotDistance(iSourceIndex, majorPlot:GetIndex()) <= iMaxStart + self.iDistance ) then
                    return false;
                end
            else
                if(Map.GetPlotDistance(iSourceIndex, majorPlot:GetIndex()) <= iMaxStart + self.iDistance or Map.GetPlotDistance(iSourceIndex, majorPlot:GetIndex()) < self.iHard_Major + self.iDistance) then
                    return false;
                end
            end

        else
            if(Map.GetPlotDistance(iSourceIndex, majorPlot:GetIndex()) <= iMaxStart + self.iDistance or Map.GetPlotDistance(iSourceIndex, majorPlot:GetIndex()) < self.iHard_Major + self.iDistance) then
                return false;
            end
        end
    end
    return true;
end
------------------------------------------------------------------------------
function BBS_AssignStartingPlots:__MinorMajorCivBuffer(plot)
    -- Checks to see if there are majors in the given distance for this minor civ
    local iMaxStart = GlobalParameters.START_DISTANCE_MINOR_MAJOR_CIVILIZATION or 8;
    --local iMaxStart = 8;
    local iSourceIndex = plot:GetIndex();

    if(self.waterMap) then
        iMaxStart = iMaxStart - 1;
    end
    for i, majorPlot in ipairs(self.majorStartPlots) do
		if majorPlot == plot then
			return false;
		end
        if(Map.GetPlotDistance(iSourceIndex, majorPlot:GetIndex()) <= iMaxStart + self.iDistance_minor or Map.GetPlotDistance(iSourceIndex, majorPlot:GetIndex()) < 11 + self.iDistance_minor or Map.GetPlotDistance(iSourceIndex, majorPlot:GetIndex()) < 5) then
            return false;
        end
    end
    return true;
end
------------------------------------------------------------------------------
function BBS_AssignStartingPlots:__MinorMinorCivBuffer(plot,playerID)
    -- Checks to see if there are minors in the given distance for this minor civ
    local iMaxStart = GlobalParameters.START_DISTANCE_MINOR_CIVILIZATION_START or 7;
    --iMaxStart = iMaxStart - GlobalParameters.START_DISTANCE_RANGE_MINOR or 2;
	--local iMaxStart = 7;
	local leader	:string = PlayerConfigurations[playerID]:GetLeaderTypeName();
	local leaderInfo:table	= GameInfo.Leaders[leader];

    local iSourceIndex = plot:GetIndex();
    for i, minorPlotandID in ipairs(self.minorStartPlotsID) do
		if minorPlotandID.Plot == plot then
			return false;
		end
        if(Map.GetPlotDistance(iSourceIndex, minorPlotandID.Plot:GetIndex()) <= iMaxStart or Map.GetPlotDistance(iSourceIndex, minorPlotandID.Plot:GetIndex()) < 7) then
            return false;
        end
		if minorPlotandID.ID ~= nil and PlayerConfigurations[minorPlotandID.ID] ~= nil then
			local min_leader	:string = PlayerConfigurations[minorPlotandID.ID]:GetLeaderTypeName();
			local min_leaderInfo:table	= GameInfo.Leaders[min_leader];
			if leaderInfo.InheritFrom == min_leaderInfo.InheritFrom and Map.GetPlotDistance(iSourceIndex, minorPlotandID.Plot:GetIndex()) < 21 then
				if self.iMinorAttempts < 20 then
					print("Too close to same CS type")
					self.iMinorAttempts = self.iMinorAttempts + 1
					return false;
				end
			end
		end
    end
    return true;
end
------------------------------------------------------------------------------
function BBS_AssignStartingPlots:__AddBonusFoodProduction(plot)
    local food = 0;
    local production = 0;
    local maxFood = 0;
    local maxProduction = 0;
    local gridHeight = Map.GetGridSize();
    local terrainType = plot:GetTerrainType();

    for direction = 0, DirectionTypes.NUM_DIRECTION_TYPES - 1, 1 do
        local adjacentPlot = Map.GetAdjacentPlot(plot:GetX(), plot:GetY(), direction);
        if (adjacentPlot ~= nil) then
            terrainType = adjacentPlot:GetTerrainType();
            if(adjacentPlot:GetX() >= 0 and adjacentPlot:GetY() < gridHeight) then
                -- Gets the food and productions
                food = food + adjacentPlot:GetYield(g_YIELD_FOOD);
                production = production + adjacentPlot:GetYield(g_YIELD_PRODUCTION);

                --Checks the maxFood
                if(maxFood <=  adjacentPlot:GetYield(g_YIELD_FOOD)) then
                    maxFood = adjacentPlot:GetYield(g_YIELD_FOOD);
                end

                --Checks the maxProduction
                if(maxProduction <=  adjacentPlot:GetYield(g_YIELD_PRODUCTION)) then
                    maxProduction = adjacentPlot:GetYield(g_YIELD_PRODUCTION);
                end
            end
        end
    end

    if(food < 7 or maxFood < 3) then
        local retry = 0;
        while (food < 7 and retry < 2) do
            food = food + self:__AddFood(plot);
            retry = retry + 1;
        end
    end

    if(production < 5 or maxProduction < 2) then
        local retry = 0;
        while (production < 5 and retry < 2) do
            production = production + self:__AddProduction(plot);
            retry = retry + 1;
        end
    end
end
------------------------------------------------------------------------------
function BBS_AssignStartingPlots:__AddFood(plot)
    local foodAdded = 0;
    local dir = TerrainBuilder.GetRandomNumber(DirectionTypes.NUM_DIRECTION_TYPES, "Random Direction");
    for i = 0, DirectionTypes.NUM_DIRECTION_TYPES - 1, 1 do
        local adjacentPlot = Map.GetAdjacentPlot(plot:GetX(), plot:GetY(), dir);
        if (adjacentPlot ~= nil) then
            local foodBefore = adjacentPlot:GetYield(g_YIELD_FOOD);
            local aShuffledBonus =  GetShuffledCopyOfTable(self.aBonusFood);
            for _, bonus in ipairs(aShuffledBonus) do
                if(ResourceBuilder.CanHaveResource(adjacentPlot, bonus.Index)) then
                    ResourceBuilder.SetResourceType(adjacentPlot, bonus.Index, 1);
                    foodAdded = adjacentPlot:GetYield(g_YIELD_FOOD) - foodBefore;
                    return foodAdded;
                end
            end
        end

        if(dir == DirectionTypes.NUM_DIRECTION_TYPES - 1) then
            dir = 0;
        else
            dir = dir + 1;
        end
    end
    return foodAdded;
end
------------------------------------------------------------------------------
function BBS_AssignStartingPlots:__AddProduction(plot)
    local prodAdded = 0;
    local dir = TerrainBuilder.GetRandomNumber(DirectionTypes.NUM_DIRECTION_TYPES, "Random Direction");
    for i = 0, DirectionTypes.NUM_DIRECTION_TYPES - 1, 1 do
        local adjacentPlot = Map.GetAdjacentPlot(plot:GetX(), plot:GetY(), dir);
        if (adjacentPlot ~= nil) then
            local prodBefore = adjacentPlot:GetYield(g_YIELD_PRODUCTION);
            local aShuffledBonus = GetShuffledCopyOfTable(self.aBonusProd);
            for _, bonus in ipairs(aShuffledBonus) do
                if(ResourceBuilder.CanHaveResource(adjacentPlot, bonus.Index)) then
                    ResourceBuilder.SetResourceType(adjacentPlot, bonus.Index, 1);
                    prodAdded = adjacentPlot:GetYield(g_YIELD_PRODUCTION) - prodBefore;
                    return prodAdded;
                end
            end
        end

        if(dir == DirectionTypes.NUM_DIRECTION_TYPES - 1) then
            dir = 0;
        else
            dir = dir + 1;
        end
    end
    return prodAdded;
end
------------------------------------------------------------------------------
function BBS_AssignStartingPlots:__AddResourcesBalanced()
    local iStartEra = GameInfo.Eras[ GameConfiguration.GetStartEra() ];
    local iStartIndex = 1;
    if iStartEra ~= nil then
        iStartIndex = iStartEra.ChronologyIndex;
    end

    local iHighestFertility = 0;
    for _, plot in ipairs(self.majorStartPlots) do
        self:__RemoveBonus(plot);
        self:__BalancedStrategic(plot, iStartIndex);

        if(self:__BaseFertility(plot:GetIndex()) > iHighestFertility) then
            iHighestFertility = self:__BaseFertility(plot:GetIndex());
        end
    end

    for _, plot in ipairs(self.majorStartPlots) do
        local iFertilityLeft = iHighestFertility - self:__BaseFertility(plot:GetIndex());

        if(iFertilityLeft > 0) then
            if(self:__IsContinentalDivide(plot)) then
                --self:__Debug("START_FERTILITY_WEIGHT_CONTINENTAL_DIVIDE", GlobalParameters.START_FERTILITY_WEIGHT_CONTINENTAL_DIVIDE);
                local iContinentalWeight = math.floor((GlobalParameters.START_FERTILITY_WEIGHT_CONTINENTAL_DIVIDE or 250) / 10);
                iFertilityLeft = iFertilityLeft - iContinentalWeight
            else
                local bAddLuxury = true;
                --self:__Debug("START_FERTILITY_WEIGHT_LUXURY", GlobalParameters.START_FERTILITY_WEIGHT_LUXURY);
                local iLuxWeight = math.floor((GlobalParameters.START_FERTILITY_WEIGHT_LUXURY or 250) / 10);
                while iFertilityLeft >= iLuxWeight and bAddLuxury do
                    bAddLuxury = self:__AddLuxury(plot);
                    if(bAddLuxury) then
                        iFertilityLeft = iFertilityLeft - iLuxWeight;
                    end
                end
            end
            local bAddBonus = true;
            --self:__Debug("START_FERTILITY_WEIGHT_BONUS", GlobalParameters.START_FERTILITY_WEIGHT_BONUS);
            local iBonusWeight = math.floor((GlobalParameters.START_FERTILITY_WEIGHT_BONUS or 75) / 10);
            while iFertilityLeft >= iBonusWeight and bAddBonus do
                bAddBonus = self:__AddBonus(plot);
                if(bAddBonus) then
                    iFertilityLeft = iFertilityLeft - iBonusWeight;
                end
            end
        end
    end
end
------------------------------------------------------------------------------
function BBS_AssignStartingPlots:__AddResourcesLegendary()
    local iStartEra = GameInfo.Eras[ GameConfiguration.GetStartEra() ];
    local iStartIndex = 1;
    if iStartEra ~= nil then
        iStartIndex = iStartEra.ChronologyIndex;
    end

    local iLegendaryBonusResources = GlobalParameters.START_LEGENDARY_BONUS_QUANTITY or 2;
    local iLegendaryLuxuryResources = GlobalParameters.START_LEGENDARY_LUXURY_QUANTITY or 1;
    for i, plot in ipairs(self.majorStartPlots) do
        self:__BalancedStrategic(plot, iStartIndex);

        if(self:__IsContinentalDivide(plot)) then
            iLegendaryLuxuryResources = iLegendaryLuxuryResources - 1;
        else
            local bAddLuxury = true;
            while iLegendaryLuxuryResources > 0 and bAddLuxury do
                bAddLuxury = self:__AddLuxury(plot);
                if(bAddLuxury) then
                    iLegendaryLuxuryResources = iLegendaryLuxuryResources - 1;
                end
            end
        end

        local bAddBonus = true;
        iLegendaryBonusResources = iLegendaryBonusResources + 2 * iLegendaryLuxuryResources;
        while iLegendaryBonusResources > 0 and bAddBonus do
            bAddBonus = self:__AddBonus(plot);
            if(bAddBonus) then
                iLegendaryBonusResources = iLegendaryBonusResources - 1;
            end
        end
    end
end
------------------------------------------------------------------------------
function BBS_AssignStartingPlots:__BalancedStrategic(plot, iStartIndex)
    local iRange = STRATEGIC_RESOURCE_FERTILITY_STARTING_ERA_RANGE or 1;
    for _, row in ipairs(self.rStrategic) do
        if(iStartIndex - iRange <= row.RevealedEra and iStartIndex + iRange >= row.RevealedEra) then
            local bHasResource = false;
            bHasResource = self:__FindSpecificStrategic(row.Index, plot);
            if(not bHasResource) then
                self:__AddStrategic(row.Index, plot)
                self:__Debug("Strategic Resource Placed :", row.Name);
            end
        end
    end
end
------------------------------------------------------------------------------
function BBS_AssignStartingPlots:__FindSpecificStrategic(eResourceType, plot)
    -- Checks to see if there is a specific strategic in a given distance
    local plotX = plot:GetX();
    local plotY = plot:GetY();
    for dx = -3, 3 do
        for dy = -3,3 do
            local otherPlot = Map.GetPlotXYWithRangeCheck(plotX, plotY, dx, dy, 3);
            if(otherPlot) then
                if(otherPlot:GetResourceCount() > 0) then
                    if(eResourceType == otherPlot:GetResourceType()) then
                        return true;
                    end
                end
            end
        end
    end
    return false;
end
------------------------------------------------------------------------------
function BBS_AssignStartingPlots:__AddStrategic(eResourceType, plot)
    -- Checks to see if it can place a specific strategic
    local plotX = plot:GetX();
    local plotY = plot:GetY();
    for dx = -2, 2 do
        for dy = -2, 2 do
            local otherPlot = Map.GetPlotXYWithRangeCheck(plotX, plotY, dx, dy, 2);
            if(otherPlot) then
                if(ResourceBuilder.CanHaveResource(otherPlot, eResourceType) and otherPlot:GetIndex() ~= plot:GetIndex()) then
                    ResourceBuilder.SetResourceType(otherPlot, eResourceType, 1);
                    return;
                end
            end
        end
    end
    for dx = -3, 3 do
        for dy = -3, 3 do
            local otherPlot = Map.GetPlotXYWithRangeCheck(plotX, plotY, dx, dy, 3);
            if(otherPlot) then
                if(ResourceBuilder.CanHaveResource(otherPlot, eResourceType) and otherPlot:GetIndex() ~= plot:GetIndex()) then
                    ResourceBuilder.SetResourceType(otherPlot, eResourceType, 1);
                    return;
                end
            end
        end
    end
    self:__Debug("Failed to add Strategic.");
end
------------------------------------------------------------------------------
function BBS_AssignStartingPlots:__AddLuxury(plot)
    local plotX = plot:GetX();
    local plotY = plot:GetY();
    local eAddLux = {};
    for dx = -4, 4 do
        for dy = -4, 4 do
            local otherPlot = Map.GetPlotXYWithRangeCheck(plotX, plotY, dx, dy, 4);
            if(otherPlot) then
                if(otherPlot:GetResourceCount() > 0) then
                    for _, row in ipairs(self.rLuxury) do
                        if(otherPlot:GetResourceType() == row.Index) then
                            table.insert(eAddLux, row);
                        end
                    end
                end
            end
        end
    end

    for dx = -2, 2 do
        for dy = -2, 2 do
            local otherPlot = Map.GetPlotXYWithRangeCheck(plotX, plotY, dx, dy, 2);
            if(otherPlot) then
                eAddLux = GetShuffledCopyOfTable(eAddLux);
                for _, resource in ipairs(eAddLux) do
                    if(ResourceBuilder.CanHaveResource(otherPlot, resource.Index) and otherPlot:GetIndex() ~= plot:GetIndex()) then
                        ResourceBuilder.SetResourceType(otherPlot, resource.Index, 1);
                        self:__Debug("Yeah Lux");
                        return true;
                    end
                end
            end
        end
    end

    self:__Debug("Failed Lux");
    return false;
end
------------------------------------------------------------------------------
function BBS_AssignStartingPlots:__AddBonus(plot)
    local plotX = plot:GetX();
    local plotY = plot:GetY();
    local aBonus =  GetShuffledCopyOfTable(self.rBonus);
    for _, resource in ipairs(aBonus) do
        for dx = -2, 2 do
            for dy = -2, 2 do
                local otherPlot = Map.GetPlotXYWithRangeCheck(plotX, plotY, dx, dy, 2);
                if(otherPlot) then
                    --self:__Debug(otherPlot:GetX(), otherPlot:GetY(), "Resource Index :", resource.Index);
                    if(ResourceBuilder.CanHaveResource(otherPlot, resource.Index) and otherPlot:GetIndex() ~= plot:GetIndex()) then
                        ResourceBuilder.SetResourceType(otherPlot, resource.Index, 1);
                        self:__Debug("Yeah Bonus");
                        return true;
                    end
                end
            end
        end
    end

    self:__Debug("Failed Bonus");
    return false
end
------------------------------------------------------------------------------
function BBS_AssignStartingPlots:__IsContinentalDivide(plot)
    local plotX = plot:GetX();
    local plotY = plot:GetY();

    local eContinents = {};

    for dx = -4, 4 do
        for dy = -4, 4 do
            local otherPlot = Map.GetPlotXYWithRangeCheck(plotX, plotY, dx, dy, 4);
            if(otherPlot) then
                if(otherPlot:GetContinentType() ~= nil) then
                    if(#eContinents == 0) then
                        table.insert(eContinents, otherPlot:GetContinentType());
                    else
                        if(eContinents[1] ~= otherPlot:GetContinentType()) then
                            return true;
                        end
                    end
                end
            end
        end
    end

    return false;
end
------------------------------------------------------------------------------
function BBS_AssignStartingPlots:__RemoveBonus(plot)
    local plotX = plot:GetX();
    local plotY = plot:GetY();
    for _, resource in ipairs(self.rBonus) do
        for dx = -3, 3 do
            for dy = -3,3 do
                local otherPlot = Map.GetPlotXYWithRangeCheck(plotX, plotY, dx, dy, 3);
                if(otherPlot) then
                    if(resource.Index == otherPlot:GetResourceType()) then
                        ResourceBuilder.SetResourceType(otherPlot, resource.Index, -1);
                        return;
                    end
                end
            end
        end
    end
end
------------------------------------------------------------------------------
function BBS_AssignStartingPlots:__TableSize(table)
    local count = 0;
    for _ in pairs(table) do
        count = count + 1;
    end
    return count;
end
------------------------------------------------------------------------------
function BBS_AssignStartingPlots:__GetShuffledCiv(incoming_table,param)
	-- Designed to operate on tables with no gaps. Does not affect original table.
	local len = table.maxn(incoming_table);
	local copy = {};
	local shuffledVersion = {};
	-- Make copy of table.
	for loop = 1, len do
		copy[loop] = incoming_table[loop];
	end
	-- One at a time, choose a random index from Copy to insert in to final table, then remove it from the copy.
	local left_to_do = table.maxn(copy);
	for loop = 1, len do
		local random_index = 0
		for n = 1, param do
			random_index = 1 + TerrainBuilder.GetRandomNumber(left_to_do, "Shuffling table entry - Lua");
		end
		table.insert(shuffledVersion, copy[random_index]);
		table.remove(copy, random_index);
		left_to_do = left_to_do - 1;
	end
	return shuffledVersion
end
------------------------------------------------------------------------------
function BBS_AssignStartingPlots:__GetValidAdjacent(plot, major)
    local impassable = 0;
    local water = 0;
    local desert = 0;
    local snow = 0;
    local toundra = 0;
    local gridWidth, gridHeight = Map.GetGridSize();
    local terrainType = plot:GetTerrainType();

	if (self:__NaturalWonderBuffer(plot, major) == false) then
		return false;
	end

	if(plot:IsFreshWater() == false and plot:IsCoastalLand() == false and major == true) then
		return false;
	end


    	local max = 0;
    	local min = 0;
    	if(major == true) then
			if Map.GetMapSize() == 4 then
				max = 7 -- math.ceil(0.5*gridHeight * self.uiStartMaxY / 100);
				min = 7 -- math.ceil(0.5*gridHeight * self.uiStartMinY / 100);
				elseif Map.GetMapSize() == 5 then
				max = 8
				min = 8
				elseif Map.GetMapSize() == 3 then
				max = 6
				min = 6	
				else
				max = 5
				min = 5
			end	
    	end

    	if(plot:GetY() <= min or plot:GetY() > gridHeight - max) then
        	return false;
    	end
		
		if(plot:GetX() <= min or plot:GetX() > gridWidth - max) then
        	return false;
    	end

	if (major == true and plot:IsFreshWater() == false and plot:IsCoastalLand() == false) then
		return false;
	end


    for direction = 0, DirectionTypes.NUM_DIRECTION_TYPES - 1, 1 do
        local adjacentPlot = Map.GetAdjacentPlot(plot:GetX(), plot:GetY(), direction);
        if (adjacentPlot ~= nil) then
            terrainType = adjacentPlot:GetTerrainType();
            if(adjacentPlot:GetX() >= 0 and adjacentPlot:GetY() < gridHeight) then
                -- Checks to see if the plot is impassable
                if(adjacentPlot:IsImpassable()) then
                    impassable = impassable + 1;
                end
                -- Checks to see if the plot is water
                if(adjacentPlot:IsWater()) then
                    water = water + 1;
                end
		if(adjacentPlot:GetFeatureType() == g_FEATURE_VOLCANO and major == true) then
			return false
		end 
            else
                impassable = impassable + 1;
            end
        end
    end
	
	if major == true then
		if self:__CountAdjacentResourcesInRange(plot, 27, major) > 0 then
		return false
		end
		if self:__CountAdjacentResourcesInRange(plot, 11, major) > 0 then
		return false
		end
		if self:__CountAdjacentResourcesInRange(plot, 28, major) > 0 then
		return false
	end
	end

    if(impassable >= 2 and not self.waterMap and major == true) then
        return false;
    elseif(impassable >= 3 and not self.waterMap) then
        return false;
    elseif(water + impassable  >= 4 and not self.waterMap and major == true) then
        return false;
    elseif(water >= 3 and major == true) then
        return false;
    elseif(water >= 4 and self.waterMap and major == true) then
        return false;
    else
        return true;
    end
end

-----------------------------------------------------------------------------
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
    if(plot ~= nil and index ~= nil) then
        if (index < 0) then
            return plot;
        end

        else

        __Debug("GetAdjacentTiles: Invalid Arguments");
        return nil;
    end

    

    -- Return Starting City Circle if index between #0 to #5 (like Firaxis' GetAdjacentPlot) 
    for i = 0, 5 do
        if(plot:GetX() >= 0 and plot:GetY() < gridHeight) then
            adjacentPlot = Map.GetAdjacentPlot(plot:GetX(), plot:GetY(), i);
            if (adjacentPlot ~= nil and index == i) then
                return adjacentPlot
            end
        end
    end

    -- Return Inner City Circle if index between #6 to #17

    count = 5;
    for i = 0, 5 do
        if(plot:GetX() >= 0 and plot:GetY() < gridHeight) then
            adjacentPlot2 = Map.GetAdjacentPlot(plot:GetX(), plot:GetY(), i);
        end

        for j = i, i+1 do
            --__Debug(i, j)
            k = j;
            count = count + 1;

            if (k == 6) then
                k = 0;
            end

            if (adjacentPlot2 ~= nil) then
                if(adjacentPlot2:GetX() >= 0 and adjacentPlot2:GetY() < gridHeight) then
                    adjacentPlot = Map.GetAdjacentPlot(adjacentPlot2:GetX(), adjacentPlot2:GetY(), k);

                    else

                    adjacentPlot = nil;
                end
            end
        

            if (adjacentPlot ~=nil) then
                if(index == count) then
                    return adjacentPlot
                end
            end

        end
    end

    -- #18 to #35 Outer city circle
    count = 0;
    for i = 0, 5 do
        if(plot:GetX() >= 0 and plot:GetY() < gridHeight) then
            adjacentPlot = Map.GetAdjacentPlot(plot:GetX(), plot:GetY(), i);
            adjacentPlot2 = nil;
            adjacentPlot3 = nil;
            else
            adjacentPlot = nil;
            adjacentPlot2 = nil;
            adjacentPlot3 = nil;
        end
        if (adjacentPlot ~=nil) then
            if(adjacentPlot:GetX() >= 0 and adjacentPlot:GetY() < gridHeight) then
                adjacentPlot3 = Map.GetAdjacentPlot(adjacentPlot:GetX(), adjacentPlot:GetY(), i);
            end
            if (adjacentPlot3 ~= nil) then
                if(adjacentPlot3:GetX() >= 0 and adjacentPlot3:GetY() < gridHeight) then
                    adjacentPlot2 = Map.GetAdjacentPlot(adjacentPlot3:GetX(), adjacentPlot3:GetY(), i);
                end
            end
        end

        if (adjacentPlot2 ~= nil) then
            count = 18 + i * 3;
            if(index == count) then
                return adjacentPlot2
            end
        end

        adjacentPlot2 = nil;

        if (adjacentPlot3 ~= nil) then
            if (i + 1) == 6 then
                if(adjacentPlot3:GetX() >= 0 and adjacentPlot3:GetY() < gridHeight) then
                    adjacentPlot2 = Map.GetAdjacentPlot(adjacentPlot3:GetX(), adjacentPlot3:GetY(), 0);
                end
                else
                if(adjacentPlot3:GetX() >= 0 and adjacentPlot3:GetY() < gridHeight) then
                    adjacentPlot2 = Map.GetAdjacentPlot(adjacentPlot3:GetX(), adjacentPlot3:GetY(), i +1);
                end
            end
        end

        if (adjacentPlot2 ~= nil) then
            count = 18 + i * 3 + 1;
            if(index == count) then
                return adjacentPlot2
            end
        end

        adjacentPlot2 = nil;

        if (adjacentPlot ~= nil) then
            if (i+1 == 6) then
                if(adjacentPlot:GetX() >= 0 and adjacentPlot:GetY() < gridHeight) then
                    adjacentPlot3 = Map.GetAdjacentPlot(adjacentPlot:GetX(), adjacentPlot:GetY(), 0);
                end
                if (adjacentPlot3 ~= nil) then
                    if(adjacentPlot3:GetX() >= 0 and adjacentPlot3:GetY() < gridHeight) then
                        adjacentPlot2 = Map.GetAdjacentPlot(adjacentPlot3:GetX(), adjacentPlot3:GetY(), 0);
                    end
                end
                else
                if(adjacentPlot:GetX() >= 0 and adjacentPlot:GetY() < gridHeight) then
                    adjacentPlot3 = Map.GetAdjacentPlot(adjacentPlot:GetX(), adjacentPlot:GetY(), i+1);
                end
                if (adjacentPlot3 ~= nil) then
                    if(adjacentPlot3:GetX() >= 0 and adjacentPlot3:GetY() < gridHeight) then
                        adjacentPlot2 = Map.GetAdjacentPlot(adjacentPlot3:GetX(), adjacentPlot3:GetY(), i+1);
                    end
                end
            end
        end

        if (adjacentPlot2 ~= nil) then
            count = 18 + i * 3 + 2;
            if(index == count) then
                return adjacentPlot2;
            end
        end

    end

    --  #35 #59 These tiles are outside the workable radius of the city
    local count = 0
    for i = 0, 5 do
        if(plot:GetX() >= 0 and plot:GetY() < gridHeight) then
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
        if (adjacentPlot ~=nil) then
            if(adjacentPlot:GetX() >= 0 and adjacentPlot:GetY() < gridHeight) then
                adjacentPlot3 = Map.GetAdjacentPlot(adjacentPlot:GetX(), adjacentPlot:GetY(), i);
            end
            if (adjacentPlot3 ~= nil) then
                if(adjacentPlot3:GetX() >= 0 and adjacentPlot3:GetY() < gridHeight) then
                    adjacentPlot4 = Map.GetAdjacentPlot(adjacentPlot3:GetX(), adjacentPlot3:GetY(), i);
                    if (adjacentPlot4 ~= nil) then
                        if(adjacentPlot4:GetX() >= 0 and adjacentPlot4:GetY() < gridHeight) then
                            adjacentPlot2 = Map.GetAdjacentPlot(adjacentPlot4:GetX(), adjacentPlot4:GetY(), i);
                        end
                    end
                end
            end
        end

        if (adjacentPlot2 ~= nil) then
            terrainType = adjacentPlot2:GetTerrainType();
            if (adjacentPlot2 ~=nil) then
                count = 36 + i * 4;
                if(index == count) then
                    return adjacentPlot2;
                end
            end

        end

        if (adjacentPlot3 ~= nil) then
            if (i + 1) == 6 then
                if(adjacentPlot3:GetX() >= 0 and adjacentPlot3:GetY() < gridHeight) then
                    adjacentPlot4 = Map.GetAdjacentPlot(adjacentPlot3:GetX(), adjacentPlot3:GetY(), 0);
                end
                else
                if(adjacentPlot3:GetX() >= 0 and adjacentPlot3:GetY() < gridHeight) then
                    adjacentPlot4 = Map.GetAdjacentPlot(adjacentPlot3:GetX(), adjacentPlot3:GetY(), i +1);
                end
            end
        end

        if (adjacentPlot4 ~= nil) then
            if(adjacentPlot4:GetX() >= 0 and adjacentPlot4:GetY() < gridHeight) then
                adjacentPlot2 = Map.GetAdjacentPlot(adjacentPlot4:GetX(), adjacentPlot4:GetY(), i);
                if (adjacentPlot2 ~= nil) then
                    count = 36 + i * 4 + 1;
                    if(index == count) then
                        return adjacentPlot2;
                    end
                end
            end


        end

        adjacentPlot4 = nil;

        if (adjacentPlot ~= nil) then
            if (i+1 == 6) then
                if(adjacentPlot:GetX() >= 0 and adjacentPlot:GetY() < gridHeight) then
                    adjacentPlot3 = Map.GetAdjacentPlot(adjacentPlot:GetX(), adjacentPlot:GetY(), 0);
                end
                if (adjacentPlot3 ~= nil) then
                    if(adjacentPlot3:GetX() >= 0 and adjacentPlot3:GetY() < gridHeight) then
                        adjacentPlot4 = Map.GetAdjacentPlot(adjacentPlot3:GetX(), adjacentPlot3:GetY(), 0);
                    end
                end
                else
                if(adjacentPlot:GetX() >= 0 and adjacentPlot:GetY() < gridHeight) then
                    adjacentPlot3 = Map.GetAdjacentPlot(adjacentPlot:GetX(), adjacentPlot:GetY(), i+1);
                end
                if (adjacentPlot3 ~= nil) then
                    if(adjacentPlot3:GetX() >= 0 and adjacentPlot3:GetY() < gridHeight) then
                        adjacentPlot4 = Map.GetAdjacentPlot(adjacentPlot3:GetX(), adjacentPlot3:GetY(), i+1);
                    end
                end
            end
        end

        if (adjacentPlot4 ~= nil) then
            if (adjacentPlot4:GetX() >= 0 and adjacentPlot4:GetY() < gridHeight) then
                adjacentPlot2 = Map.GetAdjacentPlot(adjacentPlot4:GetX(), adjacentPlot4:GetY(), i);
                if (adjacentPlot2 ~= nil) then
                    count = 36 + i * 4 + 2;
                    if(index == count) then
                        return adjacentPlot2;
                    end

                end
            end

        end

        adjacentPlot4 = nil;

        if (adjacentPlot ~= nil) then
            if (i+1 == 6) then
                if(adjacentPlot:GetX() >= 0 and adjacentPlot:GetY() < gridHeight) then
                    adjacentPlot3 = Map.GetAdjacentPlot(adjacentPlot:GetX(), adjacentPlot:GetY(), 0);
                end
                if (adjacentPlot3 ~= nil) then
                    if(adjacentPlot3:GetX() >= 0 and adjacentPlot3:GetY() < gridHeight) then
                        adjacentPlot4 = Map.GetAdjacentPlot(adjacentPlot3:GetX(), adjacentPlot3:GetY(), 0);
                    end
                end
                else
                if(adjacentPlot:GetX() >= 0 and adjacentPlot:GetY() < gridHeight) then
                    adjacentPlot3 = Map.GetAdjacentPlot(adjacentPlot:GetX(), adjacentPlot:GetY(), i+1);
                end
                if (adjacentPlot3 ~= nil) then
                    if(adjacentPlot3:GetX() >= 0 and adjacentPlot3:GetY() < gridHeight) then
                        adjacentPlot4 = Map.GetAdjacentPlot(adjacentPlot3:GetX(), adjacentPlot3:GetY(), i+1);
                    end
                end
            end
        end

        if (adjacentPlot4 ~= nil) then
            if (adjacentPlot4:GetX() >= 0 and adjacentPlot4:GetY() < gridHeight) then
                if (i+1 == 6) then
                    adjacentPlot2 = Map.GetAdjacentPlot(adjacentPlot4:GetX(), adjacentPlot4:GetY(), 0);
                    else
                    adjacentPlot2 = Map.GetAdjacentPlot(adjacentPlot4:GetX(), adjacentPlot4:GetY(), i+1);
                end
                if (adjacentPlot2 ~= nil) then
                    count = 36 + i * 4 + 3;
                    if(index == count) then
                        return adjacentPlot2;
                    end

                end
            end

        end

    end

    --  > #60 to #90

local count = 0
    for i = 0, 5 do
        if(plot:GetX() >= 0 and plot:GetY() < gridHeight) then
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
        if (adjacentPlot ~=nil) then
            if(adjacentPlot:GetX() >= 0 and adjacentPlot:GetY() < gridHeight) then
                adjacentPlot3 = Map.GetAdjacentPlot(adjacentPlot:GetX(), adjacentPlot:GetY(), i); --2nd ring
            end
            if (adjacentPlot3 ~= nil) then
                if(adjacentPlot3:GetX() >= 0 and adjacentPlot3:GetY() < gridHeight) then
                    adjacentPlot4 = Map.GetAdjacentPlot(adjacentPlot3:GetX(), adjacentPlot3:GetY(), i); --3rd ring
                    if (adjacentPlot4 ~= nil) then
                        if(adjacentPlot4:GetX() >= 0 and adjacentPlot4:GetY() < gridHeight) then
                            adjacentPlot5 = Map.GetAdjacentPlot(adjacentPlot4:GetX(), adjacentPlot4:GetY(), i); --4th ring
                            if (adjacentPlot5 ~= nil) then
                                if(adjacentPlot5:GetX() >= 0 and adjacentPlot5:GetY() < gridHeight) then
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
            if(index == count) then
                return adjacentPlot2; --5th ring
            end
        end

        adjacentPlot2 = nil;

        if (adjacentPlot5 ~= nil) then
            if (i + 1) == 6 then
                if(adjacentPlot5:GetX() >= 0 and adjacentPlot5:GetY() < gridHeight) then
                    adjacentPlot2 = Map.GetAdjacentPlot(adjacentPlot5:GetX(), adjacentPlot5:GetY(), 0);
                end
                else
                if(adjacentPlot5:GetX() >= 0 and adjacentPlot5:GetY() < gridHeight) then
                    adjacentPlot2 = Map.GetAdjacentPlot(adjacentPlot5:GetX(), adjacentPlot5:GetY(), i +1);
                end
            end
        end


        if (adjacentPlot2 ~= nil) then
            count = 60 + i * 5 + 1;
            if(index == count) then
                return adjacentPlot2;
            end

        end

        adjacentPlot2 = nil;

        if (adjacentPlot ~=nil) then
            if(adjacentPlot:GetX() >= 0 and adjacentPlot:GetY() < gridHeight) then
                adjacentPlot3 = Map.GetAdjacentPlot(adjacentPlot:GetX(), adjacentPlot:GetY(), i);
            end
            if (adjacentPlot3 ~= nil) then
                if(adjacentPlot3:GetX() >= 0 and adjacentPlot3:GetY() < gridHeight) then
                    adjacentPlot4 = Map.GetAdjacentPlot(adjacentPlot3:GetX(), adjacentPlot3:GetY(), i);
                    if (adjacentPlot4 ~= nil) then
                        if(adjacentPlot4:GetX() >= 0 and adjacentPlot4:GetY() < gridHeight) then
                            if (i+1 == 6) then
                                adjacentPlot5 = Map.GetAdjacentPlot(adjacentPlot4:GetX(), adjacentPlot4:GetY(), 0);
                                else
                                adjacentPlot5 = Map.GetAdjacentPlot(adjacentPlot4:GetX(), adjacentPlot4:GetY(), i+1);
                            end
                            if (adjacentPlot5 ~= nil) then
                                if(adjacentPlot5:GetX() >= 0 and adjacentPlot5:GetY() < gridHeight) then
                                    if (i+1 == 6) then
                                        adjacentPlot2 = Map.GetAdjacentPlot(adjacentPlot5:GetX(), adjacentPlot5:GetY(), 0);
                                        else
                                        adjacentPlot2 = Map.GetAdjacentPlot(adjacentPlot5:GetX(), adjacentPlot5:GetY(), i+1);
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
            if(index == count) then
                return adjacentPlot2;
            end

        end

        if (adjacentPlot ~=nil) then
            if(adjacentPlot:GetX() >= 0 and adjacentPlot:GetY() < gridHeight) then
                if (i+1 == 6) then
                    adjacentPlot3 = Map.GetAdjacentPlot(adjacentPlot:GetX(), adjacentPlot:GetY(), 0); -- 2 ring
                    else
                    adjacentPlot3 = Map.GetAdjacentPlot(adjacentPlot:GetX(), adjacentPlot:GetY(), i+1); -- 2 ring
                end
            end
            if (adjacentPlot3 ~= nil) then
                if(adjacentPlot3:GetX() >= 0 and adjacentPlot3:GetY() < gridHeight) then
                    if (i+1 == 6) then
                        adjacentPlot4 = Map.GetAdjacentPlot(adjacentPlot3:GetX(), adjacentPlot3:GetY(), 0); -- 3ring
                        else
                        adjacentPlot4 = Map.GetAdjacentPlot(adjacentPlot3:GetX(), adjacentPlot3:GetY(), i+1); -- 3ring

                    end
                    if (adjacentPlot4 ~= nil) then
                        if(adjacentPlot4:GetX() >= 0 and adjacentPlot4:GetY() < gridHeight) then
                            if (i+1 == 6) then
                                adjacentPlot5 = Map.GetAdjacentPlot(adjacentPlot4:GetX(), adjacentPlot4:GetY(), 0); --4th ring
                                else
                                adjacentPlot5 = Map.GetAdjacentPlot(adjacentPlot4:GetX(), adjacentPlot4:GetY(), i+1); --4th ring
                            end
                            if (adjacentPlot5 ~= nil) then
                                if(adjacentPlot5:GetX() >= 0 and adjacentPlot5:GetY() < gridHeight) then
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
            if(index == count) then
                return adjacentPlot2;
            end

        end
        
        adjacentPlot2 = nil

        if (adjacentPlot ~=nil) then
            if(adjacentPlot:GetX() >= 0 and adjacentPlot:GetY() < gridHeight) then
                if (i+1 == 6) then
                    adjacentPlot3 = Map.GetAdjacentPlot(adjacentPlot:GetX(), adjacentPlot:GetY(), 0); -- 2 ring
                    else
                    adjacentPlot3 = Map.GetAdjacentPlot(adjacentPlot:GetX(), adjacentPlot:GetY(), i+1); -- 2 ring
                end
            end
            if (adjacentPlot3 ~= nil) then
                if(adjacentPlot3:GetX() >= 0 and adjacentPlot3:GetY() < gridHeight) then
                    if (i+1 == 6) then
                        adjacentPlot4 = Map.GetAdjacentPlot(adjacentPlot3:GetX(), adjacentPlot3:GetY(), 0); -- 3ring
                        else
                        adjacentPlot4 = Map.GetAdjacentPlot(adjacentPlot3:GetX(), adjacentPlot3:GetY(), i+1); -- 3ring

                    end
                    if (adjacentPlot4 ~= nil) then
                        if(adjacentPlot4:GetX() >= 0 and adjacentPlot4:GetY() < gridHeight) then
                            if (i+1 == 6) then
                                adjacentPlot5 = Map.GetAdjacentPlot(adjacentPlot4:GetX(), adjacentPlot4:GetY(), 0); --4th ring
                                else
                                adjacentPlot5 = Map.GetAdjacentPlot(adjacentPlot4:GetX(), adjacentPlot4:GetY(), i+1); --4th ring
                            end
                            if (adjacentPlot5 ~= nil) then
                                if(adjacentPlot5:GetX() >= 0 and adjacentPlot5:GetY() < gridHeight) then
                                    if (i+1 == 6) then
                                        adjacentPlot2 = Map.GetAdjacentPlot(adjacentPlot5:GetX(), adjacentPlot5:GetY(), 0); --5th ring
                                        else
                                        adjacentPlot2 = Map.GetAdjacentPlot(adjacentPlot5:GetX(), adjacentPlot5:GetY(), i+1); --5th ring
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
            if(index == count) then
                return adjacentPlot2;
            end

        end

    end

end

-----------------------------------------------------------------------------