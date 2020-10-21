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

    self.commandMenuBool = false
    self.commandAttackBool = false
    self.commandMoveBool = false
    self.commandMagicBool = false
    

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
                    if self.currentUnit.attackTaken == false then
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
                    self.currentUnit.attackTaken = true
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
        x = VIRTUAL_WIDTH - 64,
        y = 0,
        width = 64,
        height = 96,
        group = self.levelStage.entities,
        selectionOn = false,
        items = {text = 'test',
                 onSelect = function()
                    self.characterheroMenu.selectionOn = false
                 end}}

    self.characterenemyMenu = CharacterMenu {
        x = VIRTUAL_WIDTH - 64,
        y = 0,
        width = 64,
        height = 96,
        group = self.levelStage.enemies,
        selectionOn = false,
        items = {text = 'test',
                 onSelect = function()
                    self.characterenemyMenu.selectionOn = false
                 end}}
end

function NewGameState:level(self)
    self.levelx = 8
    self.levely = 5
    self.levelNum = self.levelNum + 1
    self.levelStage = LevelGenerator.generate(self.levelx, self.levely, self.levelNum) --Game Level entities, objects, tiles
    
    for i, heroes in pairs(self.party) do
        table.insert(self.levelStage.entities, self.party[i])
        self.party[i].x = 1
        self.party[i].y = i
    end

    self.highlightedTile = HighlightedTile(self.levelStage.entities[1].x, self.levelStage.entities[1].y)

    self.currentLocations = CurrentLocations(self.levelStage)
end

function NewGameState:update(dt)
    self.characterheroMenu:update(dt, self.highlightedTile.x, self.highlightedTile.y)
    self.characterenemyMenu:update(dt, self.highlightedTile.x, self.highlightedTile.y)
    for i, heroes in pairs(self.party) do
        if self.party[i].turnTaken == false then
            break
        else
            -- End Turn Sequence

            -- Opponents take turns

            -- reset heroes turns
            for i, heroes in pairs(self.party) do
                self.party[i].turnTaken = false
                self.party[i].moveTaken = false
                self.party[i].attackTaken = false
            end
            self.currentLocations = CurrentLocations(self.levelStage)
        end
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
                for i, heroes in pairs(self.party) do
                    if self.party[i].x == self.highlightedTile.x and self.party[i].y == self.highlightedTile.y then
                        self.selectedUnit = true
                        self.currentUnit = self.party[i]
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
                    if self.currentLocations.enemies[self.highlightedTile.y][self.highlightedTile.y] == true then
                        --CombatCalculator()
                        -- attack stuff goes here, check for enemy in the tile, calculate damage, etc.
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
    self.levelStage:render()
    if self.currentLocations.entities[self.highlightedTile.y][self.highlightedTile.x] == true then
        self.characterheroMenu:render()
    elseif self.currentLocations.enemies[self.highlightedTile.y][self.highlightedTile.x] == true then
        self.characterenemyMenu:render()
    end
    
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