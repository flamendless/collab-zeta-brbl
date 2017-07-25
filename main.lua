require("modules/LOVEDEBUG/lovedebug")

local input = require("src/input")()

function love.load()
end

function love.update(dt)

end

function love.draw()

end

function love.keypressed(key)
	input:check(key,"keypressed")
end

function love.keyreleased(key)
	input:check(key,"keyreleased")
end
