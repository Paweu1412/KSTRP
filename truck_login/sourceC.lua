local screenW, screenH = guiGetScreenSize()

addEventHandler("onClientResourceStart", resourceRoot, 
	function()
		if localPlayer then
			setPlayerHudComponentVisible("all", false)

			setLoginPanelVisible(true)
		end
	end
)

function setLoginPanelVisible(state)
	if state == true then
		local dgsElements = {}

		dgsElements.roundedRectangleRender = exports.dgs:dgsCreateRoundRect(20, false, tocolor(0, 0, 0, 180))
		if not dgsElements.roundedRectangleRender then return end

		dgsElements.rectangleImage = exports.dgs:dgsCreateImage((screenW - 382) / 2, (screenH - 451) / 2, 382, 451, dgsElements.roundedRectangleRender, false)
		dgsElements.logoImage = exports.dgs:dgsCreateImage(-30, -45, 461, 78, "files/logo.png", false, dgsElements.rectangleImage)

		--dgsElements.infoLabel = exports.dgs:dgsCreateLabel()
	end
end