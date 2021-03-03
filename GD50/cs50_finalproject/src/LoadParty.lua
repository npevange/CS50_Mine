--[[
    GD50
    Final Project

    Author: Nathan Evangelista
    npevangelista@ucdavis.edu
]]
LoadParty = Class{}

function LoadParty:init(inputs)
    local name, sprite, HPbase, Attackbase, Defensebase, Speedbase, Move, HPIV, AttackIV, DefenseIV, SpeedIV, heroNum, level, _
    self.party = {}
    for i, heroes in pairs(inputs) do
        if inputs[i]['heroNum'] == 1 then
            name, sprite, HPbase, Attackbase, Defensebase, Speedbase, Move, HPIV, AttackIV, DefenseIV, SpeedIV, heroNum, level, _ = GetUnitDef(HERO_DEFS, HERO_IDS, 1)
            self.Andrew = Unit{
                name = name, sprite = sprite, HPbase = HPbase, Attackbase = Attackbase, Defensebase = Defensebase, Speedbase = Speedbase, Move = Move, HPIV = HPIV, AttackIV = AttackIV, DefenseIV = DefenseIV, SpeedIV = SpeedIV, heroNum = heroNum, level = level
            }
            self.Andrew.HP = inputs[i]['HP']
            self.Andrew.Attack = inputs[i]['Attack']
            self.Andrew.Defense = inputs[i]['Defense']
            self.Andrew.Speed = inputs[i]['Speed']
            self.Andrew.Blessing = inputs[i]['Blessing']
            table.insert(self.party, 1, self.Andrew)
        elseif inputs[i]['heroNum'] == 2 then
            name, sprite, HPbase, Attackbase, Defensebase, Speedbase, Move, HPIV, AttackIV, DefenseIV, SpeedIV, heroNum, level, _ = GetUnitDef(HERO_DEFS, HERO_IDS, 2)
            self.Christian = Unit{
                name = name, sprite = sprite, HPbase = HPbase, Attackbase = Attackbase, Defensebase = Defensebase, Speedbase = Speedbase, Move = Move, HPIV = HPIV, AttackIV = AttackIV, DefenseIV = DefenseIV, SpeedIV = SpeedIV, heroNum = heroNum, level = level
            }
            self.Christian.HP = inputs[i]['HP']
            self.Christian.Attack = inputs[i]['Attack']
            self.Christian.Defense = inputs[i]['Defense']
            self.Christian.Speed = inputs[i]['Speed']
            self.Christian.Blessing = inputs[i]['Blessing']
            table.insert(self.party, 1, self.Christian)
        elseif inputs[i]['heroNum'] == 3 then
            name, sprite, HPbase, Attackbase, Defensebase, Speedbase, Move, HPIV, AttackIV, DefenseIV, SpeedIV, heroNum, level, _ = GetUnitDef(HERO_DEFS, HERO_IDS, 3)
            self.Nick = Unit{
                name = name, sprite = sprite, HPbase = HPbase, Attackbase = Attackbase, Defensebase = Defensebase, Speedbase = Speedbase, Move = Move, HPIV = HPIV, AttackIV = AttackIV, DefenseIV = DefenseIV, SpeedIV = SpeedIV, heroNum = heroNum, level = level
            }
            self.Nick.HP = inputs[i]['HP']
            self.Nick.Attack = inputs[i]['Attack']
            self.Nick.Defense = inputs[i]['Defense']
            self.Nick.Speed = inputs[i]['Speed']
            self.Nick.Speed = inputs[i]['Blessing']
            self.Nick.Range = 2
            table.insert(self.party, 1, self.Nick)
        elseif inputs[i]['heroNum'] == 4 then
            name, sprite, HPbase, Attackbase, Defensebase, Speedbase, Move, HPIV, AttackIV, DefenseIV, SpeedIV, heroNum, level, _ = GetUnitDef(HERO_DEFS, HERO_IDS, 4)
            self.Cameron = Unit{
                name = name, sprite = sprite, HPbase = HPbase, Attackbase = Attackbase, Defensebase = Defensebase, Speedbase = Speedbase, Move = Move, HPIV = HPIV, AttackIV = AttackIV, DefenseIV = DefenseIV, SpeedIV = SpeedIV, heroNum = heroNum, level = level
            }
            self.Cameron.HP = inputs[i]['HP']
            self.Cameron.Attack = inputs[i]['Attack']
            self.Cameron.Defense = inputs[i]['Defense']
            self.Cameron.Speed = inputs[i]['Speed']
            self.Cameron.Defense = inputs[i]['Blessing']
            table.insert(self.party, 1, self.Cameron)
        end
    end
    return self.party
end

-- [1] = Party
-- [2] = levelNum
-- [3] = BossNum
-- [4] = BossLevel
-- [5] = SaveState