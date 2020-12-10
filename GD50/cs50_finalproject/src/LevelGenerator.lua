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

    local tileID = TILE_ID_GRASS -- 1

    for x = 1, height do
        table.insert(tiles, {})
        table.insert(hitMod, {})
        table.insert(defMod, {})
    end


    -- Map Creation #1 Random Grass, Tree, Lakes w/ grass top
    for x = 1, width do
        tileID = 1
        for y = 1, height do
            -- tile randomizer
            if y > 1 then
                local random = math.random(1,100)
                if random < 60 then
                    tileID = 1
                elseif random < 80 then
                    tileID = 2
                else
                    tileID = 3
                end
            end

            hitmod, defmod = TerrainDef(tileID)
            table.insert(tiles[y],
            Tile(x, y, tileID))
            table.insert(hitMod[y], hitmod)
            table.insert(defMod[y], defmod)
        end
    end

    -- Enemy Generation
    local numEnemies = 7 --math.random(2,3)
    local unitsPlaced = 0
    local row = 0
    local name, sprite, HPbase, Attackbase, Defensebase, Speedbase, Move, HPIV, AttackIV, DefenseIV, SpeedIV, level, AI

    if numEnemies <= height then
        for x = 1, numEnemies do
            name, sprite, HPbase, Attackbase, Defensebase, Speedbase, Move, HPIV, AttackIV, DefenseIV, SpeedIV, level, AI = GetUnitDef(ENEMY_DEFS, ENEMY_IDS, math.random(1,3))
            enemy = Unit{
                name = name, sprite = sprite, HPbase = HPbase, Attackbase = Attackbase, Defensebase = Defensebase, Speedbase = Speedbase, Move = Move, HPIV = HPIV, AttackIV = AttackIV, DefenseIV = DefenseIV, SpeedIV = SpeedIV, level = levelNum, AI = AI
            }
            table.insert(enemies, enemy)

            enemy.x = width
            enemy.y = height + 1 - x
        end
    else
        while (unitsPlaced < numEnemies) do
            for x = 1, height do
                name, sprite, HPbase, Attackbase, Defensebase, Speedbase, Move, HPIV, AttackIV, DefenseIV, SpeedIV, level, AI = GetUnitDef(ENEMY_DEFS, ENEMY_IDS, math.random(1,3))
                enemy = Unit{
                    name = name, sprite = sprite, HPbase = HPbase, Attackbase = Attackbase, Defensebase = Defensebase, Speedbase = Speedbase, Move = Move, HPIV = HPIV, AttackIV = AttackIV, DefenseIV = DefenseIV, SpeedIV = SpeedIV, level = levelNum, AI = AI
                }
                table.insert(enemies, enemy)

                enemy.x = width - row
                enemy.y = height + 1 - x
                unitsPlaced = unitsPlaced + 1
                if unitsPlaced == numEnemies then
                    break
                end
            end
            row = row + 1
        end
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