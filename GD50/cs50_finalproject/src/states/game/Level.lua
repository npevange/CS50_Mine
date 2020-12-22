--[[
    GD50
    Final Project

    Author: Nathan Evangelista
    npevangelista@ucdavis.edu
]]

Level = Class{__includes = BaseState}

function Level:enter(party, levelnum)
    self.levelNum = levelnum
    self.party = party
    levelx = 6
    levely = 5
    self.levelStage = LevelGenerator.generate(levelx,levely) --Game Level entities, objects, tiles

    for i, heroes in pairs(self.party) do
        table.insert(self.levelStage.entities, self.party[i])
        self.party[i].x = i
        self.party[i].y = i
    end
    if self.levelStage == nil then
        error('nil level stage')
    end
    if self.levelStage.entities ~= nil then
        -- love.window.setTitle(string.format(#self.levelStage.entities))
    end

    if self.levelStage.tileMap ~= nil then
        love.window.setTitle(string.format(#self.levelStage.tileMap.tiles))
    end

    gStateMachine:change('playstate', self.party, self.levelStage)
end

function Level:update(dt)
    --love.window.setTitle('Odyssey Quest Test')
    -- if self.playState ~= nil then
    --     gSounds['blip']:play()
    --     self.playState:update(dt)
    -- end
    --self.levelStage:render(dt)
end

function Level:render()
    --self.levelStage:render()
end