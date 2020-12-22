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
    'grass', 'tree', 'lake'
}

TERRAIN_HITMODS = {
    0, -15, -10}


TERRAIN_DEFMODS = {
    0, 1, 2}
