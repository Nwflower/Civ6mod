--  FILE: SecretSociety_OldRule_Script.lua
--  VERSION: 1
--  Author: Nwflower
--  Spicial Thanks: Uni
--  Copyright (c) 2025.
--  All rights reserved.
--  DateCreated: 2025/7/3 11:22:01
-- ===========================================================================

-- 完成项目后移除虚拟建筑
function OnProjectCompleted(playerID,cityID,projectID)
	if (projectID==GameInfo.Projects["PROJECT_ENHANCE_DISTRICT_ENCAMPMENT"].Index) then
		local pCity = CityManager.GetCity(playerID, cityID);
        -- 城市单元格
        local ix,iy = pCity:GetDistricts():GetDistrictLocation(GameInfo.Districts['DISTRICT_ENCAMPMENT'].Index)

        for loop, ppUnit in ipairs(Units.GetUnitsInPlot(Map.GetPlot(ix,iy))) do
            if(ppUnit ~= nil) then
                if ppUnit:GetOwner() == playerID then
                    -- 随机晋升
                    --local promotionNum = #GameInfo.UnitPromotions;
                    --ppUnit:GetExperience():SetPromotion(Game.GetRandNum(promotionNum));
                    local exps = ppUnit:GetExperience():GetExperienceForNextLevel()
                    ppUnit:GetExperience():ChangeExperience(exps);
                end
            end
        end
	end
end

function initialize()
	Events.CityProjectCompleted.Add(OnProjectCompleted);
end

Events.LoadScreenClose.Add(initialize);
print('FishDingzhi1 Loaded Success.')