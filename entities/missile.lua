local classic = require("modules/classic/classic")
local missile = classic:extend()
local warning = require("entities/warning")
local ht = require("src/hitTimer")

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

local imgMissile = love.graphics.newImage("assets/missile.png")

function missile:new()
	self.image = imgMissile
	
	--random grid position
	self.g = math.floor(math.random(1,#grid))
	self.x = grid[self.g]
	self.h = self.image:getHeight()
	self.w = self.image:getWidth()
	--start at above the visible screen
	self.y = -self.h * 2
	self.speed = math.random(50,100)
	self.tag = "Missile"

	--missile stats
	self.hp = 100
	self.hit = false
	self.ht = ht(self,0.25)
	self.hitColor = {255,255,255}
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

	self.warning.x = self.x

	--move the missile downwards
	if self.y + self.h then
		self.y = self.y + self.speed * dt
	end
	
	--check hp
	if self.hp <= 0 then
		self.warning.remove = true
		em:remove(self)

		global.shake = true
	end
	--hit timer
	self.ht:update(dt)
end

function missile:draw()
	love.graphics.setColor(255,255,255)
	if self.hit then
		love.graphics.setColor(self.hitColor)
	end
	love.graphics.draw(self.image, self.x, self.y)
end

function missile:onCollision(object)
end

function missile:onRemoveCondition()
	if self.y > game.gHeight then
		self.warning.remove = true
	end
	return self.y > game.gHeight
end

return missile
