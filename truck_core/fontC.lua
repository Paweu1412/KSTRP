local dgs = exports.dgs

addEventHandler("onClientResourceStart", resourceRoot, function()
	dgs:dgsSetSystemFont("files/font.otf", _, _, "antialiased")
end)