local gfx <const> = playdate.graphics

class("Pipe").extends(gfx.sprite)

local image = gfx.image.new("images/pipe")

function Pipe:init(x, y) -- x and y are the center positions of the pipe
	-- Sprite properties
	Pipe.super.init(self)
	Pipe.super.setImage(self, image)
	Pipe.super.add(self)
	self:moveTo(x, y)
	self:setZIndex(Z_INDEXES.Pipes)
	self:setTag(TAGS.Hazard)
	self.height = 16
	self.width = 16
	self:setCollideRect(0, 0, self:getSize())

	-- Physics properties
	self.xVelocity = -1
end

function Pipe:update()
	self:handleMovementAndCollisions()
end

function Pipe:handleMovementAndCollisions()
	self:moveWithCollisions(self.x + self.xVelocity, self.y)
end

function Pipe:collisionResponse(other)
	if other:getTag() == TAGS.Player then
		return gfx.sprite.kCollisionTypeFreeze
	end
end

function Pipe:isOffscreen()
	return self.x < 0
end
