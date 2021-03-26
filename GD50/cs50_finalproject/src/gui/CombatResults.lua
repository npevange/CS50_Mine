--[[
    GD50
    Final Project

    Author: Nathan Evangelista
    npevangelista@ucdavis.edu

    Modified Selection to display character Stats

    The CombatResults class gives us a list of textual items that link to callbacks;
    this particular implementation only has one dimension of items (vertically),
    but a more robust implementation might include columns as well for a more
    grid-like selection, as seen in many kinds of interfaces and games.
]]

CombatResults = Class{}

function CombatResults:init(def)
    self.text1 = ""
    self.text2 = ""
    self.text3 = ""
    self.items = {{text = self.text1}, {text = self.text2}, {text = self.text3}}
    self.x = def.x
    self.y = def.y

    self.height = def.height
    self.width = def.width
    self.font = gFonts['small']

    self.gapHeight = self.height / #self.items

    self.currentSelection = 1
    self.selectionOn = def.selectionOn
end

function CombatResults:update(dt)
    self.items = {{text = self.text1}, {text = self.text2}, {text = self.text3}}
end

function CombatResults:render()

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

function CombatResults:text(text)
    self.text3 = self.text2
    self.text2 = self.text1
    self.text1 = text
end