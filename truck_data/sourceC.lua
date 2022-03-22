local elementsData = {}

addEvent("KSTRP:ClientUpdateElementData", true)
addEventHandler("KSTRP:ClientUpdateElementData", root, function(serverElementsData)
    elementsData = serverElementsData
end)

function getCustomData(element, key)
    if element and key then
        if not elementsData[element] or not elementsData[element][key] then return end

        return elementsData[element][key]
    end
end