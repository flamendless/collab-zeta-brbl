local class = require("modules/classic/classic")
local player = class:extend()

local bullet = require("entities/bullet")
local bulletDirX = 0
local bulletDirY = 0
local shield = require("entities/shield")

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
	--key inputs either true or false
	local left = love.keyboard.isDown("a")
	local right = love.keyboard.isDown("d")
	local jump = love.keyboard.isDown("space")
	--input evaluations
	if left then
		--keep the obj inside the screen
		while self.x < 0 do
			self.x = self.x + 1 * dt
		end
		self.x = self.x - self.speed * dt
	elseif right then
		--keep the obj inside the screen
		while self.x + self.w > game.gWidth do
			self.x = self.x - 1 * dt	
		end
		self.x = self.x + self.speed * dt
	end
	--check if jump is pressed
	if jump then
		--check if on ground (yvel == 0)
		if self.yvel == 0 then
			--set yvel to jump height
			self.yvel = self.jumpheight
		end
	end
	
	--process yvel if not on ground
	if self.yvel ~= 0 then
		--makes the obj go upward
		self.y = self.y + self.yvel * dt
		--slowly decrease yvel(jump) to yvel(gravity)
		self.yvel = self.yvel - self.gravity * dt
	end
	--keep the player inside the screen, vertical-wise
	if self.y + self.h > game.gHeight then
		while self.y + self.h > game.gHeight do
			self.y = self.y - 1 * dt
		end
		self.yvel = 0
	end
end

function player:keypressed(key)
	local sLeft = "j"
	local sRight = "l"
	local sUp = "i"
	local sShield = "q"

	if key == sLeft then
		bulletDirX = -1	
		bulletDirY = 0
	elseif key == sRight then
		bulletDirX = 1
		bulletDirY = 0
	elseif key == sUp then
		bulletDirX = 0
		bulletDirY = -1
	end
	if key == sLeft or key == sRight or key == sUp then
		local b = bullet(self.x,self.y,bulletDirX,bulletDirY)
		em:add(b)
	elseif key == sShield then
		local sh = shield(self.x,self.y)
		em:add(sh)
	end

end

return player
