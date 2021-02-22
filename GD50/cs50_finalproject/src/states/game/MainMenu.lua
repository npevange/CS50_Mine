--[[
    GD50
    Final Project

    Author: Nathan Evangelista
    npevangelista@ucdavis.edu
]]

MainMenu = Class{__includes = BaseState}

function MainMenu:enter()
    self.mainMenu = Menu {  
        x = VIRTUAL_WIDTH / 2 - 32,
        y = VIRTUAL_HEIGHT / 2 - 16,
        width = 64,
        height = 80,
        selectionOn = true,
        items = {
            {
                text = 'New Game Menu', -- 'Game Saves Menu' -- GameMenu
                onSelect = function ()
                    party = Party:init()
                    gStateMachine:change('textstate', {gQuotes[1], 'gamestate', {party, nil, nil, nil, 1}})
                end
            },
            {   text = 'Load Game Menu', -- 'Game Saves Menu' -- GameMenu
                onSelect = function()
                    gStateMachine:change('gamemenu')
                end
            },
            {
                text = 'Controls',
                onSelect = function ()
                    gStateMachine:change('control')
                end
            }
        }
    }
end

function MainMenu:update(dt)
    self.mainMenu:update(dt)
end

function MainMenu:render()
    love.graphics.clear(188, 188, 188, 255)
    love.graphics.setColor(190, 0, 0, 255)
    love.graphics.setFont(gFonts['large'])
    love.graphics.printf('Odyssey Quest!', 0, VIRTUAL_HEIGHT / 2 - 72, VIRTUAL_WIDTH, 'center')
    love.graphics.setFont(gFonts['medium'])
    love.graphics.printf('Press Enter to Embark!', 0, VIRTUAL_HEIGHT / 2 + 68, VIRTUAL_WIDTH, 'center')
    love.graphics.setFont(gFonts['small'])
    self.mainMenu:render()
end