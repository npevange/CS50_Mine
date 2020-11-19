--[[
    GD50
    Final Project

    Author: Nathan Evangelista
    npevangelista@ucdavis.edu
]]


-- IMPORTANT --
-- Need to adjust moveX and moveY to be + / -
function CheckMove(enemy, moveX, moveY, levelStage)
    if (moveX + moveY) > enemy.Range then
        return false
    elseif (enemy.x + moveX) <= 0 or (enemy.x + moveX) > #levelStage.tileMap.tiles[1] then
        return false
    elseif (enemy.y + moveY) <= 0 or (enemy.y + moveY) > #levelStage.tileMap.tiles then
        return false
    elseif levelStage.currentLocations.enemies[enemy.y + moveY][enemy.x + moveX] == true then
        return false
    elseif levelStage.currentLocations.entities[enemy.y + moveY][enemy.x + moveX] == true then
        return false
    else
        return true
    end
end