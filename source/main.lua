-- CoreLibs
import("CoreLibs/object")
import("CoreLibs/graphics")
import("CoreLibs/sprites")
import("CoreLibs/timer")
import("CoreLibs/animation")

-- Libraries
import("scripts/libraries/AnimatedSprite")

-- Game
import("scripts/player")
import("scripts/pipe")
import("scripts/pipePair")
import("scripts/pipeManager")
import("scripts/gameScene")

-- Define global variables
pd = playdate
gfx = playdate.graphics
screenWidth = pd.display.getWidth()
screenHeight = pd.display.getHeight()
local gameScene = GameScene()

local function loadGame()
	playdate.display.setRefreshRate(60)
	math.randomseed(playdate.getSecondsSinceEpoch())
end

loadGame()

function pd.update()
	gfx.sprite.update()
	pd.timer.updateTimers()
	gameScene:update()
end
