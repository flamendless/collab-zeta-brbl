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

local imgMissile = love.graphics.newImage("assets/missile.png")
imgMissile:setFilter("nearest","nearest",1)

function missile:new()
	self.image = imgMissile
	
	--random grid position
	self.x = grid[math.floor(math.random(#grid))]
	self.h = self.image:getHeight()
	self.w = self.image:getWidth()
	--start at above the visible screen
	self.y = -self.h * 2
	self.speed = math.random(100,200)
	self.color = colors[1]
	self.tag = "Missile"

	--missile stats
	self.hp = 100

	--create a warning sign
	self.warning = warning(self.x)
	em:add(self.warning)
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

function missile:onCollision(obj)
	
end

function missile:update(dt)
	self:checkOverlap(dt)
	c:update(dt)
	--move the missile downwards
	if self.y + self.h then
		self.y = self.y + self.speed * dt
	end

	--process warning position
	self.warning.x = self.x - self.w/2
	
	--check hp
	if self.hp <= 0 then
		self.warning.remove = true
		em:remove(self)
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
	love.graphics.rectangle("fill", self.x,self.y,self.w,self.h)
end

function missile:onRemoveCondition()
	if self.y > game.gHeight then
		self.warning.remove = true
	end
	return self.y > game.gHeight
end

return missile
