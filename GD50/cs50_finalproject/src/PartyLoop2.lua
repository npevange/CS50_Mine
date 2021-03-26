--[[
    GD50
    Final Project

    Author: Nathan Evangelista
    npevangelista@ucdavis.edu
]]


PartyLoop2 = Class{}

function PartyLoop2:init()
    self.partyMembers = {}
    local name, sprite, HPbase, Attackbase, Defensebase, Speedbase, Move, HPIV, AttackIV, DefenseIV, SpeedIV, heroNum, level, _ = GetUnitDef(HERO_DEFS, HERO_IDS, 3)

    self.Nick = Unit{
        name = name, sprite = sprite, HPbase = HPbase, Attackbase = Attackbase, Defensebase = Defensebase, Speedbase = Speedbase, Move = Move, HPIV = HPIV, AttackIV = AttackIV, DefenseIV = DefenseIV, SpeedIV = SpeedIV, heroNum = heroNum, level = level
    }
    self.Nick.Range = 2

    name, sprite, HPbase, Attackbase, Defensebase, Speedbase, Move, HPIV, AttackIV, DefenseIV, SpeedIV, heroNum, level, _ = GetUnitDef(HERO_DEFS, HERO_IDS, 4)

    self.Cameron = Unit{
        name = name, sprite = sprite, HPbase = HPbase, Attackbase = Attackbase, Defensebase = Defensebase, Speedbase = Speedbase, Move = Move, HPIV = HPIV, AttackIV = AttackIV, DefenseIV = DefenseIV, SpeedIV = SpeedIV, heroNum = heroNum, level = level
    }
    

    self.partyMembers = {self.Nick, self.Cameron}

    for i, hero in pairs(self.partyMembers) do
        hero:calculateStats(self.partyMembers[i])
    end

    return self.partyMembers
end