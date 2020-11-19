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
        -- love.window.setTitle(string.format("NOT ENOUGH MOVE"))
        return false
    elseif (enemy.x + moveX) <= 0 or (enemy.x + moveX) > #levelStage.tileMap.tiles[1] then
        -- love.window.setTitle(string.format("OUT OF BOUNDS X"))
        return false
    elseif (enemy.y + moveY) <= 0 or (enemy.y + moveY) > #levelStage.tileMap.tiles then
        -- love.window.setTitle(string.format("OUT OF BOUNDS Y"))
        return false
    elseif levelStage.currentLocations.enemies[enemy.y + moveY][enemy.x + moveX] == true then
        -- love.window.setTitle(string.format("ENEMY IN LOCATION"))
        return false
    elseif levelStage.currentLocations.entities[enemy.y + moveY][enemy.x + moveX] == true then
        -- love.window.setTitle(string.format("HERO IN LOCATION"))
        return false
    else
        return true
    end
end