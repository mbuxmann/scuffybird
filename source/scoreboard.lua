import "CoreLibs/graphics"
import "CoreLibs/object"

local gfx <const> = playdate.graphics

class("scoreboard").extends()

function scoreboard:draw()
    local scoreText = "Score: " .. tostring(score)
    local textWidth, textHeight = gfx.getTextSize(scoreText)
    local margin = 4
    local bgX = (playdate.display.getWidth() - textWidth) / 2 - margin
    local bgY = 10 - margin
    local bgWidth = textWidth + 2 * margin
    local bgHeight = textHeight + 2 * margin

    -- Draw the background
    gfx.setColor(gfx.kColorWhite)
    gfx.fillRect(bgX, bgY, bgWidth, bgHeight)

    -- Draw the text
    gfx.setColor(gfx.kColorBlack)
    gfx.drawText(scoreText, (playdate.display.getWidth() - textWidth) / 2, 10)
end
