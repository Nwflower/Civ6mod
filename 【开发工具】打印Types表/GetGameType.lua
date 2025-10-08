-- BetterBarbarian
-- Author: QIANCHUANBAILANG
-- DateCreated: 2025-8-22 10:04:33
--------------------------------------------------------------
function DebugAllType()
    print("DebugAllType Initialization", os.date("%c"))
    print('==============Civilizations')
    for row in GameInfo.Civilizations() do
        if row.Name and row.Name ~= Locale.Lookup( row.Name ) and row.StartingCivilizationLevelType=='CIVILIZATION_LEVEL_FULL_CIV' then
            print(row.CivilizationType..'\t'.. Locale.Lookup( row.Name )..'\t'..Locale.Lookup(row.Description or 'NULL'))
        end
    end
    print('==============CityState')
    for row in GameInfo.Civilizations() do
        if row.Name and row.Name ~= Locale.Lookup( row.Name ) and row.StartingCivilizationLevelType=='CIVILIZATION_LEVEL_CITY_STATE' then
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
        if row.Name and row.Name ~= Locale.Lookup( row.Name ) and row.TraitType == nil then
            print(row.DistrictType..'\t'.. Locale.Lookup( row.Name )..'\t'..Locale.Lookup(row.Description or 'NULL'))
        end
    end
    for row in GameInfo.Districts() do
        if row.Name and row.Name ~= Locale.Lookup( row.Name ) and row.TraitType ~= nil then
            print(row.DistrictType..'\t'.. Locale.Lookup( row.Name )..'\t'..Locale.Lookup(row.Description or 'NULL'))
        end
    end
    print('==============Buildings')
    for row in GameInfo.Buildings() do
        if row.Name and row.Name ~= Locale.Lookup( row.Name ) and row.TraitType == nil then
            print(row.BuildingType..'\t'.. Locale.Lookup( row.Name )..'\t'..Locale.Lookup(row.Description or 'NULL'))
        end
    end
    for row in GameInfo.Buildings() do
        if row.Name and row.Name ~= Locale.Lookup( row.Name ) and row.TraitType ~= nil then
            print(row.BuildingType..'\t'.. Locale.Lookup( row.Name )..'\t'..Locale.Lookup(row.Description or 'NULL'))
        end
    end
    print('==============Improvements')
    for row in GameInfo.Improvements() do
        if row.Name and row.Name ~= Locale.Lookup( row.Name ) and row.TraitType == nil then
            print(row.ImprovementType..'\t'.. Locale.Lookup( row.Name )..'\t'..Locale.Lookup(row.Description or 'NULL'))
        end
    end
    for row in GameInfo.Improvements() do
        if row.Name and row.Name ~= Locale.Lookup( row.Name ) and row.TraitType ~= nil then
            print(row.ImprovementType..'\t'.. Locale.Lookup( row.Name )..'\t'..Locale.Lookup(row.Description or 'NULL'))
        end
    end
    print('==============Units')
    for row in GameInfo.Units() do
        if row.Name and row.Name ~= Locale.Lookup( row.Name ) and row.TraitType == nil then
            print(row.UnitType..'\t'.. Locale.Lookup( row.Name )..'\t'..Locale.Lookup(row.Description or 'NULL'))
        end
    end
    for row in GameInfo.Units() do
        if row.Name and row.Name ~= Locale.Lookup( row.Name ) and row.TraitType ~= nil then
            print(row.UnitType..'\t'.. Locale.Lookup( row.Name )..'\t'..Locale.Lookup(row.Description or 'NULL'))
        end
    end
    print('==============Belief')
    for row in GameInfo.Beliefs() do

        if row.Name and row.Name ~= Locale.Lookup( row.Name ) then
            print(row.BeliefType..'\t'.. Locale.Lookup( row.Name )..'\t'..Locale.Lookup(row.Description or 'NULL'))
        end
    end
    print('==============Technologies')
    for row in GameInfo.Technologies() do

        if row.Name and row.Name ~= Locale.Lookup( row.Name ) then
            print(row.TechnologyType..'\t'.. Locale.Lookup( row.Name )..'\t'..Locale.Lookup(row.Description or 'NULL'))
        end
    end
    print('==============Civics')
    for row in GameInfo.Civics() do

        if row.Name and row.Name ~= Locale.Lookup( row.Name ) then
            print(row.CivicType..'\t'.. Locale.Lookup( row.Name )..'\t'..Locale.Lookup(row.Description or 'NULL'))
        end
    end
    print('==============Agendas')
    for row in GameInfo.Agendas() do
        if row.Name and row.Name ~= Locale.Lookup( row.Name ) then
            print(row.AgendaType..'\t'.. Locale.Lookup( row.Name )..'\t'..Locale.Lookup(row.Description or 'NULL'))
        end
    end
    print('==============TechnologyBoost')
    for row in GameInfo.Boosts() do
        if row.TechnologyType and row.TriggerLongDescription and row.TriggerLongDescription ~= Locale.Lookup( row.TriggerLongDescription ) then
            print(row.BoostID..'\t'.. Locale.Lookup( GameInfo.Technologies[row.TechnologyType].Name )..'尤里卡'..'\t'..Locale.Lookup(row.TriggerLongDescription or 'NULL'))
        end
    end
    print('==============CivicBoost')
    for row in GameInfo.Boosts() do
        if row.CivicType and row.TriggerLongDescription and row.TriggerLongDescription ~= Locale.Lookup( row.TriggerLongDescription ) then
            print(row.BoostID..'\t'.. Locale.Lookup( GameInfo.Civics[row.CivicType].Name )..'鼓舞'..'\t'..Locale.Lookup(row.TriggerLongDescription or 'NULL'))
        end
    end
    print('==============CityName')
    for row in GameInfo.CityNames() do
        if row.CityName and row.CityName ~= Locale.Lookup( row.CityName ) then
            print(row.CityName..'\t'.. Locale.Lookup( GameInfo.Civilizations[row.CivilizationType].Name )..'\t'..Locale.Lookup(row.CityName or 'NULL'))
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
            print(row.GreatPersonIndividualType..'\t'.. Locale.Lookup( row.Name )..'\t'.. Locale.Lookup( GameInfo.Eras[row.EraType].Name )..'\t'..Locale.Lookup(row.ActionEffectTextOverride or 'NULL'))
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
    print('==============Resource')
    for row in GameInfo.Resources() do
        if row.Name and row.Name ~= Locale.Lookup( row.Name ) then
            print(row.ResourceType..'\t'.. Locale.Lookup( row.Name )..'\t'..Locale.Lookup('LOC_PEDIA_'..string.gsub(row.ResourceClassType,'RESOURCECLASS_','RESOURCES_PAGEGROUP_') .. '_NAME'))
        end
    end
    print('==============Terrain')
    for row in GameInfo.Terrains() do
        if row.Name and row.Name ~= Locale.Lookup( row.Name ) then
            print(row.TerrainType..'\t'.. Locale.Lookup( row.Name ))
        end
    end
    print('==============UnitAbilities')
    for row in GameInfo.UnitAbilities() do
        if row.Name and row.Name ~= Locale.Lookup( row.Name ) then
            local UnitAbilityName = Locale.Lookup( row.Name )
            if UnitAbilityName == Locale.Lookup( row.Description ) then
                UnitAbilityName = 'NULL'
            end
            print(row.UnitAbilityType..'\t'.. Locale.Lookup( row.Name )..'\t'.. Locale.Lookup( row.Description ))
        end
    end
    print('==============UnitOperations')
    for row in GameInfo.UnitOperations() do
        if row.Description and row.Description ~= Locale.Lookup( row.Description ) then
            print(row.OperationType..'\t'.. Locale.Lookup( row.Description ))
        end
    end
    print('==============UnitPromotions')
    for row in GameInfo.UnitPromotions() do
        if row.Name and row.Name ~= Locale.Lookup( row.Name ) then
            print(row.UnitPromotionType..'\t'.. Locale.Lookup( row.Name )..'\t'.. Locale.Lookup( row.Description ))
        end
    end
    print('==============Leaders And Civilizations')
    for LCRow in GameInfo.CivilizationLeaders() do
        local TraitTypes = {}
        if GameInfo.Civilizations[LCRow.CivilizationType].StartingCivilizationLevelType == 'CIVILIZATION_LEVEL_FULL_CIV' then
            for TraitRow in GameInfo.LeaderTraits() do
                if TraitRow.LeaderType == LCRow.LeaderType then
                    table.insert(TraitTypes, TraitRow.TraitType)
                end
            end
            for TraitRow in GameInfo.CivilizationTraits() do
                if TraitRow.CivilizationType == LCRow.CivilizationType then
                    table.insert(TraitTypes, TraitRow.TraitType)
                end
            end
            print('\n')
            print(LCRow.CivilizationType..'\t'.. Locale.Lookup( GameInfo.Civilizations[LCRow.CivilizationType].Name )..'\n'..LCRow.LeaderType..'\t'.. Locale.Lookup( GameInfo.Leaders[LCRow.LeaderType].Name ))
            for _,TraitType in ipairs(TraitTypes) do
                local b_TraitTypeHasUsed = false
                for row in GameInfo.Districts() do
                    if row.Name and row.Name ~= Locale.Lookup( row.Name ) and row.TraitType == TraitType then
                        local Description = Locale.Lookup(row.Description or GameInfo.Traits[TraitType].Description or 'NULL')
                        print(row.DistrictType..'\t'.. Locale.Lookup( row.Name )..'\t'..Description)
                        b_TraitTypeHasUsed = true
                    end
                end
                for row in GameInfo.Buildings() do
                    if row.Name and row.Name ~= Locale.Lookup( row.Name ) and row.TraitType == TraitType then
                        local Description = Locale.Lookup(row.Description or GameInfo.Traits[TraitType].Description or 'NULL')
                        print(row.BuildingType..'\t'.. Locale.Lookup( row.Name )..'\t'..Description)
                        b_TraitTypeHasUsed = true
                    end
                end
                for row in GameInfo.Improvements() do
                    if row.Name and row.Name ~= Locale.Lookup( row.Name ) and row.TraitType == TraitType then
                        local Description = Locale.Lookup(row.Description or GameInfo.Traits[TraitType].Description or 'NULL')
                        print(row.ImprovementType..'\t'.. Locale.Lookup( row.Name )..'\t'..Description)
                        b_TraitTypeHasUsed = true
                    end
                end
                for row in GameInfo.Units() do
                    if row.Name and row.Name ~= Locale.Lookup( row.Name ) and row.TraitType == TraitType then
                        local Description = Locale.Lookup(row.Description or GameInfo.Traits[TraitType].Description or 'NULL')
                        print(row.UnitType..'\t'.. Locale.Lookup( row.Name )..'\t'..Description)
                        b_TraitTypeHasUsed = true
                    end
                end
                if not b_TraitTypeHasUsed then
                    for row in GameInfo.Traits() do
                        if row.Name and row.Name ~= Locale.Lookup( row.Name ) and row.TraitType == TraitType then
                            print(row.TraitType..'\t'.. Locale.Lookup( row.Name )..'\t'..Locale.Lookup(row.Description or 'NULL'))
                        end
                    end
                end
                for row in GameInfo.TraitModifiers() do
                    if row.TraitType == TraitType then
                        local str = 'Modifier:\t'..row.ModifierId ..'\t'.. GameInfo.Modifiers[row.ModifierId].ModifierType
                        if GameInfo.Modifiers[row.ModifierId].OwnerRequirementSetId then
                            str = str..'\t'..'ORS:'..GameInfo.Modifiers[row.ModifierId].OwnerRequirementSetId
                        end
                        if GameInfo.Modifiers[row.ModifierId].SubjectRequirementSetId then
                            str = str..'\t'..'SRS:'..GameInfo.Modifiers[row.ModifierId].SubjectRequirementSetId
                        end
                        if GameInfo.Modifiers[row.ModifierId].RunOnce then
                            str = str..'\t'..'RunOnce'
                        end
                        if GameInfo.Modifiers[row.ModifierId].NewOnly then
                            str = str..'\t'..'NewOnly'
                        end
                        if GameInfo.Modifiers[row.ModifierId].Permanent then
                            str = str..'\t'..'Permanent'
                        end
                        if GameInfo.Modifiers[row.ModifierId].Repeatable then
                            str = str..'\t'..'Repeatable'
                        end
                        if GameInfo.Modifiers[row.ModifierId].OwnerStackLimit then
                            str = str..'\t'..'OwnerStackLimit:'..GameInfo.Modifiers[row.ModifierId].OwnerStackLimit
                        end
                        if GameInfo.Modifiers[row.ModifierId].SubjectStackLimit then
                            str = str..'\t'..'OwnerStackLimit:'..GameInfo.Modifiers[row.ModifierId].SubjectStackLimit
                        end
                        print(str)
                        print('Argument:')
                        local ModifierArguments = DB.Query("SELECT Name, Type, Value from ModifierArguments WHERE ModifierId = ?", row.ModifierId )
                        for _,MaRow in ipairs(ModifierArguments) do
                            if MaRow.Type ~= 'ARGTYPE_IDENTITY' then
                                str = MaRow.Name..':'..MaRow.Value..'(Type:'..MaRow.Type..')\t'
                            else
                                str = MaRow.Name..':'..MaRow.Value..'\t'
                            end
                        end
                        print(str)
                    end
                end
            end
        end
    end

    print("DebugAllType Initialization Compelete.", os.date("%c"))
end

Events.LoadScreenClose.Add(DebugAllType);
