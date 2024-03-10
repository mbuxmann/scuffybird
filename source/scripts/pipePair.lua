class("PipePair").extends()

function PipePair:init(xPosition, heightGap)
	local gapStartYPosition = self:generateGapYPosition()

	-- Total height of the play area (you can adjust this based on your actual screen height)
	local totalHeight = 240
	local pipeWidth = 16 -- Assuming each pipe segment is 16 pixels wide
	local totalPipeSegments = totalHeight / pipeWidth -- Total segments that can fit vertically

	-- Calculate the number of segments for the top pipe based on the gap's start position
	local numSegmentsTop = gapStartYPosition / pipeWidth

	-- Calculate the number of segments for the bottom pipe
	local numSegmentsBottom = totalPipeSegments - numSegmentsTop - (heightGap / pipeWidth)

	-- Create the top and bottom pipes and store them as properties of the instance
	self.topPipe = self:createLongPipe(xPosition, 0, numSegmentsTop)
	self.bottomPipe = self:createLongPipe(xPosition, gapStartYPosition + heightGap, numSegmentsBottom)
end

function PipePair:generateGapYPosition()
	local maxValue = 240
	local divisor = 16
	local range = maxValue / divisor -- This gives the number of possible values

	-- Generate a random index in the range
	-- math.random(a, b) generates a random number between a and b, both inclusive.
	-- However, since Lua arrays (and this conceptual range) start at 1, we adjust by 1 less.
	local randomIndex = math.random(0, range - 1) -- Adjusted range for zero-based result

	-- Multiply the random index by the divisor to get your random number
	return randomIndex * divisor
end

function PipePair:createLongPipe(x, startY, numSegments)
	local longPipe = {} -- This table will hold all the segments of the long pipe

	for i = 1, numSegments do
		-- Calculate the y position for this segment
		local yPos = startY + (i - 1) * 16 -- Each segment is 16 pixels apart

		-- Create a new pipe segment at the specified position
		local pipeSegment = Pipe(x, yPos)

		-- Add the new segment to the longPipe table
		table.insert(longPipe, pipeSegment)

		-- Add the segment to the sprite system so it will be drawn
		pipeSegment:add()
	end

	return longPipe -- Return the composite pipe
end

function PipePair:isOffscreen()
	print(self.topPipe)
	-- Check if the first segment of the top pipe is offscreen
	if self.topPipe == nil then
		return false
	end

	print("here")
	return self.topPipe[1]:isOffscreen()
end
