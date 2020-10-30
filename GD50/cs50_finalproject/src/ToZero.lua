--[[
    GD50
    Final Project

    Author: Nathan Evangelista
    npevangelista@ucdavis.edu
]]

function ToZero(num)
    local toZeroNum = num
    if toZeroNum > 0 then
        toZeroNum = toZeroNum - 1
    elseif toZeroNum < 0 then
        toZeroNum = toZeroNum + 1
    else -- toZeroNum == 0 then
        toZeroNum = 0
    end
    return toZeroNum
end