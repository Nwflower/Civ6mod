function OnCityTileOwnershipChanged(owner, cityID)
    local pCity = CityManager.GetCity(owner, cityID)
    local plots = Map.GetNeighborPlots(pCity:GetX(), pCity:GetY(), 5)
    for i, adjPlot in ipairs(plots) do
        if adjPlot:IsOwned() then
            local Distance = Map.GetPlotDistance(adjPlot:GetX(), adjPlot:GetY(), pCity:GetX(), pCity:GetY()) or 0
            local pCity2 = Cities.GetPlotPurchaseCity(adjPlot)
            local pCity2ID = pCity2:GetID() or -1
            if Distance >= 4 and pCity2ID == cityID then
                adjPlot:SetOwner(-1);
            end
        end
    end
end

function Initialize()
    Events.CityTileOwnershipChanged.Add(OnCityTileOwnershipChanged);
end
Events.LoadGameViewStateDone.Add(Initialize)
print('OnCityTileOwnershipChanged Script')