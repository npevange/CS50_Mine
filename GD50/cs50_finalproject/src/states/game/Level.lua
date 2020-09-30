--[[
    GD50
    Final Project

    Author: Nathan Evangelista
    npevangelista@ucdavis.edu
]]

Level = Class{__includes = BaseState}

function Level:init(level, party)
    self.levelNum = level
    self.party = party
    self.levelStage = LevelGenerator.generate(6,5) --Game Level entities, objects, tiles

    for i, heroes in pairs(self.party) do
        table.insert(self.levelStage.entities, self.party[i])
        self.party[i].x = i
        self.party[i].y = i
    end
end

function Level:update(dt)
    self.levelStage:render(dt)
end

function Level:render()
    self.levelStage:render()
end