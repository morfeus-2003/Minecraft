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

while true do
    for i=1,7,1 do
        for j=1,7,1 do
            if isGrownWheat() then
                turtle.digDown()   -- harvest
                if turtle.selected() == "mincraft:seeds" then turtle.placeDown() end -- replant (needs seeds selected)
            end
            turtle.forward()
        end
        turtle.turnLeft()
        turtle.forward()
        turtle.turnLeft()
        for j=1,7,1 do 
            turtle.forward()
        end
        turtle.turnLeft()
        turtle.turnLeft()
    end
    for j=1,7,1 do
        if isGrownWheat() then
            turtle.digDown()   -- harvest
            if turtle.selected() == "mincraft:seeds" then turtle.placeDown() end -- replant (needs seeds selected)
        end
        turtle.forward()
    end
    turtle.turnRight()
    for j=1,7,1 do 
        turtle.forward()
    end
    turtle.turnRight()
    for j=1,7,1 do 
        turtle.forward()
    end
    turtle.turnLeft()
    turtle.turnLeft()
    wait(600)
end