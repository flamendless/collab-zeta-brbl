local classic = require("modules.classic.classic")
local menu = classic:extend()

--local imgBG = love.graphics.newImage("assets/menuBG.png")
local font = love.graphics.newFont("assets/Doogle.TTF",8)
local list = {
	"START",
	"ABOUT",
	"EXIT"
}
local onEnterList = {
	--start
	function()
		lm:switch(level1)
	end,
	--credits
	function()
		lm:switch(credits)
	end,
	--exit
	function()
		love.event.quit()
	end
}
local cursor = 1

function menu:new()

end

function menu:load()

end

function menu:update(dt)

end

function menu:draw()
	love.graphics.setBackgroundColor(0,0,0)
	love.graphics.setColor(255,255,255)
	--love.graphics.draw(imgBG,0,0)
	
	love.graphics.setFont(font)
	for i = 1, #list do
		local s = 0.5
		local offset = (game.gHeight/s)/2
		local x = 12
		local y = (12 * i) + offset

		local bs = 0.2
		local bt = "by Brandon and Waldo"
		local bx = (game.gWidth/bs)/2 - font:getWidth(bt)/2
		local by = (game.gHeight/bs) - 16

		if cursor == i then
			love.graphics.setColor(255,0,0)
		else
			love.graphics.setColor(255,255,255)
		end
		love.graphics.push()
		love.graphics.scale(s)
		love.graphics.print(list[i], x,y)
		love.graphics.pop()
		
		love.graphics.setColor(255,255,255)
		love.graphics.push()
		love.graphics.scale(bs)
		love.graphics.print(bt,bx,by)
		love.graphics.pop()
	end
end

function menu:keypressed(key)
	local keyDown = "s"
	local keyUp = "w"
	local keyEnter = "return"

	if key == keyDown then
		if cursor ~= #list then
			cursor = cursor + 1
		else
			cursor = 1
		end
	elseif key == keyUp then
		if cursor ~= 1 then
			cursor = cursor - 1
		else
			cursor = #list
		end
	elseif key == keyEnter then
		if onEnterList[cursor] ~= nil then
			onEnterList[cursor]()
		end
	end
end

return menu
