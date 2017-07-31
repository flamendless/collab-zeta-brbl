--for debugging
--require("modules/LOVEDEBUG/lovedebug")

--game defaults
love.graphics.setDefaultFilter("nearest","nearest",1)

--very important core modules
em = require("src/entityManager")()
lm = require("src/levelManager")()

--require levels
local level1 = require("levels/level1")

function love.load()
	--start at level1
	lm:switch(level1)
end

function love.update(dt)
	--update current level
	lm:update(dt)
end

function love.draw()
	--set the screen to scale (zoom)
	love.graphics.push()
	if not game.scale then
		love.graphics.translate(game.wWidth/2, game.wHeight/2)
	else
		love.graphics.scale(game.ratio, game.ratio)
	end
	love.graphics.setColor(255,255,255)
	
	--debugging: gWidth,gHeight window borders and FPS
	if debugging then
		love.graphics.setColor(255,0,0)
		love.graphics.rectangle("line",0,0,game.gWidth,game.gHeight)
		love.graphics.print(love.timer.getFPS())
	end
	lm:draw()	

	love.graphics.pop()
end

function love.keypressed(key)
	lm:keypressed(key)

	if debugging then
		if key == "o" then
			game.scale = not game.scale
		end
	end
end

function love.keyreleased(key)
	lm:keyreleased(key)
end
