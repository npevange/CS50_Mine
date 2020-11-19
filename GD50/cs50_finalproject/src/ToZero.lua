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
        love.window.setTitle(tostring(toZeroNum))
    elseif toZeroNum < 0 then
        toZeroNum = toZeroNum + 1
        love.window.setTitle(tostring(toZeroNum))
    else -- toZeroNum == 0 then
        toZeroNum = 0
        love.window.setTitle(tostring(toZeroNum))
    end
    return toZeroNum
end