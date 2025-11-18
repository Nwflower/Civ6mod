function OnTurnEnd()
	LuaEvents.LaunchBar_ClosePantheonChooser()
end

function OnReligionFounded()
	local ReligionScreen = ContextPtr:LookUpControl("/InGame/ReligionScreen")
	if UIManager:IsInPopupQueue(ReligionScreen) then
		LuaEvents.LaunchBar_OpenReligionPanel()
	end
end

Events.TurnEnd.Add(OnTurnEnd)
Events.ReligionFounded.Add(OnReligionFounded)