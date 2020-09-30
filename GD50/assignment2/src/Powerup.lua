--[[
    GD50
    Breakout Remake

    -- Ball Class --

    PauseState Class
    Author: Nathan "Call me Cats987654321" Evangelista
    npevangelista@ucdavis.edu

    Represents a powerup which will spawn and fall towards the paddle, stop at y of paddle.
]]

Powerup = Class{}

function Powerup:init(Ball, power_num)
    --position
    self.width = 16
    self.height = 16
    self.x = Ball.x
    self.y = Ball.y

    self.inPlay = true
    --velocity
    self.dx = 0
    self.dy = 35
    self.power_num = power_num

    --VIRTUAL_HEIGHT - 32 == Paddle Height

end

function Powerup:collides(target, power_num)
    -- first, check to see if the left edge of either is farther to the right
    -- than the right edge of the other
    if self.x > target.x + target.width or target.x > self.x + self.width then
        return false
    end

    -- then check to see if the bottom edge of either is higher than the top
    -- edge of the other
    if self.y > target.y + target.height or target.y > self.y + self.height then
        return false
    end 

    -- if the above aren't true, they're overlapping
    return true
end
function Powerup:update(dt)
    self.y = self.y + self.dy * dt
    if self.y > VIRTUAL_HEIGHT then
        self.inPlay = false
    end
end

function Powerup:render()
    -- gTexture is our global texture for all blocks
    -- gBallFrames is a table of quads mapping to each individual ball skin in the texture
    if self.inPlay then
        love.graphics.draw(gTextures['main'], gFrames['powerups'][self.power_num],
            self.x, self.y)
    end
end