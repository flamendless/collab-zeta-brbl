local class = require("modules/classic/classic")
local runner = class:extend()
math.randomseed(os.time())
local val = 256
local position = {-val,game.gWidth+val}

function runner:new()
	self.image = love.graphics.newImage("assets/cactuar.png")
	self.x = position[math.floor(math.random(1,#position))]
	self.y = game.gHeight
	self.speed = 100
	self.h = self.image:getHeight()	
	self.dir = 1
	if self.x == position[1] then
		self.dir = 1
	else
		self.dir = -1
	end
	print(self.x)
end

function runner:update(dt)
	if self.y + self.h > game.gHeight then
		while self.y + self.h > game.gHeight do
			self.y = self.y - 1 * dt
		end
	end
	self.x = self.x + (self.speed*self.dir) * dt
end	

function runner:draw()
	love.graphics.setColor(255,255,255)
	love.graphics.draw(self.image,self.x,self.y, 0,self.dir,1)
end

return runner

