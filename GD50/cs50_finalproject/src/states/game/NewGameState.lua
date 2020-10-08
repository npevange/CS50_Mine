--[[
    GD50
    Final Project

    Author: Nathan Evangelista
    npevangelista@ucdavis.edu
]]


NewGameState = Class{__includes = BaseState}

function NewGameState:init()
    -- init party
    self.initParty = Party:init()

    --init level
    self.levelNum = 1

    self.Level = gStateStack:push(Level(self.levelNum, self.initParty))
end

function NewGameState:update(dt)
    -- this one is blipping
    -- gSounds['blip']:play()
    -- if self.Level ~= nil then
    --     self.Level:update(dt)
    -- end
        -- move cursor around based on bounds of grid
        if love.keyboard.wasPressed('up') then
            -- self.highlightedTile.y = math.max(0, self.highlightedTile.y - 1)
            gSounds['blip']:play()
    
        elseif love.keyboard.wasPressed('down') then
            -- self.highlightedTile.y = math.min(6, self.highlightedTile.y + 1)
            gSounds['blip']:play()
    
        elseif love.keyboard.wasPressed('left') then
            -- self.highlightedTile.x = math.max(0, self.highlightedTile.x - 1)
            gSounds['blip']:play()
    
        elseif love.keyboard.wasPressed('right') then
            -- self.highlightedTile.x = math.min(5, self.highlightedTile.x + 1)
            gSounds['blip']:play()
        end
end

function NewGameState:render()
    -- this one also blipping
    --Sounds['blip']:play()
end