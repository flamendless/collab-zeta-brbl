local classic = require("modules.classic.classic")
local gui = classic:extend()

--THIS GUI CLASS IS THE CONTAINER FOR OTHER GUI ELEMENTS!

function gui:new()
	self.container = {}
end

function gui:add(element)
	table.insert(self.container,element)
end

function gui:remove(element)
	if type(element) ~= "number" then
		for k,v in pairs(self.container) do
			if v == element then
				table.remove(self.container,k)
			end
		end
	else
		table.remove(self.container,element)
	end
end

function gui:update(dt)
	for k,v in pairs(self.container) do
		if v.update ~= nil then
			v:update(dt)
		end
	end
end

function gui:draw()
	love.graphics.setColor(255,255,255)
	for k,v in pairs(self.container) do
		if v.draw ~= nil then
			v:draw()
		end
	end
end

function gui:keypressed(key)
	for k,v in pairs(self.container) do
		if v.keypressed ~= nil then
			v:keypressed(key)
		end
	end
end

function gui:keyreleased(key)
	for k,v in pairs(self.container) do
		if v.keyreleased ~= nil then
			v:keyreleased(key)
		end
	end
end

return gui
