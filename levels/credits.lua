local classic = require("modules.classic.classic")
local credits = classic:extend()

local font = love.graphics.newFont("assets/Doogle.TTF",12)
local list = {
	"Entry for",
	"#LOWREZJAM",
	"",
	"@flamendless",
	"@ZetaHaro"
}
local sndEsc = love.audio.newSource("assets/sfx/escape.wav","stream")
sndEsc:setLooping(false)

function credits:new()

end

function credits:load()

end

function credits:update(dt)

end

function credits:draw()
	love.graphics.setBackgroundColor(0,0,0)
	love.graphics.setColor(255,255,255)
	for i = 1, #list do
		local s = 0.5
		local x = (game.gWidth/s)/2 - font:getWidth(list[i])/2
		local y = (18 * i)
		love.graphics.setFont(font)

		love.graphics.push()
		love.graphics.scale(s)
		love.graphics.print(list[i],x,y)
		love.graphics.pop()
	end
end

function credits:keypressed(key)
	lm:switch(menu)
	love.audio.play(sndEsc)
end

return credits
