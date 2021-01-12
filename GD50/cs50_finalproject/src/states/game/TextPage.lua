--[[
    GD50
    Final Project

    Author: Nathan Evangelista
    npevangelista@ucdavis.edu
]]

TextPage = Class{__includes = BaseState}

function TextPage:enter(inputs)
    self.textbox = Textbox(0,0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT, inputs[1], gFonts['small'])
    self.nextstate = inputs[2]
    self.enterparams = inputs[3]
end

function TextPage:update(dt)
    self.textbox:update(dt)

    if self.textbox:isClosed() then
        gStateMachine:change(self.nextstate, self.enterparams)
    end

end

function TextPage:render()
    self.textbox:render()
end