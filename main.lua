require("modules/LOVEDEBUG/lovedebug")

em = require("src/entityManager")()
lm = require("src/levelManager")()

local level1 = require("levels/level1")

function love.load()
	lm:switch(level1)
end

function love.update(dt)
	lm:update(dt)
end

function love.draw()
	love.graphics.push()
	love.graphics.scale(game.ratio, game.ratio)

	lm:draw()	

	love.graphics.pop()
end

function love.keypressed(key)
	lm:keypressed(key)
end

function love.keyreleased(key)
	lm:keyreleased(key)
end
