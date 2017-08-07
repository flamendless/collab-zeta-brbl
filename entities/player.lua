local class = require("modules.classic.classic")
local player = class:extend()
local particles = require("src.particles")
local quads = require("src.quads")
local anim = require("modules.anim8.anim8")

local guiBullets = require("gui.gBullets")()
gui:add(guiBullets)

local bullet = require("entities/bullet")
local shield = require("entities/shield")
local enemy = require("entities/enemy")
local bulletDirX = 0
local bulletDirY = 0
local spawned = false
local shieldRegen = 25
local shieldCost = 75

local imgPlayer = love.graphics.newImage("assets/sheets/player-sheet.png")

local gIdle = anim.newGrid(6,9,imgPlayer:getWidth(),imgPlayer:getHeight())
local gJump = anim.newGrid(6,9,imgPlayer:getWidth(),imgPlayer:getHeight(),0,9)
local gWalk = anim.newGrid(6,9,imgPlayer:getWidth(),imgPlayer:getHeight(),0,18)

local states = {}
states.idle = anim.newAnimation(gIdle('1-2',1),0.5)
states.jumping = anim.newAnimation(gJump('1-3',1),0.3, function()
		states.jumping:pause()
	end)
states.walkingRight = anim.newAnimation(gWalk('1-4',1),0.2)
states.walkingLeft = anim.newAnimation(gWalk('1-4',1),0.2):flipH()

function player:new(x, y)
	self.image = imgPlayer
	self.state = states.idle
	self.x = x
	self.y = y
	self.w = 6
	self.h = 9
	self.speed = 50
	self.yvel = 0
	self.jumpheight = -100
	self.gravity = -200
	self.tag = "Player"
	self.death = false
	self.maxAmmo = 15
	self.ammo = self.maxAmmo
	self.shieldOn = false
	self.shieldPower = 100
	self.shield = nil
end

function player:draw()
	love.graphics.setColor(255,255,255)
	--love.graphics.draw(self.image, self.x, self.y)
	self.state:draw(self.image,self.x,self.y)
	
	if debugging then
		--love.graphics.print(math.floor(self.shieldPower, 0,16)
	end
end

function player:update(dt)
	guiBullets:setBullets(self.ammo)
	self.state:update(dt)
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
		if self.state ~= states.jumping then
			states.jumping:resume()
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
		self.state = states.idle
	end
	
	--death
	if self.death then
		--remove shield
		em:remove(self.shield)
		--spawn death object	
		if not spawned then
			spawned = true
			local x = self.x + self.w/2
			local y = self.y + self.h/2
			local q = quads(self.image,4,x,y)
			
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

			self.ammo = self.ammo - 1
		end
	elseif key == keyShield then
		if not self.shieldOn then
			if self.shieldPower >= shieldCost then
				self.shield = shield(self,self.x + self.w/2,self.y + self.h/2, 8, 10)
				em:add(self.shield)
				self.shieldPower = self.shieldPower - shieldCost
				self.shieldOn = true
			end
		end
	end

	--if no ammo, reload
	if key == reload then
		self.ammo = self.maxAmmo
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
