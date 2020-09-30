--[[
    GD50
    Legend of Zelda

    Author: Nathan Evangelista
    npevangelista@ucdavis.edu
]]


PlayerThrowState = Class{__includes = BaseState}

function PlayerThrowState:init(player, dungeon)
    self.player = player
    self.dungeon = dungeon

    -- render offset for spaced character sprite
    self.player.offsetY = 5
    self.player.offsetX = 0

    -- create hitbox based on where the player is and facing
    local direction = self.player.direction
    
    local hitboxX, hitboxY, hitboxWidth, hitboxHeight
    -- TODO
    -- Set this to only hit closest enemy and dissapear when hitting enemy / wall / travels 4 tiles.
    if direction == 'left' then
        Timer.tween(0.2, {
            [self.player.pot] = {x = self.player.pot.x - 16, y = self.player.pot.y},
            [self.player.pot] = {x = self.player.pot.x - 64, y = self.player.pot.y}
        })
        :finish(function()
            self.player.pot.state = 'no-pot'
        end)
        hitboxWidth = 64
        hitboxHeight = 16
        hitboxX = self.player.x - hitboxWidth
        hitboxY = self.player.y + 2
    elseif direction == 'right' then
        Timer.tween(0.2, {
            [self.player.pot] = {x = self.player.pot.x + 16, y = self.player.pot.y},
            [self.player.pot] = {x = self.player.pot.x + 64, y = self.player.pot.y}
        })
        :finish(function()
            self.player.pot.state = 'no-pot'
        end)
        hitboxWidth = 64
        hitboxHeight = 16
        hitboxX = self.player.x + self.player.width
        hitboxY = self.player.y + 2
    elseif direction == 'up' then
        Timer.tween(0.2, {
            [self.player.pot] = {x = self.player.pot.x, y = self.player.pot.y - 22},
            [self.player.pot] = {x = self.player.pot.x, y = self.player.pot.y - 64}
        })
        :finish(function()
            self.player.pot.state = 'no-pot'
        end)
        hitboxWidth = 16
        hitboxHeight = 64
        hitboxX = self.player.x
        hitboxY = self.player.y - hitboxHeight
    else
        Timer.tween(0.2, {
            [self.player.pot] = {x = self.player.pot.x, y = self.player.pot.y + 22},
            [self.player.pot] = {x = self.player.pot.x, y = self.player.pot.y + 64}
        })
        :finish(function()
            self.player.pot.state = 'no-pot'
        end)
        hitboxWidth = 16
        hitboxHeight = 64
        hitboxX = self.player.x
        hitboxY = self.player.y + self.player.height
    end

    self.potHitbox = Hitbox(hitboxX, hitboxY, hitboxWidth, hitboxHeight)
    self.player:changeAnimation('pot-throw-' .. self.player.direction)
end

function PlayerThrowState:enter(params)
    -- gSounds['sword']:stop()
    -- gSounds['sword']:play()

    -- restart sword swing animation
    self.player.currentAnimation:refresh()
end

function PlayerThrowState:update(dt)
    -- check if hitbox collides with any entities in the scene
    local entities_hit = {}
    for k, entity in pairs(self.dungeon.currentRoom.entities) do
        if entity:collides(self.potHitbox) then
            table.insert(entities_hit, entity)
            -- entity:damage(1)
            -- gSounds['hit-enemy']:play()
        end
    end

    if self.player.currentAnimation.timesPlayed > 0 then
        self.player.currentAnimation.timesPlayed = 0
        self.player:changeState('idle')
    end

    if love.keyboard.wasPressed('space') then
        self.player:changeState('swing-sword')
    end
end

function PlayerThrowState:render()
    local anim = self.player.currentAnimation
    love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()],
        math.floor(self.player.x - self.player.offsetX), math.floor(self.player.y - self.player.offsetY))

    -- debug for player and hurtbox collision rects
    -- love.graphics.setColor(255, 0, 255, 255)
    -- love.graphics.rectangle('line', self.player.x, self.player.y, self.player.width, self.player.height)
    -- love.graphics.rectangle('line', self.swordHurtbox.x, self.swordHurtbox.y,
    --     self.swordHurtbox.width, self.swordHurtbox.height)
    -- love.graphics.setColor(255, 255, 255, 255)
end