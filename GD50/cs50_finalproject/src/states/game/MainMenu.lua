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
                text = 'New Game Menu',
                onSelect = function ()
                    party = Party:init()
                    gStateMachine:change('textstate', {'Adventure awaits, go forth and conquer', 'gamestate', {party, nil, nil, nil, 1}})
                end
            },
            {   text = 'Load Game Menu',
                onSelect = function()
                    name = '1'
                    data = tostring(love.filesystem.getSaveDirectory( ) .. '/' .. name) --love.filesystem.getSaveDirectory() Gives full path to where data is saved.
                    success, message = love.filesystem.load(data)
                    love.window.setTitle(message)
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