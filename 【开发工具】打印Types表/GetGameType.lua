-- BetterBarbarian
-- Author: QIANCHUANBAILANG
-- DateCreated: 2025-8-22 10:04:33
--------------------------------------------------------------
function DebugAllType()
    print("DebugAllType Initialization", os.date("%c"))
    print('==============Civilizations')
    for row in GameInfo.Civilizations() do
        if row.Name and row.Name ~= Locale.Lookup( row.Name ) then
            print(row.CivilizationType..'\t'.. Locale.Lookup( row.Name )..'\t'..Locale.Lookup(row.Description or 'NULL'))
        end
    end
    print('==============Leaders')
    for row in GameInfo.Leaders() do
        if row.Name and row.Name ~= Locale.Lookup( row.Name ) then
            print(row.LeaderType..'\t'.. Locale.Lookup( row.Name )..'\t'..Locale.Lookup(row.Description or 'NULL'))
        end
    end
    print('==============Traits')
    for row in GameInfo.Traits() do
        if row.Name and row.Name ~= Locale.Lookup( row.Name ) then
            print(row.TraitType..'\t'.. Locale.Lookup( row.Name )..'\t'..Locale.Lookup(row.Description or 'NULL'))
        end
    end
    print('==============Districts')
    for row in GameInfo.Districts() do
        if row.Name and row.Name ~= Locale.Lookup( row.Name ) then
            print(row.DistrictType..'\t'.. Locale.Lookup( row.Name )..'\t'..Locale.Lookup(row.Description or 'NULL'))
        end
    end
    print('==============Buildings')
    for row in GameInfo.Buildings() do

        if row.Name and row.Name ~= Locale.Lookup( row.Name ) then
            print(row.BuildingType..'\t'.. Locale.Lookup( row.Name )..'\t'..Locale.Lookup(row.Description or 'NULL'))
        end
    end
    print('==============Improvements')
    for row in GameInfo.Improvements() do

        if row.Name and row.Name ~= Locale.Lookup( row.Name ) then
            print(row.ImprovementType..'\t'.. Locale.Lookup( row.Name )..'\t'..Locale.Lookup(row.Description or 'NULL'))
        end
    end
    print('==============Units')
    for row in GameInfo.Units() do

        if row.Name and row.Name ~= Locale.Lookup( row.Name ) then
            print(row.UnitType..'\t'.. Locale.Lookup( row.Name )..'\t'..Locale.Lookup(row.Description or 'NULL'))
        end
    end
    print('==============Belief')
    for row in GameInfo.Beliefs() do

        if row.Name and row.Name ~= Locale.Lookup( row.Name ) then
            print(row.BeliefType..'\t'.. Locale.Lookup( row.Name )..'\t'..Locale.Lookup(row.Description or 'NULL'))
        end
    end
    print('==============Civics')
    for row in GameInfo.Civics() do

        if row.Name and row.Name ~= Locale.Lookup( row.Name ) then
            print(row.CivicType..'\t'.. Locale.Lookup( row.Name )..'\t'..Locale.Lookup(row.Description or 'NULL'))
        end
    end
    print('==============Technologies')
    for row in GameInfo.Technologies() do

        if row.Name and row.Name ~= Locale.Lookup( row.Name ) then
            print(row.TechnologyType..'\t'.. Locale.Lookup( row.Name )..'\t'..Locale.Lookup(row.Description or 'NULL'))
        end
    end
    print('==============Features')
    for row in GameInfo.Features() do

        if row.Name and row.Name ~= Locale.Lookup( row.Name ) then
            print(row.FeatureType..'\t'.. Locale.Lookup( row.Name )..'\t'..Locale.Lookup(row.Description or 'NULL'))
        end
    end
    print('==============GovernorPromotions')
    for row in GameInfo.GovernorPromotions() do
        if row.Name and row.Name ~= Locale.Lookup( row.Name ) then
            print(row.GovernorPromotionType..'\t'.. Locale.Lookup( row.Name )..'\t'..Locale.Lookup(row.Description or 'NULL'))
        end
    end
    print('==============GreatPersonIndividuals')
    for row in GameInfo.GreatPersonIndividuals() do
        if row.Name and row.Name ~= Locale.Lookup( row.Name ) then
            print(row.GreatPersonIndividualType..'\t'.. Locale.Lookup( row.Name )..'\t'..Locale.Lookup(row.ActionEffectTextOverride or 'NULL'))
        end
    end
    print('==============Policies')
    for row in GameInfo.Policies() do
        if row.Name and row.Name ~= Locale.Lookup( row.Name ) then
            print(row.PolicyType..'\t'.. Locale.Lookup( row.Name )..'\t'..Locale.Lookup(row.Description or 'NULL'))
        end
    end
    print('==============Projects')
    for row in GameInfo.Projects() do
        if row.Name and row.Name ~= Locale.Lookup( row.Name ) then
            print(row.ProjectType..'\t'.. Locale.Lookup( row.Name )..'\t'..Locale.Lookup(row.Description or 'NULL'))
        end
    end
    print("DebugAllType Initialization Compelete.", os.date("%c"))

    local g_iW, g_iH = Map.GetGridSize();
	for i = 0, g_iH - 1 do
		for j = 0, g_iW - 1 do
			local pPlot = Map.GetPlotByIndex(j * g_iH + i);
			if (pPlot:GetTerrainType() >= 0 and pPlot:GetTerrainType() < 6) and (not pPlot:IsImpassable() ) and Map.GetPlotDistance(pPlot:GetX(), pPlot:GetY(), Map.GetPlotByIndex(1974):GetX(), Map.GetPlotByIndex(1974):GetY()) > 12 then
				print ("('{7d0ac0f8-402b-4a9b-8073-ae85f1679659}Arrival.Civ6Map'," .. pPlot:GetIndex() .. ",'RANDOM_MAJOR'),");
			end
		end
	end
end

Events.LoadScreenClose.Add(DebugAllType);