--[[
    GD50
    Final Project

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

Controls = Class{__includes = BaseState}

function Controls:enter()
    self.controlMenu = Menu {  
        x = 0,
        y = 0,
        width = VIRTUAL_WIDTH,
        height = VIRTUAL_HEIGHT,
        selectionOn = true,
        items = {
            {
                text = 'Arrow keys to move the cursor,',
                onSelect = function ()
                    gStateMachine:change('mainmenu')
                end
            },
            {
                text = 'Space bar to select',
                onSelect = function ()
                    gStateMachine:change('mainmenu')
                end
            }
        }
    }
end

function Controls:update(dt)
    self.controlMenu:update(dt)
end

function Controls:render()
    self.controlMenu:render()
end