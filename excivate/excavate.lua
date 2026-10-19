local length = tonumber(arg[1]) --y
local width = tonumber(arg[2])  --x
local height = tonumber(arg[3]) --z



NORTH=1
EAST=2
SOUTH=3
WEST=4

CLOCKWISE=1
COUNTER_CLOCKWISE=2


local function rotateDirection(direction, spin)
    local CW  = { [NORTH] = EAST, [EAST] = SOUTH, [SOUTH] = WEST, [WEST] = NORTH }
    local CCW = { [NORTH] = WEST, [WEST] = SOUTH, [SOUTH] = EAST, [EAST] = NORTH }
    if spin == CLOCKWISE then
        return CW[direction]
    else
        return CCW[direction]
    end
end

local function hasChest()
    for i=1,15,1 do
        if turtle.getItemDetail(i) == "minecraft:chest" then
            return i
        end
    end
    return false 
end

local function returnToBase()

end

local function tryRefuel()
    for i=1,15,1 do
        if turtle.refuel() then
            return true
        end
    end
    return false
end

local function distanceToBase(position)
    return math.abs(position.x) + math.abs(position.y) + math.abs(position.z)
end

local function shouldReturnToBase(position)
    while distanceToBase(position) >= turtle.getFuelLevel() do
        if ~tryRefuel() then
            return true
        end
    end
    return false
end

local function moveForwardUnsafe(position, direction)
    if ~turtle.forward() then return false end

    position.x = position.x + (direction == EAST and 1 or (direction == WEST and -1 or 0))
    position.y = position.y + (direction == NORTH and 1 or (direction == SOUTH and -1 or 0))

    return true
end

local function moveForwardSafe(position, direction, breakBlocks)
    if shouldReturnToBase(position) then
        returnToBase()
        return false, "rtb"
    end

    if breakBlocks then
        while ~moveForwardUnsafe(position, direction) do
            turtle.dig()
        end
        return true
    end

    if moveForwardUnsafe(position, direction) then
        return true
    else
        return false, "obstruction"
    end
end

local function writeInfo(position)
    io.write("\n\nfuel amount: ")
    io.write(tostring(turtle.getFuelLevel()))
    io.write("\ndistance to base: ")
    io.write(distanceToBase(position))
end

local function main()
    local position = vector.new(0,0,0)
    local direction = NORTH

    for y=1,length do
        moveForwardSafe(position, true)
        writeInfo(position)
    end
end

main()