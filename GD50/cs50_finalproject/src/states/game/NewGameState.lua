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

end

function NewGameState:render()

end