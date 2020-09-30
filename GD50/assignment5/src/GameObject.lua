--[[
    GD50
    Legend of Zelda

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

GameObject = Class{}

function GameObject:init(def, x, y)
    -- string identifying this object type
    self.type = def.type

    self.texture = def.texture
    self.frame = def.frame or 1

    -- whether it acts as an obstacle or not
    self.solid = def.solid

    self.defaultState = def.defaultState
    self.state = self.defaultState
    self.states = def.states

    -- dimensions
    self.x = x
    self.y = y
    self.width = def.width
    self.height = def.height
    self.pot_grab = false
    self.thrown = false

    -- default empty collision callback
    self.onCollide = function() end
    self.onThrow = function() end
end

function GameObject:update(dt)
    if self.thrown then
        local bottomEdge = VIRTUAL_HEIGHT - (VIRTUAL_HEIGHT - MAP_HEIGHT * TILE_SIZE) 
                + MAP_RENDER_OFFSET_Y - TILE_SIZE

        if self.x <= MAP_RENDER_OFFSET_X + TILE_SIZE then
            self.state = 'no-pot'

        elseif self.x + 16 >= VIRTUAL_WIDTH - TILE_SIZE * 2 then
            self.state = 'no-pot'


        elseif self.y <= MAP_RENDER_OFFSET_Y + TILE_SIZE - 8 then
            self.state = 'no-pot'

        elseif self.y + 16 >= bottomEdge then
            self.state = 'no-pot'
        end
    end
end

function GameObject:render(adjacentOffsetX, adjacentOffsetY)
    love.graphics.draw(gTextures[self.texture], gFrames[self.texture][self.states[self.state].frame or self.frame],
        self.x + adjacentOffsetX, self.y + adjacentOffsetY)
end