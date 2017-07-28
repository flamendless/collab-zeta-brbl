local classic = require("modules/classic/classic")
local level1 = classic:extend()

--require objects that will be used in this level
local player = require("entities/player")
local missile = require("entities/missile")
local runner = require("entities/runner")

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
	player1 = player(playerx, playery, 100)
	em:add(player1)
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
		elseif spawnShield == false then
			spawnRunner = true
			local sh = shield()
			em:add(sh)
		end
	end
	--check remove condition for each entity
	--memory management
	em:removeConditions()
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
