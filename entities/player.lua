local class = require("modules/classic/classic")
local player = class:extend()

function player:new(x, y, speed)
	self.image = love.graphics.newImage("assets/square.png")
	self.x = x
	self.y = y
	self.w = self.image:getWidth()
	self.h = self.image:getHeight()
	self.speed = speed
	self.yvel = 0
	self.jumpheight = -100
	self.gravity = -200
end

function player:draw()
	love.graphics.setColor(255,255,255)
	love.graphics.draw(self.image, self.x, self.y)
end

function player:update(dt)
	local left = love.keyboard.isDown("a")
	local right = love.keyboard.isDown("d")
	local jump = love.keyboard.isDown("space")
	if left then 
		while self.x < 0 do
			self.x = self.x + 1 * dt
		end
		self.x = self.x - self.speed * dt
	elseif right then 
		while self.x + self.w > game.gWidth do
			self.x = self.x - 1 * dt	
		end
		self.x = self.x + self.speed * dt
	end
	if jump then
		if self.yvel == 0 then
			self.yvel = self.jumpheight
		end
	end
	if self.yvel ~= 0 then
		self.y = self.y + self.yvel * dt
		self.yvel = self.yvel - self.gravity * dt
	end
	if self.y + self.h > game.gHeight then
		while self.y + self.h > game.gHeight do
			self.y = self.y - 1 * dt
		end
		self.yvel = 0
	end
end

return player
