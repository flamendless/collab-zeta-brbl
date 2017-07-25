require("modules/LOVEDEBUG/lovedebug")
local test = require("test")

local input = require("src/input")()

function love.load()
	test:load()
end

function love.update(dt)
	test:update(dt)
end

function love.draw()
	love.graphics.push()
	love.graphics.scale(game.ratio, game.ratio)

	test:draw()	

	love.graphics.pop()
end

function love.keypressed(key)
	input:check(key,"keypressed")
end

function love.keyreleased(key)
	input:check(key,"keyreleased")
end
