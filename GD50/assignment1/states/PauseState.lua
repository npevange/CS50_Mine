--[[
    PauseState Class
    Author: Nathan "Call me Cats987654321" Evangelista
    npevangelista@ucdavis.edu

    The PauseState is the pause screen of the game. It should
    display "Pause" and make a pause sound. It should pause the gamestate and music.
    When unpaused, gamestate and music should resume.
]]

PauseState = Class{__includes = BaseState}

function PauseState:update(dt)
    -- transition back to game
    if love.keyboard.wasPressed('p') then
        gStateMachine:change('play')
        sounds['music']:play()
    end
end

function PauseState:render()
    -- Pause menu
    love.graphics.setFont(flappyFont)
    love.graphics.printf('Fifty Bird', 0, 64, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(mediumFont)
    love.graphics.printf('Pause', 0, 100, VIRTUAL_WIDTH, 'center')

    love.graphics.printf('Press p to continue', 0, 150, VIRTUAL_WIDTH, 'center')
end