local newButton = require("button")
local batteries = require("batteries")
local newIcon = require("icon")
local font = love.graphics.getFont()

local Crafter = {
	recipes = {
		{bannana = 1, melon = 2},
		{bannana = 2, melon = 2},
		{bannana = 3, melon = 2},
		{apple = 1, melon = 1},
	},
	result = {
		"apple",
		"corn",
		"cucumber",
		"strawberry"
	},
	items = {},
	fruitListResult = {}
}

Crafter.__index = Crafter

function Crafter.new(settings)
	local instance = setmetatable({}, Crafter)
	instance.x      = settings.x or 0
	instance.y      = settings.y or 0
	instance.w      = settings.w or 100
	instance.h      = settings.h or 50
	instance.fontH  = love.graphics.getFont():getHeight()
	instance.color  = {1,1,1,1}
	instance.craftbox = {x = settings.x + 5, y = settings.y + 5, w = settings.w - 10, h = settings.h - (10 + 100)}
	instance.button = newButton.new({
									x = settings.x + 5,
									y = settings.y + settings.h - 55,
									text = "craft",
									state = "game",
									fn = function () instance:craft() end
								})
	return instance
end

function Crafter:load()
	-- local y = 0
	-- local x = 530
	-- for _, o in ipairs(self.result) do
	-- 	table.insert(self.fruitListResult, newIcon.new({x = 600, y = y, name = o}))
	-- 	y = y + 20
	-- end

	-- y = 0
	-- for i, value in ipairs(self.recipes) do
	-- 	local c = 0
	-- 	for k, v in pairs(value) do
	-- 		c = c + 1
	-- 		if c == 2 then
	-- 			x = x + 30
	-- 		end
	-- 		table.insert(self.fruitListResult, newIcon.new({x = x, y = y, name = k}))
	-- 	end
	-- 	y = y + 20
	-- 	x = x - 30
	-- end
	-- print(Tprint(self.fruitListResult))

	self:generateIngredientIcons()
	self:generateResultRecipeIcons()
end

function Crafter:generateResultRecipeIcons()
	local y = 0
	local x = 530
	for _, o in ipairs(self.result) do
		table.insert(self.fruitListResult, newIcon.new({x = 600, y = y, name = o}))
		y = y + 20
	end
end

function Crafter:generateIngredientIcons()
	local y = 0
	local x = 530
	for _, value in ipairs(self.recipes) do
		local c = 0
		for k, v in pairs(value) do
			c = c + 1
			if c == 2 then
				x = x + 30
			end
			table.insert(self.fruitListResult, newIcon.new({x = x, y = y, name = k}))
		end
		y = y + 20
		x = x - 30
	end
end

function Crafter:mousepressed(x, y, button, isTouch)
	self.button:mousepressed(x, y, button, isTouch)
end

function Crafter:mousereleased(x, y, button, isTouch)

end

function Crafter:countObjects()
	local count = {}
	for _, i in ipairs(self.items) do
		if not count[i.name] then
			count[i.name] = 1
		else
			count[i.name] = count[i.name] + 1
		end
	end
	return count
end

function Crafter:removeCraftListItems()
	for key, value in pairs(self.items) do
		value:setForRemoval()
	end
	self.items = {}
end

function Crafter:craftObject(o)
	for i = 1, #self.recipes do
		if batteries.tablex.shallow_equal(self.recipes[i], o) then
			self:removeCraftListItems()
			table.insert(Objects, NewObject.new({x = self.craftbox.x  + self.craftbox.w / 2 - 16, y = self.craftbox.y + self.craftbox.h / 2 - 16, name = self.result[i]}))
		end
	end
end

function Crafter:craft()
	if #self.items < 1 then return end
	self:craftObject(self:countObjects())
end

function Crafter:update(dt)
	self.button:update(dt)
end

function Crafter:addItem(i)
	if i.state == "inCrafter" then return end
	i.state = "inCrafter"
	self.items[#self.items + 1] = i
end

function Crafter:removeItem(i)
	for key, value in ipairs(self.items) do
		if i == value then
			table.remove(self.items, key)
			i.state = ""
		end
	end
end

function Crafter:onCraftBox(ox, oy)
	local xRegion = self.craftbox.x <= ox and self.craftbox.x + self.craftbox.w >= ox
	local yRegion = self.craftbox.y <= oy and self.craftbox.y + self.craftbox.h >= oy
	return xRegion and yRegion
end

function Crafter:drawCraftBox()
	love.graphics.rectangle("line", self.craftbox.x, self.craftbox.y, self.craftbox.w, self.craftbox.h)
end

function Crafter:drawRecipes()
	local x, y = 0, 0
	for _, value in ipairs(self.recipes) do
		x = 550
		love.graphics.print("=", x + 40 , y)
		for k, v in pairs(value) do
			love.graphics.print(tostring(v), x, y)
			x = x + 30
		end
		y = y  + 20
	end

	for _, value in ipairs(self.fruitListResult) do
		value:draw()
	end
end

function Crafter:draw()
	love.graphics.setColor(self.color)
	love.graphics.rectangle("line", self.x, self.y, self.w, self.h)
	self:drawRecipes()
	self:drawCraftBox()
	self.button:draw()
	love.graphics.print(tostring(#self.items))
end

return Crafter