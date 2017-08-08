local classic = require("modules.classic.classic")
local p = classic:extend()

math.randomseed(os.time())
local colors = {
	{255,255,255},
	{150,150,150},
	{100,100,100},
	{50,50,50},
}

function p:new(image,q,x,y,size)
	self.image = image
	self.q = q
	self.x = x
	self.y = y
	self.speed = math.random(-50,50)
	self.size = size
	self.yvel = -100
	self.gravity = -200
	self.life = true
	self.timer = math.floor(math.random(2,5))
	self.color = colors[math.floor(math.random(1,#colors))]
	self.alpha = 255
end

function p:update(dt)
	--vertical calculations
	if self.yvel ~= 0 then
		self.y = self.y + self.yvel * dt
		self.yvel = self.yvel - self.gravity * dt
	end
	if self.y + self.size > global.groundY then
		while self.y + self.size > global.groundY do
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
	--post process
	if self.life then
		self.x = self.x + self.speed * dt
	else
		self.timer = self.timer - 1 * dt
		if self.timer <= 0 then
			self.alpha = self.alpha - 50 * dt
			if self.alpha <= 0 then
				em:remove(self)
			end
		end
	end
end

function p:draw()
	love.graphics.setColor(self.color,self.alpha)
	love.graphics.draw(self.image,self.q,self.x,self.y)
end

return p
