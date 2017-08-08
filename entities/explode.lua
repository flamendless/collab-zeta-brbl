local classic = require("modules.classic.classic")
local explode = classic:extend()

local rate = 20
local time = 1
local imgExplode = love.graphics.newImage("assets/explode.png")

function explode:new(x,y)
	self.image = imgExplode
	self.x = x
	self.y = y
	self.rot = 0
	self.scale = math.floor(math.random(1,1.2))
end

function explode:update(dt)
	self.y = self.y - rate * dt
	time = time - 1 * dt
	if time <= 0 then
		em:remove(self)
	end
end

function explode:draw()
	love.graphics.setColor(255,255,255)
	love.graphics.draw(self.image, self.x, self.y, self.rot,
		self.scale,self.scale)
end

return explode
