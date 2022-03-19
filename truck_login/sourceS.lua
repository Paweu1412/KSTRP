addEvent("KSTRP:TryToRegisterAccount", true)
addEventHandler("KSTRP:TryToRegisterAccount", root, function(login, password, email)
	if client and login and password and email then
		local isLoginInDatabase = exports.truck_database:dbQueryExtended(string.format("SELECT uid FROM accounts WHERE login = '%s'", login))
	end
end)