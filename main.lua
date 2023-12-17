State = require("state")

function love.load()
	State.addScene("game")
	State.setScene("game")
	State:load()
end

function love.update(dt)
	State:update(dt)
end

function love.draw()
	State:draw()
end

function love.keypressed(key,scancode,isrepeat)
	State:keypressed(key,scancode, isrepeat)
end

function love.keyreleased(key,scancode)
	State:keyreleased(key,scancode)
end

function love.mousepressed(x,y,button,istouch,presses)
	State:mousepressed(x,y,button,istouch,presses)
end

function love.mousereleased(x,y,button,istouch,presses)
	State:mousereleased(x,y,button,istouch,presses)
end

function love.mousemoved(x, y, dx, dy, istouch)
	State:mousemoved(x, y, dx, dy, istouch)
end

function love.touchpressed(id,x,y,dx,dy,pressure)
	State:touchpressed(id,x,y,dx,dy,pressure)
end

function love.touchreleased(id,x,y,dx,dy,pressure)
	State:touchreleased(id,x,y,dx,dy,pressure)
end

function love.touchmoved(id,x,y,dx,dy,pressure)
	State:touchmoved(id,x,y,dx,dy,pressure)
end

function love.wheelmoved(x, y)
	State:wheelmoved(x,y)
end

function love.textinput(t)
	State:textinput(t)
end

function love.quit()
	State:quit()
end