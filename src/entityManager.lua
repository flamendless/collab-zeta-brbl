local classic = require("modules/classic/classic")
local em = classic:extend()

function em:new()
	self.entities = {}
end

function em:add(ent)
	table.insert(self.entities, ent)
end

function em:update(dt)
	for k,v in pairs(self.entities) do
		if v.update ~= nil then
			v:update(dt)
		end
	end
end

function em:draw()
	for k,v in pairs(self.entities) do
		if v.draw ~= nil then
			v:draw()
		end
	end
end

function em:keypressed(key)
	for k,v in pairs(self.entities) do
		if v.keypressed ~= nil then
			v:keypressed(key)
		end
	end
end

function em:keyreleased(key)
	for k,v in pairs(self.entities) do
		if v.keyreleased ~= nil then
			v:keyreleased(key)
		end
	end
end

return em
