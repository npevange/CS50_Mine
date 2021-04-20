--[[
    GD50
    Final Project

    Author: Nathan Evangelista
    npevangelista@ucdavis.edu
]]

function EnemyTurn(enemy, levelStage, index, combatMenu)
    if enemy.AI == "aggro" then
        FindClosestHero(enemy, levelStage, index, combatMenu)

        -- FindLowHP(enemy, levelStage, index, combatMenu)

    elseif enemy.AI == 'astar' then
        -- A_Star(enemy, levelStage, index)
    
    elseif enemy.AI == "safe" then
        --safe 
    elseif enemy.AI == "boss" then
        if enemy.currentHP < enemy.HP then
            FindClosestHero(enemy, levelStage, index, combatMenu)
        end
    end
end