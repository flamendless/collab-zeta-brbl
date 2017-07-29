local classic = require("modules.classic.classic")
local q = classic:extend()

local particles = require("src.particles")

function q:new(image,size,x,y)
	self.x = x
	self.y = y
	self.image = image
	self.w = self.image:getWidth()
	self.h = self.image:getHeight()
	self.size = size
	self.num = math.floor(self.w/self.size)
	self.quads = {}
	self:set()
end

function q:set()
	for y = 0, self.num - 1 do
		self.quads[y] = {}
		for x = 0, self.num - 1 do
			local q = love.graphics.newQuad(
					x * self.size,
					y * self.size,
					self.size, self.size,
					self.image:getDimensions()
				)
			local px = self.x + math.random(-15,15)
			local py = self.y + math.random(-15,5)
			local psize = self.size
			local p = particles(self.image,q,px,py,psize)
			em:add(p)
		end
	end
end

return q
