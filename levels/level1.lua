local classic = require("modules/classic/classic")
local level1 = classic:extend()

player = require("entities/player")

function level1:load()
	player1 = player(50, 50, 100, 100)
	em:add(player1)
end

function level1:update(dt)
	em:update(dt)
end

function level1:draw()
	em:draw()
end

return level1
