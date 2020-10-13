--[[
    GD50
    Final Project

    Author: Nathan Evangelista
    npevangelista@ucdavis.edu
]]

PlayState = Class{__includes = BaseState}

function PlayState:enter(party, levelstage)
    self.party = party
    self.levelStage = levelstage
    if levelStage == nil then
        gSounds['blip']:play()
        error('nil level stage')
    end
    if self.levelStage.entities == nil then
        error('nil entities')
    end
    if self.levelStage.objects == nil then
        error('nil objects')
    end
    if self.levelStage.tileMap == nil then
        error('nil tilemap')
    end
    self.highlightedTile = HighlightedTile(self.levelStage.entities[1].x, self.levelStage.entities[1].y)
end

function PlayState:update(dt)
    -- move cursor around based on bounds of grid
    if love.keyboard.wasPressed('up') then
        self.highlightedTile.y = math.max(0, self.highlightedTile.y - 1)
        gSounds['blip']:play()

    elseif love.keyboard.wasPressed('down') then
        self.highlightedTile.y = math.min(6, self.highlightedTile.y + 1)
        gSounds['blip']:play()

    elseif love.keyboard.wasPressed('left') then
        self.highlightedTile.x = math.max(0, self.highlightedTile.x - 1)
        gSounds['blip']:play()

    elseif love.keyboard.wasPressed('right') then
        self.highlightedTile.x = math.min(5, self.highlightedTile.x + 1)
        gSounds['blip']:play()
    end
end

function PlayState:render(dt)
    self.levelStage:render()
    -- multiply so drawing white rect makes it brighter
    love.graphics.setBlendMode('add')

    love.graphics.setColor(255, 255, 0, 255)
    love.graphics.rectangle('line', (self.highlightedTile.x - 1) * 32,
        (self.highlightedTile.y - 1) * 32, 32, 32, 4)

    -- back to alpha
    love.graphics.setBlendMode('alpha')
end