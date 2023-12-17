local State = {}
local scenes = {}
local currentScene = nil
local state

function State.addScene(scene)
	scenes[scene] = require(scene)
end

function State.setGameState(arg)
	state = arg
end

function State.getGameState()
	return state
end

function State.setScene(nextScene)
	currentScene = nextScene
end

function State.getScene()
	if currentScene then
		return currentScene
	else
		error("No scenes found")
	end
end

function State:load()
if not currentScene then
	error("No scenes found, don't forget to add a scene with State.addScene() & set your active scene with State.setScene")
end

	for _, scene in pairs(scenes) do
		if scene.load then
			scene:load()
		end
	end
end

function State:update(dt)
	if scenes[currentScene].update then
		scenes[currentScene]:update(dt)
	end
end

function State:draw()
	if scenes[currentScene].draw then
		scenes[currentScene]:draw()
	end
end

function State:mousepressed(x, y, button, istouch, presses)
	if scenes[currentScene].mousepressed then
		scenes[currentScene]:mousepressed(x, y, button, istouch, presses)
	end
end

function State:mousereleased(x, y, button, istouch, presses)
	if scenes[currentScene].mousereleased then
		scenes[currentScene]:mousereleased(x, y, button, istouch, presses)
	end
end

function State:keypressed(key, scancode, isrepeat)
	if scenes[currentScene].keypressed then
		scenes[currentScene]:keypressed(key, scancode, isrepeat)
	end
end

function State:keyreleased(key, scancode)
	if scenes[currentScene].keyreleased then
		scenes[currentScene]:keyreleased(key, scancode)
	end
end

function State:resize()
	if scenes[currentScene].resize then
		scenes[currentScene]:resize()
	end
end

function State:mousemoved(x, y, dx, dy, istouch)
	if scenes[currentScene].mousemoved then
		scenes[currentScene]:mousemoved(x, y, dx, dy, istouch)
	end
end

function State:wheelmoved(x, y)
	if scenes[currentScene].mousemoved then
		scenes[currentScene]:mousemoved(x, y)
	end
end

function State:quit()
	if scenes[currentScene].quit then
		scenes[currentScene]:quit()
	end
end

function State:touchpressed(id,x,y,dx,dy,pressure)
	if scenes[currentScene].touchpressed then
		scenes[currentScene]:touchpressed(id,x,y,dx,dy,pressure)
	end
end

function State:touchreleased(id,x,y,dx,dy,pressure)
	if scenes[currentScene].touchreleased then
		scenes[currentScene]:touchreleased(id,x,y,dx,dy,pressure)
	end
end

function State:touchmoved(id,x,y,dx,dy,pressure)
	if scenes[currentScene].touchmoved then
		scenes[currentScene]:touchmoved(id,x,y,dx,dy,pressure)
	end
end

function State:textinput(text)
	if scenes[currentScene].textinput then
		scenes[currentScene]:textinput(text)
	end
end

return State