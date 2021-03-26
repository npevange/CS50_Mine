--[[
    GD50
    Final Project

    Author: Nathan Evangelista
    npevangelista@ucdavis.edu
]]

function CombatCalculator(attacker, defender, levelStage, combatMenu)
    local toHit = math.random(100)
    local hunterBuff = 0
    if InList(attacker.Blessing, "Hunter") then
        hunterBuff = 10
    end
    local hitChance = 70 - levelStage.hitMod[defender.y][defender.x] + (((attacker.Speed - defender.Speed)/2)^3) + hunterBuff
    -- local toHit = 50
    -- local hitChance = 70
    local damage = math.max(1, attacker.Attack - defender.Defense - levelStage.defMod[defender.y][defender.x])
    if toHit <= hitChance and defender.currentHP > 0 then
        -- Hit
        if InList(attacker.Blessing, "Blood") then
            attacker.currentHP = math.min(attacker.HP, attacker.currentHP + 1)
        end
        defender.currentHP = defender.currentHP - damage
        if defender.currentHP < 1 then
            if InList(defender.Blessing, "Stone") then
                local deathchance = math.random(100)
                if deathchance > 75 then
                    defender.currentHP = defender.currentHP + damage
                    combatMenu:text(string.format("The Blessing of Stone has hardened " .. defender.name))
                    return false
                end
            end
            combatMenu:text(string.format(attacker.name .. " has slain " .. defender.name .. ", dealing ".. damage .. " damage"))
            return true
        else
            combatMenu:text(string.format(attacker.name .. " has dealt " .. damage .. " damage to " .. defender.name))
        end
    else
        combatMenu:text(string.format(attacker.name .. " missed an attack on " .. defender.name))
        -- Miss
        -- Possible Perks here
    end
    return false
end

--text = string.format("HP: " .. self.referenceUnit.currentHP)