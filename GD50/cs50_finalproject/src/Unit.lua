--[[
    GD50
    Final Project

    Author: Nathan Evangelista
    npevangelista@ucdavis.edu
]]

Unit = Class{}

function Unit:init(def)
    self.x = 0
    self.y = 0
    self.name = def.name
    self.sprite = def.sprite
    self.Turntaken = false
    self.AI = def.AI or nil


    self.HPbase = def.HPbase
    self.Attackbase = def.Attackbase
    self.Defensebase = def.Defensebase
    self.Speedbase = def.Speedbase
    self.Move = def.Move

    self.HPIV = def.HPIV
    self.AttackIV = def.AttackIV
    self.DefenseIV = def.DefenseIV
    self.SpeedIV = def.SpeedIV

    self.HP = self.HPbase
    self.Attack = self.Attackbase
    self.Defense = self.Defensebase
    self.Speed = self.Speedbase

    self.level = def.level

    self.currentEXP = 0
    self.EXPtoLevel = 100

    self:calculateStats()

    self.currentHP = self.HP
end

function Unit:calculateStats()
    --if self.level ~= nil then
        if self.level ~= nil and self.level > 0 then
            for i = 1, self.level do
                Unit:statsLevelUp()
            end
        end
    --end
end

--[[
    Need to look at IV Math later for balance.

    Skill tree upgrades every 3/5 levels???

    Class upgrade level 10/20... ???

    Takes the IV (individual value) for each stat into consideration and rolls
    the dice 3 times to see if that number is less than or equal to the IV (capped at 5).
    The dice is capped at 6 just so no stat ever increases by 3 each time, but
    higher IVs will on average give higher stat increases per level. Returns all of
    the increases so they can be displayed in the TakeTurnState on level up.
]]
function Unit:statsLevelUp()
    local HPIncrease = 0

    for j = 1, 3 do
        if math.random(6) <= self.HPIV then
            self.HP = self.HP + 1
            HPIncrease = HPIncrease + 1
        end
    end

    local attackIncrease = 0

    for j = 1, 3 do
        if math.random(6) <= self.AttackIV then
            self.Attack = self.Attack + 1
            attackIncrease = attackIncrease + 1
        end
    end

    local defenseIncrease = 0

    for j = 1, 3 do
        if math.random(6) <= self.DefenseIV then
            self.Defense = self.Defense + 1
            defenseIncrease = defenseIncrease + 1
        end
    end

    local speedIncrease = 0

    for j = 1, 3 do
        if math.random(6) <= self.SpeedIV then
            self.Speed = self.Speed + 1
            speedIncrease = speedIncrease + 1
        end
    end

    return HPIncrease, attackIncrease, defenseIncrease, speedIncrease
end

function Unit.getDef(DEFS, IDS, Unit)
    return DEFS[IDS[Unit]]
end

function Unit:render()
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.draw(gTextures[self.sprite], gFrames[self.sprite][1],
        (self.x - 1) * TILE_SIZE, (self.y - 1) * TILE_SIZE)
end