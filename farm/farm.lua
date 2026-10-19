local depth = tonumber(arg[1])
local width = tonumber(arg[2])
local waitTime = tonumber(arg[3])

local BREAD = "minecraft:bread"

local function wait(time)
	for i=time,1,-1 do
		print(i)
		sleep(1)
		term.clear()
	end
end

local function countItem(itemName)
	local sum = 0
	local item = nil
	for i=1,16 do
		item = turtle.getItemDetail(i)
		if item and item.name == itemName then
			sum = sum + turtle.getItemCount(i)
		end
	end
	return sum
end

local function isGrownWheat()
	local ok, block = turtle.inspectDown()

	return ok
		and block.name == "minecraft:wheat"
		and block.state.age == 7
end

local function blockBelowEmpty()
	local ok, _ = turtle.inspectDown()

	return not ok
end

local function trySelectSeeds()
	local item = nil
	for i=1,16 do
		item = turtle.getItemDetail(i)
		if item and item.name == "minecraft:wheat_seeds" then
			turtle.select(i)
			return true
		end
	end
	print("no seeds")
	return false
end

local function plantIfNeeded()
	if (isGrownWheat() or blockBelowEmpty()) and trySelectSeeds() then
		turtle.digDown()
		turtle.placeDown()
	end
end

local function moveSeedsOutOfBuildArea()
	trySelectSeeds()
	turtle.transferTo(16)
end

local function throwAllButOneSeed()
	local hasSavedOne = false
	local item
	for i=16,1,-1 do
		item = turtle.getItemDetail(i)
		if item and item.name == "minecraft:wheat_seeds" then
			turtle.select(i)
			turtle.drop(turtle.getItemCount(i) - (hasSavedOne and 1 or 0))
			hasSavedOne = true
		end
	end
end

local function tryMakeBread()
	if countItem(BREAD) < 3 then return false end

	moveSeedsOutOfBuildArea()
	throwAllButOneSeed()





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
		turtle.turnRight()
	for i=1,width + 1 do
		turtle.forward()
	end
	turtle.turnLeft()
end


local function main()
	width = math.ceil(width / 2)

	while true do
		farmField()

		returnAfterfarm()
		tryMakeBread()

		wait(waitTime)
	end
end

main()