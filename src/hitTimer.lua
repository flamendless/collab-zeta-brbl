local classic = require("modules/classic/classic")
local ht = classic:extend()

function ht:new(obj,max)
	self.obj = obj
	self.timerMax = max
	self.timer = self.timerMax
end

function ht:update(dt)
	if self.obj.hit then
		self.timer = self.timer - 1 * dt
		if self.timer <= 0 then
			self.timer = self.timerMax
			self.obj.hit = false
		end
	end
end

return ht
