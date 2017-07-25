local classic = require("modules/classic/classic")
local input = classic:extend()

function input:new()
	self.inputs = {}
end

--@param1 = id = string
--@param2 = event = string
--@param3 = key = string
--@param4 = function = functiom
--sample usage: input:add("test","keypressed","e", function()
--  print(1)
--end)

function input:new()
	self.inputs = {}
end

function input:add(id, event, key, func)
    if not key then return end
    self.inputs[key] = self.inputs[key] or {}
    self.inputs[key][event] = self.inputs[key][event] or {}
    table.insert(self.inputs[key][event], {fn = func; name = id})
end

function input:check(key, event)
    if self.inputs[key] then
        if self.inputs[key][event] then
            for k, v in ipairs(self.inputs[key][event]) do
                v.fn()
            end
        end
    end
end

function input:remove(key, event, func)
    if self.inputs[key] then
        if self.inputs[key][event] then
            for k, v in pairs(self.inputs[key][event]) do
                if v == func then
                    table.remove(self.inputs[key][event][k])
                    return
                end
            end
        end
    end
end

return input
