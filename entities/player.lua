local class = require("modules/classic/classic")
local player = class:extend()
local particles = require("src.particles")
local quads = require("src.quads")
local anim = require("modules.anim8.anim8")

local bullet = require("entities/bullet")
local shield = require("entities/shield")
local enemy = require("entities/enemy")
local bulletDirX = 0
local bulletDirY = 0
local spawned = false
local shieldRegen = 25
local shieldCost = 75

local imagePlayer = love.graphics.newImage("assets/square.png")

--local gIdle = anim.newGrid(size,size,imageWidth,imageHeight)
--states.idle = anim.newAnimation(gIdle('range',1),speed)

local states = {
	idle = "idle",
	jumping = "jumping",
	walkingLeft = "walk left",
	walkingRight = "walk right",
	shooting = "shooting",
	reloading = "reloading"
}

function player:new(x, y, speed)
	self.state = states.idle
	self.image = imagePlayer
	self.x = x
	self.y = y
	self.w = self.image:getWidth()
	self.h = self.image:getHeight()
	self.speed = speed
	self.yvel = 0
	self.jumpheight = -100
	self.gravity = -200
	self.tag = "Player"
	self.death = false
	self.maxAmmo = 10
	self.ammo = self.maxAmmo
	self.shieldOn = false
	self.shieldPower = 100
end

function player:draw()
	love.graphics.setColor(255,255,255)
	love.graphics.draw(self.image, self.x, self.y)
	
	if debugging then
		love.graphics.print(math.floor(self.shieldPower, 0,16))
		--love.graphics.print(self.state,0,32)
	end
end

function player:update(dt)
	--key inputs either true or false
	local left = love.keyboard.isDown("a")
	local right = love.keyboard.isDown("d")
	local jump = love.keyboard.isDown("w")
	--input evaluations
	if left then
		--keep the obj inside the screen
		while self.x < 0 do
			self.x = self.x + 1 * dt
		end
		self.x = self.x - self.speed * dt
		self.state = states.walkingLeft
	elseif right then
		--keep the obj inside the screen
		while self.x + self.w > game.gWidth do
			self.x = self.x - 1 * dt	
		end
		self.x = self.x + self.speed * dt
		self.state = states.walkingRight
	else
		if self.state ~= states.jumping then
			self.state = states.idle
		end
	end
	--check if jump is pressed
	if jump then
		--check if on ground (yvel == 0)
		if self.yvel == 0 then
			--set yvel to jump height
			self.yvel = self.jumpheight
		end
		self.state = states.jumping
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
	
	--death
	if self.death then
		--spawn death object	
		if not spawned then
			spawned = true
			local x = self.x + self.w/2
			local y = self.y + self.h/2
			local q = quads(self.image,1,x,y)
			
			--remove player object
			em:remove(self)
		end
	end
	if self.shieldPower < 100 then
		self.shieldPower = self.shieldPower + shieldRegen * dt
	end
	if debugging then
		if self.death then
			if love.keyboard.isDown("p") then
				self.death = false
				spawned = false
			end
		end
	end


end

function player:keypressed(key)
	local sLeft = "j"
	local sRight = "l"
	local sUp = "i"
	local reload = "r"
	local keyShield = "q"
	
	--set bullet
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
		if self.ammo > 0 then
			--fire bullet
			local b = bullet(self.x,self.y,bulletDirX,bulletDirY)
			em:add(b)

			self.state = states.shooting
			self.ammo = self.ammo - 1
		end
	elseif key == keyShield then
		if not self.shieldOn then
			if self.shieldPower >= shieldCost then
				local sh = shield(self,self.x + self.w/2,self.y + self.h/2, 8, 1)
				em:add(sh)
				self.shieldPower = self.shieldPower - shieldCost
				self.shieldOn = true
			end
		end
	end

	--if no ammo, reload
	if key == reload then
		self.ammo = self.maxAmmo
		self.state = states.reloading
	end
end

function player:onCollision(object)
	local objTag = object.tag
	if objTag == "Missile" or
		objTag == "Runner" then
		self.death = true
	end
end

return player
