local classic = require("modules/classic/classic")
local ct = classic:extend()

function ct:new(timer, colorTable)
	self.maxTimer = timer
	self.timer = timer
	self.colorTable = colorTable
	self.color = self.colorTable[1]
end

function ct:update(dt)
	self.timer = self.timer - 1 * dt
	--process
	if self.timer > 1 then
		self.color = self.colorTable[math.floor(self.timer)]
	end
	--reset timer
	if self.timer <= 0 then
		self.timer = self.maxTimer
	end
end

function ct:get()
	return self.color
end

return ct
