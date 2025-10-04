-- Qab_Nw
-- Author: Administrator
-- DateCreated: 2025/3/21 20:01:25
--------------------------------------------------------------
print('Qab_Nw loading')

local QAB_1 = GameConfiguration.GetValue('NW_QAB_CONFIG1')
local QAB_2 = GameConfiguration.GetValue('NW_QAB_CONFIG2')
local QAB_3 = GameConfiguration.GetValue('NW_QAB_CONFIG3')

function AttachQABModifiers(iPlayer)
    local pPlayer = Players[iPlayer]
    pPlayer:SetProperty("Chaos", 1)
    pPlayer:AttachModifierByID("MODIFIER_TRAIT_CIVILIZATION_CHAOSA")
    pPlayer:AttachModifierByID("MODIFIER_TRAIT_CIVILIZATION_CHAOSB")
    pPlayer:AttachModifierByID("MODIFIER_TRAIT_CIVILIZATION_CHAOSC")
    pPlayer:AttachModifierByID("MODIFIER_TRAIT_CIVILIZATION_CHAOSD")
    pPlayer:AttachModifierByID("AGENDA_EVERCHOSEN")
    pPlayer:AttachModifierByID("MODIFIER_TRAIT_CIVILIZATION_CHAOSF")
    pPlayer:AttachModifierByID("MODIFIER_TRAIT_CIVILIZATION_CHAOSG")
    pPlayer:AttachModifierByID("MODIFIER_TRAIT_CIVILIZATION_CHAOSH")
    pPlayer:AttachModifierByID("MODIFIER_TRAIT_CIVILIZATION_CHAOSI")
    pPlayer:AttachModifierByID("MODIFIER_TRAIT_CIVILIZATION_CHAOSJ")
    pPlayer:AttachModifierByID("MODIFIER_TRAIT_CIVILIZATION_CHAOSK")
    pPlayer:AttachModifierByID("MODIFIER_TRAIT_CIVILIZATION_CHAOSL")
    pPlayer:AttachModifierByID("MODIFIER_TRAIT_CIVILIZATION_CHAOSN")
    pPlayer:AttachModifierByID("MODIFIER_TRAIT_CIVILIZATION_CHAOSM")
    pPlayer:AttachModifierByID("MODIFIER_TRAIT_CIVILIZATION_CHAOSO")
    pPlayer:AttachModifierByID("MODIFIER_TRAIT_CIVILIZATION_CHAOSP")
    pPlayer:AttachModifierByID("MODIFIER_TRAIT_CIVILIZATION_CHAOSQ")
    pPlayer:AttachModifierByID("MODIFIER_TRAIT_CIVILIZATION_CHAOSR")
    pPlayer:AttachModifierByID("MODIFIER_TRAIT_CIVILIZATION_CHAOSS")
    pPlayer:AttachModifierByID("MODIFIER_TRAIT_CIVILIZATION_CHAOSV")
    pPlayer:AttachModifierByID("MODIFIER_TRAIT_CIVILIZATION_CHAOSW")
    pPlayer:AttachModifierByID("MODIFIER_TRAIT_CIVILIZATION_CHAOSX")
    pPlayer:AttachModifierByID("MODIFIER_TRAIT_CIVILIZATION_CHAOSY")
    pPlayer:AttachModifierByID("MODIFIER_TRAIT_CIVILIZATION_CHAOSZ")
    pPlayer:AttachModifierByID("MODIFIER_TRAIT_CIVILIZATION_CHAOSA_A")
    pPlayer:AttachModifierByID("MODIFIER_TRAIT_CIVILIZATION_CHAOSA_B")
    pPlayer:AttachModifierByID("MODIFIER_TRAIT_CIVILIZATION_CHAOSA_C")
    pPlayer:AttachModifierByID("MODIFIER_TRAIT_CIVILIZATION_CHAOSB_A")
end

function SetPlayerQAB(iPlayer1, iPlayer2)
    if Game:GetProperty("ChaosDone") == nil then
        AttachQABModifiers(QAB_1)
        if QAB_1 ~= QAB_2 then
            AttachQABModifiers(QAB_2)
        end
        if QAB_1 ~= QAB_3 and QAB_2 ~= QAB_3 then
            AttachQABModifiers(QAB_3)
        end
        Game:SetProperty("ChaosDone", 1)
    end
end


function checkPlayer_New()
    local playerIDS = PlayerManager.GetAliveIDs();
    if Game:GetProperty("ChaosCo") == nil then
        local name = ''
        for i, playerId in ipairs(playerIDS) do
            local pPlayer = Players[playerId];
            local playerConfig = PlayerConfigurations[playerId];
            if pPlayer:GetProperty("Chaos") == 1 then
                if name == '' then
                    name = name..Locale.Lookup(GameInfo.Leaders[playerConfig:GetLeaderTypeName()].Name)
                else
                    name = name..'、'..Locale.Lookup(GameInfo.Leaders[playerConfig:GetLeaderTypeName()].Name)
                end
            end
        end
        ExposedMembers.QA.showDialog("LOC_CTQ", name);
        Game:SetProperty("ChaosCo", 1)
    end
end
Events.TurnBegin.Remove(checkPlayer)
Events.TurnBegin.Add(checkPlayer_New)

function Initialize()
    SetPlayerQAB(QAB_1, QAB_2);
    print('Qab_Nw Script Loaded.');
end
Events.LoadGameViewStateDone.Remove(GodChoice);
Events.LoadGameViewStateDone.Add(Initialize)