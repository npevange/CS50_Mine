--[[
    GD50
    Final Project

    Author: Nathan Evangelista
    npevangelista@ucdavis.edu
]]

function CheckMove(enemy, moveX, moveY, levelStage)
    if (moveX + moveY) > enemy.Range then
        return false
    elseif levelStage.currentLocations.enemies[enemy.y + moveY][enemy.x + moveX] == true then
        return false
    elseif levelStage.currentLocations.entities[enemy.y + moveY][enemy.x + moveX] == true then
        return false
    else
        return true
    end
end