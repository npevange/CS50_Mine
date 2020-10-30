--[[
    GD50
    Final Project

    Author: Nathan Evangelista
    npevangelista@ucdavis.edu
]]


Party = Class{}

function Party:init()
    self.partyMembers = {}

    self.Andrew = Unit{
       x = 1,
       y = 1,
       name = 'Andrew',
       sprite = 'Andrew',
       HPbase = 10,
       Attackbase = 3,
       Defensebase = 5,
       Speedbase = 4,
       Move = 3,
       HPIV = 4,
       AttackIV = 2,
       DefenseIV = 3,
       SpeedIV = 2,
       level = 1
    }

    -- self.Andrew.x = 1
    -- self.Andrew.y = 1
    -- self.Andrew.name = 'Andrew'
    -- self.Andrew.sprite = 'Andrew'
    -- self.Andrew.HPbase = 10
    -- self.Andrew.Attackbase = 3
    -- self.Andrew.Defensebase = 5
    -- self.Andrew.Speedbase = 4
    -- self.Andrew.Move = 3
    -- self.Andrew.HPIV = 4
    -- self.Andrew.AttackIV = 2
    -- self.Andrew.DefenseIV = 3
    -- self.Andrew.SpeedIV = 2
    -- self.Andrew.level = 1

    self.Christian = Unit{
       x = 1,
       y = 2,
       name = 'Christian',
       sprite = 'Christian',
       HPbase = 8,
       Attackbase = 4,
       Defensebase = 2,
       Speedbase = 6,
       Move = 3,
       HPIV = 3,
       AttackIV = 5,
       DefenseIV = 3,
        SpeedIV = 3,
       level = 1
    }

    -- self.Christian.x = 2
    -- self.Christian.y = 2
    -- self.Christian.name = 'Christian'
    -- self.Christian.sprite = 'Christian'
    -- self.Christian.HPbase = 8
    -- self.Christian.Attackbase = 4
    -- self.Christian.Defensebase = 2
    -- self.Christian.Speedbase = 6
    -- self.Christian.Move = 3
    -- self.Christian.HPIV = 3
    -- self.Christian.AttackIV = 5
    -- self.Christian.DefenseIV = 3
    -- self.Christian. SpeedIV = 3
    -- self.Christian.level = 1
    
    self.partyMembers = {self.Andrew, self.Christian}

    return self.partyMembers
end

function Party:defs()
    self.partyMembers = {}

    for i = 1, #HERO_IDS do
        local test = 0
    end
end

function Party:heal()
    for i, hero in pairs(self.partyMembers) do
        hero.currentHP = hero.HP
    end
end