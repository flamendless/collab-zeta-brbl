local class = require("modules/classic/classic")
local ground = class:extend()

local imgGround = love.graphics.newImage("assets/ground.png")

function ground:new()
	self.image = imgGround
	self.width = self.image:getWidth()
	self.height = self.image:getHeight()
	self.x = 0
	self.y = game.gHeight - self.height
	self.tag = "Ground"
end

function ground:draw()
	--love.graphics.setColor(255, 0, 0)
	--love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
	love.graphics.setColor(255,255,255)
	love.graphics.draw(self.image,self.x,self.y)
end

function ground:update(dt)
end

return ground
