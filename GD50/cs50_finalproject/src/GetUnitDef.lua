--[[
    GD50
    Final Project

    Author: Nathan Evangelista
    npevangelista@ucdavis.edu
]]

function GetUnitDef(DEFS, IDS, Unit)
    local name = DEFS[IDS[Unit]].name
    local sprite = DEFS[IDS[Unit]].sprite
    local HPbase = DEFS[IDS[Unit]].HPbase
    local Attackbase = DEFS[IDS[Unit]].Attackbase
    local Defensebase = DEFS[IDS[Unit]].Defensebase
    local Speedbase = DEFS[IDS[Unit]].Speedbase
    local Move = DEFS[IDS[Unit]].Move
    local HPIV = DEFS[IDS[Unit]].HPIV
    local AttackIV = DEFS[IDS[Unit]].AttackIV
    local DefenseIV = DEFS[IDS[Unit]].DefenseIV
    local SpeedIV = DEFS[IDS[Unit]].SpeedIV
    local level = DEFS[IDS[Unit]].level
    local AI = DEFS[IDS[Unit]].AI
    local heroNum = DEFS[IDS[Unit]].heroNum

    return name, sprite, HPbase, Attackbase, Defensebase, Speedbase, Move, HPIV, AttackIV, DefenseIV, SpeedIV, level, heroNum, AI
end