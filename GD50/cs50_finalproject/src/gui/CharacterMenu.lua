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
    self.mapHit = def.mapHit
    self.mapDef = def.mapDef
    self.charStats = CharacterStats({
        x = def.x,
        y = def.y,
        width = def.width,
        height = def.height,
        selectionOn = def.selectionOn
    },
    self.mapHit, self.mapDef, self.referenceGroup, self.referenceUnit)
end

function CharacterMenu:update(dt, x, y)
    self.charStats:update(dt, x, y)
end

function CharacterMenu:isClosed()
    return self.closed
end

function CharacterMenu:render()
    self.panel:render()
    self.charStats:render()
end