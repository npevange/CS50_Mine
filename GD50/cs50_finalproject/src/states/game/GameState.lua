--[[
    GD50
    Final Project

    Author: Nathan Evangelista
    npevangelista@ucdavis.edu
]]


GameState = Class{__includes = BaseState}

function GameState:enter(enterParams) --party, levelNum, bossNum
    -- init party
    self.party = enterParams[1] or Party:init()
    PartyHeal(self.party)
    -- init level
    self.party1 = {}
    self.levelNum = enterParams[2] or 1
    self.BossNum = enterParams[3] or 0
    self.BossLevel = enterParams[4] or false
    self.SaveState = enterParams[5]

    -- Control unit selector
    self.selectedUnit = false
    self.currentUnit = nil
    self.currentUnitIndex = nil
    self.currentDefender = nil
    self.currentDefenderIndex = nil

    -- Control command menu
    self.commandMenuBool = false
    self.commandAttackBool = false
    self.commandMoveBool = false
    self.commandMagicBool = false
    
    -- Options menus
    self.optionsMenuBool = false

    self.EndTurn = false
    self.EndTurnCounter = 0

    -- Command Menu options
    self.commandsMenu = Menu {
        x = VIRTUAL_WIDTH - 64,
        y = VIRTUAL_HEIGHT - 80,
        width = 64,
        height = 80,
        selectionOn = true,
        items = {
            {
                text = 'Move',
                onSelect = function ()
                    if self.currentUnit.moveTaken == false then
                        self.commandMenuBool = false
                        self.commandMoveBool = true
                    end
                end
            },
            {
                text = 'Attack',
                onSelect = function ()
                    if self.currentUnit.actionTaken == false then
                        self.commandMenuBool = false
                        self.commandAttackBool = true
                    end
                end
            },
            {
                text = 'Wait',
                onSelect = function ()
                    self.currentUnit.turnTaken = true
                    self.currentUnit.moveTaken = true
                    self.currentUnit.actionTaken = true
                    self.commandMenuBool = false
                end
            },
            {
                text = 'Cancel',
                onSelect = function ()
                    self.commandMenuBool = false
                    self.commandMoveBool = false
                    self.commandAttackBool = false
                    self.currentUnit = nil
                end
            }
        }
    }

    self.optionsMenu = Menu {
        x = VIRTUAL_WIDTH - 64,
        y = VIRTUAL_HEIGHT - 80,
        width = 64,
        height = 80,
        selectionOn = true,
        items = {
            {
                text = 'Retreat (Save Game)',
                onSelect = function ()
                    name = tostring(self.SaveState .. '.txt')
                    data = SaveObject(self.party, self.levelNum, self.BossNum, self.BossLevel, self.SaveState, 'load') --love.filesystem.getSaveDirectory() Gives full path to where data is saved.
                    success, message = love.filesystem.write( name, data)

                    nameLevel = tostring(self.SaveState .. 'Level.txt')
                    dataLevel = SaveObject(self.party, self.levelNum, self.BossNum, self.BossLevel, self.SaveState, 'level')
                    success, message = love.filesystem.write( nameLevel, dataLevel)

                    love.event.quit()
                end
            },
            {
                text = 'Cancel',
                onSelect = function ()
                    self.optionsMenuBool = false
                end
            },
        }
    }
    GameState:level(self)
end

-- Call to set level
function GameState:level(self)
    self.levelx = 8 --math.random(6,8) --#self.levelStage.tileMap.tiles[1]
    self.levely = 5 --math.random(4,5) --#self.levelStage.tileMap.tiles
    -- Check for loaded Level / enemies
    if self.levelNum == 17 then
        self.party1 = self.party
        self.party = PartyLoop2:init()
    end

    self.levelStage = LevelGenerator.generate(self.levelx, self.levely, self.levelNum, self.BossNum, self.BossLevel) --Game Level entities, objects, tiles
    
    for i, heroes in pairs(self.party) do
        table.insert(self.levelStage.entities, self.party[i])
        self.levelStage.entities[i].x = 1
        self.levelStage.entities[i].y = i
    end


    self.highlightedTile = HighlightedTile(self.levelStage.entities[1].x, self.levelStage.entities[1].y)

    self.currentLocations = CurrentLocations(self.levelStage)
    self.levelStage.currentLocations = self.currentLocations

    -- Hero stats menu
    self.characterheroMenu = CharacterMenu {
        x = VIRTUAL_WIDTH - 128,
        y = 0,
        width = 128,
        height = 136,
        group = self.levelStage.entities,
        mapHit = self.levelStage.hitMod,
        mapDef = self.levelStage.defMod,
        selectionOn = false
    }

    -- Enemy stats menu
    self.characterenemyMenu = CharacterMenu {
        x = VIRTUAL_WIDTH - 128,
        y = 0,
        width = 128,
        height = 136,
        group = self.levelStage.enemies,
        mapHit = self.levelStage.hitMod,
        mapDef = self.levelStage.defMod,
        selectionOn = false
    }
    
    self.combatMenu = CombatMenu{
        x = 0,
        y = VIRTUAL_HEIGHT - 56,
        width = VIRTUAL_WIDTH - 128,
        height = 56,
        selectionOn = false
    }
end

function GameState:update(dt)
    if #self.levelStage.enemies == 0 then
        -- You Win
        self.levelNum = self.levelNum + 1
        -- Party Management
        PartyHeal(self.party)
        for i, hero in pairs(self.party) do
            hero:statsLevelUp(self.party[i])
        end
        if InList(gBossLevels, self.levelNum) then
            self.BossNum = self.BossNum + 1
            self.BossLevel = true
            -- name = tostring(self.SaveState .. '.txt')
            -- data = SaveObject(self.party, self.levelNum, self.BossNum, self.BossLevel, self.SaveState, 'load') --love.filesystem.getSaveDirectory() Gives full path to where data is saved.
            -- success, message = love.filesystem.write( name, data)

            -- nameLevel = tostring(self.SaveState .. 'Level.txt')
            -- dataLevel = SaveObject(self.party, self.levelNum, self.BossNum, self.BossLevel, self.SaveState, 'level')
            -- success, message = love.filesystem.write( nameLevel, dataLevel)
            gStateMachine:change('textstate', {gBossQuotes[self.BossNum] , 'gamestate' , {self.party, self.levelNum, self.BossNum, self.BossLevel, self.SaveState}})

            -- table.insert(self.party, 1, self.Andrew)

        elseif InList(gQuoteLevels, self.levelNum) then
            if InList(gBlessingLevels, self.levelNum) then
                if gBlessingLevels[1] == self.levelNum then
                    for i, hero in pairs(self.party) do
                        table.insert(hero.Blessing, 1, 'Blood')
                    end
                elseif gBlessingLevels[2] == self.levelNum then
                    for i, hero in pairs(self.party) do
                        table.insert(hero.Blessing, 1, 'Stone')
                    end
                elseif gBlessingLevels[3] == self.levelNum then
                    for i, hero in pairs(self.party) do
                        table.insert(hero.Blessing, 1, 'Tempest')
                    end
                elseif gBlessingLevels[4] == self.levelNum then
                    for i, hero in pairs(self.party) do
                        table.insert(hero.Blessing, 1, 'Hunter')
                    end
                elseif gBlessingLevels[5] == self.levelNum then
                    for i, hero in pairs(self.party) do
                        table.insert(hero.Blessing, 1, 'Blood')
                    end
                elseif gBlessingLevels[6] == self.levelNum then
                    for i, hero in pairs(self.party) do
                        table.insert(hero.Blessing, 1, 'Stone')
                    end
                elseif gBlessingLevels[7] == self.levelNum then
                    for i, hero in pairs(self.party) do
                        table.insert(hero.Blessing, 1, 'Tempest')
                    end
                elseif gBlessingLevels[8] == self.levelNum then
                    for i, hero in pairs(self.party) do
                        table.insert(hero.Blessing, 1, 'Hunter')
                    end
                end
            end
            self.BossLevel = false
            
            -- name = tostring(self.SaveState .. '.txt')
            -- data = SaveObject(self.party, self.levelNum, self.BossNum, self.BossLevel, self.SaveState, 'load') --love.filesystem.getSaveDirectory() Gives full path to where data is saved.
            -- success, message = love.filesystem.write( name, data)

            -- nameLevel = tostring(self.SaveState .. 'Level.txt')
            -- dataLevel = SaveObject(self.party, self.levelNum, self.BossNum, self.BossLevel, self.SaveState, 'level')
            -- success, message = love.filesystem.write( nameLevel, dataLevel)
            gStateMachine:change('textstate', {gQuotes[self.levelNum] , 'gamestate' , {self.party, self.levelNum, self.BossNum, self.BossLevel, self.SaveState}})
        else
            -- name = tostring(self.SaveState .. '.txt')
            -- data = SaveObject(self.party, self.levelNum, self.BossNum, self.BossLevel, self.SaveState, 'load') --love.filesystem.getSaveDirectory() Gives full path to where data is saved.
            -- success, message = love.filesystem.write( name, data)

            -- nameLevel = tostring(self.SaveState .. 'Level.txt')
            -- dataLevel = SaveObject(self.party, self.levelNum, self.BossNum, self.BossLevel, self.SaveState, 'level')
            -- success, message = love.filesystem.write( nameLevel, dataLevel)
            gStateMachine:change('textstate', {gQuoteGameEnd[1] , 'mainmenu'})
        end
    end
    self.characterheroMenu:update(dt, self.highlightedTile.x, self.highlightedTile.y)
    self.characterenemyMenu:update(dt, self.highlightedTile.x, self.highlightedTile.y)
    self.combatMenu:update(dt)
    for i, heroes in pairs(self.levelStage.entities) do
        if self.levelStage.entities[i].turnTaken == false then
            break
        else
            self.EndTurnCounter = self.EndTurnCounter + 1
        end
    end
    if self.EndTurnCounter == #self.levelStage.entities then
        self.EndTurn = true
    end
    self.EndTurnCounter = 0
    if self.EndTurn == true then
        -- End Turn Sequence

        -- Opponents take turns
        for i, enemy in pairs(self.levelStage.enemies) do
            --Enemy Turn action, move and attack.

            self.currentLocations = CurrentLocations(self.levelStage)
            self.levelStage.currentLocations = self.currentLocations

            EnemyTurn(enemy, self.levelStage, i, self.combatMenu)

            self.currentLocations = CurrentLocations(self.levelStage)
            self.levelStage.currentLocations = self.currentLocations

            if #self.levelStage.entities == 0 then
                gStateMachine:change('textstate', {gEndings[1], 'mainmenu'})
                break
            end
        end

        -- reset heroes turns
        for i, heroes in pairs(self.levelStage.entities) do
            self.levelStage.entities[i].turnTaken = false
            self.levelStage.entities[i].moveTaken = false
            self.levelStage.entities[i].actionTaken = false
        end
        self.currentLocations = CurrentLocations(self.levelStage)
        self.levelStage.currentLocations = self.currentLocations
        self.EndTurn = false
    end
    if self.commandMenuBool == false and self.optionsMenuBool == false then
        -- move cursor around based on bounds of grid
        if love.keyboard.wasPressed('up') then
            self.highlightedTile.y = math.max(1, self.highlightedTile.y - 1)

        elseif love.keyboard.wasPressed('down') then
            self.highlightedTile.y = math.min(self.levely, self.highlightedTile.y + 1)

        elseif love.keyboard.wasPressed('left') then
            self.highlightedTile.x = math.max(1, self.highlightedTile.x - 1)

        elseif love.keyboard.wasPressed('right') then
            self.highlightedTile.x = math.min(self.levelx, self.highlightedTile.x + 1)
        elseif love.keyboard.wasPressed('m') then
            self.optionsMenuBool = true
        elseif love.keyboard.wasPressed('space') then
            
            --Command Menu if selecting a hero
            if self.commandMenuBool == false and self.commandMoveBool == false and self.commandAttackBool == false then
                gSounds['blip']:play()
                for i, heroes in pairs(self.levelStage.entities) do
                    if self.levelStage.entities[i].x == self.highlightedTile.x and self.levelStage.entities[i].y == self.highlightedTile.y then
                        self.selectedUnit = true
                        self.currentUnit = self.levelStage.entities[i]
                        self.currentUnitIndex = i
                        self.commandMenuBool = true
                    end
                end
            -- Move command
            elseif self.commandMoveBool == true then
                if (math.abs(self.currentUnit.x - self.highlightedTile.x) + math.abs(self.currentUnit.y - self.highlightedTile.y)) <= self.currentUnit.Move then
                    if self.currentLocations.entities[self.highlightedTile.y][self.highlightedTile.x] == false and self.currentLocations.enemies[self.highlightedTile.y][self.highlightedTile.x] == false then
                        local TempX = self.highlightedTile.x
                        local TempY = self.highlightedTile.y
                        Timer.tween(0.5, {
                            [self.currentUnit] = {x = TempX, y = TempY},
                        })
                        :finish(function()
                            self.currentUnit.x = TempX
                            self.currentUnit.y = TempY
                            self.currentLocations = CurrentLocations(self.levelStage)
                            self.levelStage.currentLocations = self.currentLocations
                            self.currentUnit.moveTaken = true
                            self.commandMoveBool = false
                        end)
                    end
                else
                    self.commandMoveBool = false
                    self.commandMenuBool = true
                end
                
            -- Attack command
            elseif self.commandAttackBool == true then
                if (math.abs(self.currentUnit.x - self.highlightedTile.x) + math.abs(self.currentUnit.y - self.highlightedTile.y)) <= self.currentUnit.Range then
                    if self.currentLocations.enemies[self.highlightedTile.y][self.highlightedTile.x] == true then
                        for i, enemies in pairs(self.levelStage.enemies) do
                            if self.levelStage.enemies[i].x == self.highlightedTile.x and self.levelStage.enemies[i].y == self.highlightedTile.y then
                                self.currentDefender = self.levelStage.enemies[i]
                                self.currentDefenderIndex = i
                            end
                        end
                        
                        -- attack stuff goes here, check for enemy in the tile, calculate damage, etc.
                        local deadUnit = false
                        deadUnit = CombatCalculator(self.currentUnit, self.currentDefender, self.levelStage, self.combatMenu)
                        -- if dead units, remove from levelStage
                        if deadUnit == true then
                            if self.currentUnit.currentHP < 1 then
                                table.remove(self.levelStage.entities, self.currentUnitIndex)
                            end
                            if self.currentDefender.currentHP < 1 then
                                self.currentUnit.Kills = self.currentUnit.Kills + 1
                                table.remove(self.levelStage.enemies, self.currentDefenderIndex)
                            end
                            self.currentLocations = CurrentLocations(self.levelStage)
                            self.levelStage.currentLocations = self.currentLocations
                        end

                        self.currentUnit.actionTaken = true
                        self.currentUnit.turnTaken = true
                        self.currentUnit.moveTaken = true
                        self.commandAttackBool = false
                        self.commandMenuBool = false
                    end
                else
                    self.commandAttackBool = false
                    self.commandMenuBool = true
                end
            end
        end
    else
        if self.commandMenuBool == true then
            self.commandsMenu:update(dt)
        elseif self.optionsMenuBool == true then
            self.optionsMenu:update(dt)
        end
    end
end
 
function GameState:render(dt)
    if self.currentLocations.entities[self.highlightedTile.y][self.highlightedTile.x] == true then
        self.characterheroMenu:render()
    elseif self.currentLocations.enemies[self.highlightedTile.y][self.highlightedTile.x] == true then
        self.characterenemyMenu:render()
    end
    self.levelStage:render()
    self.combatMenu:render()

    
    if self.commandMenuBool == true then
        self.commandsMenu:render()
    elseif self.optionsMenuBool == true then
        self.optionsMenu:render()
    else
        if self.commandMoveBool == true then
            for y = 1, self.levely do
                for x = 1, self.levelx do
                    if (self.highlightedTile.x ~= x or self.highlightedTile.y ~= y) and ((math.abs(self.currentUnit.x - x) + math.abs(self.currentUnit.y - y)) <= self.currentUnit.Move) then
                        love.graphics.setBlendMode('replace')
                        love.graphics.setColor(0, 0, 255, 255)
                        love.graphics.rectangle('line', (x - 1) * 32,
                            (y - 1) * 32, 32, 32, 4)
                        -- back to alpha
                        love.graphics.setBlendMode('alpha')
                    end
                end
            end
        elseif self.commandAttackBool == true then
            for y = 1, self.levely do
                for x = 1, self.levelx do
                    if (self.highlightedTile.x ~= x or self.highlightedTile.y ~= y) and ((math.abs(self.currentUnit.x - x) + math.abs(self.currentUnit.y - y)) <= self.currentUnit.Range) then
                        love.graphics.setBlendMode('replace')
                        love.graphics.setColor(0, 0, 255, 255)
                        love.graphics.rectangle('line', (x - 1) * 32,
                            (y - 1) * 32, 32, 32, 4)
                        -- back to alpha
                        love.graphics.setBlendMode('alpha')
                    end
                end
            end
        end

        -- multiply so drawing white rect makes it brighter
        love.graphics.setBlendMode('replace')

        love.graphics.setColor(255, 0, 0, 255)
        love.graphics.rectangle('line', (self.highlightedTile.x - 1) * 32,
            (self.highlightedTile.y - 1) * 32, 32, 32, 4)

        -- back to alpha
        love.graphics.setBlendMode('alpha')
    end
end