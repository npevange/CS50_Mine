--[[
    GD50
    Final Project

    Author: Nathan Evangelista
    npevangelista@ucdavis.edu
]]


Party = Class{}

function Party:init()
    self.partyMembers = {}
    local name, sprite, HPbase, Attackbase, Defensebase, Speedbase, Move, HPIV, AttackIV, DefenseIV, SpeedIV, level = GetUnitDef(HERO_DEFS, HERO_IDS, 1)
    
    self.Andrew = Unit{
        name = name, sprite = sprite, HPbase = HPbase, Attackbase = Attackbase, Defensebase = Defensebase, Speedbase = Speedbase, Move = Move, HPIV = HPIV, AttackIV = AttackIV, DefenseIV = DefenseIV, SpeedIV = SpeedIV, level = level
    }
    -- love.window.setTitle(string.format(self.Andrew.level))
    --    name = 'Andrew',
    --    sprite = 'Andrew',
    --    HPbase = 10,
    --    Attackbase = 3,
    --    Defensebase = 5,
    --    Speedbase = 4,
    --    Move = 3,
    --    HPIV = 4,
    --    AttackIV = 2,
    --    DefenseIV = 3,
    --    SpeedIV = 2,
    --    level = 1
    -- }

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

    name, sprite, HPbase, Attackbase, Defensebase, Speedbase, Move, HPIV, AttackIV, DefenseIV, SpeedIV, level = GetUnitDef(HERO_DEFS, HERO_IDS, 2)
    self.Christian = Unit{
        name = name, sprite = sprite, HPbase = HPbase, Attackbase = Attackbase, Defensebase = Defensebase, Speedbase = Speedbase, Move = Move, HPIV = HPIV, AttackIV = AttackIV, DefenseIV = DefenseIV, SpeedIV = SpeedIV, level = level
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