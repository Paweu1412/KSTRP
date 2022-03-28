local elementsData = {}

function setCustomData(element, key, data)
    if element and key and data then
        if not elementsData[element] then 
            elementsData[element] = {}
        end

        elementsData[element][key] = data

        triggerClientEvent("KSTRP:ClientUpdateElementData", resourceRoot, elementsData)
        return true
    end
end

function getCustomData(element, key)
    if element and key then
        if not elementsData[element] or not elementsData[element][key] then return end

        return elementsData[element][key]
    end
end

function getAllCustomData()
    return elementsData
end