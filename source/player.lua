import "CoreLibs/graphics"
import "CoreLibs/object"

local gfx <const> = playdate.graphics

class("player").extends()

local initialX, initialY, initialR = 100, 110, 15

function player:init()
    self.x = initialX;
    self.y = initialY;
    self.r = initialR;
    self.jumpHeight = 20;
end

function player:update()
    if playdate.buttonJustPressed(playdate.kButtonA) then
        if self.y - self.jumpHeight - self.r < 0 then
            self.y = 0 + self.r;
        else
            self.y = self.y - self.jumpHeight;
        end
    else
        if self.y + 1 + self.r > 240 then
            self.y = screenHeight - self.r;
        else
            self.y = self.y + 1;
        end
    end
end

function player:draw()
    local x, y, r = self.x, self.y, self.r;
    gfx.fillCircleAtPoint(x, y, r)
end

function player:reset()
    self.x = initialX;
    self.y = initialY;
    self.r = initialR;
end
