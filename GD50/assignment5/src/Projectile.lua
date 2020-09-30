--[[
    GD50
    Legend of Zelda

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

Projectile = Class{}

function Projectile:init(def)
    GameObject.init(self, def)
end

function Projectile:update(dt)

end

function Projectile:collides(target)
    local selfY, selfHeight = self.y + 8, self.y
    
    return not (self.x + self.width < target.x or self.x > target.x + target.width or
                selfY + selfHeight < target.y or selfY > target.y + target.height)
end

function Projectile:render()
    GameObject.render(self)
end