--[[
    GD50
    Final Project

    Author: Nathan Evangelista
    npevangelista@ucdavis.edu
]]


function AdjustMove(enemy, moveX, moveY, levelStage)
    local tempmoveX = moveX
    local tempmoveY = moveY
    local rand = math.random(1,2)
    if tempmoveX == 0 then
        rand = 2
    elseif tempmoveY == 0 then
        rand = 1
    end
    if rand == 1 then
        tempmoveX = ToZero(tempmoveX)
    else
        tempmoveY = ToZero(tempmoveY)
    end
    return tempmoveX, tempmoveY
end