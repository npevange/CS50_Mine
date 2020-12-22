--[[
    GD50
    Final Project

    Author: Nathan Evangelista
    npevangelista@ucdavis.edu
]]

function CombatCalculator(attacker, defender, levelStage)
    local toHit = math.random(100)
    local hitChance = 70 - levelStage.hitMod[defender.y][defender.x] + (((attacker.Speed - defender.Speed)/2)^3)
    -- local toHit = 50
    -- local hitChance = 70
    local damage = math.max(1, attacker.Attack - defender.Defense - levelStage.defMod[defender.y][defender.x])
    if toHit <= hitChance and defender.currentHP > 0 then
        -- Hit
        defender.currentHP = defender.currentHP - damage
        if defender.currentHP < 1 then
            return true
            -- Remove Unit from board and clean up
            -- return something remove from Level Stage
        end
    else
        -- love.window.setTitle(string.format("miss"))
        -- Miss
        -- Possible Perks here
    end
    return false
end