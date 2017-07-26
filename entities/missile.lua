local classic = require("modules/classic/classic")
local missile = classic:extend()
local warning = require("entities/warning")
local ct = require("src/colorTimer")

--set up grid system for missile path
local grid = {}
--calculate the width of the grid
local gridW = math.floor(game.gWidth/8)
--calculate the number of grids
local gridN = math.floor((game.gWidth)/gridW)

--attach each value in a grid table
for i = 1, gridN do
	local x = i * gridW
	grid[i] = x
end

--color tables for timerColor
local colors = {
	{255,0,0}, --red
	{255,175,175}, --half
	{255,255,255}, --white
}
local c = ct(3, colors)

function missile:new()
	self.image = love.graphics.newImage("assets/missile.png")
	
	--random grid position
	self.x = grid[math.floor(math.random(#grid))]
	self.h = self.image:getHeight()

	--start at above the visible screen
	self.y = -self.h * 2
	self.speed = math.random(100,200)
	self.color = colors[1]
	self.tag = "Missile"

	--create a warning sign
	local w = warning(self.x)
	em:add(w)
end

--check so that no multiple missiles appear on the same column
function missile:checkOverlap(dt)
	for k,v in pairs(em.entities) do
		if v ~= self then
			if v.tag == "Missile" then
				if v.x == self.x then
					v.x = grid[math.floor(math.random(#grid))]
				end
			end
		end
	end
end

function missile:update(dt)
	self:checkOverlap(dt)
	c:update(dt)
	--move the missile downwards
	if self.y + self.h then
		self.y = self.y + self.speed * dt
	end
end

function missile:draw()
	love.graphics.setColor(c:get())
	love.graphics.draw(self.image, self.x, self.y)

	--debugging: draw the grid lines
	if debugging then
		love.graphics.setColor(255,0,0)
		for i = 1, #grid do
			love.graphics.line(i*gridW,0,i*gridW,game.gHeight)
		end
	end
end

function missile:onRemoveCondtion()
	return self.y > game.gHeight
end

return missile
