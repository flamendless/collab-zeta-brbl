local classic = require("modules/classic/classic")
local shield = classic:extend()

local imgShield = love.graphics.newImage("assets/shield.png")
imgShield:setFilter("nearest","nearest",1)

function shield:new(x, y, dirX, dirY)
	self.image = imgShield
	self.x = x
	self.y = y
	self.dirX = dirX
	self.dirY = 1
end

function shield:draw()
	love.graphics.setColor(255,255,255)
	love.graphics.draw(self.image,self.x,self.y,0,self.dirX,self.dirY)
end

return shield
