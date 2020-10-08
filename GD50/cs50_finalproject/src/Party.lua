--[[
    GD50
    Final Project

    Author: Nathan Evangelista
    npevangelista@ucdavis.edu
]]


Party = Class{}

function Party:init()
    self.partyMembers = {}

    self.Andrew = Unit({
        HERO_DEFS['Andrew']
    }, 1)

    self.Andrew.x = 1
    self.Andrew.y = 1
    self.Andrew.sprite = 'Andrew'
    self.Christian = Unit({
        HERO_DEFS['Christian']
    }, 1)
    self.Christian.x = 2
    self.Christian.y = 2
    self.Christian.sprite = 'Christian'
    
    self.partyMembers = {self.Andrew, self.Christian}

    return self.partyMembers
end

function Party:heal()
    for i, hero in pairs(self.partyMembers) do
        hero.currentHP = hero.HP
    end
end