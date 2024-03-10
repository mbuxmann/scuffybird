class("PipeManager").extends()

function PipeManager:init(numPipes, pipeSpacing)
	self.pipePairs = {}
	self.pipePairspacing = pipeSpacing
	self.numPipes = numPipes
	self.heightGap = 80
	self:createInitialPipes()
end

function PipeManager:createInitialPipes()
	for i = 1, self.numPipes do
		local startXPosition = 200 + (i - 1) * self.pipePairspacing
		local pipePair = PipePair(startXPosition, self.heightGap)
		table.insert(self.pipePairs, pipePair)
	end
end

function PipeManager:reset()
	for _, pipe in ipairs(self.pipePairs) do
		pipe:remove()
	end
	self.pipePairs = {}
	self:createInitialPipes()
end

function PipeManager:update()
	print("Updating PipeManager with", #self.pipePairs, "pipe pairs") -- How many pipes are being updated
	if #self.pipePairs == 0 then
		return
	end

	print(#self.pipePairs)

	local firstPipePair = self.pipePairs[1]

	if firstPipePair.topPipe[1]:isOffscreen() then
		table.remove(self.pipePairs, 1)

		local lastPipePair = self.pipePairs[#self.pipePairs]
		local startXPosition = lastPipePair.topPipe[1].x + self.pipePairspacing
		local pipePair = PipePair(startXPosition, self.heightGap)
		table.insert(self.pipePairs, pipePair)
	end
end
