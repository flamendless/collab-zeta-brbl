local classic = require("modules.classic.classic")
local fin = classic:extend()

local font = love.graphics.newFont("assets/Doogle.TTF",12)
local list = {
	"Congrats!",
	"You have defeated",
	"Earth's Defenses.",
	"You now rule",
	"the planet!"
}
local imgHooray = love.graphics.newImage("assets/hooray.png")

local sndEsc = love.audio.newSource("assets/sfx/escape.wav","stream")
sndEsc:setLooping(false)
local sndWin = love.audio.newSource("assets/sfx/win.wav","stream")

function fin:new()
end

function fin:load()
	love.audio.play(sndWin)
end

function fin:exit()
	love.audio.stop(sndWin)
end

function fin:update(dt)
end

function fin:draw()
	love.graphics.setColor(255,255,255)
	love.graphics.setBackgroundColor(0,0,0)

	for i = 1, #list do
		local s = 0.25
		local x = (game.gWidth/s)/2 - font:getWidth(list[i])/2
		local y = (18 * i)
		love.graphics.setFont(font)

		love.graphics.push()
		love.graphics.scale(s)
		love.graphics.print(list[i],x,y)
		love.graphics.pop()
	end

	love.graphics.draw(imgHooray,0,0)
end

function fin:keypressed(key)
	local keyEnter = "return"
	local keySpace = "space"
	local keyEsc = "escape"

	if key == keyEnter or key == keySpace or key == keyEsc then
		love.audio.play(sndEsc)
		love.event.quit()
	end
end

return fin
