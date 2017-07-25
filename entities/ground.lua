local class = require("modules/classic/classic")
local ground = class:extend()

function ground:new(x, y, width, height)
	self.x = x 
	self.y = y 
	self.width = width 
	self.height = height 
	self.tag = "Ground"

end

function ground:draw()
	love.graphics.setColor(255, 0, 0)
	love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end

function ground:update(dt)
	local player = em:getEntity("Player")
	if player.y + player.h > self.y then
		player.onGround = true
	else player.onGround = false end
end

return ground