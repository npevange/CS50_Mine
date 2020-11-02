--[[
    GD50
    Final Project

    Author: Nathan Evangelista
    npevangelista@ucdavis.edu
]]


NewGameState = Class{__includes = BaseState}

function NewGameState:enter()
    -- init party
    self.party = Party:init()

    --init level
    self.levelNum = 0

    self.selectedUnit = false
    self.currentUnit = nil
    self.currentUnitIndex = nil
    self.currentDefender = nil
    self.currentDefenderIndex = nil

    self.commandMenuBool = false
    self.commandAttackBool = false
    self.commandMoveBool = false
    self.commandMagicBool = false
    
    self.EndTurn = false
    self.EndTurnCounter = 0

    self.commandsMenu = Menu {
        x = VIRTUAL_WIDTH - 64,
        y = VIRTUAL_HEIGHT - 96,
        width = 64,
        height = 96,
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
                text = 'Magic',
                onSelect = function ()
                    
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
    NewGameState:level(self)

    self.characterheroMenu = CharacterMenu {
        x = VIRTUAL_WIDTH - 128,
        y = 0,
        width = 64,
        height = 96,
        group = self.levelStage.entities,
        selectionOn = true,
        items = {
                    text = 'test test test'
                },
                {
                    text = 'stuff'
                }
            }

    self.characterenemyMenu = CharacterMenu {
        x = VIRTUAL_WIDTH - 128,
        y = 0,
        width = 128,
        height = 96,
        group = self.levelStage.enemies,
        selectionOn = true,
        items = {
                    text = 'test test test test test'
                },
                {
                    text = "stuff stuff"
                }
            }
end

function NewGameState:level(self)
    self.levelx = 8 --#self.levelStage.tileMap.tiles[1]
    self.levely = 5 --#self.levelStage.tileMap.tiles
    self.levelNum = self.levelNum + 1
    self.levelStage = LevelGenerator.generate(self.levelx, self.levely, self.levelNum) --Game Level entities, objects, tiles
    
    for i, heroes in pairs(self.party) do
        table.insert(self.levelStage.entities, self.party[i])
        self.levelStage.entities[i].x = 1
        self.levelStage.entities[i].y = i
    end

    self.highlightedTile = HighlightedTile(self.levelStage.entities[1].x, self.levelStage.entities[1].y)

    self.currentLocations = CurrentLocations(self.levelStage)
    self.levelStage.currentLocations = self.currentLocations
end

function NewGameState:update(dt)
    if #self.levelStage.enemies == 0 then
        -- You Win, widepeepoHappy
        gStateMachine:change('mainmenu')
    end
    self.characterheroMenu:update(dt, self.highlightedTile.x, self.highlightedTile.y)
    self.characterenemyMenu:update(dt, self.highlightedTile.x, self.highlightedTile.y)
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
            EnemyTurn(enemy, self.levelStage, i)
            self.currentLocations = CurrentLocations(self.levelStage)
            self.levelStage.currentLocations = self.currentLocations
            if #self.levelStage.entities == 0 then
                -- You Lose, Sadge
                gStateMachine:change('mainmenu')
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
    if self.commandMenuBool == false then
        -- move cursor around based on bounds of grid
        if love.keyboard.wasPressed('up') then
            self.highlightedTile.y = math.max(1, self.highlightedTile.y - 1)

        elseif love.keyboard.wasPressed('down') then
            self.highlightedTile.y = math.min(self.levely, self.highlightedTile.y + 1)

        elseif love.keyboard.wasPressed('left') then
            self.highlightedTile.x = math.max(1, self.highlightedTile.x - 1)

        elseif love.keyboard.wasPressed('right') then
            self.highlightedTile.x = math.min(self.levelx, self.highlightedTile.x + 1)
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
                        self.currentUnit.x = self.highlightedTile.x
                        self.currentUnit.y = self.highlightedTile.y
                        self.currentLocations = CurrentLocations(self.levelStage)
                        self.levelStage.currentLocations = self.currentLocations
                        self.currentUnit.moveTaken = true
                        self.commandMoveBool = false
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
                        deadUnit = CombatCalculator(self.currentUnit, self.currentDefender, self.levelStage)
                        -- if dead units, remove from levelStage
                        if deadUnit == true then
                            if self.currentUnit.HP < 1 then
                                table.remove(self.levelStage.entities, self.currentUnitIndex)
                            end
                            if self.currentDefender.HP < 1 then
                                table.remove(self.levelStage.enemies, self.currentDefenderIndex)
                            end
                            self.currentLocations = CurrentLocations(self.levelStage)
                            self.levelStage.currentLocations = self.currentLocations
                        end

                        -- check that there are still heroes and enemies left
                        if #self.levelStage.enemies == 0 then
                            love.window.setTitle(string.format("You Win"))
                        end
                        self.currentUnit.actionTaken = true
                        self.commandAttackBool = false
                        self.commandMenuBool = true
                    end
                else
                    self.commandAttackBool = false
                    self.commandMenuBool = true
                end
            end
        end
    else
        self.commandsMenu:update(dt)
    end
end
 
function NewGameState:render(dt)
    if self.currentLocations.entities[self.highlightedTile.y][self.highlightedTile.x] == true then
        self.characterheroMenu:render()
    elseif self.currentLocations.enemies[self.highlightedTile.y][self.highlightedTile.x] == true then
        self.characterenemyMenu:render()
    end
    self.levelStage:render()

    
    if self.commandMenuBool == true then
        self.commandsMenu:render()
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