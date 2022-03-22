local resourcesToStart = {
    "dgs",
    "truck_util",
    "truck_database",
    "truck_core",
    "truck_data",
    "truck_login",
    "truck_infobox"
}

addEventHandler("onResourceStart", resourceRoot, function()
    for i = 1, #resourcesToStart do
        local resourceToStart = resourcesToStart[i]

        startResource(getResourceFromName(resourceToStart))
    end
end)