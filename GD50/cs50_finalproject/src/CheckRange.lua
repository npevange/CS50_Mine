--[[
    GD50
    Final Project

    Author: Nathan Evangelista
    npevangelista@ucdavis.edu
]]

function CheckRange(enemy, target)
    if (math.abs(enemy.x - target.x) + math.abs(enemy.y - target.y)) <= enemy.Range then
        return true
    else
        return false
    end
end