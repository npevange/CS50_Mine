--[[
    GD50
    Final Project

    Author: Nathan Evangelista
    npevangelista@ucdavis.edu
]]

sPath = love.filesystem.getSaveDirectory()
love.filesystem.setRequirePath("?.lua;?/init.lua;" .. sPath .. "/?;?OdysseyQuest?")
require 'src/Dependencies'

function love.load()
    love.window.setTitle('Odyssey Quest')

    love.graphics.setDefaultFilter('nearest', 'nearest') --If I want to make it blocky
    math.randomseed(os.time())

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        vsync = true,
        resizable = true
    })

    gStateMachine = StateMachine {
        ['mainmenu'] = function() return MainMenu() end,
        ['control'] = function() return Controls() end,
        ['gamestate'] = function() return GameState() end,
        ['gamemenu'] = function() return GameMenu() end,
        ['level'] = function() return Level() end,
        ['playstate'] = function() return PlayState() end,
        ['textstate'] = function() return TextPage() end
    }
    gStateMachine:change('textstate', {'"Of all creatures that breathe and move upon the earth, nothing is bred that is weaker than man" --Homer, The Odyssey' .. '\n' .. 'Press Space to Embark', 'mainmenu'})

    love.keyboard.keysPressed = {}
end

function love.resize(w, h)
    push:resize(w, h)
end

function love.keypressed(key)
    if key == 'escape' then
        -- love.event.quit()
    end
    love.keyboard.keysPressed[key] = true
end

function love.keyboard.wasPressed(key)
    if love.keyboard.keysPressed[key] then
        return true
    else
        return false
    end
end

function love.update(dt)
    Timer.update(dt)
    gStateMachine:update(dt)

    love.keyboard.keysPressed = {}
end

function love.draw()
    push:start()
    gStateMachine:render()
    push:finish()
end