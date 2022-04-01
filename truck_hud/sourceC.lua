local elementsToHide = {"ammo", "armour", "breath", "clock", "health", "money", "weapon", "wanted"}

local screenH, screenW = guiGetScreenSize()

local dgsElements = {}
local dgs = exports.dgs

addEventHandler("onClientResourceStart", resourceRoot, function()
	--[[for i=1, #elementsToHide do
		setPlayerHudComponentVisible(elementsToHide[i], false)
	end]]--

	

end)