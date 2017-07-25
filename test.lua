local classic = require("modules/classic/classic")
local test = classic:extend()
local em = require("src/entityManager")

function test:load()

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
