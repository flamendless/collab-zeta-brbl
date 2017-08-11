local classic = require("modules/classic/classic")
local em = classic:extend()

function em:new()
	self.entities = {}
end

function em:exit()
	for k,v in pairs(self.entities) do
		if v.exit ~= nil then
			v:exit()
		end
	end
end

function em:add(ent)
	table.insert(self.entities, ent)
end

function em:remove(ent)
	if type(ent) ~= "number" then
		for k,v in pairs(self.entities) do
			if v == ent then
				table.remove(self.entities,k)
			end
		end
	else
		table.remove(self.entities, ent)
	end
end

function em:getEntity(ent)
	for k,v in pairs(self.entities) do
		if v.tag == ent then
			return v
		end
	end
end

--check remove condition for each entity
--memory management
function em:removeConditions()
	for k,v in pairs(self.entities) do
		--make sure the remove condition function exists!
		if v.onRemoveCondition ~= nil then
			if v:onRemoveCondition() then
				self:remove(k)
				break
			end
		end
	end
end

function em:checkCollisions()
	for k,v in pairs(self.entities) do
		for n,m in pairs(self.entities) do
			if v ~= m then
				if v.onCollision ~= nil and
					m.onCollision ~= nil then
					if self:collision(v,m) then
						v:onCollision(m)
					end
				end
			end
		end
	end
end

function em:collision(obj1, obj2)
	return obj1.x < obj2.x + obj2.w and
		obj2.x < obj1.x + obj1.w and
		obj1.y < obj2.y + obj2.h and
		obj2.y < obj1.y + obj1.h
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
