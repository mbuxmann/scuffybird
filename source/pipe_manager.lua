import "CoreLibs/graphics"
import "pipe"

local gfx <const> = playdate.graphics

class("PipeManager").extends()

function PipeManager:init(numPipes, pipeSpacing)
    self.pipes = {}
    self.pipeSpacing = pipeSpacing
    self.numPipes = numPipes
    self:initPipes()
end

function PipeManager:initPipes()
    for i = 1, self.numPipes do
        local startXPosition = 200 + (i - 1) * self.pipeSpacing
        table.insert(self.pipes, pipe(startXPosition))
    end
end

function PipeManager:update()
    for _, p in ipairs(self.pipes) do
        p:update()
    end

    -- Check for collision with the player
    for _, pipe in ipairs(self.pipes) do
        if checkCircleRectCollision(player.x, player.y, player.r,
                pipe.x, 0, pipe.width, pipe.gapYStartPosition) or
            checkCircleRectCollision(player.x, player.y, player.r,
                pipe.x, pipe.gapYStartPosition + pipe.gap, pipe.width, screenHeight - (pipe.gapYStartPosition + pipe.gap)) then
            player.reset(player);
            self:resetPipes()
            score = 0;
        end
    end

    -- Check if the first pipe has moved off the screen and if so, move it to the end
    local firstPipe = self.pipes[1]
    if firstPipe.x + firstPipe.width < 0 then
        score += 1;
        firstPipe.x = self.pipes[#self.pipes].x +
            self.pipeSpacing
        firstPipe.gapYStartPosition = math.random(0, playdate.display.getHeight() - firstPipe.gap)
        table.remove(self.pipes, 1)
        table.insert(self.pipes, firstPipe)
    end
end

function PipeManager:draw()
    for _, p in ipairs(self.pipes) do
        p:draw()
    end
end

function PipeManager:resetPipes()
    self.pipes = {}  -- Clear existing pipes
    self:initPipes() -- Reinitialize pipes
end

function checkCircleRectCollision(cx, cy, r, rx, ry, rw, rh)
    -- Find the closest point on the rectangle to the circle
    local closestX = math.clamp(cx, rx, rx + rw)
    local closestY = math.clamp(cy, ry, ry + rh)

    -- Calculate the distance between the circle's center and this closest point
    local distanceX = cx - closestX
    local distanceY = cy - closestY

    -- If the distance is less than the circle's radius, there's a collision
    return (distanceX ^ 2 + distanceY ^ 2) < (r ^ 2)
end

function math.clamp(val, lower, upper)
    if lower > upper then lower, upper = upper, lower end -- Ensures lower is less than upper
    return math.max(lower, math.min(val, upper))
end
