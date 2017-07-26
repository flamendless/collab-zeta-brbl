local classic = require("modules/classic/classic")
local warning = classic:extend()

function warning:new(x)
	self.x = x
end

function warning:update(dt)

end

function warning:draw()

end

return warning
