--[[
    GD50
    Final Project

    Author: Nathan Evangelista
    npevangelista@ucdavis.edu
]]

CharacterMenu = Class{}

function CharacterMenu:init(def)
    self.panel = Panel(def.x, def.y, def.width, def.height)
    self.closed = false
    self.referenceGroup = def.group
    self.referenceUnit = self.referenceGroup[1]
    self.selection = CharacterStats {
        items = def.items,
        x = def.x,
        y = def.y,
        width = def.width,
        height = def.height,
        selectionOn = false
    }
end

function CharacterMenu:update(dt, x, y)
    for units = 1, #self.referenceGroup do
        if self.referenceGroup[units].x == x and self.referenceGroup[units].y == y then
            self.referenceUnit = self.referenceGroup[units]
        end
    end
    self.selection:update(dt)
end

function CharacterMenu:isClosed()
    return self.closed
end

function CharacterMenu:render()
    self.panel:render()
    self.selection:render()
end