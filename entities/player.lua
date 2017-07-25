local class = require("modules/classic/classic")
local player = class:extend()

function player:new(x, y, speed, grav, jumpspeed)
	self.image = love.graphics.newImage("assets/square.png")
	self.x = x
	self.y = y
	self.w = self.image:getWidth()
	self.h = self.image:getHeight()
	self.speed = speed
	self.grav = grav
	self.jumpspeed = jumpspeed
	self.isJumping = false
	self.onGround = false
	self.maxjump = self.y + 100
end

function player:draw()
	love.graphics.setColor(255,255,255)
	love.graphics.draw(self.image, self.x, self.y)
end

function player:update(dt)
	if self.isJumping == false then
		self:physics(dt)
	end
	
	local left = love.keyboard.isDown("a")
	local right = love.keyboard.isDown("d")
	
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
	if self.isJumping then
		self:jump(dt)
	end
end

function player:keypressed(key)
	if key=="space" then
		if self.onGround then
			self.isJumping = true
			self.maxjump = self.y - 100
			print(self.maxjump)
			print(self.isJumping)
		end
	end
end
function player:physics(dt)
	if self.y + self.h < game.gHeight then
		while self.y + self.h > game.gHeight do
			self.y = self.y - 1 * dt
		end
		self.onGround = false
		self.y = self.y + self.grav * dt
	elseif self.y + self.h >= game.gHeight then
		self.onGround = true
	end
end

function player:jump(dt)
	-- local dt = love.timer.getDelta()
	self.y = self.y - self.jumpspeed * dt
	if self.y > self.maxjump then
		self.isJumping = false
	end
end

return player