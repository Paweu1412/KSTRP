addEvent("KSTRP:LoginSuccessful", true)
addEventHandler("KSTRP:LoginSuccessful", root, function(accountData)
	if source and accountData then
        setPlayerName(source, accountData.login)
        setElementModel(source, accountData.skin)
        setPlayerMoney(source, accountData.cash, true)

        exports.truck_data:setCustomData(source, "plr:cash", accountData.cash)
		exports.truck_data:setCustomData(source, "plr:bank_money", accountData.bank_money)
		exports.truck_data:setCustomData(source, "plr:score", accountData.score)
		exports.truck_data:setCustomData(source, "plr:penalty_points", accountData.penalty_points)
		exports.truck_data:setCustomData(source, "plr:fine", accountData.fine)
	end
end)