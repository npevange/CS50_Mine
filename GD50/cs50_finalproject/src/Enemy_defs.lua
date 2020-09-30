--[[
    GD50
    Final Project

    Author: Nathan Evangelista
    npevangelista@ucdavis.edu
]]

ENEMY_IDS = {
    'bandit', 'swordsman'
}

ENEMY_DEFS = {
    ['bandit'] = {
        name = 'bandit',
        sprite = 'bandit.png',
        HPbase = 8,
        Attackbase = 5,
        Defensebase = 2,
        Speedbase = 2,
        Move = 3,
        HPIV = 4,
        AttackIV = 1,
        DefenseIV = 2,
        SpeedIV = 1,
        AI = 'aggro'

    },
    ['swordsman'] = {
        name = 'swordsman',
        sprite = 'swordsman.png',
        HPbase = 7,
        Attackbase = 5,
        Defensebase = 2,
        Speedbase = 3,
        Move = 3,
        HPIV = 2,
        AttackIV = 3,
        DefenseIV = 1,
        SpeedIV = 4,
        AI = 'aggro'
    }
}