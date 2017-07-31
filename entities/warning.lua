local classic = require("modules/classic/classic")
local warning = classic:extend()
local ct = require("src/colorTimer")

--color table
local colors = {
	{255,255,0},
	{255,0,0},
	{255,255,255},
}

local c = ct(3, colors)

--load the image when the file is required (when loaded)
--loading the image in the :new function may result in glitch
local imgWarning = love.graphics.newImage("assets/warning.png")

function warning:new(x)
	self.image = imgWarning
	self.w, self.h = self.image:getDimensions()
	self.x = x
	self.y = 0
	self.size = 2
	self.rot = 0
	self.tag = "Warning"
	self.remove = false
end

function warning:update(dt)
	c:update(dt)
end

function warning:draw()
	love.graphics.setColor(c:get())
	love.graphics.draw(self.image,
		self.x + self.w/2,
		self.y)
end

function warning:onRemoveCondition()
	return self.remove
end

return warning
