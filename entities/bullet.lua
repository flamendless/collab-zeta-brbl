local classic = require("modules/classic/classic")
local bullet = classic:extend()

local imgBullet = love.graphics.newImage("assets/bullet.png")
imgBullet:setFilter("nearest","nearest")

function bullet:new(x,y,xdir,ydir)
	self.img = imgBullet
	self.w, self.h = self.img:getDimensions()
	self.x = x
	self.y = y
	self.xdir = xdir
	self.ydir = ydir
	self.speed = 200
	self.tag = "Bullet"
	self.damage = 30
end

function bullet:update(dt)
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
	love.graphics.draw(self.img, self.x, self.y)
end

function bullet:onCollision(object)
	local obj = object.tag
	if obj == "Missile" or obj == "Runner" then
		if object.hit then
			self.damage = 20
		else
			self.damage = 30
		end
		object.hp = object.hp - self.damage
		object.hit = true
		--remove bullet
		em:remove(self)
	end
end

function bullet:onRemoveCondition()
	return self.x < -32 or self.x > game.gWidth + 32 or self.y < - 32
end

return bullet
