local classic = require("modules/classic/classic")
local enemy = classic:extend()
local imgEnemy = love.graphics.newImage("assets/ship.png")
local ht = require("src/hitTimer")

--set up table for enemy possible events macro
local enemyEvents = {
	"hide",
	"Left_to_Right",
	"Right_to_left",
	"Top_to_Bottom"
}

function enemy:new(x,y,speed)
	self.image = imgEnemy
	self.x = x
	self.y = y
	self.w = self.image:getWidth()
	self.h = self.image:getHeight()
	self.speed = speed
	self.dir = 1
	self.tag = "Enemy"

	self.hp = 1000
	self.hit = false
	self.hitColor = {255,255,255}
	self.ht = ht(self,0.25)
end

function enemy:draw()
	love.graphics.setColor(255,255,255)
	if self.hit then
		love.graphics.setColor(self.hitColor)
	end
	love.graphics.draw(self.image,self.x,self.y)
end

function enemy:update(dt)
	self.ht:update(dt)
end

function enemy:onCollision(object)
end

function enemy:onRemoveCondition()
	return self.hp <= 0
end

return enemy
