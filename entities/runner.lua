local class = require("modules/classic/classic")
local runner = class:extend()

--set starting possible spawn positions
local val = 256
local position = {-val,game.gWidth+val}

--randomize seed
math.randomseed(os.time())

function runner:new()
	self.image = love.graphics.newImage("assets/cactuar.png")
	self.x = position[math.floor(math.random(1,#position))]
	self.y = game.gHeight
	self.speed = 100
	self.h = self.image:getHeight()	
	self.dir = 1

	--check where facing
	if self.x == position[1] then
		self.dir = 1
	else
		self.dir = -1
	end
	self.tag = "Runner"
end

function runner:update(dt)
	--keep the obj inside the screen(above the ground)
	if self.y + self.h > game.gHeight then
		while self.y + self.h > game.gHeight do
			self.y = self.y - 1 * dt
		end
	end
	--process movement(motion)
	self.x = self.x + (self.speed*self.dir) * dt
end	

function runner:draw()
	love.graphics.setColor(255,255,255)
	love.graphics.draw(self.image,self.x,self.y, 0, self.dir, 1)
end

function runner:onRemoveCondtion()
	return self.x < -512 or self.x > gamegWidth + 512
end

return runner

