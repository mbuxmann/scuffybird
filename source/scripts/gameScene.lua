TAGS = {
	Player = 1,
	Hazard = 2,
}

Z_INDEXES = {
	Pipes = 10,
	Player = 20,
	Scoreboard = 40,
}

class("GameScene").extends()

function GameScene:init()
	-- Set player spawn point
	self.spawnX = 3 * 16
	self.spawnY = 120
	--	self.player = Player(self.spawnX, self.spawnY, self)
	self.pipeManager = PipeManager(5, 100)

	-- Set background color
	gfx.setBackgroundColor(0)
	gfx.fillRect(0, 0, pd.display.getWidth(), pd.display.getHeight())
end

function GameScene:update()
	self.pipeManager:update()
end

function GameScene:reset()
	self.player:moveTo(self.spawnX, self.spawnY, self)
	self.pipeManager:reset()
end
