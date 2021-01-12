--[[
    GD50
    Final Project

    Author: Nathan Evangelista
    npevangelista@ucdavis.edu
]]

GameMenu = Class{__includes = BaseState}

function GameMenu:enter()
    local state1 = 1
    local state2 = 2
    local state3 = 3
    self.mainMenu = Menu {
        x = VIRTUAL_WIDTH / 2 - 32,
        y = VIRTUAL_HEIGHT / 2 - 16,
        width = 64,
        height = 80,
        selectionOn = true,
        items = { --love.filesystem.getSaveDirectory() Gives full path to where data is saved.
            {
                text = 'Save State 1',
                onSelect = function ()
                    party = Party:init()
                    gStateMachine:change('textstate', {'Adventure awaits, go forth and conquer', 'gamestate', {party, nil, nil, nil, 1}})
                end
            },
            {   text = 'Save State 2',
                onSelect = function()
                    party = Party:init()
                    gStateMachine:change('textstate', {'Adventure awaits, go forth and conquer', 'gamestate', {party, nil, nil, nil, 2}})
                end
            },
            {
                text = 'Save State 3',
                onSelect = function ()
                    party = Party:init()
                    gStateMachine:change('textstate', {'Adventure awaits, go forth and conquer', 'gamestate', {party, nil, nil, nil, 3}})
                end
            }
        }
    }
end

function GameMenu:update(dt)
    self.mainMenu:update(dt)
end

function GameMenu:render()
    love.graphics.clear(188, 188, 188, 255)
    love.graphics.setColor(190, 0, 0, 255)
    love.graphics.setFont(gFonts['large'])
    love.graphics.printf('Odyssey Quest!', 0, VIRTUAL_HEIGHT / 2 - 72, VIRTUAL_WIDTH, 'center')
    love.graphics.setFont(gFonts['medium'])
    love.graphics.printf('Press Enter to Embark!', 0, VIRTUAL_HEIGHT / 2 + 68, VIRTUAL_WIDTH, 'center')
    love.graphics.setFont(gFonts['small'])
    self.mainMenu:render()
end