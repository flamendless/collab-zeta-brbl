local class = require("modules/classic/classic")
local ground = class:extend()

function ground:new()
	self.x = 0
	self.y = game.gHeight - 8
	self.width = game.gWidth
	self.height = 8
	self.tag = "Ground"
end

function ground:draw()
	love.graphics.setColor(255, 0, 0)
	love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end

function ground:update(dt)
end

return ground
