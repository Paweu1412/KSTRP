addEvent("KSTRP:TryToRegisterAccount", true)
addEventHandler("KSTRP:TryToRegisterAccount", root, function(login, password, email)
	if client and login and password and email then
		local accountData = exports.truck_database:dbQueryExtended(string.format("SELECT * FROM accounts WHERE login = '%s'", login))
		if accountData.uid == nil then
			local isSerialRegistered = exports.truck_database:dbQueryExtended(string.format("SELECT uid FROM accounts WHERE serial = '%s'", getPlayerSerial(client)))
			if isSerialRegistered.uid == nil then
				local hashedPassword = passwordHash(password, "bcrypt", {})
				if hashedPassword then
					local newAccount = exports.truck_database:dbExecExtended(string.format("INSERT INTO accounts (login, password, serial, email, skin, cash, bank_money, score, penalty_points, fine) VALUES ('%s', '%s', '%s', '%s', '%d', '%d', '%d', '%d', '%d', '%d')", login, hashedPassword, getPlayerSerial(client), email ~= nil and email or _, 133, 1500, 0, 0, 0, 0))
					if newAccount then
						exports.truck_infobox:showInfo(client, "Pomyślnie się zarejestrowałeś. Możesz się teraz zalogować!", "info")
						
						triggerClientEvent(client, "KSTRP:SetPanelVisibleTab", client, "login")
					end
				else
					exports.truck_infobox:showInfo(client, "Wystąpił nieoczekiwany błąd [#1]", "error")
				end
			else
				exports.truck_infobox:showInfo(client, "Istnieje już aktywne konto z Twoim serialem!", "error")
			end
		else
			exports.truck_infobox:showInfo(client, "Konto o podanym loginie już istnieje!", "error")
		end
	end
end)

local loggedPlayers = {}

addEvent("KSTRP:TryToLogin", true)
addEventHandler("KSTRP:TryToLogin", root, function(login, password)
	if client and login and password then
		local accountData = exports.truck_database:dbQueryExtended(string.format("SELECT * FROM accounts WHERE login = '%s'", login))
		if accountData.uid ~= nil then
			local passwordFromDatabase = accountData.password
			if passwordVerify(password, passwordFromDatabase) then
				if not loggedPlayers[login] or loggedPlayers[login] == nil then
					if triggerClientEvent(client, "KSTRP:HideLoginGUI", client) then
						triggerEvent("KSTRP:LoginSuccessful", client, accountData)

						loggedPlayers[login] = true
				    end 
				else
					exports.truck_infobox:showInfo(client, "Ktoś już jest zalogowany na tym koncie!", "error")
				end	
			else
				exports.truck_infobox:showInfo(client, "Podane hasło jest nieprawidłowe.", "error")
			end
		else
			exports.truck_infobox:showInfo(client, "Konto o podanym loginie nie istnieje!", "error")
		end
	end
end)

addEventHandler("onPlayerQuit", root, function()
	if loggedPlayers[getPlayerName(source)] then
		loggedPlayers[getPlayerName(source)] = nil
	end
end)