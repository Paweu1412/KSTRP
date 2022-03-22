function showInfo(player, text, type)
	if player and text and type then
		triggerClientEvent(player, "KSTRP:ShowInfo", player, text, type)
	end
end