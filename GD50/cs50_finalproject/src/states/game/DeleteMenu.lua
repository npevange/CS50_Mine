--[[
    GD50
    Final Project

    Author: Nathan Evangelista
    npevangelista@ucdavis.edu
]]

DeleteMenu = Class{__includes = BaseState}

function DeleteMenu:enter()
    local state1 = false
    local state2 = false
    local state3 = false

    if love.filesystem.exists( "1.txt" ) == true then
        state1 = true
        text1 = "Delete Save State 1"
    else
        text1 = "No Save 1- Return"
    end
    if love.filesystem.exists( "2.txt" ) == true then
        state2 = true
        text2 = "Delete Save State 2"
    else
        text2 = "No Save 2- Return"
    end
    if love.filesystem.exists( "3.txt" ) == true then
        state3 = true
        text3 = "Delete Save State 3"
    else
        text3 = "No Save 3- Return"
    end
    self.mainMenu = Menu {
        x = VIRTUAL_WIDTH / 2 - 32,
        y = VIRTUAL_HEIGHT / 2 - 64,
        width = 96,
        height = 128,
        selectionOn = true,
        items = { --love.filesystem.getSaveDirectory() Gives full path to where data is saved.
            {
                text = text1,
                onSelect = function ()
                    if state1 then
                        success = love.filesystem.remove("C:\\Users\\npeva\\Documents\\Deletetest1.txt")
                        love.window.setTitle(tostring(success))
                        success = love.filesystem.remove(love.filesystem.getSaveDirectory( ).."/1.txt")
                        -- love.window.setTitle(tostring(success))
                        success = love.filesystem.remove(love.filesystem.getSaveDirectory( ).."/1Level.txt")
                        gStateMachine:change('mainmenu')
                    else
                        gStateMachine:change('mainmenu')
                    end
                end
            },
            {   text = text2,
                onSelect = function()
                    if state2 then
                        success = love.filesystem.remove(love.filesystem.getSaveDirectory( ).."/2.txt")
                        success = love.filesystem.remove(love.filesystem.getSaveDirectory( ).."/2Level.txt")
                        gStateMachine:change('mainmenu')
                    else
                        gStateMachine:change('mainmenu')
                    end
                end
            },
            {
                text = text3,
                onSelect = function ()
                    if state3 then
                        success = love.filesystem.remove(love.filesystem.getSaveDirectory( ).."/3.txt")
                        success = love.filesystem.remove(love.filesystem.getSaveDirectory( ).."/3Level.txt")
                        gStateMachine:change('mainmenu')
                    else
                        gStateMachine:change('mainmenu')
                    end
                end
            },
            {
                text = "Return to Main Menu",
                onSelect = function ()
                    gStateMachine:change('mainmenu')
                end
            }
        }
    }
end

function DeleteMenu:update(dt)
    self.mainMenu:update(dt)
end

function DeleteMenu:render()
    love.graphics.clear(188, 188, 188, 255)
    love.graphics.setColor(190, 0, 0, 255)
    love.graphics.setFont(gFonts['large'])
    love.graphics.printf('Odyssey Quest!', 0, VIRTUAL_HEIGHT / 2 - 108, VIRTUAL_WIDTH, 'center')
    love.graphics.setFont(gFonts['medium'])
    love.graphics.printf('Press Enter to Embark!', 0, VIRTUAL_HEIGHT / 2 + 80, VIRTUAL_WIDTH, 'center')
    love.graphics.setFont(gFonts['small'])
    self.mainMenu:render()
end