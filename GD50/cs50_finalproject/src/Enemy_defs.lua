--[[
    GD50
    Final Project

    Author: Nathan Evangelista
    npevangelista@ucdavis.edu
]]

ENEMY_IDS = {
    'Bandit', 'Swordsman', 'Goblin', 'OrcWarrior', 'OrcBerserker', 'SeaDweller'
}
BOSS_IDS = {
    'Vampire', 'Golem', 'Leviathan', 'WereWolf','DemonKnight','Dhampir', 'Ent', 'EmeraldSerpent', 'YoungWereWolf','DemonKnight2'
}

BOSS_IDS_2 = {
    'Dhampir', 'Ent', 'EmeraldSerpent', 'YoungWereWolf'
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
    ['OrcWarrior'] = {
        name = 'Orc Warrior',
        sprite = 'OrcWarrior',
        HPbase = 7,
        Attackbase = 5,
        Defensebase = 4,
        Speedbase = 3,
        Move = 3,
        HPIV = 2,
        AttackIV = 2,
        DefenseIV = 1,
        SpeedIV = 2,
        AI = 'aggro'
    },
    ['OrcBerserker'] = {
        name = 'Orc Berserker',
        sprite = 'OrcBerserker',
        HPbase = 7,
        Attackbase = 5,
        Defensebase = 2,
        Speedbase = 3,
        Move = 3,
        HPIV = 2,
        AttackIV = 3,
        DefenseIV = 1,
        SpeedIV = 3,
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
        DefenseIV = 2,
        SpeedIV = 3,
        AI = 'aggro'
    },
    ['Goblin'] = {
        name = 'Goblin',
        sprite = 'Goblin',
        HPbase = 4,
        Attackbase = 3,
        Defensebase = 2,
        Speedbase = 2,
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
        Attackbase = 7,
        Defensebase = 7,
        Speedbase = 8,
        Move = 3,
        HPIV = 5,
        AttackIV = 3,
        DefenseIV = 3,
        SpeedIV = 4,
        AI = 'boss',
        level = 3
    },
    ['Leviathan'] = {
        name = 'Leviathan',
        sprite = 'Leviathan',
        HPbase = 30,
        Attackbase = 11,
        Defensebase = 7,
        Speedbase = 7,
        Move = 3,
        HPIV = 5,
        AttackIV = 3,
        DefenseIV = 3,
        SpeedIV = 4,
        AI = 'boss',
        level = 3
    },
    ['Golem'] = {
        name = 'Golem',
        sprite = 'Golem',
        HPbase = 25,
        Attackbase = 9,
        Defensebase = 7,
        Speedbase = 5,
        Move = 3,
        HPIV = 5,
        AttackIV = 3,
        DefenseIV = 3,
        SpeedIV = 4,
        AI = 'boss',
        level = 3
    },
    ['WereWolf'] = {
        name = 'WereWolf',
        sprite = 'WereWolf',
        HPbase = 40,
        Attackbase = 12,
        Defensebase = 5,
        Speedbase = 10,
        Move = 3,
        HPIV = 5,
        AttackIV = 3,
        DefenseIV = 3,
        SpeedIV = 4,
        AI = 'boss',
        level = 3
    },
    ['Dhampir'] = {
        name = 'Dhampir',
        sprite = 'Dhampir',
        HPbase = 20,
        Attackbase = 7,
        Defensebase = 7,
        Speedbase = 8,
        Move = 3,
        HPIV = 5,
        AttackIV = 3,
        DefenseIV = 3,
        SpeedIV = 4,
        AI = 'boss',
        level = 3
    },
    ['EmeraldSerpent'] = {
        name = 'Emerald Serpent',
        sprite = 'EmeraldSerpent',
        HPbase = 30,
        Attackbase = 11,
        Defensebase = 7,
        Speedbase = 7,
        Move = 3,
        HPIV = 5,
        AttackIV = 3,
        DefenseIV = 3,
        SpeedIV = 4,
        AI = 'boss',
        level = 3
    },
    ['Ent'] = {
        name = 'Ent',
        sprite = 'Ent',
        HPbase = 25,
        Attackbase = 8,
        Defensebase = 7,
        Speedbase = 5,
        Move = 3,
        HPIV = 5,
        AttackIV = 3,
        DefenseIV = 3,
        SpeedIV = 4,
        AI = 'boss',
        level = 3
    },
    ['YoungWereWolf'] = {
        name = 'Young WereWolf',
        sprite = 'YoungWereWolf',
        HPbase = 40,
        Attackbase = 10,
        Defensebase = 5,
        Speedbase = 10,
        Move = 3,
        HPIV = 5,
        AttackIV = 3,
        DefenseIV = 3,
        SpeedIV = 4,
        AI = 'boss',
        level = 3
    },
    ['DemonKnight'] = {
        name = 'Demon Knight',
        sprite = 'DemonKnight',
        HPbase = 45,
        Attackbase = 10,
        Defensebase = 8,
        Speedbase = 5,
        Move = 3,
        HPIV = 5,
        AttackIV = 3,
        DefenseIV = 3,
        SpeedIV = 4,
        AI = 'boss',
        level = 3
    },
    ['DemonKnight2'] = {
        name = 'Demon Knight',
        sprite = 'DemonKnight2',
        HPbase = 45,
        Attackbase = 10,
        Defensebase = 8,
        Speedbase = 5,
        Move = 3,
        HPIV = 5,
        AttackIV = 3,
        DefenseIV = 3,
        SpeedIV = 4,
        AI = 'boss',
        level = 3
    },
}