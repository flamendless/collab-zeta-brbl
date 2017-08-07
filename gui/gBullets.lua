local classic = require("modules.classic.classic")
local guiBullets = classic:extend()

local offset = 2
local imgGUI = love.graphics.newImage("assets/gui/bullet.png")
local imgReload = love.graphics.newImage("assets/gui/reload.png")

local appear = true
local maxTimer = 0.5
local at = 0

function guiBullets:new()
	self.remaining = 0
	self.number = 10
	self.image = imgGUI
	self.w, self.h = self.image:getDimensions()
end

function guiBullets:update(dt)
	at = at + 1 * dt
	if at > maxTimer then
		appear = not appear
		at = 0
	end
end

function guiBullets:draw()
	love.graphics.setColor(255,255,255)
	
	if self.number ~= 0 then
		for i = 1, self.number do
			love.graphics.draw(self.image, i * offset, 1,
				0,1,1,
				self.w/2)
		end
	else
		if appear then
			love.graphics.draw(imgReload,2,2)
		end
	end
end

function guiBullets:setBullets(n)
	self.number = n
end

return guiBullets
