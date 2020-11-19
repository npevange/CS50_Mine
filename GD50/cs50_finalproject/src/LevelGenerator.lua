--[[
    GD50
    Final Project

    Author: Nathan Evangelista
    npevangelista@ucdavis.edu
]]

LevelGenerator = Class{}

function LevelGenerator.generate(width, height, levelNum)
    local tiles = {}
    local hitMod = {}
    local defMod = {}
    local entities = {}
    local enemies = {}

    local tileID = TILE_ID_GRASS

    -- Introduce some rng for map creation
    for x = 1, height do
        table.insert(tiles, {})
        table.insert(hitMod, {})
        table.insert(defMod, {})
    end

    for x = 1, width do
        for y = 1, height do
            hitmod, defmod = TerrainDef(tileID)
            table.insert(tiles[y],
            Tile(x, y, tileID))
            table.insert(hitMod[y], hitmod)
            table.insert(defMod[y], defmod)
        end
    end

    -- Enemy Generation
    local numEnemies = 3 --math.random(2,3)
    local name, sprite, HPbase, Attackbase, Defensebase, Speedbase, Move, HPIV, AttackIV, DefenseIV, SpeedIV, level, AI
    for x = 1, numEnemies do
        name, sprite, HPbase, Attackbase, Defensebase, Speedbase, Move, HPIV, AttackIV, DefenseIV, SpeedIV, level, AI = GetUnitDef(ENEMY_DEFS, ENEMY_IDS, x)
        enemy = Unit{
            name = name, sprite = sprite, HPbase = HPbase, Attackbase = Attackbase, Defensebase = Defensebase, Speedbase = Speedbase, Move = Move, HPIV = HPIV, AttackIV = AttackIV, DefenseIV = DefenseIV, SpeedIV = SpeedIV, level = levelNum, AI = AI
        }
        table.insert(enemies, enemy)

        enemy.x = width
        enemy.y = height - x
    end

    -- enemy = Unit({
    --     name = 'Swordsman',
    --     sprite = 'Swordsman',
    --     HPbase = 7,
    --     Attackbase = 5,
    --     Defensebase = 2,
    --     Speedbase = 3,
    --     Move = 3,
    --     HPIV = 2,
    --     AttackIV = 3,
    --     DefenseIV = 1,
    --     SpeedIV = 4,
    --     AI = 'aggro',
    --     level = 1
    -- })
    -- table.insert(enemies, enemy)

    -- enemy.x = width
    -- enemy.y = height


    local map = TileMap(width, height)
    map.tiles = tiles
    
    return GameLevel(entities, enemies, map, hitMod, defMod)
end