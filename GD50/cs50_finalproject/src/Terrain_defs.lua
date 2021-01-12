--[[
    GD50
    Final Project

    Author: Nathan Evangelista
    npevangelista@ucdavis.edu
]]

function TerrainDef(Tile_ID)
    local hitmod, defmod

    hitmod = TERRAIN_HITMODS[Tile_ID]
    defmod = TERRAIN_DEFMODS[Tile_ID]


    return hitmod, defmod
end

TERRAIN_IDS = {
    'grass', 'tree', 'lake', 'castle', 'house'
}

TERRAIN_HITMODS = {
    0, -5, 5, -10, -5}


TERRAIN_DEFMODS = {
    0, 1, -1, 2, 1}
