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
    self.charStats = CharacterStats {
        items = {{text = string.format(self.referenceUnit.name)},
                {text = string.format(self.referenceUnit.currentHP)}},
        x = def.x,
        y = def.y,
        width = def.width,
        height = def.height,
        selectionOn = def.selectionOn
    }
end

function CharacterMenu:update(dt, x, y)
    for i, units in pairs(self.referenceGroup) do
        if self.referenceGroup[i].x == x and self.referenceGroup[i].y == y then
            self.referenceUnit = self.referenceGroup[i]
        end
    end
    self.charStats:update(dt)
end

function CharacterMenu:isClosed()
    return self.closed
end

function CharacterMenu:render()
    self.panel:render()
    self.charStats:render()
end