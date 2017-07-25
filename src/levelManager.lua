local classic = require("modules/classic/classic")
local lm = classic:extend()

local startLevel = require("levels/init")

function lm:new()
	self.currentLevel = startLevel
end

function lm:switch(new)
	self.currentLevel = new
	self.currentLevel:load()
end

function lm:load()
	self.currentLevel:load()
end

function lm:update(dt)
	self.currentLevel:update(dt)
end

function lm:draw()
	self.currentLevel:draw()
end

function lm:keypressed(key)
	if self.currentLevel.keypressed ~= nil then
		self.currentLevel:keypressed(key)
	end
end

function lm:keyreleased(key)
	if self.currentLevel.keyreleased ~= nil then
		self.currentLevel:keyreleased(key)
	end
end

return lm
