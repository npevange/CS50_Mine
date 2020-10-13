--[[
    GD50
    Final Project

    Author: Nathan Evangelista
    npevangelista@ucdavis.edu
]]

LevelGenerator = Class{}

function LevelGenerator.generate(width, height, level)
    local tiles = {}
    local entities = {}
    local enemies = {}

    local tileID = TILE_ID_GRASS

    -- Introduce some rng for map creation
    for x = 1, height do
        table.insert(tiles, {})
    end

    for x = 1, width do
        for y = 1, height do
            table.insert(tiles[y],
            Tile(x,y, tileID))
        end
    end

    -- Enemy Generation
    local numEnemies = 2 --math.random(3,6)

    for x = 1, numEnemies do
        enemy = Unit({
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
        }, 1)
        table.insert(enemies, enemy)

        enemy.x = x + 2
        enemy.y = x + 2
    end

    local map = TileMap(width, height)
    map.tiles = tiles
    
    return GameLevel(entities, enemies, map)
end