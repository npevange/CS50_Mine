--[[
    GD50
    Final Project

    Author: Nathan Evangelista
    npevangelista@ucdavis.edu
]]

LevelGenerator = Class{}

function LevelGenerator.generate(width,height)
    local tiles = {}
    local entities = {}
    local objects = {}

    local tileID = TILE_ID_GRASS

    -- Introduce some rng for map creation    
    for x = 1, height do
        table.insert(tiles, {})
    end

    for x = 1, width do
        for y = 1, height do
            table.insert(tiles[y],
            Tile(x,y, tileID))
        end
    end
    


    local map = TileMap(width, height)
    map.tiles = tiles
    
    return GameLevel(entities, objects, map)
end