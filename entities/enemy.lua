local classic = require("modules/classic/classic")
local enemy = classic:extend()
local imgEnemy = love.graphics.newImage("assets/ship.png")
local ht = require("src/hitTimer")
local quads = require("src.quads")

local snd = {
	explode = love.audio.newSource("assets/sfx/explode-enemy.wav","static"),
	move = love.audio.newSource("assets/sfx/enemy-move-1.wav","stream"),
}

for k,v in pairs(snd) do
	v:setLooping(false)
end
snd.move:setLooping(true)

--set up table for enemy possible events macro
local events = {
	{
		id = "hide",
		x = game.gWidth/2,
		y = -32,
		tx = game.gWidth/2,
		ty = -32,
	},
	{
		id = "ltr",
		x = -32,
		y = 0,
		tx = game.gWidth + 32,
		ty = 0,
	},
	{
		id = "rtl",
		x = game.gWidth + 32,
		y = 0,
		tx = -32,
		ty = 0
	},
	{
		id = "ttb",
		x = game.gWidth/2,
		y = -32,
		tx = game.gWidth/2,
		ty = game.gHeight + 32
	}
}

local d = false
local timer = 0
local maxTimer = 2
local hideTimer = 0
local maxHideTimer = 5

function enemy:chooseAgain()
	local c = math.floor(math.random(#events))
	if self.eventID == events[c].id then
		self:chooseAgain()
		return
	end
	self.events = events[c]
	self.eventID = self.events.id
end

function enemy:eventDone()
	if d then
		local n = math.floor(math.random(1, #events))
		local previous = self.eventID --previous event
		self.events = events[n]
		self.eventID = self.events.id --next event

		--check first for the previous ID
		--if the new event is the same as the previous, choose again
		if previous == self.eventID then
			self:chooseAgain()
		end
		if self.eventID == "ltr" or
			self.eventID == "rtl" or
			self.eventID == "ttb" then
			love.audio.play(snd.move)
		end
		self.x = self.events.x
		self.y = self.events.y
		self.tx = self.events.tx
		self.ty = self.events.ty

		if self.eventID == "ttb" then
			self.x = math.random(8,game.gWidth-32)
			self.tx = self.x
		end
		d = false
	end
end

function enemy:new(x,y,speed)
	self.image = imgEnemy
	self.events = events[1]
	self.eventID = self.events.id
	self.x = self.events.x
	self.y = self.events.y
	self.tx = self.events.tx
	self.ty = self.events.ty
	self.w = self.image:getWidth()
	self.h = self.image:getHeight()
	self.speed = speed
	self.dir = 1
	self.tag = "Enemy"

	self.hp = 1000
	if debugging then
		self.hp = 1
	end
	self.hit = false
	self.hitColor = {255,255,255}
	self.ht = ht(self,0.25)
end

function enemy:draw()
	love.graphics.setColor(255,255,255)
	if self.hit then
		love.graphics.setColor(self.hitColor)
	end
	love.graphics.draw(self.image,self.x,self.y)
end

function enemy:update(dt)
	self.ht:update(dt)
	
	timer = timer + 1 * dt
	if timer >= maxTimer then
		timer = 0
		self:eventDone()
	end

	--check hp
	if self.hp <= 0 then
		if not spawned then
			spawned = true
			local x = self.x + self.w/2
			local y = self.y + self.h/2
			local q = quads(self.image,2,x,y)

			em:remove(self)
			global.enemyDone = true
			love.audio.play(snd.explode)
			global.shake = true
		end
	end

	if self.eventID == "hide" then
		hideTimer = hideTimer + 1 * dt
		if hideTimer >= maxHideTimer then
			hideTimer = 0
			d = true
		end
	elseif self.eventID == "ltr" then
		if self.x < self.tx then
			self.x = self.x + self.speed * dt
		else
			d = true
			love.audio.stop(snd.move)
		end
	elseif self.eventID == "rtl" then
		if self.x > self.tx then
			self.x = self.x - self.speed * dt
		else
			d = true
			love.audio.stop(snd.move)
		end
	elseif self.eventID == "ttb" then
		if self.y < self.ty then
			self.y = self.y + self.speed * dt
		else
			d = true
			love.audio.stop(snd.move)
		end
	else
		d = true
	end
end

function enemy:onCollision(object)
end

function enemy:onRemoveCondition()
	return self.hp <= 0
end

function enemy:exit()
	for k,v in pairs(snd) do
		love.audio.stop(v)
	end
end

return enemy
