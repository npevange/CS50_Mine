--[[
    GD50
    Final Project

    Author: Nathan Evangelista
    npevangelista@ucdavis.edu
]]

function EnemyTurn(enemy, levelStage, index)
    if enemy.AI == "aggro" then
        -- love.window.setTitle(string.format("Enemy Turn"))
        FindClosestHero(enemy, levelStage, index)
        -- love.window.setTitle(string.format("Found Closest Enemy"))

    elseif enemy.AI == 'astar' then
        -- A_Star(enemy, levelStage, index)
    
    elseif enemy.AI == "safe" then
        --safe
    elseif enemy.AI == "boss" then
        --boss
    end
end