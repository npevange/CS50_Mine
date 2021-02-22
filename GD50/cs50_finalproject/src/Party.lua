--[[
    GD50
    Final Project

    Author: Nathan Evangelista
    npevangelista@ucdavis.edu
]]


Party = Class{}

function Party:init()
    self.partyMembers = {}
    local name, sprite, HPbase, Attackbase, Defensebase, Speedbase, Move, HPIV, AttackIV, DefenseIV, SpeedIV, heroNum, level = GetUnitDef(HERO_DEFS, HERO_IDS, 1)

    self.Andrew = Unit{
        name = name, sprite = sprite, HPbase = HPbase, Attackbase = Attackbase, Defensebase = Defensebase, Speedbase = Speedbase, Move = Move, HPIV = HPIV, AttackIV = AttackIV, DefenseIV = DefenseIV, SpeedIV = SpeedIV, heroNum = heroNum, level = level
    }

    name, sprite, HPbase, Attackbase, Defensebase, Speedbase, Move, HPIV, AttackIV, DefenseIV, SpeedIV, level = GetUnitDef(HERO_DEFS, HERO_IDS, 2)
    self.Christian = Unit{
        name = name, sprite = sprite, HPbase = HPbase, Attackbase = Attackbase, Defensebase = Defensebase, Speedbase = Speedbase, Move = Move, HPIV = HPIV, AttackIV = AttackIV, DefenseIV = DefenseIV, SpeedIV = SpeedIV, heroNum = heroNum, level = level
    }
    self.partyMembers = {self.Andrew, self.Christian}

    for i, hero in pairs(self.partyMembers) do
        hero:calculateStats(self.partyMembers[i])
    end

    return self.partyMembers
end