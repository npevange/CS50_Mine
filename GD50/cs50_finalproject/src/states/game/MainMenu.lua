--[[
    GD50
    Final Project

    Author: Nathan Evangelista
    npevangelista@ucdavis.edu
]]

MainMenu = Class{__includes = BaseState}

function MainMenu:init()
    self.mainMenu = Menu {  
        x = VIRTUAL_WIDTH / 2 - 32,
        y = VIRTUAL_HEIGHT / 2 - 16,
        width = 64,
        height = 64,
        selectionOn = true,
        items = {
            {
                text = 'New Game',
                onSelect = function ()
                    gStateStack:pop()
                    gStateStack:push(NewGameState())
                    --gStateStack:push(NewGameState())
                end
            },
            {   text = 'Saved Game',
                onSelect = function()
                    -- gStateStack:pop()
                    -- gStateStack:push(SaveMenu())
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