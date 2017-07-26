local classic = require("modules/classic/classic")
local warning = classic:extend()
local ct = require("src/colorTimer")

--color table
local colors = {
	{255,255,255},
	{255,255,0},
	{255,0,0}
}

local c = ct(3, colors)

function warning:new(x)
	self.x = x
	self.size = 2
	self.color = colors[1]
end

function warning:update(dt)
	c:update(dt)
end

function warning:draw()
	love.graphics.setColor(c:get())
end

return warning
