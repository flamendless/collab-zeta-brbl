require("modules/LOVEDEBUG/lovedebug")

local em = require("src/entityManager")
local test = require("test")

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
	test:keypressed(key)
end

function love.keyreleased(key)
	test:keyreleased(key)
end
