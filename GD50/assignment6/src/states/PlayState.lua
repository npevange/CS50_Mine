--[[
    GD50
    Angry Birds

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

PlayState = Class{__includes = BaseState}

function PlayState:init()
    self.level = Level()
    self.levelTranslateX = 0
end

function PlayState:update(dt)
    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end

    -- update camera
    if love.keyboard.isDown('left') then
        self.levelTranslateX = self.levelTranslateX + MAP_SCROLL_X_SPEED * dt
        
        if self.levelTranslateX > VIRTUAL_WIDTH then
            self.levelTranslateX = VIRTUAL_WIDTH
        else
            -- only update background if we were able to scroll the level
            self.level.background:update(dt)
        end
    elseif love.keyboard.isDown('right') then
        self.levelTranslateX = self.levelTranslateX - MAP_SCROLL_X_SPEED * dt

        if self.levelTranslateX < -VIRTUAL_WIDTH then
            self.levelTranslateX = -VIRTUAL_WIDTH
        else
            -- only update background if we were able to scroll the level
            self.level.background:update(dt)
        end
    elseif love.keyboard.wasPressed('space') then
        if self.level.launchMarker.alien == nil then

        elseif self.level.launchMarker.launched == true and self.level.launchMarker.split == false then

            local velX, velY = self.level.launchMarker.alien.body:getLinearVelocity()
            local X = self.level.launchMarker.alien.body:getX()
            local Y = self.level.launchMarker.alien.body:getY()
            
            self.level.launchMarker.alien2 = Alien(self.level.world, 'round', X, Y - 40, 'Player')

            -- apply the difference between current X,Y and base X,Y as launch vector impulse
            self.level.launchMarker.alien2.body:setLinearVelocity(velX, velY - 30)

            -- make the alien pretty bouncy
            self.level.launchMarker.alien2.fixture:setRestitution(0.4)
            self.level.launchMarker.alien2.body:setAngularDamping(1)

            self.level.launchMarker.alien3 = Alien(self.level.world, 'round', X, math.min(VIRTUAL_HEIGHT, Y + 40), 'Player')

            -- apply the difference between current X,Y and base X,Y as launch vector impulse
            self.level.launchMarker.alien3.body:setLinearVelocity(velX, velY + 30)

            -- make the alien pretty bouncy
            self.level.launchMarker.alien3.fixture:setRestitution(0.4)
            self.level.launchMarker.alien3.body:setAngularDamping(1)

            self.level.launchMarker.split = true

        end
    end



    self.level:update(dt)
end

function PlayState:render()
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()))
    love.graphics.setColor(255, 255, 255, 255)

    -- render background separate from level rendering
    self.level.background:render()

    love.graphics.translate(math.floor(self.levelTranslateX), 0)
    self.level:render()
end