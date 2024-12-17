using HorizonSideRobots

robot = Robot(animate = true)

HorizonSideRobots.move!(robot, side, nsteps::Integer) = for _ in 1:nsteps move!(robot, side) end
HorizonSideRobots.move!(robot, side::Any) = for s in side move!(robot, s) end
HorizonSideRobots.isborder(robot, side::NTuple{2, HorizonSide}) = isborder(robot, side[1]) || isborder(robot, side[2])
HorizonSideRobots.move!(robot, side::Any) = for s in side move!(robot, s) end
movetoend!(stop_condition::Function, robot, side) = while !stop_condition() move!(robot, side) end
inverse(side::HorizonSide) = HorizonSide(mod(Int(side)+2, 4))
inverse(side::NTuple{2, HorizonSide}) = inverse.(side)
left(side::HorizonSide) = HorizonSide(mod(Int(side)+1, 4))
right(side::HorizonSide) = HorizonSide(mod(Int(side)+3, 4))

function cross(robot, sides)
    for side in sides 
        steps = move_to_border(robot, side)
    end
end

function move_to_border(robot, side)
    n::Int = 0
    while true
        if !isborder(robot, side)
            move!(robot, side)
            putmarker!(robot)
            n += 1
        elseif move2(robot, side)
            putmarker!(robot)
            n += 1
        elseif !againmove!(robot, side)
            return n
        end
    end

end



function move2(robot, sides::NTuple{2, HorizonSide})::Bool 
    for side in sides
        nsteps = move_to_end(robot, right(side)) do 
            !isborder(robot, side) || isborder(robot, right(side))
        end 
        if !isborder(robot, side)
            move!(robot, side) 
            if nsteps > 0
                movetoend!(robot, side) do
                    !isborder(robot, left(side)) 
                end 
            end
            result = true 
        else
            result = false 
        end 
        move!(robot, left(side), nsteps) 
        return result 
    end
end

move_to_end(stop_condition::Function, robot, side) = begin 
    n = 0 
    while !stop_condition() 
        move!(robot, side) 
        n += 1 
    end 
    return n
end