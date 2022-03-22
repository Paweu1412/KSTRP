local screenW, screenH = guiGetScreenSize()

addEventHandler("onClientResourceStart", resourceRoot, function()
	if localPlayer then
		setPlayerHudComponentVisible("all", false)

		showCursor(true)
		showChat(false)

		fadeCamera(true, 2.5)
    	setCameraMatrix(-883.42181, 1405.34521, 16.83056, -873.87213, 1395.98499, 13.39513)
    	setMusicEnabled(true)
    	setCutsceneEnabled(true)
    	setTime(4, 0)

		setPanelVisibleTab("intro")
	end
end)

function setCutsceneEnabled(state)
    if state == true then
        cutsceneVehicles = {}
        cutscenePeds = {}

        cutsceneVehicles.truck = createVehicle(403, -869, 1385.2002, 2.7, 343.998, 0, 283.997)
        cutsceneVehicles.trailer = createVehicle(435, -876.900, 1384.2002, 5.5, 343.998, 0, 283.997)
        cutsceneVehicles.policeCar = createVehicle(596, -875.099, 1377.2998, 6.5, 334.748, 0, 327.997)
        setVehicleSirensOn(cutsceneVehicles.policeCar, true)

        cutsceneVehicles.sentinel = createVehicle(405, -841.099, 1396.4, 13.8, 0, 0, 206)
        cutsceneVehicles.roadtrain = createVehicle(515, -827.90, 1371.9, 14.8, 0, 0, 208)
        cutsceneVehicles.ambulance = createVehicle(416, -817.7, 1336.7, 14.8, 0, 0, 60)
        setVehicleSirensOn(cutsceneVehicles.ambulance, true)

        for _, vehicle in pairs(cutsceneVehicles) do
            setElementFrozen(vehicle, true)
        end

        cutscenePeds.firstOfficer = createPed(280, -868.20001, 1376.1, 5.3, 344.001)
        cutscenePeds.secondOfficer = createPed(280, -869.5, 1377.7, 5.1, 276)
        setPedAnimation(cutscenePeds.secondOfficer, "PED", "IDLE_CHAT", 1) 

        cutscenePeds.trucker = createPed(206, -867.90002, 1377.6, 4.7, 130)
        setPedAnimation(cutscenePeds.trucker, "PED", "IDLE_CHAT", 1) 

        cutscenePeds.firstLocals = createPed(66, -838.5998, 1385.5, 13.9, 124)
        cutscenePeds.secondLocals = createPed(127, -837.900, 1384.09, 13.9, 94)
    elseif state == false then
        if cutsceneVehicles and cutscenePeds then
            for _, vehicle in pairs(cutsceneVehicles) do
                destroyElement(vehicle)
            end

            for _, ped in pairs(cutscenePeds) do
                destroyElement(ped)
            end
        end
    end
end

local dgs = exports.dgs

function setMusicEnabled(state)
    if state == true then
        currentSong = playSound("files/song.mp3", true)
    elseif state == false then
        stopSound(currentSong)
    end
end

local dgsElements = {}

function setPanelVisibleTab(tab)
	if tab then
		if dgsElements.rectangleImage then
			destroyElement(dgsElements.rectangleImage)

			if dgsElements.returnButton then
				destroyElement(dgsElements.returnButton)
			end

			dgsElements = {}
		end

		if tab == "intro" then
			dgsElements.roundedRectangleRender = dgs:dgsCreateRoundRect(20, false, tocolor(0, 0, 0, 190))
			if not dgsElements.roundedRectangleRender then return end

			dgsElements.rectangleImage = dgs:dgsCreateImage((screenW - 382)/2, (screenH - 451)/2, 382, 451, dgsElements.roundedRectangleRender, false)
			dgsElements.logoImage = dgs:dgsCreateImage(-30, -45, 461, 78, "files/logo.png", false, dgsElements.rectangleImage)

			local infoText = "Witaj na Krajowym Serwerze Transportu!\nŚwieża reaktywacja w nowoczesnej odsłonie!\n\nNaciśnij jeden z dwóch przycisków,\naby rozpocząć nową przygodę truckera :)\n\n★ ★ ★ ★ ★"

			dgsElements.infoLabel = dgs:dgsCreateLabel(95, 50, 200, 200, infoText, false, dgsElements.rectangleImage, _, 1, 1, _, _, _, "center")
			dgs:dgsSetFont(dgsElements.infoLabel, dgs:dgsGetSystemFont() or "default-bold")

			dgsElements.loginButton = dgs:dgsCreateButton(93, 240, 200, 50, "Logowanie", false, dgsElements.rectangleImage, _, _, _, _, _, _, _, tocolor(1, 111, 170), tocolor(0, 55, 120))
			addEventHandler("onDgsMouseClick", dgsElements.loginButton, function(button, state)
				if button == "left" and state == "up" then
					setPanelVisibleTab("login")
				end
			end, false)

			dgsElements.registerButton = dgs:dgsCreateButton(93, 320, 200, 50, "Rejestracja", false, dgsElements.rectangleImage)
			addEventHandler("onDgsMouseClick", dgsElements.registerButton, function(button, state)
				if button == "left" and state == "up" then
					setPanelVisibleTab("register")
				end
			end, false)
		elseif tab == "register" then
			dgsElements.roundedRectangleRender = dgs:dgsCreateRoundRect(20, false, tocolor(0, 0, 0, 200))
			if not dgsElements.roundedRectangleRender then return end

			dgsElements.rectangleImage = dgs:dgsCreateImage((screenW - 382)/2, (screenH - 451)/2, 382, 451, dgsElements.roundedRectangleRender, false)
			dgsElements.logoImage = dgs:dgsCreateImage(-30, -45, 461, 78, "files/logo.png", false, dgsElements.rectangleImage)

			local infoText = "Witaj w zakładce rejestracji!\n\nWpisz login oraz hasło, aby się zarejestrować.\nE-mail możesz wpisać w ramach weryfikacji\ngdybyś zapomniał danych do logowania."

			dgsElements.infoLabel = dgs:dgsCreateLabel(95, 50, 200, 10, infoText, false, dgsElements.rectangleImage, _, 1, 1, _, _, _, "center")
			dgs:dgsSetFont(dgsElements.infoLabel, dgs:dgsGetSystemFont() or "default-bold")

			dgsElements.returnButton = dgs:dgsCreateButton((screenW-195)/2, (screenH+449)/2, 200, 30, "Powrót", false, _, _, _, _, _, _, _, tocolor(0, 0, 0, 190), tocolor(1, 111, 170), tocolor(0, 55, 120))
			addEventHandler("onDgsMouseClick", dgsElements.returnButton, function(button, state)
				if button == "left" and state == "up" then
					setPanelVisibleTab("intro")
				end
			end, false)

			dgsElements.loginLabel = dgs:dgsCreateLabel(95, 180, 200, 1, "Login", false, dgsElements.rectangleImage, _, 1, 1, _, _, _, "center")
			dgsElements.loginEdit = dgs:dgsCreateEdit(108, 200, 170, 30, _, false, dgsElements.rectangleImage, _, _, _, _, tocolor(255, 255, 255, 90))
			dgs:dgsEditSetHorizontalAlign(dgsElements.loginEdit, "center")

			dgsElements.passwordLabel = dgs:dgsCreateLabel(95, 240, 200, 1, "Hasło", false, dgsElements.rectangleImage, _, 1, 1, _, _, _, "center")
			dgsElements.passwordEdit = dgs:dgsCreateEdit(108, 260, 170, 30, _, false, dgsElements.rectangleImage, _, _, _, _, tocolor(255, 255, 255, 90))
			dgs:dgsEditSetHorizontalAlign(dgsElements.passwordEdit, "center")
			dgs:dgsEditSetMasked(dgsElements.passwordEdit, true)

			dgsElements.emailLabel = dgs:dgsCreateLabel(95, 300, 200, 1, "E-mail (opcjonalnie)", false, dgsElements.rectangleImage, _, 1, 1, _, _, _, "center")
			dgsElements.emailEdit = dgs:dgsCreateEdit(108, 320, 170, 30, _, false, dgsElements.rectangleImage, _, _, _, _, tocolor(255, 255, 255, 90))
			dgs:dgsEditSetHorizontalAlign(dgsElements.emailEdit, "center")

			dgsElements.registerButton = dgs:dgsCreateButton(93, 375, 200, 40, "Zarejestruj", false, dgsElements.rectangleImage)
			addEventHandler("onDgsMouseClick", dgsElements.registerButton, function(button, state)
				if button == "left" and state == "up" then
					local loginFromEdit = dgs:dgsGetText(dgsElements.loginEdit)
					local passwordFromEdit = dgs:dgsGetText(dgsElements.passwordEdit)
					local emailFromEdit = dgs:dgsGetText(dgsElements.emailEdit)

					if string.len(loginFromEdit) == 0 or string.find(loginFromEdit, " ") ~= nil then 
						exports.truck_infobox:showInfo("Pole loginu nie może pozostać puste!", "warning")
						return
					end

					if string.len(loginFromEdit) < 3 then
						exports.truck_infobox:showInfo("Login musi zawierać co najmniej 3 znaki.", "warning")
						return
					end

					if string.len(passwordFromEdit) == 0 or string.find(passwordFromEdit, " ") ~= nil then 
						exports.truck_infobox:showInfo("Pole hasła nie może pozostać puste!", "warning")
						return
					end

					if string.len(passwordFromEdit) < 5 then
						exports.truck_infobox:showInfo("Hasło musi zawierać co najmniej 5 znaków.", "warning")
						return
					end

					if string.len(emailFromEdit) ~= 0 then
						if exports.truck_util:validEmail(emailFromEdit) ~= true then 
							exports.truck_infobox:showInfo("Niepoprawny adres E-mail!", "warning")
							return
						end
					end

					triggerServerEvent("KSTRP:TryToRegisterAccount", localPlayer, loginFromEdit, passwordFromEdit, emailFromEdit)
				end
			end, false)
		elseif tab == "login" then
			dgsElements.roundedRectangleRender = dgs:dgsCreateRoundRect(20, false, tocolor(0, 0, 0, 190))
			if not dgsElements.roundedRectangleRender then return end

			dgsElements.rectangleImage = dgs:dgsCreateImage((screenW - 382)/2, (screenH - 451)/2, 382, 451, dgsElements.roundedRectangleRender, false)
			dgsElements.logoImage = dgs:dgsCreateImage(-30, -45, 461, 78, "files/logo.png", false, dgsElements.rectangleImage)

			local infoText = "Witaj w zakładce logowania!\n\nWpisz login oraz hasło, aby się zalogować.\nMamy nadzieję, że będziesz się super bawił,\ngrając na naszym serwerze :)"

			dgsElements.infoLabel = dgs:dgsCreateLabel(95, 50, 200, 10, infoText, false, dgsElements.rectangleImage, _, 1, 1, _, _, _, "center")
			dgs:dgsSetFont(dgsElements.infoLabel, dgs:dgsGetSystemFont() or "default-bold")

			dgsElements.returnButton = dgs:dgsCreateButton((screenW-195)/2, (screenH+449)/2, 200, 30, "Powrót", false, _, _, _, _, _, _, _, tocolor(0, 0, 0, 190), tocolor(1, 111, 170), tocolor(0, 55, 120))
			addEventHandler("onDgsMouseClick", dgsElements.returnButton, function(button, state)
				if button == "left" and state == "up" then
					setPanelVisibleTab("intro")
				end
			end, false)

			dgsElements.loginLabel = dgs:dgsCreateLabel(95, 180, 200, 1, "Login", false, dgsElements.rectangleImage, _, 1, 1, _, _, _, "center")
			dgsElements.loginEdit = dgs:dgsCreateEdit(108, 200, 170, 30, _, false, dgsElements.rectangleImage, _, _, _, _, tocolor(255, 255, 255, 90))
			dgs:dgsEditSetHorizontalAlign(dgsElements.loginEdit, "center")

			dgsElements.passwordLabel = dgs:dgsCreateLabel(95, 240, 200, 1, "Hasło", false, dgsElements.rectangleImage, _, 1, 1, _, _, _, "center")
			dgsElements.passwordEdit = dgs:dgsCreateEdit(108, 260, 170, 30, _, false, dgsElements.rectangleImage, _, _, _, _, tocolor(255, 255, 255, 90))
			dgs:dgsEditSetHorizontalAlign(dgsElements.passwordEdit, "center")
			dgs:dgsEditSetMasked(dgsElements.passwordEdit, true)

			dgsElements.loginButton = dgs:dgsCreateButton(93, 335, 200, 40, "Zaloguj", false, dgsElements.rectangleImage)
			addEventHandler("onDgsMouseClick", dgsElements.loginButton, function(button, state)
				if button == "left" and state == "up" then
					local loginFromEdit = dgs:dgsGetText(dgsElements.loginEdit)
					local passwordFromEdit = dgs:dgsGetText(dgsElements.passwordEdit)

					if string.len(loginFromEdit) == 0 or string.find(loginFromEdit, " ") ~= nil then 
						exports.truck_infobox:showInfo("Pole loginu nie może pozostać puste!", "warning")
						return
					end

					if string.len(passwordFromEdit) == 0 or string.find(passwordFromEdit, " ") ~= nil then 
						exports.truck_infobox:showInfo("Pole hasła nie może pozostać puste!", "warning")
						return
					end

					triggerServerEvent("KSTRP:TryToLogin", localPlayer, loginFromEdit, passwordFromEdit)
				end
			end, false)
		end
	end
end

addEvent("KSTRP:SetPanelVisibleTab", true)
addEventHandler("KSTRP:SetPanelVisibleTab", localPlayer, setPanelVisibleTab)