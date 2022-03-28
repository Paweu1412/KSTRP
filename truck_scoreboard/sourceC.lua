local screenW, screenH = guiGetScreenSize()

local dgsElements = {}
local dgs = exports.dgs

local destroyTimer = nil
local isScoreboardEnabled = false

addEvent("KSTRP:ToggleScoreboard", true)
addEventHandler("KSTRP:ToggleScoreboard", root, function(data)
	if isScoreboardEnabled == false and data then
		if isTimer(destroyTimer) then
			killTimer(destroyTimer)
		end

		dgsElements.roundedRectangleRender = dgs:dgsCreateRoundRect(10, false, tocolor(0, 0, 0, 190))
		if not dgsElements.roundedRectangleRender then return end

		local elementsInTableCount = 0
  		for _ in pairs(data) do 
  			elementsInTableCount = elementsInTableCount + 1 
  		end

  		local dgsElementsOffsetY = 0
		if elementsInTableCount < 35 then 
			dgsElementsOffsetY = dgsElementsOffsetY + 25*(elementsInTableCount-14)
		else
			dgsElementsOffsetY = 530
		end

		dgsElements.rectangleImage = dgs:dgsCreateImage((screenW - 370)/2, (screenH - 450 - dgsElementsOffsetY)/2, 370, 450 + dgsElementsOffsetY, dgsElements.roundedRectangleRender, false)

		dgsElements.logoImage = dgs:dgsCreateImage(3, -1, 381, 64, "files/logo.png", false, dgsElements.rectangleImage)

		dgsElements.lineRender = dgs:dgsCreateLine((screenW - 450)/2, (screenH - 550)/2, 450, 550, false, dgsElements.rectangleImage, 2, tocolor(1, 111, 170))
		dgsElements.blueLine = dgs:dgsLineAddItem(dgsElements.lineRender, -735, -180, -366, -180)

		dgs:dgsCreateLabel(-70, 65, 200, 10, "ID", false, dgsElements.rectangleImage, tocolor(170, 170, 170), 0.9, 0.9, _, _, _, "center")
		dgs:dgsCreateLabel(5, 65, 200, 10, "Nick", false, dgsElements.rectangleImage, tocolor(170, 170, 170), 0.9, 0.9, _, _, _, "center")
		dgs:dgsCreateLabel(105, 65, 200, 10, "Score", false, dgsElements.rectangleImage, tocolor(170, 170, 170), 0.9, 0.9, _, _, _, "center")
		dgs:dgsCreateLabel(200, 65, 200, 10, "Rola", false, dgsElements.rectangleImage, tocolor(170, 170, 170), 0.9, 0.9, _, _, _, "center")

		local labelsOffsetY = 25
		local currentID = 1

		for indexPlayer, playerData in pairs(data) do
			dgs:dgsCreateLabel(-70, 70+labelsOffsetY, 200, 10, currentID, false, dgsElements.rectangleImage, tocolor(170, 170, 170), 0.9, 0.9, _, _, _, "center")
			dgs:dgsCreateLabel(5, 70+labelsOffsetY, 200, 10, getPlayerName(indexPlayer), false, dgsElements.rectangleImage, tocolor(170, 170, 170), 0.9, 0.9, _, _, _, "center")
			dgs:dgsCreateLabel(105, 70+labelsOffsetY, 200, 10, playerData["plr:score"] or "Brak", false, dgsElements.rectangleImage, tocolor(170, 170, 170), 0.9, 0.9, _, _, _, "center")
			dgs:dgsCreateLabel(200, 70+labelsOffsetY, 200, 10, playerData["plr:role"] or "Brak", false, dgsElements.rectangleImage, tocolor(170, 170, 170), 0.9, 0.9, _, _, _, "center")
		
			if currentID == 35 then return end

			currentID = currentID + 1
			labelsOffsetY = labelsOffsetY + 25
		end

		isScoreboardEnabled = true
	else
		dgs:dgsAlphaTo(dgsElements.rectangleImage, 0, "Linear", 50)

		destroyTimer = setTimer(function()
			destroyElement(dgsElements.roundedRectangleRender)
			isScoreboardEnabled = false
		end, 50, 1)
	end
end)