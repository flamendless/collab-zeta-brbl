local classic = require("modules/classic/classic")
local bullet = classic:extend()

function bullet:new(x,y,xdir,ydir)
	self.x = x
	self.y = y
	self.xdir = xdir
	self.ydir = ydir
	self.speed = 200
	self.tag = "Bullet"
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
	love.graphics.setColor(255,0,0)
	love.graphics.circle("fill",self.x,self.y,4)
end

function bullet:onRemoveCondition()
	return self.x < -32 or self.x > game.gWidth + 32 or self.y < - 32
end

return bullet
