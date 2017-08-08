local classic = require("modules/classic/classic")
local level1 = classic:extend()

--require objects that will be used in this level
local player = require("entities/player")
local missile = require("entities/missile")
local runner = require("entities/runner")
local enemy = require("entities/enemy")
local ground = require("entities/ground")

--declare player positions
local playerx = game.gWidth/2
local playery = game.gHeight

--for missile and runner events
local spawnMissile = false
local spawnRunner = false
local numMissiles = 3
local timerEvent = 0

function level1:load()
	--instantitiate the player
	player1 = player(playerx, playery)
	enemy1 = enemy(0,0,50)
	ground1 = ground()
	em:add(player1)
	em:add(enemy1)
	em:add(ground1)
end

function level1:update(dt)
	em:update(dt) --update all entities
	
	--process the events
	timerEvent = timerEvent + 1 * dt
	if timerEvent >= 3 then
		timerEvent = 0
		--choose whether next event is missile or runner
		local n = math.floor(math.random(100))
		if n >= 50 then
			spawnMissile = true
			spawnRunner = false
			spawnShield = false
		elseif n < 49 then
			spawnRunner = true
			spawnMissile = false
		end
		if spawnMissile then
			spawnMissile = false
			--spawn 3 missiles
			for i = 1, numMissiles do
				local m = missile()
				em:add(m)
			end
		elseif spawnRunner then
			spawnRunner = false
			local r = runner()
			em:add(r)
		end
	end
	--check remove condition for each entity
	--memory management
	em:removeConditions()
	--check collision for each entity
	em:checkCollisions()
end

function level1:draw()
	--draw all entities
	em:draw()
end

function level1:keypressed(key)
	em:keypressed(key)
end

function level1:keyreleased(key)
	em:keyreleased(key)
end

return level1
