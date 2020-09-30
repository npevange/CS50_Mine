--[[
    GD50
    Breakout Remake

    -- PlayState Class --

    Author: Colton Ogden
    cogden@cs50.harvard.edu

    Represents the state of the game in which we are actively playing;
    player should control the paddle, with the ball actively bouncing between
    the bricks, walls, and the paddle. If the ball goes below the paddle, then
    the player should lose one point of health and be taken either to the Game
    Over screen if at 0 health or the Serve screen otherwise.
]]

PlayState = Class{__includes = BaseState}

--[[
    We initialize what's in our PlayState via a state table that we pass between
    states as we go from playing to serving.
]]
function PlayState:enter(params)
    self.paddle = params.paddle
    self.bricks = params.bricks
    self.health = params.health
    self.score = params.score
    self.highScores = params.highScores
    self.ball0 = params.ball0
    self.ball1 = params.ball1
    self.ball2 = params.ball2
    
    self.level = params.level
    self.powerups = params.powerups
    self.recoverPoints = 5000

    -- for k, balls in pairs(self.ball) do
    self.ball0.inPlay = true
    self.ball0.dx = math.random(-200, 200)
    self.ball0.dy = math.random(-50, -60)
    self.ball1.inPlay = false
    self.ball1.dx = 0
    self.ball1.dy = 0
    self.ball2.inPlay = false
    self.ball2.dx = 0
    self.ball2.dy = 0
    self.ball_in_play = true

    self.ball = {self.ball0, self.ball1, self.ball2}
end

function PlayState:update(dt)
    if self.paused then
        if love.keyboard.wasPressed('space') then
            self.paused = false
            gSounds['pause']:play()
        else
            return
        end
    elseif love.keyboard.wasPressed('space') then
        self.paused = true
        gSounds['pause']:play()
        return
    end

    -- update positions based on velocity
    self.paddle:update(dt)
    for k, balls in pairs(self.ball) do
        self.ball[k]:update(dt)
    end
    if self.powerups == nil then

    else
        for k, powerup in pairs(self.powerups) do
            self.powerups[k]:update(dt)
            if self.powerups[k]:collides(self.paddle, self.powerups[k].power_num) then
                if self.powerups[k].power_num == 10 then
                    for i, brick in pairs(self.bricks) do
                        brick.isLocked = false
                    end
                elseif self.powerups[k].power_num == 4 then
                    for k, balls in pairs(self.ball) do
                        if self.ball[k].inPlay == true then
                            gSounds['pause']:play()
                        -- nothing if inPlay
                        else
                            gSounds['pause']:play()
                            self.ball[k].inPlay = true
                            self.ball[k].x = self.paddle.x + (self.paddle.width / 2) - 4
                            self.ball[k].y = self.paddle.y - 8
                            self.ball[k].dx = math.random(-200, 200)
                            self.ball[k].dy = math.random(-50, -60)
                        end 
                    end
                end
                self.powerups[k].inPlay = false
            end
        end
    end
    
    for k, balls in pairs(self.ball) do
        if self.ball[k]:collides(self.paddle) then
            -- raise ball above paddle in case it goes below it, then reverse dy
            self.ball[k].y = self.paddle.y - 8
            self.ball[k].dy = -self.ball[k].dy

            --
            -- tweak angle of bounce based on where it hits the paddle
            --

            -- if we hit the paddle on its left side while moving left...
            if self.ball[k].x < self.paddle.x + (self.paddle.width / 2) and self.paddle.dx < 0 then
                self.ball[k].dx = -50 + -(8 * (self.paddle.x + self.paddle.width / 2 - self.ball[k].x))
            
            -- else if we hit the paddle on its right side while moving right...
            elseif self.ball[k].x > self.paddle.x + (self.paddle.width / 2) and self.paddle.dx > 0 then
                self.ball[k].dx = 50 + (8 * math.abs(self.paddle.x + self.paddle.width / 2 - self.ball[k].x))
            end

            gSounds['paddle-hit']:play()
        end
    end

    -- detect collision across all bricks with the ball
    for i, balls in pairs(self.ball) do
        for k, brick in pairs(self.bricks) do

            -- only check collision if we're in play
            if brick.inPlay and self.ball[i]:collides(brick) then

                -- add to score
                self.score = self.score + (brick.tier * 200 + brick.color * 25)

                -- trigger the brick's hit function, which removes it from play
                brick:hit()
                math.randomseed(os.time())
                powerup_ball = math.random(5)
                if brick.inPlay == false then
                    if powerup_ball == 1 then
                        --TODO spawn powerup_ball and fall
                        new_powerup = Powerup(self.ball[i], 4)
                        table.insert(self.powerups, new_powerup)
                    end
                elseif brick.isLocked and powerup_ball == 1 then
                    new_powerup = Powerup(self.ball[i], 10)
                    table.insert(self.powerups, new_powerup)
                end

                -- if we have enough points, recover a point of health
                if self.score > self.recoverPoints then
                    -- can't go above 3 health
                    self.health = math.min(3, self.health + 1)
                    if self.paddle.size > 1 then
                        self.paddle.size = self.paddle.size - 1
                        self.paddle.width = self.paddle.size * 32
                    end

                    -- multiply recover points by 2
                    self.recoverPoints = math.min(100000, self.recoverPoints * 2)

                    -- play recover sound effect
                    gSounds['recover']:play()
                end

                -- go to our victory screen if there are no more bricks left
                if self:checkVictory() then
                    gSounds['victory']:play()

                    gStateMachine:change('victory', {
                        level = self.level,
                        paddle = self.paddle,
                        health = self.health,
                        score = self.score,
                        highScores = self.highScores,
                        ball = self.ball[1],
                        recoverPoints = self.recoverPoints,
                        powerups = {}
                    })
                end

                --
                -- collision code for bricks
                --
                -- we check to see if the opposite side of our velocity is outside of the brick;
                -- if it is, we trigger a collision on that side. else we're within the X + width of
                -- the brick and should check to see if the top or bottom edge is outside of the brick,
                -- colliding on the top or bottom accordingly 
                --

                -- left edge; only check if we're moving right, and offset the check by a couple of pixels
                -- so that flush corner hits register as Y flips, not X flips
                if self.ball[i].x + 2 < brick.x and self.ball[i].dx > 0 then
                    
                    -- flip x velocity and reset position outside of brick
                    self.ball[i].dx = -self.ball[i].dx
                    self.ball[i].x = brick.x - 8
                
                -- right edge; only check if we're moving left, , and offset the check by a couple of pixels
                -- so that flush corner hits register as Y flips, not X flips
                elseif self.ball[i].x + 6 > brick.x + brick.width and self.ball[i].dx < 0 then
                    
                    -- flip x velocity and reset position outside of brick
                    self.ball[i].dx = -self.ball[i].dx
                    self.ball[i].x = brick.x + 32
                
                -- top edge if no X collisions, always check
                elseif self.ball[i].y < brick.y then
                    
                    -- flip y velocity and reset position outside of brick
                    self.ball[i].dy = -self.ball[i].dy
                    self.ball[i].y = brick.y - 8
                
                -- bottom edge if no X collisions or top collision, last possibility
                else
                    
                    -- flip y velocity and reset position outside of brick
                    self.ball[i].dy = -self.ball[i].dy
                    self.ball[i].y = brick.y + 16
                end

                -- slightly scale the y velocity to speed up the game, capping at +- 150
                if math.abs(self.ball[i].dy) < 150 then
                    self.ball[i].dy = self.ball[i].dy * 1.02
                end

                -- only allow colliding with one brick, for corners
                break
            end
        end
    end

    -- if ball goes below bounds, revert to serve state and decrease health
    for k, balls in pairs(self.ball) do
        if self.ball[k].y >= VIRTUAL_HEIGHT and self.ball[k].inPlay then
            self.ball[k].inPlay = false
        end
    end
    for k, balls in pairs(self.ball) do
        if self.ball[k].inPlay then
            self.ball_in_play = true
            break
        else
            self.ball_in_play = false
        end
    end

    if self.ball_in_play == false then
        self.health = self.health - 1
        gSounds['hurt']:play()

        if self.health == 0 then
            gStateMachine:change('game-over', {
                score = self.score,
                highScores = self.highScores
            })
        else
            if self.paddle.size < 4 then
                self.paddle.size = self.paddle.size + 1
                self.paddle.width = self.paddle.size * 32
            end
            gStateMachine:change('serve', {
                paddle = self.paddle,
                bricks = self.bricks,
                health = self.health,
                score = self.score,
                highScores = self.highScores,
                level = self.level,
                recoverPoints = self.recoverPoints,
                powerups = self.powerups
            })
        end
    end

    -- for rendering particle systems
    for k, brick in pairs(self.bricks) do
        brick:update(dt)
    end

    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end
end

function PlayState:render()
    -- render bricks
    for k, brick in pairs(self.bricks) do
        brick:render()
    end

    -- render all particle systems
    for k, brick in pairs(self.bricks) do
        brick:renderParticles()
    end
    if self.powerups == nil then

    else
        for k, powerup in pairs(self.powerups) do
            powerup:render()
        end
    end

    self.paddle:render()
    self.ball0:render()
    self.ball1:render()
    self.ball2:render()

    renderScore(self.score)
    renderHealth(self.health)

    -- pause text, if paused
    if self.paused then
        love.graphics.setFont(gFonts['large'])
        love.graphics.printf("PAUSED", 0, VIRTUAL_HEIGHT / 2 - 16, VIRTUAL_WIDTH, 'center')
    end
end

function PlayState:checkVictory()
    for k, brick in pairs(self.bricks) do
        if brick.inPlay then
            return false
        end 
    end

    return true
end