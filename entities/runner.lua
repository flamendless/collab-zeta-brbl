local class = require("modules/classic/classic")
local runner = class:extend()
local ht = require("src/hitTimer")
local warning = require("entities/warning")

--set starting possible spawn positions
local val = 256
local position = {-val,game.gWidth+val}


--randomize seed
math.randomseed(os.time())

local imgRunner = love.graphics.newImage("assets/cactuar.png")

function runner:new()
	self.image = imgRunner
	self.x = position[math.floor(math.random(1,#position))]
	self.y = game.gHeight
	self.speed = 100
	self.w = self.image:getWidth()
	self.h = self.image:getHeight()	
	self.dir = 1
	self.hp = 100
	self.hit = false
	self.ht = ht(self,0.25)
	--check where facing
	if self.x == position[1] then
		self.dir = 1
	else
		self.dir = -1
	end
	self.origX = self.x
	self.tag = "Runner"

	--warning
	local wx
	local wy = game.gHeight - 12
	if self.x == position[1] then
		wx = 0
	elseif self.x == position[2] then
		wx = game.gWidth
	end
	self.warning = warning(wx,wy)
	em:add(self.warning)
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

	--process life
	if self.hp <= 0 then
		em:remove(self)
	end
	self.ht:update(dt)
end	

function runner:draw()
	love.graphics.setColor(255,255,255)
	if self.hit then
		love.graphics.setColor(255,0,0)
	end
	love.graphics.draw(self.image,self.x,self.y, 0, self.dir, 1)
end

function runner:onRemoveCondition()
	if self.origX == position[1] then
		if self.x >= 0 then
			self.warning.remove = true
		end
	elseif self.origX == position[2] then
		if self.x <= game.gWidth then
			self.warning.remove = true
		end
	end
	return self.x < -512 or self.x > game.gWidth + 512
end

function runner:onCollision(obj)

end

return runner

