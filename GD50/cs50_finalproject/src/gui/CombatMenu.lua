--[[
    GD50
    Final Project

    Author: Nathan Evangelista
    npevangelista@ucdavis.edu
]]

CombatMenu = Class{}

function CombatMenu:init(def)
    self.panel = Panel(def.x, def.y, def.width, def.height)
    self.closed = false
    self.combatResults = CombatResults({
        x = def.x,
        y = def.y,
        width = def.width,
        height = def.height,
        selectionOn = def.selectionOn
    })
end

function CombatMenu:update(dt)
    self.combatResults:update(dt)
end

function CombatMenu:isClosed()
    return self.closed
end

function CombatMenu:text(text)
    self.combatResults:text(text)
end

function CombatMenu:render()
    self.panel:render()
    self.combatResults:render()
end