local dgs = exports.dgs

addEventHandler("onClientResourceStart", resourceRoot, function()
	dgs:dgsSetSystemFont("files/font.otf", 11, false)
end)