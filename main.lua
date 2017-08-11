--for debugging
--require("modules/LOVEDEBUG/lovedebug")

--game defaults
love.graphics.setDefaultFilter("nearest","nearest",1)

--very important core modules
em = require("src/entityManager")()
lm = require("src/levelManager")()
gui = require("src/guiManager")()

--require levels
menu = require("levels/menu")
credits = require("levels/credits")
level1 = require("levels/level1")
finish = require("levels/finish")
gameover = require("levels/gameover")

local sx,sy = 0,0
local shakeForceMax = 50
local shakeForce = shakeForceMax
local shakeDecrease = 25
local doneTimer = 0

function love.load()
	--start at menu
	lm:switch(menu)
end

function love.update(dt)
	if global.shake then
		sx = (math.random()-.5) * shakeForce
		sy = (math.random()-.5) * shakeForce

		if shakeForce > 0 then
			shakeForce = shakeForce - shakeDecrease * dt
		end
		if shakeForce <= 0 then
			if global.done then
				local success = love.window.showMessageBox("Too Bad",
					"The Earth lost without a fight",
					"info",
					true)
				love.event.quit()
			end
		end
	end
	if global.enemyDone or global.playerDeath then
		doneTimer = doneTimer + 1 * dt
		if doneTimer >= 3 then
			doneTimer = 0

			if global.enemyDone then
				lm:switch(finish)	
			elseif global.playerDeath then
				lm:switch(gameover)
			end
		end
	end
	--update current level
	lm:update(dt)
end

function love.draw()
	--set the screen to scale (zoom)
	love.graphics.setBackgroundColor(190,80,180)
	love.graphics.push()
	if not game.scale then
		love.graphics.translate(game.wWidth/2, game.wHeight/2)
	else
		if global.shake then
			love.graphics.translate(sx,sy)
		end
		love.graphics.scale(game.ratio, game.ratio)
	end
	love.graphics.setColor(255,255,255)
	
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
