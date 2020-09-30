--[[
    GD50
    Final Project

    Author: Nathan Evangelista
    npevangelista@ucdavis.edu
]]


Party = Class{}

function Party:init()
    self.partyMembers = {}

    -- for i = 1, #HERO_IDS do
    --     name = HERO_IDS[i]
    --     --def = Unit.getDef(HERO_DEFS, HERO_IDS, name)
    --     unit = Unit:init({
    --     --HERO_DEFS[HERO_IDS[i]]
    --     name = HERO_DEFS[name].name,
    --     sprite = HERO_DEFS[name].sprite,
    --     HPbase = HERO_DEFS[name].HPbase,
    --     Attackbase = HERO_DEFS[name].Attackbase,
    --     Defensebase = HERO_DEFS[name].Defensebase,
    --     Speedbase = HERO_DEFS[name].Speedbase,
    --     Move = HERO_DEFS[name].Move,
    --     HPIV = HERO_DEFS[name].HPIV,
    --     AttackIV = HERO_DEFS[name].AttackIV,
    --     DefenseIV = HERO_DEFS[name].DefenseIV,
    --     SpeedIV = HERO_DEFS[name].SpeedIV,
    --     level = HERO_DEFS[name].level
    --     })
    --     unit.sprite = HERO_DEFS[HERO_IDS[i]].sprite
    --     table.insert(self.partyMembers, unit)
    -- end

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

    -- --test 1
    -- self.test = Unit({
    --     HERO_DEFS['Christian']
    -- }, 1)
    -- table.insert(self.partyMembers, self.test)

    -- -- test 2
    -- self.test = Unit({
    --     HERO_DEFS['Christian']
    -- }, 1)
    -- table.insert(self.partyMembers, self.test)

    -- test sprite ? --error
    if #self.partyMembers == 2 then
        self.test = Unit({
            HERO_DEFS['Christian']
        }, 1)
        self.test.sprite = 'Bandit'
        self.test.x = 3
        self.test.y = 3
        table.insert(self.partyMembers, self.test)
    end

    return self.partyMembers
end

function Party:heal()
    for i, hero in pairs(self.partyMembers) do
        hero.currentHP = hero.HP
    end
end

-- function Party:render()

-- end