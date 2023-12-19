require("tprint")
local NewObject = require("object")
local newCrafter = require("crafter")

local Game = {}
local Crafter

local objectList = {
	{name = "bannana", x = 600, y = 100},
	{name = "bannana", x = 600, y = 150},
	{name = "bannana", x = 600, y = 200},
	{name = "melon", x = 600, y = 250},
	{name = "melon", x = 600, y = 300},
	{name = "melon", x = 600, y = 350},
}

Objects = {}

function Game:load()
	Crafter = newCrafter.new({x = 10, y = 10, w = 500, h = 500})
	self:generateObjects()

	Crafter:load()
end

function Game:generateObjects()
	for _, o in ipairs(objectList) do
		table.insert(Objects, NewObject.new({x = o.x, y = o.y, name = o.name}))
	end
end

function Game:mousepressed(x, y, button, isTouch)
	Crafter:mousepressed(x, y, button, isTouch)

	for _, o in pairs(Objects) do
		o:mousepressed(x, y, button, isTouch)
	end
end

function Game:mousereleased(x, y, button, isTouch)
	Crafter:mousereleased(x, y, button, isTouch)
	for _, o in pairs(Objects) do
		o:mousereleased(x, y, button, isTouch)
		if Crafter:onCraftBox(o.x, o.y) then
			Crafter:addItem(o)
		else
			Crafter:removeItem(o)
		end
	end
end

function Game:update(dt)
	Crafter:update(dt)
	for k, o in pairs(Objects) do
		o:update(dt)
		if o.remove then
			table.remove(Objects, k)
		end
	end
end

function Game:drawObjects()
	for _, value in ipairs(Objects) do
		value:draw()
	end
end

function Game:draw()
	Crafter:draw()
	self:drawObjects()
end

return Game