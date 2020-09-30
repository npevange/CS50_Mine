--[[
    GD50
    Legend of Zelda

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

PlayerWalkState = Class{__includes = EntityWalkState}

function PlayerWalkState:init(player, dungeon)
    self.entity = player
    self.dungeon = dungeon

    -- render offset for spaced character sprite
    self.entity.offsetY = 5
    self.entity.offsetX = 0
end

function PlayerWalkState:update(dt)
    if love.keyboard.isDown('left') then
        self.entity.direction = 'left'
        if self.entity.holding_pot == false then
            self.entity:changeAnimation('walk-left')
        else
            self.entity:changeAnimation('pot-walk-left')
        end
    elseif love.keyboard.isDown('right') then
        self.entity.direction = 'right'
        if self.entity.holding_pot == false then
            self.entity:changeAnimation('walk-right')
        else
            self.entity:changeAnimation('pot-walk-right')
        end
    elseif love.keyboard.isDown('up') then
        self.entity.direction = 'up'
        if self.entity.holding_pot == false then
            self.entity:changeAnimation('walk-up')
        else
            self.entity:changeAnimation('pot-walk-up')
        end
    elseif love.keyboard.isDown('down') then
        self.entity.direction = 'down'
        if self.entity.holding_pot == false then
            self.entity:changeAnimation('walk-down')
        else
            self.entity:changeAnimation('pot-walk-down')
        end
    else
        self.entity:changeState('idle')
    end

    if love.keyboard.wasPressed('space') then
        if self.entity.holding_pot == false then
            self.entity:changeState('swing-sword')
        else
            self.entity.pot.onThrow()
            self.entity.holding_pot = false
            self.entity:changeState('pot-throw')
        end
    end

    -- perform base collision detection against walls
    EntityWalkState.update(self, dt)

    -- if we bumped something when checking collision, check any object collisions
    if self.bumped then
        if self.entity.direction == 'left' then
            
            -- temporarily adjust position
            self.entity.x = self.entity.x - PLAYER_WALK_SPEED * dt
            
            for k, doorway in pairs(self.dungeon.currentRoom.doorways) do
                if self.entity:collides(doorway) and doorway.open and self.entity.holding_pot == false then

                    -- shift entity to center of door to avoid phasing through wall
                    self.entity.y = doorway.y + 4
                    Event.dispatch('shift-left')
                    self.entity.holding_pot = false
                    --self.entity:changeAnimation('pot-throw' .. self.entity.direction)
                end
            end

            -- readjust
            self.entity.x = self.entity.x + PLAYER_WALK_SPEED * dt
        elseif self.entity.direction == 'right' then
            
            -- temporarily adjust position
            self.entity.x = self.entity.x + PLAYER_WALK_SPEED * dt
            
            for k, doorway in pairs(self.dungeon.currentRoom.doorways) do
                if self.entity:collides(doorway) and doorway.open and self.entity.holding_pot == false then

                    -- shift entity to center of door to avoid phasing through wall
                    self.entity.y = doorway.y + 4
                    Event.dispatch('shift-right')
                    self.entity.holding_pot = false
                end
            end

            -- readjust
            self.entity.x = self.entity.x - PLAYER_WALK_SPEED * dt
        elseif self.entity.direction == 'up' then
            
            -- temporarily adjust position
            self.entity.y = self.entity.y - PLAYER_WALK_SPEED * dt
            
            for k, doorway in pairs(self.dungeon.currentRoom.doorways) do
                if self.entity:collides(doorway) and doorway.open and self.entity.holding_pot == false then

                    -- shift entity to center of door to avoid phasing through wall
                    self.entity.x = doorway.x + 8
                    Event.dispatch('shift-up')
                    self.entity.holding_pot = false
                end
            end

            -- readjust
            self.entity.y = self.entity.y + PLAYER_WALK_SPEED * dt
        else
            
            -- temporarily adjust position
            self.entity.y = self.entity.y + PLAYER_WALK_SPEED * dt
            
            for k, doorway in pairs(self.dungeon.currentRoom.doorways) do
                if self.entity:collides(doorway) and doorway.open and self.entity.holding_pot == false then

                    -- shift entity to center of door to avoid phasing through wall
                    self.entity.x = doorway.x + 8
                    Event.dispatch('shift-down')
                    self.entity.holding_pot = false
                end
            end

            -- readjust
            self.entity.y = self.entity.y - PLAYER_WALK_SPEED * dt
        end
    end
end