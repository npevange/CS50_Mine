--[[
    GD50
    Final Project

    Author: Nathan Evangelista
    npevangelista@ucdavis.edu
]]

function InList(list, val)
    for i, j in pairs(list) do
        if val == j then
            return true
        end
    end
    return false
end