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
  return ok
	and block.name == "minecraft:wheat"
	and block.state.age == 7
end

local function blockBelowEmpty()
	local ok, _ = turtle.inspectDown()
	return ok
end

local function trySelectSeeds()
	for i=1,15 do
		if turtle.getItemDetail(i) and turtle.getItemDetail(i).name == "mincraft:seeds" then
			turtle.select(i)
			return true
		end
	end
	return false
end

local function plantIfNeeded()
	if not (isGrownWheat() and blockBelowEmpty()) then
		return
	end

	if turtle.selected() ~= "mincraft:seeds" then
		if not trySelectSeeds() then
			return
		end
	end

	turtle.placeDown()
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