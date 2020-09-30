--[[
    GD50
    Pokemon

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

MenuState = Class{__includes = BaseState}

function MenuState:init(party, HPup, ATKup, DFNup, SPDup, onClose)
self.party = party

self.onClose = onClose or function() end

self.levelMenu = Menu {
    x = VIRTUAL_WIDTH - VIRTUAL_WIDTH / 2 - 64,
    y = VIRTUAL_HEIGHT - VIRTUAL_HEIGHT / 2 - 64,
    width = 128,
    height = 128,
    selectionOn = false,
    items = {
        {
            text = 'HP: '.. tostring(self.party.pokemon[1].HP) .. '+' .. tostring(HPup) .. '=' .. tostring(self.party.pokemon[1].HP + HPup)
        },
        {
            text = 'ATK: '.. tostring(self.party.pokemon[1].attack) .. '+' .. tostring(ATKup) .. '=' .. tostring(self.party.pokemon[1].attack + ATKup)
        },
        {
            text = 'DFN: '.. tostring(self.party.pokemon[1].defense) .. '+' .. tostring(DFNup) .. '=' .. tostring(self.party.pokemon[1].defense + DFNup)
        },
        {
            text = 'SPD: '.. tostring(self.party.pokemon[1].speed) .. '+' .. tostring(SPDup) .. '=' .. tostring(self.party.pokemon[1].speed + SPDup)
        }
    }
}
end

function MenuState:update(dt)
    if love.keyboard.wasPressed('space') or love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateStack:pop()
        self.onClose()
    end
end

function MenuState:render()
    self.levelMenu:render()
end