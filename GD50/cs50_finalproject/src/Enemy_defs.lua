--[[
    GD50
    Final Project

    Author: Nathan Evangelista
    npevangelista@ucdavis.edu
]]

ENEMY_IDS = {
    'Bandit', 'Swordsman', 'Goblin', 'GelatinousCube', 'SeaDweller'
}
BOSS_IDS = {
    'Vampire', 'Leviathan', 'Golem', 'WereWolf'
}

ENEMY_DEFS = {
    ['Bandit'] = {
        name = 'Bandit',
        sprite = 'Bandit',
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
    ['Swordsman'] = {
        name = 'Swordsman',
        sprite = 'Swordsman',
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
    },
    ['GelatinousCube'] = {
        name = 'GelatinousCube',
        sprite = 'GelatinousCube',
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
    },
    ['SeaDweller'] = {
        name = 'SeaDweller',
        sprite = 'SeaDweller',
        HPbase = 7,
        Attackbase = 5,
        Defensebase = 2,
        Speedbase = 3,
        Move = 3,
        HPIV = 4,
        AttackIV = 3,
        DefenseIV = 3,
        SpeedIV = 3,
        AI = 'aggro'
    },
    ['Goblin'] = {
        name = 'Goblin',
        sprite = 'Goblin',
        HPbase = 4,
        Attackbase = 3,
        Defensebase = 2,
        Speedbase = 3,
        Move = 3,
        HPIV = 3,
        AttackIV = 2,
        DefenseIV = 2,
        SpeedIV = 4,
        AI = 'aggro'
    }
}

BOSS_DEFS = {
    ['Vampire'] = {
        name = 'Vampire',
        sprite = 'Vampire',
        HPbase = 20,
        Attackbase = 5,
        Defensebase = 5,
        Speedbase = 5,
        Move = 3,
        HPIV = 5,
        AttackIV = 3,
        DefenseIV = 3,
        SpeedIV = 4,
        AI = 'boss'
    },
    ['Leviathan'] = {
        name = 'Leviathan',
        sprite = 'Leviathan',
        HPbase = 20,
        Attackbase = 5,
        Defensebase = 5,
        Speedbase = 5,
        Move = 3,
        HPIV = 5,
        AttackIV = 3,
        DefenseIV = 3,
        SpeedIV = 4,
        AI = 'boss'
    },
    ['Golem'] = {
        name = 'Golem',
        sprite = 'Golem',
        HPbase = 20,
        Attackbase = 5,
        Defensebase = 5,
        Speedbase = 5,
        Move = 3,
        HPIV = 5,
        AttackIV = 3,
        DefenseIV = 3,
        SpeedIV = 4,
        AI = 'boss'
    },
    ['WereWolf'] = {
        name = 'WereWolf',
        sprite = 'WereWolf',
        HPbase = 20,
        Attackbase = 5,
        Defensebase = 5,
        Speedbase = 5,
        Move = 3,
        HPIV = 5,
        AttackIV = 3,
        DefenseIV = 3,
        SpeedIV = 4,
        AI = 'boss'
    }
}