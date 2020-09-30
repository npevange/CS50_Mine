--[[
    GD50
    Final Project

    Author: Nathan Evangelista
    npevangelista@ucdavis.edu
]]

TERRAIN_IDS = {
    'grass', 'tree', 'lake'
}

TERRAIN_DEFS = {
    ['grass'] = {
        name = 'grass',
        hitmod = 0,
        defmod = 0
    },
    ['tree'] = {
        name = 'tree',
        hitmod = -15,
        defmod = 2
    },
    ['lake'] = {
        name = 'lake',
        hitmod = -10,
        defmod = 1
    }
}