--[[
    GD50
    Final Project

    Author: Nathan Evangelista
    npevangelista@ucdavis.edu
]]

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

    -- this time, we are using a stack for all of our states, where the field state is the
    -- foundational state; it will have its behavior preserved between state changes because
    -- it is essentially being placed "behind" other running states as needed (like the battle
    -- state)

    gStateMachine = StateMachine {
        ['mainmenu'] = function() return MainMenu() end,
        ['control'] = function() return Controls() end,
        ['newgamestate'] = function() return NewGameState() end,
        ['level'] = function() return Level() end,
        ['playstate'] = function() return PlayState() end
    }
    gStateMachine:change('mainmenu')

    love.keyboard.keysPressed = {}
end

function love.resize(w, h)
    push:resize(w, h)
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
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