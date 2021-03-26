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
        y = VIRTUAL_HEIGHT / 2 - 64,
        width = 96,
        height = 128,
        selectionOn = true,
        items = {
            {   text = 'Game Saves Menu', -- 'Game Saves Menu' -- GameMenu
                onSelect = function()
                    gStateMachine:change('gamemenu')
                end
            },
            {
                text = 'Controls',
                onSelect = function ()
                    gStateMachine:change('control')
                end
            },
            {
                text = 'Delete Menu',
                onSelect = function ()
                    gStateMachine:change('deletemenu')
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
    love.graphics.printf('Odyssey Quest!', 0, VIRTUAL_HEIGHT / 2 - 108, VIRTUAL_WIDTH, 'center')
    love.graphics.setFont(gFonts['medium'])
    love.graphics.printf('Press Enter to Embark!', 0, VIRTUAL_HEIGHT / 2 + 80, VIRTUAL_WIDTH, 'center')
    love.graphics.setFont(gFonts['small'])
    self.mainMenu:render()
end