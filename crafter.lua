local newButton = require("button")
local batteries = require("batteries")

local Crafter = {
	recipes = {
		{bannana = 1, melon = 1},
		{bannana = 2, melon = 2},
		{bannana = 3, melon = 3},
		-- {stone = 4, wood = 4},
	},
	result = {
		"apple",
		"apple",
		"apple",
	},
	items = {}
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
									name = "craft",
									state = "game",
									fn = function () Crafter:craft() end
								})
	return instance
end

function Crafter:load()

end

function Crafter:mousepressed(x, y, button, isTouch)
	self.button:mousepressed(x, y, button, isTouch)
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
	-- print(Tprint(count))
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
			table.insert(Objects, NewObject.new({x = 100, y = 100, name = self.result[i]}))
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
	table.insert(self.items, i)
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
	for i, _ in ipairs(self.recipes) do
		local name = self.recipes[i].name
		local o1   = self.recipes[i][1].name
		local a1   = self.recipes[i][1].amount
		local o2   = self.recipes[i][2].name
		local a2   = self.recipes[i][2].amount
		love.graphics.print(
			name..": "..o1.." ["..a1.."], "..o2.." ["..a2.."]",
			self.x + self.w + 5,
			self.y + self.fontH * (i - 1))
	end
end

function Crafter:draw()
	love.graphics.setColor(self.color)
	love.graphics.rectangle("line", self.x, self.y, self.w, self.h)
	-- self:drawRecipes()
	self:drawCraftBox()
	self.button:draw()
end

return Crafter