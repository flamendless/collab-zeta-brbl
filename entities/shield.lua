local classic = require("modules/classic/classic")
local shield = classic:extend()

function shield:new(x, y)
	self.image = love.graphics.newImage("assets/shield.png")
	self.x = x 
	self.y = y 
	self.dirX = dirX
	self.dirY = dirY
end

function shield:draw()
	love.graphics.setColor(255,255,255)
	love.graphics.draw(self.image,self.x,self.y)
end

return shield