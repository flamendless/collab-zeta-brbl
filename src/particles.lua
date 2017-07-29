local classic = require("modules.classic.classic")
local p = classic:extend()

math.randomseed(os.time())

function p:new(image,q,x,y,size)
	self.image = image
	self.q = q
	self.x = x
	self.y = y
	self.speed = math.random(-100,100)
	self.size = size
	self.yvel = -100
	self.gravity = -200
	self.life = true
end

function p:update(dt)
	--vertical calculations
	if self.yvel ~= 0 then
		self.y = self.y + self.yvel * dt
		self.yvel = self.yvel - self.gravity * dt
	end
	if self.y + self.size > game.gHeight then
		while self.y + self.size > game.gHeight do
			self.y = self.y - 1 * dt
		end
		self.yvel = 0
		self.life = false
	end
	--horizontal
	if self.x < 0 then
		while self.x < 0 do
			self.x = self.x + 1 * dt
		end
	end
	if self.x + self.size > game.gWidth then
		while self.x + self.size > game.gWidth do
			self.x = self.x - 1 * dt
		end
	end
	if self.life then
		self.x = self.x + self.speed * dt
	end
end

function p:draw()
	love.graphics.setColor(255,255,255)
	love.graphics.draw(self.image,self.q,self.x,self.y)
end

return p
