--[[
    GD50
    Super Mario Bros. Remake

    -- GameLevel Class --

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

GameLevel = Class{}

function GameLevel:init(entities, enemies, tilemap)
    self.entities = entities
    self.enemies = enemies
    self.tileMap = tilemap
end

--[[
    Remove all nil references from tables in case they've set themselves to nil.
]]
function GameLevel:clear()
    for i = #self.enemies, 1, -1 do
        if not self.enemies[i] then
            table.remove(self.enemies, i)
        end
    end

    for i = #self.entities, 1, -1 do
        if not self.enemies[i] then
            table.remove(self.enemies, i)
        end
    end
end

function GameLevel:update(dt)
    self.tileMap:update(dt)

    for k, enemy in pairs(self.enemies) do
        enemy:update(dt)
    end

    for k, entity in pairs(self.entities) do
        entity:update(dt)
    end
end

function GameLevel:render()
    self.tileMap:render()
    -- if testing < 2 then

    -- end
    for k, enemy in pairs(self.enemies) do
        enemy:render()
    end

    for k, entity in pairs(self.entities) do
        entity:render()
    end
end