local classic = require("modules.classic.classic")
local bullet = classic:extend()

local imgBullet = {
	love.graphics.newImage("assets/bullets/fire.png"),
	love.graphics.newImage("assets/bullets/dark.png"),
	love.graphics.newImage("assets/bullets/elec.png"),
	love.graphics.newImage("assets/bullets/grass.png"),
	love.graphics.newImage("assets/bullets/rock.png"),
	love.graphics.newImage("assets/bullets/water.png")
}

local hitColors = {
	{255,0,0},
	{0,0,0},
	{255,255,0},
	{0,255,0},
	{102,57,0},
	{0,0,255}
}

function bullet:new(x,y,xdir,ydir)
	local n = math.floor(math.random(1,6))
	self.image = imgBullet[n]
	self.w, self.h = self.image:getDimensions()
	self.x = x
	self.y = y
	self.xdir = xdir
	self.ydir = ydir
	self.speed = 100
	self.tag = "Bullet"
	self.damage = 30
	self.rot = 0
	self.scale = 1
	self.bColor = hitColors[n]
end

local rotSpeed = 30

function bullet:update(dt)
	--update rotation
	self.rot = self.rot + rotSpeed * dt

	--move the bullet accordingly in the horizontal
	self.x = self.x + (self.xdir * self.speed) * dt
	--check if bullet is fired upwards
	--checking avoids glitch/bug
	if self.ydir ~= 0 then
		self.y = self.y + (self.ydir * self.speed) * dt
	end
end

function bullet:draw()
	love.graphics.setColor(255,255,255)
	love.graphics.draw(self.image,self.x,self.y,self.rot,
		self.scale,self.scale,
		self.w/2, self.h/2)
end

function bullet:onCollision(object)
	local obj = object.tag
	if obj == "Missile" or obj == "Runner" or
		obj == "Enemy" then
		if object.hit then
			self.damage = 20
		else
			self.damage = 30
		end
		object.hp = object.hp - self.damage
		object.hit = true
		object.hitColor = self.bColor
		--remove bullet
		em:remove(self)
	end
end

function bullet:onRemoveCondition()
	return self.x < -32 or self.x > game.gWidth + 32 or self.y < - 32
end

return bullet
