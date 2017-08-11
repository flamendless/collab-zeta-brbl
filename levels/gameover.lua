local classic = require("modules.classic.classic")
local gameover = classic:extend()

local font = love.graphics.newFont("assets/Doogle.TTF",12)
local list = {
	"Too bad!",
	"You failed your mission!"
}
local imgBooh = love.graphics.newImage("assets/booh.png")

local sndEsc = love.audio.newSource("assets/sfx/escape.wav","stream")
local sndLose = love.audio.newSource("assets/sfx/lose.wav","stream")
sndLose:setLooping(false)
sndEsc:setLooping(false)

function gameover:new()
end

function gameover:load()
	love.audio.play(sndLose)
end

function gameover:exit()
	love.audio.stop(sndLose)
end

function gameover:update(dt)

end

function gameover:draw()
	love.graphics.setBackgroundColor(0,0,0)
	love.graphics.setColor(255,255,255)

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
	love.graphics.draw(imgBooh,0,0)
end

function gameover:keypressed(key)
	local keyEnter = "return"
	local keySpace = "space"
	local keyEsc = "escape"

	if key == keyEnter or key == keySpace or key == keyEsc then
		love.audio.play(sndEsc)
		love.event.quit("restart")
	end
end

return gameover
