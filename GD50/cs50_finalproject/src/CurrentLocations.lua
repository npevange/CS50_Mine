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
    -- love.window.setTitle(string.format("Loc Starts"))
    for i, heroes in pairs(stageLevel.entities) do
        currentLocations.entities[stageLevel.entities[i].y][stageLevel.entities[i].x] = true
        -- love.window.setTitle(string.format("Hero Loc" .. i))
    end

    for i, enemy in pairs(stageLevel.enemies) do
        -- love.window.setTitle(string.format("Current Enemy Loc" .. i))
        currentLocations.enemies[stageLevel.enemies[i].y][stageLevel.enemies[i].x] = true
        -- love.window.setTitle(string.format("Enemy Loc" .. i))
    end
    -- love.window.setTitle(string.format("All Locs Checked"))

    return currentLocations
end