local dgs = exports.dgs

local screenH, screenW = guiGetScreenSize()

local devScreenY = 1080
local rectangleSettings = {
	width = 60,
	height = 35
}

local guiElements = {}

function showInfo(text, type)
	if text and type then
		if isTimer(guiElements.timer) then
			if isElement(guiElements.roundedRectangleRender) then 
				destroyElement(guiElements.roundedRectangleRender)
				destroyElement(guiElements.rectangleImage)
			end
			
			killTimer(guiElements.timer)
		end

		guiElements.roundedRectangleRender = dgs:dgsCreateRoundRect(10, false, tocolor(0, 0, 0, 160))
		if not guiElements.roundedRectangleRender then return end

		local scaleValue = screenW/devScreenY
		scaleValue = math.max(scaleValue, 0.65)

		local textWidth = dxGetTextWidth(text, 1*scaleValue, dgs:dgsGetSystemFont())
		guiElements.rectangleImage = dgs:dgsCreateImage((screenH/2)*(-0.5), (screenW/2)*1.23, rectangleSettings.width*scaleValue+textWidth, rectangleSettings.height*scaleValue, guiElements.roundedRectangleRender, false)
		dgs:dgsMoveTo(guiElements.rectangleImage, (screenH/2)*0.09, (screenW/2)*1.23, false, "InQuad", 500)
		guiElements.iconImage = dgs:dgsCreateImage(-18, -7, 45*scaleValue, 45*scaleValue, "files/"..type..".png", false, guiElements.rectangleImage)
		guiElements.text = dgs:dgsCreateLabel(30, 8, 1, 1, text, false, guiElements.rectangleImage, _, 1*scaleValue, 1*scaleValue)
		guiElements.timer = setTimer(function()
			dgs:dgsAlphaTo(guiElements.rectangleImage, 0, "Linear", 300)
			setTimer(function()
				destroyElement(guiElements.roundedRectangleRender)
				destroyElement(guiElements.rectangleImage)
			end, 400, 1)
		end, 2500, 1)
	end
end

addEvent("KSTRP:ShowInfo", true)
addEventHandler("KSTRP:ShowInfo", localPlayer, showInfo)