local class = require("modules/classic/classic")
local timer = class:extend()
local font = love.graphics.newFont("assets/Doogle.ttf")
font:setFilter("nearest","nearest",1)

function timer:new(x, y, init)
	self.x = x 
	self.y = y 
	self.init = init
	self.red = {255,0,0}
	self.yellow = {255,255,0}
	self.tag = "Timer"
end

function timer:update(dt)
	if self.init > 1 then
		self.init = self.init - 2 * dt
	end
end

function timer:draw(dt)

	if self.init < 20 and self.init > 11 then
		love.graphics.setColor(self.yellow)

	elseif self.init < 12 then 
		love.graphics.setColor(self.red)
	end
	love.graphics.setFont(font)
	love.graphics.print(math.floor(self.init), self.x, self.y)
end

function timer:getTimer()
	return self.init
end



return timer