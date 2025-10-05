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
local HasGenerateContinents = false;

local RichNum;

-------------------------------------------------------------------------------
function BBS_Assign(args)
	print("地图：富饶南北出生点分配中")
	local start_plot_database = {};
	start_plot_database = BBS_AssignStartingPlots.Create(args)
	return start_plot_database
end
-------------------------------------------------------------------------------
function GenerateMap()
	print("地图：富饶南北开始生成");
	local pPlot;

	-- 全局设置
	--【温度】
	-- 温度将影响地图中草原和平原的比例
	g_iW, g_iH = Map.GetGridSize();
	g_iFlags = TerrainBuilder.GetFractalFlags();
	local temperature = MapConfiguration.GetValue("temperature");
	if temperature == 4 then
		temperature  =  1 + TerrainBuilder.GetRandomNumber(3, "Random Temperature- Lua");
	end
	
	--【纪元】
	-- 纪元将影响地图中丘陵和山脉的比例
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

	--【富饶系数】
	-- 富饶系数将综合影响地图中地貌/资源/大陆/自然奇观/开局补正
	RichNum = MapConfiguration.GetValue("RichNum") or 5;
	print("富饶系数", RichNum);

	--【海陆、地形】
	print("划分海陆");
	plotTypes = TeamPVPGeneratePlotTypes(world_age);
	terrainTypes = TeamPVPGenerateTerrainTypes(plotTypes, g_iW, g_iH, g_iFlags, true, temperature);
	ApplyBaseTerrain(plotTypes, terrainTypes, g_iW, g_iH);

	-- 分配大陆
	print("划分大陆板块");
	TeamPVPGenerateContinents(plotTypes);

	AreaBuilder.Recalculate();
	TerrainBuilder.AnalyzeChokepoints();

	--【丰富大陆边界地形】
	print("在板块交界处增加火山");
	local iContinentBoundaryPlots = GetContinentBoundaryPlotCount(g_iW, g_iH);
	TeamPVPAddTerrainFromContinents(plotTypes, terrainTypes, world_age, g_iW, g_iH, iContinentBoundaryPlots);
	AreaBuilder.Recalculate();
	TerrainBuilder.AnalyzeChokepoints();

	print("分析降雨量，增加地貌与河流");
	AddFeatures();
	
	print("增加悬崖");
	AddCliffs(plotTypes, terrainTypes);

	print("增加自然奇观");
	local nwGen = NaturalWonderGenerator.Create({
		numberToPlace = GameInfo.Maps[Map.GetMapSize()].NumNaturalWonders + RichNum/3,
	});

	print("增加大陆边界地貌");
	AddFeaturesFromContinents();
	DW_MarkCoastalLowlands();

	print("增加冰川");
	AddIceIsland()


	resourcesConfig = MapConfiguration.GetValue("resources");
	local startConfig = MapConfiguration.GetValue("start");-- Get the start config
	local resGen = BBS_ResourceGenerator.Create({
		resources = resourcesConfig,
		START_CONFIG = startConfig,
		plotTypes = plotTypes,
		RichNum = RichNum
	});

	print("分配出生点");
	local start_plot_database = BBS_Assign({
		MIN_MAJOR_CIV_FERTILITY = 150,
		MIN_MINOR_CIV_FERTILITY = 5,
		MIN_BARBARIAN_FERTILITY = 1,
		START_MIN_Y = 10,
		START_MAX_Y = 10,
		START_CONFIG = startConfig,
		WATER = false,
		LAND = false,
	})

	print("增加部落村庄");
	local GoodyGen = TPT_AddGoodies(g_iW, g_iH, {
		TilesPerGoody = 60 + RichNum * 5,
		GoodyRange = 5 - math.floor(RichNum/5)
	});

	print("地图平衡");
	local Balance = BBS_Script({
		RichNum= RichNum
	});
	AreaBuilder.Recalculate();
	TerrainBuilder.AnalyzeChokepoints();
	RichNSBalance();

	print("开始生成道路");
	DoRoute()
	AreaBuilder.Recalculate();
	TerrainBuilder.AnalyzeChokepoints();
	print("地图：富饶南北生成完毕");
end
-------------------------------------------------------------------------------
function RichNSBalance()
	-- 将无地貌、资源的丘陵变为平地
	for i = 0, g_iH - 1 do
		for j = 0, g_iW - 1 do
			local pPlot = Map.GetPlotByIndex(j * g_iH + i);
			if (pPlot:GetTerrainType() == 1 or pPlot:GetTerrainType() == 4) and pPlot:GetFeatureType() == -1 and pPlot:GetResourceType() == -1 then
				TerrainBuilder.SetTerrainType(pPlot, pPlot:GetTerrainType() - 1)
			end
			if pPlot:GetFeatureType() == g_FEATURE_VOLCANO then
				TerrainBuilder.SetFeatureType(pPlot, - 1)
				print ("Delete Volcano at (x, y): " .. i .. ", " .. j);
			end
		end
	end

	-- 如果富饶系数大于等于4，所有人都会有加成资源屁股
	-- 如果富饶系数大于等于7，所有人都会有奢侈品屁股
	if RichNum >= 4 then
		local ChooseResourceClass = 'RESOURCECLASS_BONUS'
		if RichNum >= 7 then
			ChooseResourceClass = 'RESOURCECLASS_LUXURY'
		end
		local Resource_ValidTerrainsTable = {}
		for row in GameInfo.Resource_ValidTerrains() do
			if GameInfo.Resources[row.ResourceType].ResourceClassType == ChooseResourceClass then
				if not Resource_ValidTerrainsTable[row.TerrainType] then
					Resource_ValidTerrainsTable[row.TerrainType] = {}
				end
				table.insert(Resource_ValidTerrainsTable[row.TerrainType],GameInfo.Resources[row.ResourceType].Index)
				print(row.ResourceType,GameInfo.Resources[row.ResourceType].Index,'已记录')
			end
		end
		local tempMajorList = PlayerManager.GetAliveMajorIDs();
		for i = 1, PlayerManager.GetAliveMajorsCount() do
			if (PlayerConfigurations[tempMajorList[i]]:GetLeaderTypeName() ~= "LEADER_SPECTATOR" and PlayerConfigurations[tempMajorList[i]]:GetHandicapTypeID() ~= 2021024770) then
				local pStartPlot_i = Players[tempMajorList[i]]:GetStartingPlot()
				if (pStartPlot_i ~= nil and pStartPlot_i:IsWater() == false) then
					local TerrainType = GameInfo.Terrains[pStartPlot_i:GetTerrainType()].TerrainType
					-- 先看一下玩家大陆的奢侈
					local flag = false;
					local Plots = Map.GetContinentPlots(pStartPlot_i:GetContinentType());
					if (Resource_ValidTerrainsTable[TerrainType] and #Resource_ValidTerrainsTable[TerrainType]>0) then
						for _,eResource in ipairs(Resource_ValidTerrainsTable[TerrainType]) do
							local iPlot = PlotsHasResource(eResource,Plots)
							if iPlot > 0 and ResourceBuilder.CanHaveResource(pStartPlot_i,eResource) then
								-- 这就好办了
								ResourceBuilder.SetResourceType(pStartPlot_i,eResource,1);
								flag = true;
								break;
							end
						end
						if not flag then
							for _,eResource in ipairs(Resource_ValidTerrainsTable[TerrainType]) do
								local iPlot = RichNSMapHasResource(eResource)
								if iPlot > 0 and ResourceBuilder.CanHaveResource(pStartPlot_i,eResource) then
									ResourceBuilder.SetResourceType(pStartPlot_i,eResource,1);
									flag = true;
									break;
								end
							end
						end
					end
					-- 到这里还不能保底那我也没招了
				end
			end
		end
	end

	-- 修正：RichNum * RichNum/200的沙漠变为沙漠丘陵
	-- 修正：RichNum * RichNum/200的沙漠丘陵变为铜
	-- 修正：RichNum * RichNum/100的石头将变为丘陵
	-- 修正：RichNum * RichNum/150的空雨林将变为香蕉
	-- 修正：RichNum * RichNum/150的空沼泽将变为大米
	-- 修正：RichNum * RichNum/200的空树林将变为鹿
	-- 修正：RichNum * RichNum/400的空地将变为地脉
	-- 修正：RichNum * RichNum/300的绿地将变为牛
	-- 修正：RichNum * RichNum/300的鱼将变为礁石
	-- 修正：RichNum * RichNum/300的沙漠将变为绿洲
	local CanHaveLeyLine = false
	local CanHaveLeyLineIndex;
	if GameInfo.Resources['RESOURCE_LEY_LINE'] and GameInfo.Resources['RESOURCE_LEY_LINE'].Index ~= nil then
		CanHaveLeyLine = true
		CanHaveLeyLineIndex = GameInfo.Resources['RESOURCE_LEY_LINE'].Index
	end
	if RichNum > 0 then
		for i = 0, g_iH - 1 do
			for j = 0, g_iW - 1 do
				local pPlot = Map.GetPlotByIndex(j * g_iH + i);
				if (pPlot:GetTerrainType() == 0 or pPlot:GetTerrainType() == 3) and pPlot:GetResourceType() == 8 and TerrainBuilder.GetRandomNumber(100, "Resource Placement Score Adjust") < RichNum * RichNum then
					TerrainBuilder.SetTerrainType(pPlot, pPlot:GetTerrainType() + 1)
				end
				if (pPlot:GetTerrainType() == 6) and pPlot:GetResourceType() == -1 and pPlot:GetFeatureType() == -1 and TerrainBuilder.GetRandomNumber(200, "Resource Placement Score Adjust") < RichNum * RichNum then
					TerrainBuilder.SetTerrainType(pPlot, 7)
				end
				if (pPlot:GetTerrainType() == 7) and pPlot:GetResourceType() == -1 and TerrainBuilder.GetRandomNumber(200, "Resource Placement Score Adjust") < RichNum * RichNum then
					ResourceBuilder.SetResourceType(pPlot,2,1);
				end
				if pPlot:GetFeatureType() == g_FEATURE_JUNGLE and pPlot:GetResourceType() == -1 and TerrainBuilder.GetRandomNumber(150, "Resource Placement Score Adjust") < RichNum * RichNum then
					ResourceBuilder.SetResourceType(pPlot,0,1);
				end
				if pPlot:GetFeatureType() == g_FEATURE_MARSH and pPlot:GetResourceType() == -1 and TerrainBuilder.GetRandomNumber(150, "Resource Placement Score Adjust") < RichNum * RichNum then
					ResourceBuilder.SetResourceType(pPlot,6,1);
				end
				if pPlot:GetFeatureType() == -1 and pPlot:GetTerrainType() == 0 and pPlot:GetResourceType() == -1 and TerrainBuilder.GetRandomNumber(300, "Resource Placement Score Adjust") < RichNum * RichNum then
					ResourceBuilder.SetResourceType(pPlot,1,1);
				end
				if pPlot:GetFeatureType() == -1 and pPlot:GetResourceType() == 5 and TerrainBuilder.GetRandomNumber(300, "Resource Placement Score Adjust") < RichNum * RichNum then
					TerrainBuilder.SetFeatureType(pPlot, 28)
				end
				if pPlot:GetFeatureType() == g_FEATURE_FOREST and pPlot:GetResourceType() == -1 and TerrainBuilder.GetRandomNumber(200, "Resource Placement Score Adjust") < RichNum * RichNum then
					ResourceBuilder.SetResourceType(pPlot,4,1);
				end
				if CanHaveLeyLine and (pPlot:GetTerrainType() == 0 or pPlot:GetTerrainType() == 3) and pPlot:GetResourceType() == -1 and pPlot:GetFeatureType() == -1 and TerrainBuilder.GetRandomNumber(2000, "Resource Placement Score Adjust") < RichNum * RichNum * RichNum then
					ResourceBuilder.SetResourceType(pPlot,CanHaveLeyLineIndex,1);
				end
			end
		end
	end

end
-------------------------------------------------------------------------------
function PlotsHasResource(iResources,Plots)
    for  i, plot in ipairs(Plots) do
		local pPlot = Map.GetPlotByIndex(plot);
        if pPlot:GetResourceType() == iResources then
            return i
        end
    end
    return -1
end

-------------------------------------------------------------------------------

function RichNSMapHasResource(iResources)
    local iW, iH = Map.GetGridSize();
    for k = 0, iH * iW - 1 do
        local pPlot = Map.GetPlotByIndex(k);
        if pPlot:GetResourceType() == iResources then
            return k
        end
    end
    return -1
end
-------------------------------------------------------------------------------
function TeamPVPGenerateContinents(plotTypes)
	local iTeamPlacement = MapConfiguration.GetValue("BBS_Team_Spawn") or 0
	if iTeamPlacement == 0 then
		TerrainBuilder.StampContinents();
		HasGenerateContinents = true
	end
	if HasGenerateContinents then
		AreaBuilder.Recalculate();
		TerrainBuilder.AnalyzeChokepoints();
		return;
	end
	-- 初始大陆
	local iNumContinents = #GameInfo.Continents;
	local iContinent = TerrainBuilder.GetRandomNumber(iNumContinents, "Continent");
	local MapContinentsNum = GameInfo.Maps[Map.GetMapSize()].Continents + math.floor(RichNum/3) - 1
	-- 陆地总数
	local Lands  = 0;
	for i = 0, (g_iW * g_iH) - 1, 1 do
		if plotTypes[i] == g_PLOT_TYPE_LAND then
			Lands = Lands + 1
		end
	end
	-- 大陆平均陆地数
	local LandsAvg = math.ceil(Lands/MapContinentsNum)
	-- 将两侧的陆地分配到同一个大陆
	local HasGetTypePlot = math.floor(LandsAvg / 2);
	-- 东西
	if iTeamPlacement == 1 then
		for i = 0, g_iH - 1 do
			for j = 0, g_iW - 1 do
				if plotTypes[i * g_iW + j] == g_PLOT_TYPE_LAND then
					TerrainBuilder.SetContinentType(Map.GetPlotByIndex(i * g_iW + j), (iContinent + math.floor((HasGetTypePlot % Lands)/LandsAvg)) % iNumContinents);
					HasGetTypePlot = HasGetTypePlot + 1
				else
					TerrainBuilder.SetContinentType(Map.GetPlotByIndex(i * g_iW + j), (iContinent + math.floor((HasGetTypePlot % Lands)/LandsAvg)) % iNumContinents);
				end
			end
		end
	-- 南北
	elseif iTeamPlacement == 2 then
		for j = 0, g_iW - 1 do
			for i = 0, g_iH - 1 do
				if plotTypes[i * g_iW + j] == g_PLOT_TYPE_LAND then
					TerrainBuilder.SetContinentType(Map.GetPlotByIndex(i * g_iW + j), (iContinent + math.floor((HasGetTypePlot % Lands)/LandsAvg)) % iNumContinents);
					HasGetTypePlot = HasGetTypePlot + 1
				else
					TerrainBuilder.SetContinentType(Map.GetPlotByIndex(i * g_iW + j), (iContinent + math.floor((HasGetTypePlot % Lands)/LandsAvg)) % iNumContinents);
				end
			end
		end
	end
	HasGenerateContinents = true
end

-------------------------------------------------------------------------------
function TeamPVPGeneratePlotTypes(world_age)
	plotTypes = table.fill(g_PLOT_TYPE_LAND, g_iW * g_iH);
	
	-- 大陆主体
	local variationFrac1 = Fractal.Create(g_iW, g_iH, 3, g_iFlags, -1, -1);
	local variationFrac2 = Fractal.Create(g_iW, g_iH, 3, g_iFlags, -1, -1);
	
	local Land_boundary = 8		-- 大陆距离地图边缘的距离
	local fjord_rate = 0.1		-- 峡湾深度
	
	
	local Land_fjord = 	Land_boundary + ((g_iW / 2) - Land_boundary) * fjord_rate		-- 边缘崎岖修饰范围
	local Landlatitude = (1 - (Land_boundary / (g_iW * 0.5))) ^ 2 / 2;
	local Land_fjord_latitude = (1 - (Land_fjord / (g_iW * 0.5))) ^ 2 / 2
	
	-- 峡湾修饰
	local water_percent = 55;
	InitFractal{continent_grain = 4, rift_grain = 5, false, false};
	iWaterThreshold = g_continentsFrac:GetHeight(water_percent);
	
	-- 生成大陆主体
	for y = 0, g_iH -1 do
		for x = 0, g_iW - 1 do
			local i = y * g_iW + x
			local pPlot = Map.GetPlotByIndex(i);
			local lat = (GetLatitudeAtPlot(variationFrac1, x, y) ^ 2 + GetLatitudeAtPlot(variationFrac2, y, x) ^ 2) / 2;
			if lat >= Landlatitude then
				plotTypes[i] = g_PLOT_TYPE_OCEAN;
				TerrainBuilder.SetTerrainType(pPlot, g_TERRAIN_TYPE_OCEAN);		
			end
			-- 修饰大陆边缘，生成峡湾
			local val = g_continentsFrac:GetHeight(x, y);
			if lat >= Land_fjord_latitude and val <= iWaterThreshold then
				plotTypes[i] = g_PLOT_TYPE_OCEAN;
				TerrainBuilder.SetTerrainType(pPlot, g_TERRAIN_TYPE_OCEAN);
			end
		end
	end

	AreaBuilder.Recalculate();
	-- 填海
	local biggest_ocean = Areas.FindBiggestArea(true);
	for y = 0, g_iH -1 do
		for x = 0, g_iW - 1 do
			local i = y * g_iW + x
			local pPlot = Map.GetPlotByIndex(i);
			if(plotTypes[i] == g_PLOT_TYPE_OCEAN and pPlot:GetArea() ~= biggest_ocean) then
				plotTypes[i] = g_PLOT_TYPE_LAND;
			end
		end
	end
	
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
	plotTypes = ApplyTectonics(args, plotTypes);
	plotTypes = AddLonelyMountains(plotTypes, mountainRatio);

	-- 705: Found a good map, now we can loop through every tile and add additional details
	print("添加丘陵");
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
			
			-- 705: 详细的丘陵和山脉通过，盘古大陆版本创建较少的丘陵
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
				if(hillCount < rChance - 2 and plotTypes[i] == g_PLOT_TYPE_LAND) then
					plotTypes[i] = g_PLOT_TYPE_HILLS;
					hillsAdded = hillsAdded + 2;
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


	-- 重新划分大陆

	
	-- 705: Flip the map?
	
	local flipMap = DetermineFlip(plotTypes);
	-- todo：检查极地以确定我们是否需要翻转
	
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
	local rift_grain = args.rift_grain or -1;
	-- Default no rifts. Set grain to between 1 and 3 to add rifts. - Bob
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
	print("增加地貌");
	-- 获取降雨量设置
	local rainfall = MapConfiguration.GetValue("rainfall");
	if rainfall == 4 then
		rainfall = 1 + TerrainBuilder.GetRandomNumber(3, "Random Rainfall - Lua");
	end
	
	-- 河流的形成受地块类型的影响，发源于高地，更倾向于流经低地。
	-- 705：将降雨考虑在内的自定义河流方法
	AddRivers({
		rainfall = rainfall + 1;
	});

	local args = {};
	args.rainfall = rainfall;
	
	-- 湖泊会干扰河流，导致河流停止，如果再早一点建起来，就无法流入海洋。
	local numLargeLakes = GameInfo.Maps[Map.GetMapSize()].Continents;
	-- 705：通过降雨调整大湖
	numLargeLakes = numLargeLakes + rainfall - 4;

	-- 不添加湖泊
	-- AddLakes(numLargeLakes);

	-- 雨林比例
	args.iJunglePercent = 18 + RichNum;
	-- 森林比例
	args.iForestPercent = 16 + RichNum * 1.5;
	-- 沼泽比例
	args.iMarshPercent = 4 - RichNum / 3;
	-- 绿洲比例
	args.iOasisPercent = 1;
	-- 礁石比例
	args.iReefPercent = 8 + RichNum / 1.5;
	
	featuregen = DW_FeatureGenerator.Create(args);
	featuregen:AddFeatures(true, true, {
		RichNum = RichNum
	});
end

function AddFeaturesFromContinents()
	print("为大陆边界增加地貌");
	featuregen:AddFeaturesFromContinents({
		FissuresMultyDesired = 1 + RichNum/10
	});
end

-------------------------------------------------------------------------------
function GenerateWaterLayer (args, plotTypes)
	-- 这个功能的目的是允许将海洋添加到大型大陆的特定区域。
	local args = args or {};
	
	-- 处理参数或分配默认值。
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
	-- 705: 看看我们是否需要翻转地图，把大部分的土地放在地图的北部边缘，使它看起来更像地球，这将使地图感觉更自然

	local g_iW, g_iH = Map.GetGridSize();

	-- 首先循环通过地图行并在每一行中记录地块
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
	--[[ 这个函数打算与ApplyTectonics配对。如果所有的山和
	--山脉地块将被大地构造所覆盖，那么为什么要浪费呢
	--产生它们的计算？ ]]--
	args = args or {};
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
	-- =====================================================================
	local Land_boundary = 8		-- 大陆距离地图边缘的距离

	local iTundra_rate = 0.40
	local iTundra_width = 10
	local iTundra_Balanced = 0.4
	
	local t_Tundra_rate_base = (((g_iH / 2) - Land_boundary) * iTundra_rate + Land_boundary) * 2 / g_iH
	local t_Tundra_width = (Land_boundary + iTundra_width) * 2 / g_iH
	
	local iDesertPercent = 5;
	local iPlainsPercent = 50; 
	local fSnowLatitude  = 1 + coldShift;
	local fTundraLatitude = fSnowLatitude
	local fGrassLatitude = 0.1; 
	local fDesertBottomLatitude = 0.1;
	local fDesertTopLatitude = 0.35;

	if temperature > 2.5 then
		iDesertPercent = iDesertPercent - desert_shift;
		fTundraLatitude = fTundraLatitude - (temperature_shift * 1.5);
		iPlainsPercent = iPlainsPercent + plains_shift;
		fDesertTopLatitude = fDesertTopLatitude - temperature_shift;
		fGrassLatitude = fGrassLatitude - (temperature_shift * 0.5);
	elseif temperature < 1.5 then
		iDesertPercent = iDesertPercent + desert_shift;
		fSnowLatitude  = fSnowLatitude + (temperature_shift * 0.5);
		fTundraLatitude = fTundraLatitude + temperature_shift;
		fDesertTopLatitude = fDesertTopLatitude + temperature_shift;
		fGrassLatitude = fGrassLatitude - (temperature_shift * 0.5);
		iPlainsPercent = iPlainsPercent + plains_shift;
	else
	end
	print("TeamPVP fTundraLatitude:",fTundraLatitude);

    iDesertPercent = iDesertPercent * 0.6;
	local iDesertTopPercent		= 100;
	local iDesertBottomPercent	= math.max(0, math.floor(100-iDesertPercent));
	local iPlainsTopPercent		= 100;
	local iPlainsBottomPercent	= math.max(0, math.floor(100-iPlainsPercent));

	print("-"); print("DW- Desert Percentage:", iDesertPercent);
	print("--- Latitude Readout ---");
	print("- All Grass End Latitude:", fGrassLatitude);
	print("- Desert Start Latitude:", fDesertBottomLatitude);
	print("- Desert End Latitude:", fDesertTopLatitude);
	print("- Tundra Start Latitude:", fTundraLatitude);
	print("- Snow Start Latitude:", fSnowLatitude);
	print("- - - - - - - - - - - - - -");

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
	
	grain_amount = 4;
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

	for iX = 0, iW - 1 do
		for iY = 0, iH - 1 do
			local index = (iY * iW) + iX;
			local lat = GetLatitudeAtPlot(variationFrac, iX, iY);

			if (plotTypes[index] == g_PLOT_TYPE_MOUNTAIN) then
			    terrainTypes[index] = g_TERRAIN_TYPE_GRASS_MOUNTAIN;

			    -- 地图整体偏下，北极应有更多冻土
				-- 冻毛线 删了删了全删了
			    local teampfTundraLatitude=fTundraLatitude;

				if(lat >= fSnowLatitude) then
					terrainTypes[index] = g_TERRAIN_TYPE_TUNDRA_MOUNTAIN;
				elseif(lat >= teampfTundraLatitude) then
					terrainTypes[index] = g_TERRAIN_TYPE_TUNDRA_MOUNTAIN;
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

				local teampfTundraLatitude=fTundraLatitude;
				if(lat >= fSnowLatitude) then
					terrainTypes[index] = g_TERRAIN_TYPE_TUNDRA;
				elseif(lat >= teampfTundraLatitude) then
					terrainTypes[index] = g_TERRAIN_TYPE_TUNDRA;
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

	print("添加草原、沙漠过渡区");
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
   
	print("添加大陆架");
	for iI = 0, 2 do
		local shallowWaterPlots = {};
		for iX = 0, iW - 1 do
			for iY = 0, iH - 1 do
				local index = (iY * iW) + iX;
				if (terrainTypes[index] == g_TERRAIN_TYPE_OCEAN) then
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
	-- 在大陆边界处增加火山
	local iMountainPercentByDistance = {42, 24, 6}; 
	local iHillPercentByDistance = {50, 40, 30}; 
	local aLonelyMountainIndices = {};
	local iVolcanoesPlaced = 0;

	-- 计算火山数量
	local iTotalLandPlots = 0;
	for iX = 0, iW - 1 do
		for iY = 0, iH - 1 do
			local index = (iY * iW) + iX;
			if (plotTypes[index] ~= g_PLOT_TYPE_OCEAN) then
				iTotalLandPlots = iTotalLandPlots + 1;
			end
		end
	end

	-- 平均每(iDivisor * 150)个陆地单元格分配一个火山
	local iDivisor = 8;
	if (world_age < 8) then
		iDivisor = 8 - world_age;
	end
	local iDesiredVolcanoes = iTotalLandPlots / (iDivisor * 150);
	print ("预计火山数量: " .. iDesiredVolcanoes);

	-- 2/3rds of Earth's volcanoes are near continent boundaries
	print ("大陆边界单元格数量: " .. iContinentBoundaryPlots);
	local iDesiredNearBoundaries = iDesiredVolcanoes * 2 / 3;

	if (iDesiredNearBoundaries > 0) then
		local iBoundaryPlotsPerVolcano = iContinentBoundaryPlots / iDesiredNearBoundaries;

		-- 密度不能少于每50个单元格一个
		if (iBoundaryPlotsPerVolcano < 50) then
			iBoundaryPlotsPerVolcano = 50;
		end
		print ("Boundary Plots Per Volcano: " .. iBoundaryPlotsPerVolcano);

		for iX = 0, iW - 1 do
			for iY = 0, iH - 1 do
				local index = (iY * iW) + iX;
				if (plotTypes[index] ~= g_PLOT_TYPE_OCEAN) then
					local pPlot = Map.GetPlotByIndex(index);
					local iPlotsFromBoundary = -1;
					local bVolcanoHere = false;
					-- 705: 现在，块状火山正在沙漠上形成
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
	args.iWaterPercent = 75;
	args.iRegionWidth = math.ceil(g_iW);
	args.iRegionHeight = math.ceil(g_iH);
	args.iRegionWestX = math.floor(0);
	args.iRegionSouthY = math.floor(0);
	args.iRegionGrain = 5;
	args.iRegionHillsGrain = 4;
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
			elseif Distance >= 5 then
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









