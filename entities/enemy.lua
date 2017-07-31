local classic = require("modules/classic/classic")
local enemy = classic:extend()
local imgEnemy = love.graphics.newImage("assets/ship.png")

local val = 256
local position = {-val,game.gWidth+val}

function enemy:new(x,y,speed)
	self.image = imgEnemy
	self.x = x
	self.y = y
	self.w = self.image:getWidth()
	self.speed = speed
	self.dir = 1
	self.tag = "Enemy"
	
end

function enemy:draw()
	love.graphics.setColor(255,255,255)
	love.graphics.draw(self.image,self.x,self.y)
end

function enemy:update(dt)
	if self.x + self.w > game.gWidth then
		self.dir = -1
	elseif self.x < 0 then
		self.dir = 1
	end
	self.x = self.x + self.speed * self.dir * dt 
end

return enemy