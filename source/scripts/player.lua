class("Player").extends(AnimatedSprite)

function Player:init(x, y, gameManager)
	self.gameManager = gameManager

	-- State Machine
	local playerImageTable = gfx.imagetable.new("images/player-table-16-16")
	Player.super.init(self, playerImageTable)

	self:addState("fly", 1, 4, { tickStep = 4 })
	self:playAnimation()

	-- Sprite properties
	self:moveTo(x, y)
	self:setZIndex(Z_INDEXES.Player)
	self.collisionHeight = 14
	self.collisionWidth = 14
	self:setCollideRect(1, 1, self.collisionWidth, self.collisionHeight)

	-- Physics properties
	self.yVelocity = 0
	self.maxYVelocity = 5
	self.jumpVelocity = -8
	self.gravity = 1.0

	-- Player State
	self.touchingGround = false
	self.touchingCeiling = false
	self.dead = false
end

function Player:update()
	if self.dead then
		return
	end

	self:updateAnimation()
	self:handleState()
	self:handleMovementAndCollisions()
end

function Player:handleState()
	if self.currentState == "fly" then
		self:applyGravity()
		self:handleGroundInput()
	end
end

function Player:handleMovementAndCollisions()
	local _, actualY, collisions, length =
		self:moveWithCollisions(self.x, math.max(self.y + self.yVelocity, self.collisionHeight))

	if actualY >= (screenHeight - self.collisionHeight) then
		self.touchingGround = true
	elseif actualY <= self.collisionHeight then
		self.touchingCeiling = true
	else
		self.touchingGround = false
		self.touchingCeiling = false
	end

	local died = false

	for i = 1, length do
		local collision = collisions[i]
		local collisionObject = collision.other
		local collisionTag = collisionObject:getTag()
		if collisionTag == TAGS.Hazard then
			died = true
		end
	end

	if died then
		self:die()
	end
end

function Player:die()
	self.xVelocity = 0
	self.yVelocity = 0
	self.dead = true
	self:setCollisionsEnabled(false)
	pd.timer.performAfterDelay(200, function()
		self:setCollisionsEnabled(true)
		self.gameManager:reset()
		self.dead = false
	end)
end

-- Input Helper Functions
function Player:handleGroundInput()
	if pd.buttonJustPressed(pd.kButtonA) then
		self:changeToJumpState()
	end

	self:changeToFlyState()
end

-- State transitions
function Player:changeToJumpState()
	self.yVelocity = self.jumpVelocity
end

function Player:changeToFlyState()
	self:changeState("fly")
end

-- Physics Helper Functions
function Player:applyGravity()
	self.yVelocity = math.min(self.yVelocity + self.gravity, self.maxYVelocity)

	if self.touchingGround then
		self.yVelocity = 0
	end
end
