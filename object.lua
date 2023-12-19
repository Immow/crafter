local Object = {}
Object.__index = Object

local fruitIndex = require("assets.fruitindex")
local sprite = love.graphics.newImage("assets/fruits.png")

function Object.new(settings)
	local index = fruitIndex[settings.name]
	local x, y, w, h        = index[1], index[2], index[3], index[4]
	local instance          = setmetatable({}, Object)
	instance.x              = settings.x or 0
	instance.y              = settings.y or 0
	instance.w              = 32
	instance.h              = 32
	instance.color          = settings.color or {1,1,1,1}
	instance.name           = settings.name or ""
	instance.drag           = false
	instance.clickedOffsetX = 0
	instance.clickedOffsetY = 0
	instance.state          = ""
	instance.sprite         = sprite
	instance.spriteW        = instance.sprite:getWidth()
	instance.spriteH        = instance.sprite:getHeight()
	instance.quad           = love.graphics.newQuad(x, y, w, h, instance.spriteW, instance.spriteH)
	instance.remove         = false

	return instance
end

function Object:isMouseOnObject(mx, my)
	local xRegion = self.x <= mx and self.x + self.w >= mx
	local yRegion = self.y <= my and self.y + self.h >= my
	return xRegion and yRegion
end

function Object:setXpos(x)
	self.x = x
end

function Object:setYpos(y)
	self.y = y
end

function Object:mousepressed(mx,my,button,isTouch)
	if self:isMouseOnObject(mx, my) then
		self.clickedOffsetX = mx - self.x
		self.clickedOffsetY = my - self.y
		self.drag = true
	end
end

function Object:setForRemoval()
	self.remove = true
end

function Object:mousereleased(mx,my,button,isTouch)
	if self.drag then
		self.clickedOffsetX = 0
		self.clickedOffsetY = 0
		self.drag = false
	end
end

function Object:update(dt)
	local mx, my = love.mouse.getPosition()
	if self.drag then
		self.x, self.y = mx - self.clickedOffsetX, my - self.clickedOffsetY
	end
end

function Object:draw()
	love.graphics.setColor(1,1,1,1)
	love.graphics.draw(self.sprite, self.quad, self.x, self.y)
end

return Object