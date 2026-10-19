local function dig(amount)
	for i=1,amount,1
	do
		turtle.dig()
		turtle.forward()
	end
end

local function move(amount, direction)
	if (direction == "forward") then
		for i=1, amount,1
		do
			turtle.forward()
		end
	elseif (direction == "back") then
		for i=1, amount, 1
		do
			turtle.back()
		end
	end
end

local function minePath(length)
	dig(length)
end

local function mineSides(depth)
	turtle.turnLeft()
	dig(depth)
	turtle.turnRight()
	turtle.turnRight()
	move(depth, "forward")
	dig(depth)
	move(depth, "back")
	turtle.turnLeft()
end

while(true) do
	minePath(4)
	mineSides(10)
end