local classic = require("modules.classic.classic")
local guiMana = classic:extend()

function guiMana:new()
	self.max = 100
	self.current = 100
	self.percent = 1

	self.x = game.gWidth/2 + 8
	self.y = game.gHeight - 3
	self.w = 22
	self.h = 2
end

function guiMana:update(dt)
	--get the percentage of the current/max
	--since a full bar is 22pixels wide, to get the "part" or the "remaining", we need to multiply its percentage to the max width.
	--bar = current/max * barMaxWidth
	self.percent = (self.current/self.max) * self.w
end

function guiMana:setMana(mana)
	self.current = mana
end

function guiMana:draw()
	love.graphics.setColor(255,0,0)
	love.graphics.rectangle("fill", self.x,self.y,self.w,self.h)
	love.graphics.setColor(255,255,255)
	love.graphics.rectangle("fill", self.x,self.y,self.percent,self.h)
end

return guiMana
