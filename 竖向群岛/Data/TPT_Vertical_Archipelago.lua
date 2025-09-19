------------------------------------------------------------------------------
--	FILE:	 DWPangaea.lua
--	AUTHOR:  Evil Victor (Steam) / Seven05 (CivFanatics)
--	PURPOSE: Produces widely varied continents.
------------------------------------------------------------------------------



include "MapEnums"
include "DW_MapUtilities"
include "DW_MountainsCliffs"
include "DW_RiversLakes"
include "DW_FeatureGenerator"
include "DW_TerrainGenerator"
include "NaturalWonderGenerator"
include "BBS_ResourceGenerator"
include "DW_CoastalLowlands"
include "AssignStartingPlots"
include "BBS_AssignStartingPlots";
include "BBS_Balance";

local g_iW, g_iH;
local g_iFlags = {};
local g_continentsFrac = nil;
local featureGen = nil;
local world_age_new = 5;
local world_age_normal = 3;
local world_age_old = 2;

local Remove_South_Sea_Resource_Plots  = {}		-- 需要移除资源的南海单元格
-------------------------------------------------------------------------------
function BBS_Assign(args)
	print("BBS_Assign: Injecting Spawn Placement")
	local start_plot_database = {};

	start_plot_database = BBS_AssignStartingPlots.Create(args)

	return start_plot_database
end
-------------------------------------------------------------------------------
function GenerateMap()
	print("TeanPVP Generating Pangea+ Map");
	local pPlot;

	-- Set globals
	g_iW, g_iH = Map.GetGridSize();
	g_iFlags = TerrainBuilder.GetFractalFlags();
	local temperature = MapConfiguration.GetValue("temperature"); -- Default setting is Temperate.
	if temperature == 4 then
		temperature  =  1 + TerrainBuilder.GetRandomNumber(3, "Random Temperature- Lua");
	end
	
	--	local world_age
	local world_age = MapConfiguration.GetValue("world_age");
	if (world_age == 1) then
		world_age = world_age_new;
	elseif (world_age == 2) then
		world_age = world_age_normal;
	elseif (world_age == 3) then
		world_age = world_age_old;
	else
		world_age = 2 + TerrainBuilder.GetRandomNumber(4, "Random World Age - Lua");
	end
	
	plotTypes = TeamPVPGeneratePlotTypes(world_age);
	terrainTypes = TeamPVPGenerateTerrainTypes(plotTypes, g_iW, g_iH, g_iFlags, true, temperature);
	ApplyBaseTerrain(plotTypes, terrainTypes, g_iW, g_iH);

	AreaBuilder.Recalculate();
	TerrainBuilder.AnalyzeChokepoints();
	TerrainBuilder.StampContinents();

	local iContinentBoundaryPlots = GetContinentBoundaryPlotCount(g_iW, g_iH);
	local biggest_area = Areas.FindBiggestArea(false);
	print("After Adding Hills: ", biggest_area:GetPlotCount());
		if (MapConfiguration.GetValue("BBSRidge") ~= 1) then
		print("Adding Ridges");
	    end
	TeamPVPAddTerrainFromContinents(plotTypes, terrainTypes, world_age, g_iW, g_iH, iContinentBoundaryPlots);
	AreaBuilder.Recalculate();
	TerrainBuilder.AnalyzeChokepoints();

	-- 705: River generation moved into AddFeatures() so we can pass random rainfall value

	AddFeatures();
	
	print("Adding cliffs");
	AddCliffs(plotTypes, terrainTypes);

	local args = {
		numberToPlace = GameInfo.Maps[Map.GetMapSize()].NumNaturalWonders,
	};
	local nwGen = NaturalWonderGenerator.Create(args);

	AddFeaturesFromContinents();
	DW_MarkCoastalLowlands();
	
	AddIceIsland()
	
	resourcesConfig = MapConfiguration.GetValue("resources");
	local startConfig = MapConfiguration.GetValue("start");-- Get the start config
	local args = {
		resources = resourcesConfig,
		START_CONFIG = startConfig,
		plotTypes=plotTypes,
	};
	local resGen = BBS_ResourceGenerator.Create(args);

	Remove_SouthSeaResource()
	
	print("Creating start plot database.");

	-- START_MIN_Y and START_MAX_Y is the percent of the map ignored for major civs' starting positions.
	local args = {
		MIN_MAJOR_CIV_FERTILITY = 150,
		MIN_MINOR_CIV_FERTILITY = 5,
		MIN_BARBARIAN_FERTILITY = 1,
		START_MIN_Y = 15,
		START_MAX_Y = 15,
		START_CONFIG = startConfig,
		WATER = false,
		LAND = false,
	};
	local start_plot_database = BBS_Assign(args)

		local GoodyGen = TPT_AddGoodies(g_iW, g_iH);
		local Balance = BBS_Script();
		AreaBuilder.Recalculate();	TerrainBuilder.AnalyzeChokepoints();
end

-------------------------------------------------------------------------------
function TeamPVPGeneratePlotTypes(world_age)
	plotTypes = table.fill(g_PLOT_TYPE_LAND, g_iW * g_iH);

	local variationFrac1 = Fractal.Create(g_iH, g_iW, 3, g_iFlags, -1, -1);
	local variationFrac2 = Fractal.Create(g_iH, g_iW, 3, g_iFlags, -1, -1);
	local variationFrac3 = Fractal.Create(g_iW, g_iH, 3, g_iFlags, -1, -1);
	local variationFrac4 = Fractal.Create(g_iW, g_iH, 3, g_iFlags, -1, -1);

	local d_water_W = 15
	local d_water_H = 6
	-- local waterlatitude_W = 1 - (d_water_W * 2 / g_iH)
	-- local waterlatitude_H = 1 - (d_water_H * 2 / g_iH)

	local waterlatitude_W = 5 / g_iH
	local waterlatitude_H = 5 / g_iH

	for y = 0, g_iH -1 do
		for x = 0, g_iW - 1 do
			local i = y * g_iW + x
			local pPlot = Map.GetPlotByIndex(i);
			if x > g_iW - g_iH / 2 then
				local lat = GetLatitudeAtPlot(variationFrac1, y, g_iW - x);
				if lat >= waterlatitude_W then
					plotTypes[i] = g_PLOT_TYPE_OCEAN
					TerrainBuilder.SetTerrainType(pPlot, g_TERRAIN_TYPE_OCEAN);
				end
			elseif x < g_iH / 2 then
				local lat = GetLatitudeAtPlot(variationFrac2, y, x);	
				if lat >= waterlatitude_W then
					plotTypes[i] = g_PLOT_TYPE_OCEAN
					TerrainBuilder.SetTerrainType(pPlot, g_TERRAIN_TYPE_OCEAN);
				end
			end
			if y > g_iH / 2 then
				local lat = GetLatitudeAtPlot(variationFrac3, x, g_iH - y);
				if lat >= waterlatitude_H then
					plotTypes[i] = g_PLOT_TYPE_OCEAN
					TerrainBuilder.SetTerrainType(pPlot, g_TERRAIN_TYPE_OCEAN);
				end
			else
				local lat = GetLatitudeAtPlot(variationFrac3, x, y);
				if lat >= waterlatitude_H then
					plotTypes[i] = g_PLOT_TYPE_OCEAN
					TerrainBuilder.SetTerrainType(pPlot, g_TERRAIN_TYPE_OCEAN);
				end
			end
			if y <= 1 or y >= g_iH - 1 then
				plotTypes[i] = g_PLOT_TYPE_OCEAN
				TerrainBuilder.SetTerrainType(pPlot, g_TERRAIN_TYPE_OCEAN);
			end
		end
	end
	AreaBuilder.Recalculate();
	
	local biggest_area = Areas.FindBiggestArea(false);		-- 删除岛屿
	for x = 0, g_iW - 1 do
		for y = 0, g_iH - 1 do
			local i = y * g_iW + x;
			local pPlot = Map.GetPlotByIndex(i);
			if(plotTypes[i] == g_PLOT_TYPE_LAND and pPlot:GetArea() ~= biggest_area) or x <= 1 or x >= g_iW - 2 then
				plotTypes[i] = g_PLOT_TYPE_OCEAN;
				TerrainBuilder.SetTerrainType(pPlot, g_TERRAIN_TYPE_OCEAN);
			end
		end
	end
	
	-- 移除远洋资源
	for x = 0, g_iW - 1 do
		for y = 0, g_iH - 1 do
			local i = y * g_iW + x;
			local pPlot = Map.GetPlotByIndex(i)	
			local nPlot = pPlot:GetNearestLandPlot()
			local Distance = Map.GetPlotDistance(pPlot:GetX(), pPlot:GetY(), nPlot:GetX(), nPlot:GetY())
			if Distance > 5 and plotTypes[i] ~= g_PLOT_TYPE_LAND then
				table.insert(Remove_South_Sea_Resource_Plots, i)
			end
		end
	end

	-- 添加岛屿
	
	local d_island = d_water_W + 13
	local Islandlatitude_W = 1 - (d_island * 2 / g_iH)

	local d_island_2 = d_water_W - 9
	local Islandlatitude_W_2 = 1 - (d_island_2 * 2 / g_iH)

	local args = args or {};
	args.iWaterPercent = 63;
	args.iRegionWidth = math.ceil(g_iW);
	args.iRegionHeight = math.ceil(g_iH);
	args.iRegionWestX = math.floor(0);
	args.iRegionSouthY = math.floor(0);
	args.iRegionGrain = 5;
	args.iRegionHillsGrain = 6;
	args.iRegionPlotFlags = g_iFlags;
	args.iRegionFracXExp = 7;
	args.iRegionFracYExp = 6;

	local iWaterPercent = args.iWaterPercent or 55;
	local iRegionWidth = args.iRegionWidth; -- Mandatory Parameter, no default
	local iRegionHeight = args.iRegionHeight; -- Mandatory Parameter, no default
	local iRegionWestX = args.iRegionWestX; -- Mandatory Parameter, no default
	local iRegionSouthY = args.iRegionSouthY; -- Mandatory Parameter, no default
	local iRegionGrain = args.iRegionGrain or 1;
	local iRegionPlotFlags = args.iRegionPlotFlags or g_iFlags;
	local iRegionTerrainFlags = g_iFlags; -- Removed from args list.
	local iRegionFracXExp = args.iRegionFracXExp or 6;
	local iRegionFracYExp = args.iRegionFracYExp or 5;
	local iRiftGrain = args.iRiftGrain or -1;

	local regionContinentsFrac;
	if(iRiftGrain > 0 and iRiftGrain < 4) then
		local riftsFrac = Fractal.Create(g_iW, g_iH, rift_grain, {}, iRegionFracXExp, iRegionFracYExp);
		regionContinentsFrac = Fractal.CreateRifts(g_iW, g_iH, iRegionGrain, iRegionPlotFlags, riftsFrac, iRegionFracXExp, iRegionFracYExp);
	else
		regionContinentsFrac = Fractal.Create(g_iW, g_iH, iRegionGrain, iRegionPlotFlags, iRegionFracXExp, iRegionFracYExp);	
	end
	local iWaterThreshold = regionContinentsFrac:GetHeight(iWaterPercent);

	for y = 0, g_iH -1 do
		for x = 0, g_iW - 1 do
			if y > d_water_H and y < g_iH - d_water_H then
				local i = y * g_iW + x
				local pPlot = Map.GetPlotByIndex(i);
				local val = regionContinentsFrac:GetHeight(x,y);
				if val >= iWaterThreshold then
					if x > g_iW - g_iH / 2 then
						local lat = GetLatitudeAtPlot(variationFrac1, y, g_iW - x);
						if lat >= Islandlatitude_W and lat <= Islandlatitude_W_2 then
							plotTypes[i] = g_PLOT_TYPE_LAND
							TerrainBuilder.SetTerrainType(pPlot, g_TERRAIN_TYPE_DESERT);
						end
					elseif x < g_iH / 2 then
						local lat = GetLatitudeAtPlot(variationFrac2, y, x);
						if lat >= Islandlatitude_W and lat <= Islandlatitude_W_2 then
							plotTypes[i] = g_PLOT_TYPE_LAND
							TerrainBuilder.SetTerrainType(pPlot, g_TERRAIN_TYPE_DESERT);
						end
					end
				end
			end
		end
	end
	AreaBuilder.Recalculate();

	local args = {};
	args.world_age = world_age;
	args.iW = g_iW;
	args.iH = g_iH;
	args.iFlags = g_iFlags;
	args.blendRidge = 10;
	args.blendFract = 1;
	args.extra_mountains = (2 + ( 3 - world_age)) * 2;
	args.tectonic_islands = tectonic_islands;
	mountainRatio = (24 + ( 3 - world_age)) * 2;--15
	--	if (MapConfiguration.GetValue("BBSRidge") == 1) then
	--	mountainRatio = 10 + world_age * 3;
	--end
	plotTypes = ApplyTectonics(args, plotTypes);
	plotTypes = AddLonelyMountains(plotTypes, mountainRatio);

	-- 705: Found a good map, now we can loop through every tile and add additional details
	print("-");
	local plotDataIsCoastal = GenerateCoastalLandDataTable();
	local hillsAdded = 0;
	local mountainsAdded = 0;
	local mountainsFilled = 0;
	
	for x = 0, g_iW - 1 do
		for y = 0, g_iH - 1 do
			local i = y * g_iW + x;
			-- 705: First, clean up the rare case of a non mountain plot surrounded by mountains
			if(plotTypes[i] == g_PLOT_TYPE_LAND or plotTypes[i] == g_PLOT_TYPE_HILLS) then
				local mountainCount = 0;
				for direction = 0, DirectionTypes.NUM_DIRECTION_TYPES - 1, 1 do
					local adjacentPlot = Map.GetAdjacentPlot(x, y, direction);
					if adjacentPlot ~= nil then
						local newIndex = adjacentPlot:GetIndex();
						if(plotTypes[newIndex] == g_PLOT_TYPE_MOUNTAIN) then
							mountainCount = mountainCount + 1;
						end
					end
				end
				
				if(mountainCount > 1) then -- surrounded by mountains 相邻山大于
					for direction = 0, DirectionTypes.NUM_DIRECTION_TYPES - 1, 1 do
						local rChance = 1 + TerrainBuilder.GetRandomNumber(6, "Add pass - LUA Pangaea");
						local adjacentPlot = Map.GetAdjacentPlot(x, y, direction);
						if adjacentPlot ~= nil then
							local newIndex = adjacentPlot:GetIndex();
							if(plotTypes[newIndex] == g_PLOT_TYPE_MOUNTAIN and rChance > 3 ) then
								plotTypes[newIndex] = g_PLOT_TYPE_HILLS;
								mountainsFilled = mountainsFilled + 1;
							end
						end
					end
				end
			end
			
			-- 705: Detailed hills and mountains pass, Pangaea version creates fewer hills
			-- Add extra hills in vast flatlands
			-- Change hills into mountains or flat land in vast hilly areas
			
			local rChance = TerrainBuilder.GetRandomNumber(6, "Add hills - LUA Mixed Continents");
			local mountainsAllowed = g_iH / (6 - world_age);
			
			if(plotDataIsCoastal[i] == false) then
				local hillCount = 0;
				for direction = 0, DirectionTypes.NUM_DIRECTION_TYPES - 1, 1 do
					local adjacentPlot = Map.GetAdjacentPlot(x, y, direction);
					if adjacentPlot ~= nil then
						local newIndex = adjacentPlot:GetIndex();
						if(plotTypes[newIndex] == g_PLOT_TYPE_HILLS) then
							hillCount = hillCount + 1;
						end
					end
				end
				--[[local hillsAddedrChance=0;
				if(hillCount<=1)then
					hillsAddedrChance =rChance+2;
				else
					hillsAddedrChance =rChance;
				end]]
				-- Add hill to flatland areas
				if(hillCount < rChance - 2 and plotTypes[i] == g_PLOT_TYPE_LAND) then
					plotTypes[i] = g_PLOT_TYPE_HILLS;
					hillsAdded = hillsAdded + 2;

				-- Add mountain or remove hill in hilly areas
				elseif(hillCount > rChance + 1 and mountainsAdded < mountainsAllowed) then
					plotTypes[i] = g_PLOT_TYPE_MOUNTAIN;
					mountainsAdded = mountainsAdded + 4;
				elseif(hillCount > rChance) then
					plotTypes[i] = g_PLOT_TYPE_LAND;
				end
			
			end
		end
	end

	AddMountain(plotTypes)
	
	print("-");
	print("--- Details pass");
	print("-  Mountain Passes Cleared:", mountainsFilled);
	print("-              Hills added:", hillsAdded);
	print("-          Mountains added:", mountainsAdded);
	
	-- 705: Flip the map?
	
	local flipMap = DetermineFlip(plotTypes); -- Todo: check polar land to determine if we need to flip
	
	if(flipMap) then
		local i, j = 1, #plotTypes;

		while i < j do
			plotTypes[i], plotTypes[j] = plotTypes[j], plotTypes[i];

			i = i + 1;
			j = j - 1;
		end
		print("-");
		print("- Map Flipped!");
	end
	
	print("- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -");

	return plotTypes;
end

function InitFractal(args)

	if(args == nil) then args = {}; end

	local continent_grain = args.continent_grain or 2;
	local rift_grain = args.rift_grain or -1; -- Default no rifts. Set grain to between 1 and 3 to add rifts. - Bob
	local invert_heights = args.invert_heights or false;
	local polar = args.polar or true;
	local ridge_flags = args.ridge_flags or g_iFlags;

	local fracFlags = {};
	
	if(invert_heights) then
		fracFlags.FRAC_INVERT_HEIGHTS = true;
	end
	
	if(polar) then
		fracFlags.FRAC_POLAR = true;
	end

	-- 705: Reduce max vertical size and hope that the plot shift function will clean up this mess.
	local g_maxH = math.floor(g_iH * 0.9);

	if(rift_grain > 0 and rift_grain < 4) then
		local riftsFrac = Fractal.Create(g_iW, g_maxH, rift_grain, {}, 6, 5);
		g_continentsFrac = Fractal.CreateRifts(g_iW, g_maxH, continent_grain, fracFlags, riftsFrac, 6, 5);
	else
		g_continentsFrac = Fractal.Create(g_iW, g_maxH, continent_grain, fracFlags, 6, 5);	
	end

	-- Use Brian's tectonics method to weave ridgelines in to the continental fractal.
	-- Without fractal variation, the tectonics come out too regular.
	--
	--[[ "The principle of the RidgeBuilder code is a modified Voronoi diagram. I 
	added some minor randomness and the slope might be a little tricky. It was 
	intended as a 'whole world' modifier to the fractal class. You can modify 
	the number of plates, but that is about it." ]]-- Brian Wade - May 23, 2009
	--
	local MapSizeTypes = {};
	for row in GameInfo.Maps() do
		MapSizeTypes[row.MapSizeType] = row.PlateValue;
	end
	local sizekey = Map.GetMapSize();

	local numPlates = MapSizeTypes[sizekey] or 4
	
	-- 705: Increase plates for better detail on all map sizes
	numPlates = numPlates * 2;

	-- Blend a bit of ridge into the fractal.
	-- This will do things like roughen the coastlines and build inland seas. - Brian

	g_continentsFrac:BuildRidges(numPlates, {}, 1, 2);
end

function AddFeatures()
	print("Adding Features");

	-- Get Rainfall setting input by user.
	local rainfall = MapConfiguration.GetValue("rainfall");
	if rainfall == 4 then
		rainfall = 1 + TerrainBuilder.GetRandomNumber(3, "Random Rainfall - Lua");
	end
	
	local args = {};
	
	args.rainfall = rainfall+1;
	
	-- River generation is affected by plot types, originating from highlands and preferring to traverse lowlands.
	-- 705: Custom river method to take rainfall into consideration
	AddRivers(args);
	args.rainfall = rainfall-1;
	
	-- Lakes would interfere with rivers, causing them to stop and not reach the ocean, if placed any sooner.
	local numLargeLakes = GameInfo.Maps[Map.GetMapSize()].Continents;
	-- 705: Adjusted large lakes by rainfall
	numLargeLakes = numLargeLakes + rainfall - 4;
	--AddLakes(numLargeLakes);
	
	args.iJunglePercent = 18;-- 21
	args.iForestPercent = 19;-- 21 --17
	args.iMarshPercent = 3;
	args.iOasisPercent = 1;
	args.iReefPercent = 12;
	
	featuregen = DW_FeatureGenerator.Create(args);
	featuregen:AddFeatures(true, true);
end

function AddFeaturesFromContinents()
	print("Adding Features from Continents");

	featuregen:AddFeaturesFromContinents();
end

-------------------------------------------------------------------------------
function GenerateWaterLayer (args, plotTypes)
	-- This function is intended to allow adding seas to specific areas of large continents.
	local args = args or {};
	
	-- Handle args or assign defaults.
	local iWaterPercent = args.iWaterPercent or 55;
	local iRegionWidth = args.iRegionWidth; -- Mandatory Parameter, no default
	local iRegionHeight = args.iRegionHeight; -- Mandatory Parameter, no default
	local iRegionWestX = args.iRegionWestX; -- Mandatory Parameter, no default
	local iRegionSouthY = args.iRegionSouthY; -- Mandatory Parameter, no default
	local iRegionGrain = args.iRegionGrain or 1;
	local iRegionPlotFlags = args.iRegionPlotFlags or g_iFlags;
	local iRegionFracXExp = args.iRegionFracXExp or 6;
	local iRegionFracYExp = args.iRegionFracYExp or 5;
	local iRiftGrain = args.iRiftGrain or -1;
	local bShift = args.bShift or true;

	-- Init the plot types array for this region's plot data. Redone for each new layer.
	-- Compare to self.wholeworldPlotTypes, which contains the sum of all layers.
	plotTypes2 = {};
	-- Loop through the region's plots
	for x = 0, iRegionWidth - 1, 1 do
		for y = 0, iRegionHeight - 1, 1 do
			local i = y * iRegionWidth + x + 1; -- Lua arrays start at 1.
			plotTypes2[i] = g_PLOT_TYPE_OCEAN;
		end
	end

	-- Init the land/water fractal
	local regionContinentsFrac;
	if (iRiftGrain > 0) and (iRiftGrain < 4) then
		local riftsFrac = Fractal.Create(iRegionWidth, iRegionHeight, iRiftGrain, {}, iRegionFracXExp, iRegionFracYExp);
		regionContinentsFrac = Fractal.CreateRifts(iRegionWidth, iRegionHeight, iRegionGrain, iRegionPlotFlags, riftsFrac, iRegionFracXExp, iRegionFracYExp);
	else
		regionContinentsFrac = Fractal.Create(iRegionWidth, iRegionHeight, iRegionGrain, iRegionPlotFlags, iRegionFracXExp, iRegionFracYExp);	
	end
	
	-- Using the fractal matrices we just created, determine fractal-height values for sea level.
	local iWaterThreshold = regionContinentsFrac:GetHeight(iWaterPercent);

	-- Loop through the region's plots
	for x = 0, iRegionWidth - 1, 1 do
		for y = 0, iRegionHeight - 1, 1 do
			local i = y * iRegionWidth + x + 1; -- Lua arrays start at 1.
			local val = regionContinentsFrac:GetHeight(x,y);
			if val <= iWaterThreshold then
				--do nothing
			else
				plotTypes2[i] = g_PLOT_TYPE_LAND;
			end
		end
	end

	if bShift then -- Shift plots to obtain a more natural shape.
		ShiftPlotTypes(plotTypes);
	end

	-- Apply the region's plots to the global plot array.
	for x = 0, iRegionWidth - 1, 1 do
		local wholeworldX = x + iRegionWestX;
		for y = 0, iRegionHeight - 1, 1 do
			local i = y * iRegionWidth + x + 1;
			if plotTypes2[i] ~= g_PLOT_TYPE_OCEAN then
				local wholeworldY = y + iRegionSouthY;
				local index = wholeworldY * g_iW + wholeworldX + 1
				plotTypes[index] = g_PLOT_TYPE_OCEAN;
			end
		end
	end

	-- This region is done.
	return plotTypes;
end

-------------------------------------------------------------------------------------------
function DetermineFlip(plotTypes)
	-- 705: See if we need to flip the map to put the most land along the north edge of the
	-- map to make it look more earth-like which will make the map feel more natural

	local g_iW, g_iH = Map.GetGridSize();

	-- First loop through the map rows and record land plots in each row.
	local land_totals = {};
	for y = 0, g_iH - 1 do
		local current_row = 0;
		for x = 0, g_iW - 1 do
			local i = y * g_iW + x + 1;
			if (plotTypes[i] ~= g_PLOT_TYPE_OCEAN) then
				current_row = current_row + 1;
			end
		end
		table.insert(land_totals, current_row);
	end
	
	-- Now evaluate row groups, each record applying to the center row of the group.
	local row_groups = {};
	-- Determine the group size in relation to map height.
	local group_radius = math.floor(g_iH / 15);
	-- Measure the groups.
	for row_index = 1, g_iH do
		local current_group_total = 0;
		for current_row = row_index - group_radius, row_index + group_radius do
			local current_index = current_row % g_iH;
			if current_index == 0 then -- Modulo of the last row will be zero; this repairs the issue.
				current_index = g_iH;
			end
			current_group_total = current_group_total + land_totals[current_index];
		end
		table.insert(row_groups, current_group_total);
	end
	
	-- Identify the group with the least amount of land in it.
	local best_value = g_iW * (2 * group_radius + 1); -- Set initial value to max possible.
	local best_group = 1; -- Set initial best group as current map edge.
	for row_index, group_land_plots in ipairs(row_groups) do
		if group_land_plots < best_value then
			best_value = group_land_plots;
			best_group = row_index;
		end
	end
	
	if best_group < math.floor(g_iH * 0.25) then
		return false;
	end
	
	return true;
end

-------------------------------------------------------------------------------
function GenerateFractalLayerWithoutHills (args, plotTypes)
	--[[ This function is intended to be paired with ApplyTectonics. If all the hills and
	mountains plots are going to be overwritten by the tectonics results, then why waste
	calculations generating them? ]]--
	local args = args or {};
	local plotTypes2 = {};

	-- Handle args or assign defaults.
	local iWaterPercent = args.iWaterPercent or 55;
	local iRegionWidth = args.iRegionWidth; -- Mandatory Parameter, no default
	local iRegionHeight = args.iRegionHeight; -- Mandatory Parameter, no default
	local iRegionWestX = args.iRegionWestX; -- Mandatory Parameter, no default
	local iRegionSouthY = args.iRegionSouthY; -- Mandatory Parameter, no default
	local iRegionGrain = args.iRegionGrain or 1;
	local iRegionPlotFlags = args.iRegionPlotFlags or g_iFlags;
	local iRegionTerrainFlags = g_iFlags; -- Removed from args list.
	local iRegionFracXExp = args.iRegionFracXExp or 6;
	local iRegionFracYExp = args.iRegionFracYExp or 5;
	local iRiftGrain = args.iRiftGrain or -1;
	
	--print("Received Region Data");
	--print(iRegionWidth, iRegionHeight, iRegionWestX, iRegionSouthY, iRegionGrain);
	--print("- - -");
	
	--print("Filled regional table.");
	-- Loop through the region's plots
	for x = 0, iRegionWidth - 1, 1 do
		for y = 0, iRegionHeight - 1, 1 do
			local i = y * iRegionWidth + x + 1; -- Lua arrays start at 1.
			plotTypes2[i] =g_PLOT_TYPE_OCEAN;
		end
	end

	-- Init the land/water fractal
	local regionContinentsFrac;
	if(iRiftGrain > 0 and iRiftGrain < 4) then
		local riftsFrac = Fractal.Create(g_iW, g_iH, rift_grain, {}, iRegionFracXExp, iRegionFracYExp);
		regionContinentsFrac = Fractal.CreateRifts(g_iW, g_iH, iRegionGrain, iRegionPlotFlags, riftsFrac, iRegionFracXExp, iRegionFracYExp);
	else
		regionContinentsFrac = Fractal.Create(g_iW, g_iH, iRegionGrain, iRegionPlotFlags, iRegionFracXExp, iRegionFracYExp);	
	end
	--print("Initialized main fractal");
	local iWaterThreshold = regionContinentsFrac:GetHeight(iWaterPercent);

	-- Loop through the region's plots
	for x = 0, iRegionWidth - 1, 1 do
		for y = 0, iRegionHeight - 1, 1 do
			local i = y * iRegionWidth + x + 1; -- Lua arrays start at 1.
			local val = regionContinentsFrac:GetHeight(x,y);
			if val <= iWaterThreshold or Adjacent(i) == true then
				--do nothing
			else
				plotTypes2[i] = g_PLOT_TYPE_LAND;
			end
		end
	end

	-- print("Shifted Plots - Width: ", iRegionWidth, "Height: ", iRegionHeight);

	-- Apply the region's plots to the global plot array.
	for x = 0, iRegionWidth - 1, 1 do
		local wholeworldX = x + iRegionWestX;
		for y = 0, iRegionHeight - 1, 1 do
			local index = y * iRegionWidth + x + 1
			if plotTypes2[index] ~= g_PLOT_TYPE_OCEAN then
				local wholeworldY = y + iRegionSouthY;
				local i = wholeworldY * g_iW + wholeworldX + 1
				plotTypes[i] = plotTypes2[index];
			end
		end
	end
	--print("Generated Plot Types");

	return plotTypes;
end

-------------------------------------------------------------------------------------------
function Adjacent(index)
	aIslands = islands;
	index = index -1;

	if(aIslands == nil) then
		return false;
	end
	
	if(index < 0) then
		return false
	end

	local plot = Map.GetPlotByIndex(index);
	if(aIslands[index] ~= nil and aIslands[index] == g_PLOT_TYPE_LAND) then
		return true;
	end

	for direction = 0, DirectionTypes.NUM_DIRECTION_TYPES - 1, 1 do
		local adjacentPlot = Map.GetAdjacentPlot(plot:GetX(), plot:GetY(), direction);
		if(adjacentPlot ~= nil) then
			local newIndex = adjacentPlot:GetIndex();
			if(aIslands  ~= nil and aIslands[newIndex] == g_PLOT_TYPE_LAND) then
				return true;
			end
		end
	end

	return false;
end

function TeamPVPGenerateTerrainTypes(plotTypes, iW, iH, iFlags, bNoCoastalMountains, temperature, bonus_cold_shift)
	print("TeamPVP Generating Terrain Types");
	local terrainTypes = {};

	if(temperature == nil) then
		temperature = 2;
	end

	local coldShift = bonus_cold_shift or 0;
	local temperature_shift = 0.1;
	local desert_shift = 1;
	local plains_shift = 8;

	local iDesertPercent = 5;
	local iPlainsPercent = 56;
	local fSnowLatitude  = 1 + coldShift;
	local fTundraLatitude = 1;
	local fGrassLatitude = 0.1; 
	local fDesertBottomLatitude = 0.1;
	local fDesertTopLatitude = 0.35;

	--冻土
	local t_Land_H = 6
	local t_Tundra_H = 8
	fTundraLatitude = 1 - ((t_Land_H + t_Tundra_H) * 2 / g_iH);		-- 冻土固定高度

	-- 文明冻土关联查询
	local Max_Level = 5
	for _, iPlayerID in ipairs(PlayerManager.GetAliveMajorIDs()) do
		local civilizationType = PlayerConfigurations[iPlayerID]:GetCivilizationTypeName();
		for row in GameInfo.StartBiasTerrains() do
			if(row.CivilizationType == civilizationType) then
				if row.TerrainType == "TERRAIN_TUNDRA" or row.TerrainType == "TERRAIN_TUNDRA_HILLS" then
--					print("绑定等级", row.CivilizationType, row.Tier)
					if row.Tier < Max_Level then
						Max_Level = row.Tier
					end
				end
			end
		end
	end
	
	if Max_Level >= 2 then
		fTundraLatitude = 1
	end

	if temperature > 2.5 then -- World Temperature is Cool.
		iDesertPercent = iDesertPercent - desert_shift;
		fTundraLatitude = fTundraLatitude - (temperature_shift * 1.5);
		iPlainsPercent = iPlainsPercent + plains_shift;
		fDesertTopLatitude = fDesertTopLatitude - temperature_shift;
		fGrassLatitude = fGrassLatitude - (temperature_shift * 0.5);
	elseif temperature < 1.5 then -- World Temperature is Hot.
		iDesertPercent = iDesertPercent + desert_shift;
		fSnowLatitude  = fSnowLatitude + (temperature_shift * 0.5);
		fTundraLatitude = fTundraLatitude + temperature_shift;
		fDesertTopLatitude = fDesertTopLatitude + temperature_shift;
		fGrassLatitude = fGrassLatitude - (temperature_shift * 0.5);
		iPlainsPercent = iPlainsPercent + plains_shift;
	else -- Normal Temperature.
	end

    iDesertPercent=iDesertPercent*0.6;
	local iDesertTopPercent		= 100;
	local iDesertBottomPercent	= math.max(0, math.floor(100-iDesertPercent));
	local iPlainsTopPercent		= 100;
	local iPlainsBottomPercent	= math.max(0, math.floor(100-iPlainsPercent));

	local fracXExp = -1;
	local fracYExp = -1;
	local iDesertTop;
	local iDesertBottom;																
	local iPlainsTop;
	local iPlainsBottom;

	local grain_amount = 3;
	if temperature < 1.5 then -- World Temperature is Hot.
		grain_amount = 2;
	end

	deserts = Fractal.Create(iW, iH, grain_amount, iFlags, fracXExp, fracYExp);
	
	grain_amount = 5;
	plains = Fractal.Create(iW, iH, grain_amount, iFlags, fracXExp, fracYExp);
	local variationFrac = Fractal.Create(iW, iH, grain_amount, iFlags, fracXExp, fracYExp);

	iDesertTop = deserts:GetHeight(iDesertTopPercent);
	iDesertBottom = deserts:GetHeight(iDesertBottomPercent);


	iPlainsTop = plains:GetHeight(iPlainsTopPercent);
	iPlainsBottom = plains:GetHeight(iPlainsBottomPercent);
	
	for iX = 0, iW - 1 do
		for iY = 0, iH - 1 do
			local index = (iY * iW) + iX;
			if (plotTypes[index] == g_PLOT_TYPE_OCEAN) then
				if (TeamPVPIsAdjacentToLand(plotTypes, iX, iY)) then
					terrainTypes[index] = g_TERRAIN_TYPE_COAST;
				else
					terrainTypes[index] = g_TERRAIN_TYPE_OCEAN;
				end
			end
		end
	end
	
	if (bNoCoastalMountains == true) then
		plotTypes = RemoveCoastalMountains(plotTypes, terrainTypes);
	end

	local landCheck = false;
	local landiY=nil;
	for iY = iH - 1,0,-1  do
		local landCount = 0;
		for iX = 0,iW - 1 do
			local index = (iY * iW) + iX;
			if(plotTypes[index] ~= g_PLOT_TYPE_OCEAN)then
				landCount=landCount+1;
			end
			if(landCount>5)then
				landCheck = true;
				landiY = iY;
				break;
			end
		end
		if(landCheck==true)then
			break;
		end
	end
	print("teamPVP landiY landiY",landiY);

	for iX = 0, iW - 1 do
		for iY = 0, iH - 1 do
			local index = (iY * iW) + iX;
			local lat = GetLatitudeAtPlot(variationFrac, iX, iY);

			if (plotTypes[index] == g_PLOT_TYPE_MOUNTAIN) then
			    terrainTypes[index] = g_TERRAIN_TYPE_GRASS_MOUNTAIN;
				if(lat >= fSnowLatitude) then
					if iY > g_iH / 2 and fTundraLatitude ~= 1 then
						terrainTypes[index] = g_TERRAIN_TYPE_TUNDRA_MOUNTAIN;
					end
				elseif(lat >= fTundraLatitude) then
					if iY > g_iH / 2 and fTundraLatitude ~= 1 then
						terrainTypes[index] = g_TERRAIN_TYPE_TUNDRA_MOUNTAIN;
					end
				elseif (lat < fGrassLatitude) then
					terrainTypes[index] = g_TERRAIN_TYPE_GRASS_MOUNTAIN;
				else
					local desertVal = deserts:GetHeight(iX, iY);
					local plainsVal = plains:GetHeight(iX, iY);
					if ((desertVal >= iDesertBottom) and (desertVal <= iDesertTop) and (lat >= fDesertBottomLatitude) and (lat < fDesertTopLatitude)) then
						terrainTypes[index] = g_TERRAIN_TYPE_DESERT_MOUNTAIN;
					elseif ((plainsVal >= iPlainsBottom) and (plainsVal <= iPlainsTop)) then
						terrainTypes[index] = g_TERRAIN_TYPE_PLAINS_MOUNTAIN;
					end
				end

			elseif (plotTypes[index] ~= g_PLOT_TYPE_OCEAN) then
				terrainTypes[index] = g_TERRAIN_TYPE_GRASS;
				if(lat >= fSnowLatitude) then
					if iY > g_iH / 2 and fTundraLatitude ~= 1 then
						terrainTypes[index] = g_TERRAIN_TYPE_TUNDRA;
					end
				elseif(lat >= fTundraLatitude) then
					if iY > g_iH / 2 and fTundraLatitude ~= 1 then
						terrainTypes[index] = g_TERRAIN_TYPE_TUNDRA;
					end
				elseif (lat < fGrassLatitude) then
					terrainTypes[index] = g_TERRAIN_TYPE_GRASS;
				else
					local desertVal = deserts:GetHeight(iX, iY);
					local plainsVal = plains:GetHeight(iX, iY);
					if ((desertVal >= iDesertBottom) and (desertVal <= iDesertTop) and (lat >= fDesertBottomLatitude) and (lat < fDesertTopLatitude)) then
						terrainTypes[index] = g_TERRAIN_TYPE_DESERT;
					elseif ((plainsVal >= iPlainsBottom) and (plainsVal <= iPlainsTop)) then
						terrainTypes[index] = g_TERRAIN_TYPE_PLAINS;
					end
				end
			end
		end
	end

	print("Cleaning up grassland-desert borders");
	for iI = 0, 2 do
		local nearDesertPlots = {};
		for iX = 0, iW - 1 do
			for iY = 0, iH - 1 do
				local index = (iY * iW) + iX;
				if (terrainTypes[index] == g_TERRAIN_TYPE_GRASS) then
					-- Chance for each eligible plot to become an expansion is 1 / iExpansionDiceroll.
					-- Default is two passes at 1/4 chance per eligible plot on each pass.
					if (IsAdjacentToDesert(terrainTypes, iX, iY) ) then
						table.insert(nearDesertPlots, index);
					end
				end
			end
		end
		for i, index in ipairs(nearDesertPlots) do
			terrainTypes[index] = g_TERRAIN_TYPE_PLAINS;
		end
	end
   
	print("Expanding coasts");
	for iI = 0, 2 do
		local shallowWaterPlots = {};
		for iX = 0, iW - 1 do
			for iY = 0, iH - 1 do
				local index = (iY * iW) + iX;
				if (terrainTypes[index] == g_TERRAIN_TYPE_OCEAN) then
					-- Chance for each eligible plot to become an expansion is 1 / iExpansionDiceroll.
					-- Default is two passes at 1/4 chance per eligible plot on each pass.
					if (IsAdjacentToShallowWater(terrainTypes, iX, iY) and TerrainBuilder.GetRandomNumber(5, "add shallows") == 0) then
						table.insert(shallowWaterPlots, index);
					end
				end
			end
		end
		for i, index in ipairs(shallowWaterPlots) do
			terrainTypes[index] = g_TERRAIN_TYPE_COAST;
		end
	end
	
	return terrainTypes; 
end


function TeamPVPAddTerrainFromContinents(plotTypes, terrainTypes, world_age, iW, iH, iContinentBoundaryPlots)

	local iMountainPercentByDistance:table = {42, 24, 6}; 
	local iHillPercentByDistance:table = {50, 40, 30}; 
	local aLonelyMountainIndices:table = {};
	local iVolcanoesPlaced = 0;

	-- Compute target number of volcanoes
	local iTotalLandPlots = 0;
	for iX = 0, iW - 1 do
		for iY = 0, iH - 1 do
			local index = (iY * iW) + iX;
			if (plotTypes[index] ~= g_PLOT_TYPE_OCEAN) then
				iTotalLandPlots = iTotalLandPlots + 1;
			end
		end
	end
	local iDivisor = 8;
	if (world_age < 8) then
		iDivisor = 8 - world_age;  -- iDivisor should be 3 for new, 6 for old
	end
	local iDesiredVolcanoes = iTotalLandPlots / (iDivisor * 50);
	print ("Desired Volcanoes: " .. iDesiredVolcanoes);

	-- 2/3rds of Earth's volcanoes are near continent boundaries
	print ("Continent Boundary Plots: " .. iContinentBoundaryPlots);
	local iDesiredNearBoundaries = iDesiredVolcanoes * 2 / 3;

	if (iDesiredNearBoundaries > 0) then
		local iBoundaryPlotsPerVolcano = iContinentBoundaryPlots / iDesiredNearBoundaries;

		-- Not more than 1 per 16 tiles
		if (iBoundaryPlotsPerVolcano < 16) then
			iBoundaryPlotsPerVolcano = 16;
		end
		print ("Boundary Plots Per Volcano: " .. iBoundaryPlotsPerVolcano);

		for iX = 0, iW - 1 do
			for iY = 0, iH - 1 do
				local index = (iY * iW) + iX;
				if (plotTypes[index] ~= g_PLOT_TYPE_OCEAN) then
					local pPlot = Map.GetPlotByIndex(index);
					local iPlotsFromBoundary = -1;
					local bVolcanoHere = false;
					-- 705: For now, block volcanoes being created on desert tiles
					if (GetNumberAdjacentVolcanoes(iX, iY) == 0 and GetNumberAdjacentMountains() < 4) then
						if (terrainTypes[index] ~= g_TERRAIN_TYPE_DESERT and terrainTypes[index] ~= g_TERRAIN_TYPE_DESERT_HILLS and terrainTypes[index] ~= g_TERRAIN_TYPE_DESERT_MOUNTAINS) then
							if (Map.FindSecondContinent(pPlot, 1)) then
								if (TerrainBuilder.GetRandomNumber(iBoundaryPlotsPerVolcano *.7, "Volcano on boundary") == 1) then
									bVolcanoHere = true;
								end
								iPlotsFromBoundary = 1;
							elseif(Map.FindSecondContinent(pPlot, 2)) then
								if (TerrainBuilder.GetRandomNumber(iBoundaryPlotsPerVolcano, "Volcano 1 from boundary") == 1) then
									bVolcanoHere = true;
								end
								iPlotsFromBoundary = 2;
							elseif(Map.FindSecondContinent(pPlot, 3)) then
								if (TerrainBuilder.GetRandomNumber(iBoundaryPlotsPerVolcano * 1.5, "Volcano 2 from boundary") == 1) then
									bVolcanoHere = true;
								end
								iPlotsFromBoundary = 3;

							elseif (plotTypes[index] == g_PLOT_TYPE_MOUNTAIN) then
								if (GetNumberAdjacentMountains() == 0) then
									table.insert(aLonelyMountainIndices, index);
								end
							end
						end
					end

					if (bVolcanoHere) then
						TerrainBuilder.SetTerrainType(pPlot, ConvertToMountain(terrainTypes[index]));
						TerrainBuilder.SetFeatureType(pPlot, g_FEATURE_VOLCANO);
						print ("Volcano Placed at (x, y): " .. iX .. ", " .. iY);
						iVolcanoesPlaced = iVolcanoesPlaced + 1;
					end
				end
			end
		end
		print ("Continent Edge Volcanoes Placed: " .. iVolcanoesPlaced);
	end

	if ((iDesiredVolcanoes - iVolcanoesPlaced) > 0 and #aLonelyMountainIndices > 0) then
		local iChance = #aLonelyMountainIndices / iDesiredVolcanoes;
		aShuffledIndices =  GetShuffledCopyOfTable(aLonelyMountainIndices);
		for i, index in ipairs(aShuffledIndices) do
			local pPlot = Map.GetPlotByIndex(index);
			local iX = pPlot:GetX();
			local iY = pPlot:GetY();
			
			if (GetNumberAdjacentVolcanoes(iX, iY) == 0) then
				TerrainBuilder.SetFeatureType(pPlot, g_FEATURE_VOLCANO);
				print ("Lonely Volcano Placed at (x, y): " .. iX .. ", " .. iY);
				iVolcanoesPlaced = iVolcanoesPlaced + 1;
				if (iVolcanoesPlaced >= iDesiredVolcanoes) then
					break
				end
			end
		end
	end

	print ("Total Volcanoes Placed: " .. iVolcanoesPlaced);
end

function TeamPVPIsAdjacentToLand(plotTypes, iX, iY)
	local adjacentPlot;	
	local iW, iH = Map.GetGridSize();

	for direction = 0, 5, 1 do
		adjacentPlot = Map.GetAdjacentPlot(iX, iY, direction);
		if (adjacentPlot ~= nil) then
			if(IsAdjacentToLand(plotTypes, adjacentPlot:GetX(), adjacentPlot:GetY()))then
				return true;
		    end
	   		local i = adjacentPlot:GetY() * iW + adjacentPlot:GetX();
			if (plotTypes[i] ~= g_PLOT_TYPE_OCEAN) then
				return true;
		    end
		end
	end
	return false;
end

function AddIceIsland(args, plotTypes)

	local args = args or {};
	args.iWaterPercent = 70;
	args.iRegionWidth = math.ceil(g_iW);
	args.iRegionHeight = math.ceil(g_iH);
	args.iRegionWestX = math.floor(0);
	args.iRegionSouthY = math.floor(0);
	args.iRegionGrain = 6;
	args.iRegionHillsGrain = 7;
	args.iRegionPlotFlags = g_iFlags;
	args.iRegionFracXExp = 7;
	args.iRegionFracYExp = 6;


	-- Handle args or assign defaults.
	local iWaterPercent = args.iWaterPercent or 55;
	local iRegionWidth = args.iRegionWidth; -- Mandatory Parameter, no default
	local iRegionHeight = args.iRegionHeight; -- Mandatory Parameter, no default
	local iRegionWestX = args.iRegionWestX; -- Mandatory Parameter, no default
	local iRegionSouthY = args.iRegionSouthY; -- Mandatory Parameter, no default
	local iRegionGrain = args.iRegionGrain or 1;
	local iRegionPlotFlags = args.iRegionPlotFlags or g_iFlags;
	local iRegionTerrainFlags = g_iFlags; -- Removed from args list.
	local iRegionFracXExp = args.iRegionFracXExp or 6;
	local iRegionFracYExp = args.iRegionFracYExp or 5;
	local iRiftGrain = args.iRiftGrain or -1;

	-- Init the land/water fractal
	local regionContinentsFrac;
	if(iRiftGrain > 0 and iRiftGrain < 4) then
		local riftsFrac = Fractal.Create(g_iW, g_iH, rift_grain, {}, iRegionFracXExp, iRegionFracYExp);
		regionContinentsFrac = Fractal.CreateRifts(g_iW, g_iH, iRegionGrain, iRegionPlotFlags, riftsFrac, iRegionFracXExp, iRegionFracYExp);
	else
		regionContinentsFrac = Fractal.Create(g_iW, g_iH, iRegionGrain, iRegionPlotFlags, iRegionFracXExp, iRegionFracYExp);	
	end
	--print("Initialized main fractal");
	local iWaterThreshold = regionContinentsFrac:GetHeight(iWaterPercent);

	-- Loop through the region's plots
	for x = 0, iRegionWidth - 1, 1 do
		for y = 0, iRegionHeight - 1, 1 do
			local i = y * iRegionWidth + x + 1; -- Lua arrays start at 1.
			
			local plot = Map.GetPlotByIndex(i - 1);
			local nPlot = plot:GetNearestLandPlot()
			local Distance = Map.GetPlotDistance(plot:GetX(),plot:GetY(), nPlot:GetX(), nPlot:GetY())
			
			local val = regionContinentsFrac:GetHeight(x,y);
			if val <= iWaterThreshold or Adjacent(i) == true then
				--do nothing
			elseif Distance >= 3 and plot:GetResourceType() == -1 and TerrainBuilder.CanHaveFeature(plot, g_FEATURE_ICE) == true then
				TerrainBuilder.SetFeatureType(plot, g_FEATURE_ICE);
				TerrainBuilder.AddIce(plot:GetIndex(), 0); 
			end
		end
	end
	AreaBuilder.Recalculate();
end

function AddMountain(plotTypes)
	local args = args or {};
	args.iWaterPercent = 94;
	args.iRegionWidth = math.ceil(g_iW);
	args.iRegionHeight = math.ceil(g_iH);
	args.iRegionWestX = math.floor(0);
	args.iRegionSouthY = math.floor(0);
	args.iRegionGrain = 5;
	args.iRegionHillsGrain = 6;
	args.iRegionPlotFlags = g_iFlags;
	args.iRegionFracXExp = 7;
	args.iRegionFracYExp = 6;


	-- Handle args or assign defaults.
	local iWaterPercent = args.iWaterPercent or 55;
	local iRegionWidth = args.iRegionWidth; -- Mandatory Parameter, no default
	local iRegionHeight = args.iRegionHeight; -- Mandatory Parameter, no default
	local iRegionWestX = args.iRegionWestX; -- Mandatory Parameter, no default
	local iRegionSouthY = args.iRegionSouthY; -- Mandatory Parameter, no default
	local iRegionGrain = args.iRegionGrain or 1;
	local iRegionPlotFlags = args.iRegionPlotFlags or g_iFlags;
	local iRegionTerrainFlags = g_iFlags; -- Removed from args list.
	local iRegionFracXExp = args.iRegionFracXExp or 6;
	local iRegionFracYExp = args.iRegionFracYExp or 5;
	local iRiftGrain = args.iRiftGrain or -1;

	-- Init the land/water fractal
	local regionContinentsFrac;
	if(iRiftGrain > 0 and iRiftGrain < 4) then
		local riftsFrac = Fractal.Create(g_iW, g_iH, rift_grain, {}, iRegionFracXExp, iRegionFracYExp);
		regionContinentsFrac = Fractal.CreateRifts(g_iW, g_iH, iRegionGrain, iRegionPlotFlags, riftsFrac, iRegionFracXExp, iRegionFracYExp);
	else
		regionContinentsFrac = Fractal.Create(g_iW, g_iH, iRegionGrain, iRegionPlotFlags, iRegionFracXExp, iRegionFracYExp);	
	end
	--print("Initialized main fractal");
	local iWaterThreshold = regionContinentsFrac:GetHeight(iWaterPercent);

	-- Loop through the region's plots
	for x = 0, iRegionWidth - 1, 1 do
		for y = 0, iRegionHeight - 1, 1 do
			local i = y * iRegionWidth + x + 1; -- Lua arrays start at 1.
			
			local plot = Map.GetPlotByIndex(i - 1);
			
			local val = regionContinentsFrac:GetHeight(x,y);
			if val >= iWaterThreshold and plotTypes[i] == g_PLOT_TYPE_LAND then
				plotTypes[i] = g_PLOT_TYPE_MOUNTAIN;
			end
		end
	end
	AreaBuilder.Recalculate();
end

function Remove_SouthSeaResource()
	for _, index in pairs(Remove_South_Sea_Resource_Plots) do
		local pPlot = Map.GetPlotByIndex(index);
		ResourceBuilder.SetResourceType(pPlot, -1);
	end
end