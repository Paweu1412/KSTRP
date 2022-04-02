DGS = exports.dgs

local text = DGS:dgsCreate3DText(0,0,4,"DGS 3D Text Test",white)
DGS:dgsSetProperty(text,"fadeDistance",20)
DGS:dgsSetProperty(text,"shadow",{1,1,tocolor(0,0,0,255),true})
DGS:dgsSetProperty(text,"outline",{"out",1,tocolor(255,255,255,255)})
DGS:dgs3DTextAttachToElement(text,getPlayerFromName("Marek"),0,5)

setTimer(function()
	for index, player in pairs(getElementsByType("player")) do
		iprint(player)
	end
end, 2000, 0)