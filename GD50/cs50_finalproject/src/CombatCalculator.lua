--[[
    GD50
    Final Project

    Author: Nathan Evangelista
    npevangelista@ucdavis.edu
]]

function CombatCalculator(attacker, defender, levelStage)
    local toHit = math.random(100)
    local hitChance = 70 - levelStage.hitMod[defender.y][defender.x] + (((attacker.Speed - defender.Speed)/2)^3)
    -- local toHit = 100
    -- local hitChance = 70
    local damage = math.max(1, attacker.Attack - defender.Defense - levelStage.defMod[defender.y][defender.x])
    if toHit <= hitChance and defender.HP > 0 then
        -- Hit
        defender.HP = defender.HP - damage
        -- love.window.setTitle(string.format("hit"))
        if defender.HP < 1 then
            love.window.setTitle(string.format("dead"))
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