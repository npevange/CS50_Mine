--[[
    GD50
    Final Project

    Author: Nathan Evangelista
    npevangelista@ucdavis.edu
]]

HighlightedTile = Class{}

function HighlightedTile:init(x, y)
    self.x = x
    self.y = y
    self.height = TILE_SIZE
    self.width = TILE_SIZE
end