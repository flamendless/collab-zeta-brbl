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

function warning:new(x,y)
	self.image = imgWarning
	self.w, self.h = self.image:getDimensions()
	self.x = x
	self.y = y or 0
	self.size = 0.5
	self.rot = 0
	self.tag = "Warning"
	self.remove = false
end

function warning:update(dt)
	c:update(dt)

	if self.size < 1 then
		self.size = self.size + 0.1 * dt
		if self.size >= 1 then
			em:remove(self)
		end
	end
end

function warning:draw()
	love.graphics.setColor(c:get())
	love.graphics.draw(self.image,
		self.x + self.w/2,
		self.y, self.rot,
		self.size,self.size,
		(self.w * self.size)/2,
		(self.h * self.size)/2)
end

function warning:onRemoveCondition()
	return self.remove
end

return warning
