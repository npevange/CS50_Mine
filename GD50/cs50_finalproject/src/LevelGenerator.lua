--[[
    GD50
    Final Project

    Author: Nathan Evangelista
    npevangelista@ucdavis.edu
]]

LevelGenerator = Class{}

function LevelGenerator.generate(width, height, levelNum, BossNum, BossLevel)
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

    -- Map Creation for boss levels / non boss levels (else)
    if BossLevel then
        -- Map Creation #1 Random Grass, Tree, Lakes w/ grass top
        for x = 1, width do
            for y = 1, height do
                tileID = 1
                -- tile randomizer
                if math.ceil(width / 2) == x and math.ceil(height / 2) == y then
                    tileID = 4 --Castle
                end

                hitmod, defmod = TerrainDef(tileID)
                table.insert(tiles[y],
                Tile(x, y, tileID))
                table.insert(hitMod[y], hitmod)
                table.insert(defMod[y], defmod)
            end
        end

        local name, sprite, HPbase, Attackbase, Defensebase, Speedbase, Move, HPIV, AttackIV, DefenseIV, SpeedIV, level, heroNum, AI
        name, sprite, HPbase, Attackbase, Defensebase, Speedbase, Move, HPIV, AttackIV, DefenseIV, SpeedIV, level, _, AI = GetUnitDef(BOSS_DEFS, BOSS_IDS, BossNum)
        enemy = Unit{
            name = name, sprite = sprite, HPbase = HPbase, Attackbase = Attackbase, Defensebase = Defensebase, Speedbase = Speedbase, Move = Move, HPIV = HPIV, AttackIV = AttackIV, DefenseIV = DefenseIV, SpeedIV = SpeedIV, level = level, AI = AI
        }
        table.insert(enemies, enemy)

        enemy.x = math.ceil(width / 2)
        enemy.y = math.ceil(height / 2)

    else
        -- Map Creation #1 Random Grass, Tree, Lakes w/ grass top
        for x = 1, width do
            tileID = 1
            for y = 1, height do
                -- tile randomizer
                if y > 1 then
                    local random = math.random(1,100)
                    if random < 60 then --Grass
                        tileID = 1
                    elseif random < 75 then --Tree
                        tileID = 2
                    elseif random < 95 then --Lake
                        tileID = 3
                    else -- House
                        tileID = 5
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
        if levelNum > 20 then
            numEnemies = math.random(2,3)

        elseif levelNum > 15 then
            numEnemies = math.random(2,3)

        elseif levelNum > 10 then
            numEnemies = math.random(2,3)

        elseif levelNum > 5 then
            numEnemies = math.random(2,3)
            first = 1
            last = 3
            
        else -- levelNum < 5
            numEnemies = math.random(2,3)
            first = 1
            last = 2
        end
        
        local unitsPlaced = 0
        local row = 0
        local name, sprite, HPbase, Attackbase, Defensebase, Speedbase, Move, HPIV, AttackIV, DefenseIV, SpeedIV, level, AI

        if numEnemies <= height then
            for x = 1, numEnemies do
                name, sprite, HPbase, Attackbase, Defensebase, Speedbase, Move, HPIV, AttackIV, DefenseIV, SpeedIV, level, _, AI = GetUnitDef(ENEMY_DEFS, ENEMY_IDS, math.random(first,last))
                enemy = Unit{
                    name = name, sprite = sprite, HPbase = HPbase, Attackbase = Attackbase, Defensebase = Defensebase, Speedbase = Speedbase, Move = Move, HPIV = HPIV, AttackIV = AttackIV, DefenseIV = DefenseIV, SpeedIV = SpeedIV, level = level, AI = AI
                }
                table.insert(enemies, enemy)

                enemy.x = width
                enemy.y = height + 1 - x
            end
        end
    end


    local map = TileMap(width, height)
    map.tiles = tiles
    
    return GameLevel(entities, enemies, map, hitMod, defMod)
end