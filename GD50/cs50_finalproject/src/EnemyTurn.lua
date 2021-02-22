--[[
    GD50
    Final Project

    Author: Nathan Evangelista
    npevangelista@ucdavis.edu
]]

function EnemyTurn(enemy, levelStage, index)
    if enemy.AI == "aggro" then
        FindClosestHero(enemy, levelStage, index)

    elseif enemy.AI == 'astar' then
        -- A_Star(enemy, levelStage, index)
    
    elseif enemy.AI == "safe" then
        --safe
    elseif enemy.AI == "boss" then
        if enemy.currentHP < enemy.HP then
            FindClosestHero(enemy, levelStage, index)
        end
    end
end