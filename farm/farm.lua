local depth = arg[1]
local width = arg[2]
local waitTime = arg[3]

local function wait(time)
	for i=time,1,-1 do
		print(i)
		sleep(1)
		term.clear()
	end
end

local function isGrownWheat()
	local ok, block = turtle.inspectDown()
	local returnValue = ok
		and block.name == "minecraft:wheat"
		and block.state.age == 7

	if returnValue then print("This is grown wheat") end

	return returnValue
end

local function blockBelowEmpty()
	local ok, _ = turtle.inspectDown()

	if not ok then print("This block is empty") end

	return not ok
end

local function trySelectSeeds()
	for i=1,16 do
		if turtle.getItemDetail(i) and turtle.getItemDetail(i).name == "minecraft:seeds" then
			turtle.select(i)
			return true
		end
	end
	print("No seeds!?")
	return false
end

local function plantIfNeeded()
	if (isGrownWheat() or blockBelowEmpty()) and trySelectSeeds() then
		print("OMG: imma place some wheat")
		turtle.digDown()
		turtle.placeDown()
	end
end


local function farmField()
	for i=1,width / 2,1 do
		for j=1,depth,1 do
			plantIfNeeded()
			turtle.forward()
		end
		turtle.turnLeft()
		turtle.forward()
		turtle.turnLeft()
		for j=1,depth,1 do
			plantIfNeeded()
			turtle.forward()
		end
		turtle.turnRight()
		turtle.forward()
		turtle.turnRight()
	end
end

local function returnAfterfarm()
	turtle.turnLeft()
	for i=1,width do
		turtle.forward()
	end
	turtle.turnLeft()
end


local function main()
	if width % 2 ~= 0 then
		error("Width must be even")
		return
	end

	while true do
		farmField()

		returnAfterfarm()

		wait(waitTime)
	end
end

main()