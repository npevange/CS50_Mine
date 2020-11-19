--[[
    GD50
    Final Project

    Author: Nathan Evangelista
    npevangelista@ucdavis.edu
]]

function PartyHeal(party)
    for i, hero in pairs(party) do
        hero.currentHP = hero.HP
        hero.turnTaken = false
        hero.moveTaken = false
        hero.actionTaken = false
    end
end