import "Player";
import "pipe_manager";
import "scoreboard";

screenHeight = playdate.display.getHeight();
screenWidth = playdate.display.getWidth()
player = Player();
score = 0;


local pipeManager = PipeManager(5, 150);
local scoreboard = scoreboard(score);
local gfx <const> = playdate.graphics;

local function loadGame()
	playdate.display.setRefreshRate(60)
	math.randomseed(playdate.getSecondsSinceEpoch())
end


local function updateGame()
	player:update();
	pipeManager:update();
end

local function drawGame()
	gfx.clear();
	player:draw();
	pipeManager:draw();
	scoreboard:draw();
end

loadGame()

function playdate.update()
	updateGame();
	drawGame();
	playdate.drawFPS(0, 0)
end
