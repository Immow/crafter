local Object = {}
Object.__index = Object

local fruitindex_small = require("assets.fruitindex_small")
local sprite = love.graphics.newImage("assets/fruits_small.png")

function Object.new(settings)
	local x, y, w, h = fruitindex_small[settings.name][1], fruitindex_small[settings.name][2], fruitindex_small[settings.name][3], fruitindex_small[settings.name][4]
	local instance = setmetatable({}, Object)
	instance.x      = settings.x or 0
	instance.y      = settings.y or 0
	instance.w      = 16
	instance.h      = 16
	instance.name   = settings.name or ""
	instance.sprite = sprite
	instance.spriteW = instance.sprite:getWidth()
	instance.spriteH = instance.sprite:getHeight()
	instance.quad = love.graphics.newQuad(x, y, w, h, instance.spriteW, instance.spriteH)

	return instance
end

function Object:setXpos(x)
	self.x = x
end

function Object:setYpos(y)
	self.y = y
end

function Object:update(dt)
end

function Object:draw()
	love.graphics.draw(self.sprite, self.quad, self.x, self.y)
end

return Object