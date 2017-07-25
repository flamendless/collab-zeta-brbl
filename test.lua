local classic = require("modules/classic/classic")
local test = classic:extend()
em = require("src/entityManager")()
lm = require("src/levelManager")()

function test:load()
	lm:load()
end

function test:update(dt)
	lm:update(dt)
end

function test:draw()
	lm:draw()
end

function test:keypressed(key)
	lm:keypressed(key)
end

function test:keyreleased(key)
	lm:keyreleased(key)
end

return test
