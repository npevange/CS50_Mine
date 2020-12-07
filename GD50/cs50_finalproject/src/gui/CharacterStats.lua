--[[
    GD50
    Final Project

    Author: Nathan Evangelista
    npevangelista@ucdavis.edu

    Modified Selection to display character Stats

    The CharacterStats class gives us a list of textual items that link to callbacks;
    this particular implementation only has one dimension of items (vertically),
    but a more robust implementation might include columns as well for a more
    grid-like selection, as seen in many kinds of interfaces and games.
]]

CharacterStats = Class{}

function CharacterStats:init(def, referenceGroup, referenceUnit)
    self.referenceGroup = referenceGroup
    self.referenceUnit = referenceUnit
    self.items = {{text = string.format(self.referenceUnit.name)},
    {text = string.format("HP: " .. self.referenceUnit.currentHP)},
    {text = string.format("Attack: " .. self.referenceUnit.Attack)},
    {text = string.format("Defense: " .. self.referenceUnit.Defense)}}
    self.x = def.x
    self.y = def.y

    self.height = def.height
    self.width = def.width
    self.font = gFonts['medium']

    self.gapHeight = self.height / #self.items

    self.currentSelection = 1
    self.selectionOn = def.selectionOn
end

function CharacterStats:update(dt, x, y)
    for i, units in pairs(self.referenceGroup) do
        if self.referenceGroup[i].x == x and self.referenceGroup[i].y == y then
            self.referenceUnit = self.referenceGroup[i]
        end
    end
    self.items = {{text = string.format(self.referenceUnit.name)},
    {text = string.format("HP: " .. self.referenceUnit.currentHP)},
    {text = string.format("Attack: " .. self.referenceUnit.Attack)},
    {text = string.format("Defense: " .. self.referenceUnit.Defense)}}
end

function CharacterStats:render()

    local currentY = self.y

    for i = 1, #self.items do
        local paddedY = currentY + (self.gapHeight / 2) - self.font:getHeight() / 2

        -- draw selection marker if we're at the right index
        if i == self.currentSelection and self.selectionOn then
            love.graphics.draw(gTextures['cursor'], self.x - 8, paddedY)
        end

        love.graphics.printf(self.items[i].text, self.x, paddedY, self.width, 'center')

        currentY = currentY + self.gapHeight
    end
end