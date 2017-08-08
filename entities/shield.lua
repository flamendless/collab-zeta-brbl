local classic = require("modules/classic/classic")
local shield = classic:extend()

local imgShield = love.graphics.newImage("assets/shield.png")

function shield:new(player, x, y, duration)
	self.image = imgShield
	self.x = x
	self.y = y
	self.dirX = dirX
	self.dirY = 1
	self.radius = 12
	self.player = player
	self.duration = duration
	self.tag = "Shield"
end

function shield:draw()
	love.graphics.setColor(255,255,255)
	love.graphics.circle("line", self.x, self.y, self.radius)
end

function shield:update(dt)
	if self.duration > 0 then
		self.x = self.player.x + self.player.w/2
		self.y = self.player.y + self.player.h/2
		self.duration = self.duration - 1 * dt
	else
		em:remove(self)
		self.player.shieldOn = false
	end
end

return shield
