--[[
    GD50
    Final Project

    Author: Nathan Evangelista
    npevangelista@ucdavis.edu
]]

function CurrentLocations(stageLevel)
    local currentLocations = Locations()

    for y = 1, #stageLevel.tileMap.tiles do
        table.insert(currentLocations.entities, {})
        table.insert(currentLocations.enemies, {})
        for x = 1, #stageLevel.tileMap.tiles[y] do
            table.insert(currentLocations.entities[y], false)
            table.insert(currentLocations.enemies[y], false)
        end
    end

    for i, heroes in pairs(stageLevel.entities) do
        currentLocations.entities[stageLevel.entities[i].y][stageLevel.entities[i].x] = true
    end

    for i, enemies in pairs(stageLevel.enemies) do
        currentLocations.enemies[stageLevel.enemies[i].y][stageLevel.enemies[i].x] = true
    end


    return currentLocations
end