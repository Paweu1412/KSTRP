addEvent("KSTRP:LoginSuccessful", true)
addEventHandler("KSTRP:LoginSuccessful", root, function()
	setTimer(function(source)
		bindKey(source, "tab", "down", function(player, key, keyState)
			if keyState == "down" and "pressed" then
				local allPlayersData = exports.truck_data:getAllCustomData()
				if not allPlayersData then return end

				triggerClientEvent(player, "KSTRP:ToggleScoreboard", player, allPlayersData)
			end
		end)
	end, 1000, 1, source)
end)