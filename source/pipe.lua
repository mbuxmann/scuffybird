import "CoreLibs/graphics"
import "CoreLibs/object"

local gfx <const> = playdate.graphics

class("pipe").extends()

function pipe:init(startXPosition)
    self.x = startXPosition;
    self.gap = 80;
    self.width = 40;
    self.gapYStartPosition = math.random(0, screenHeight - self.gap);
end

function pipe:update()
    self.x = self.x - 1;
end

function pipe:draw()
    local x, width, gap, gapYStartPosition = self.x, self.width, self.gap, self.gapYStartPosition;

    -- Draw the top pipe
    gfx.fillRect(x, 0, width, gapYStartPosition)

    -- Draw the bottom pipe
    gfx.fillRect(x, gapYStartPosition + gap, width, screenHeight - gapYStartPosition - gap)
end
