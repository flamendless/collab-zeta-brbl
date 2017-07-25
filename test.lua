local classic = require("modules/classic/classic")
local test = classic:extend()
em = require("src/entityManager")()

player = require("entities/player")
player1 = player(50, 50, 100, 100)

function test:load()
	em:add(player1)
end

function test:update(dt)
	em:update(dt)
end

function test:draw()
	em:draw()
end

function test:keypressed(key)
	em:keypressed(key)
end

function test:keyreleased(key)
	em:keyreleased(key)
end

return test
