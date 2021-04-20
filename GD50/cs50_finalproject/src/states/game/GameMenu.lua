--[[
    GD50
    Final Project

    Author: Nathan Evangelista
    npevangelista@ucdavis.edu
]]

GameMenu = Class{__includes = BaseState}

function GameMenu:enter()
    local state1 = false
    local state2 = false
    local state3 = false

    -- Check for saved state files, and if found then allow user to load
    if love.filesystem.exists( "1.txt" ) == true then
        state1 = true
        level1func = loadfile(love.filesystem.getSaveDirectory( ).."/1Level.txt")
        level1func()
        text1 = "Save State 1 - Level: " .. returnCurrentLevel
        level1 = returnCurrentLevel
    else
        text1 = "New Game 1"
    end
    if love.filesystem.exists( "2.txt" ) == true then
        state2 = true
        level2func = loadfile(love.filesystem.getSaveDirectory( ).."/2Level.txt")
        level2func()
        text2 = "Save State 2 - Level: " .. returnCurrentLevel
        level2 = returnCurrentLevel
    else
        text2 = "New Game 2"
    end
    if love.filesystem.exists( "3.txt" ) == true then
        state3 = true
        level3func= loadfile(love.filesystem.getSaveDirectory( ).."/3Level.txt")
        level3func()
        text3 = "Save State 3 - Level: " .. returnCurrentLevel
        level3 = returnCurrentLevel
    else
        text3 = "New Game 3"
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
                        level1func = loadfile(love.filesystem.getSaveDirectory().."/1.txt")
                        level1func()
                    else
                        party = Party:init()
                        gStateMachine:change('textstate', {gQuotes[1], 'gamestate', {party, nil, nil, nil, 1}})
                    end
                end
            },
            {   text = text2,
                onSelect = function()
                    if state2 then
                        level2func = loadfile(love.filesystem.getSaveDirectory().."/2.txt")
                        level2func()
                    else
                        party = Party:init()
                        gStateMachine:change('textstate', {gQuotes[1], 'gamestate', {party, nil, nil, nil, 2}})
                    end
                end
            },
            {
                text = text3,
                onSelect = function ()
                    if state3 then
                        level3func = loadfile(love.filesystem.getSaveDirectory().."/3.txt")
                        level3func()
                    else
                        party = Party:init()
                        gStateMachine:change('textstate', {gQuotes[1], 'gamestate', {party, nil, nil, nil, 3}})
                    end
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
    love.graphics.printf('Odyssey Quest!', 0, VIRTUAL_HEIGHT / 2 - 108, VIRTUAL_WIDTH, 'center')
    love.graphics.setFont(gFonts['medium'])
    love.graphics.printf('Press Enter to Embark!', 0, VIRTUAL_HEIGHT / 2 + 80, VIRTUAL_WIDTH, 'center')
    love.graphics.setFont(gFonts['small'])
    self.mainMenu:render()
end