using HorizonSideRobots

mutable struct markChessRobot
    robot::Robot
    flag::Bool
end

r = Robot(animate=1)
ro = markChessRobot(r, 1)

HorizonSideRobots.move!(robot::markChessRobot, side) = begin
    robot.flag && putmarker!(robot.robot)
    move!(robot.robot, side)
    robot.flag = !robot.flag
end


function end_move!(robot, side)
    count::Int = 0
    while !isborder(robot, side)
        move!(robot, side); count += 1
    end
    return count
end



function snake_move!(robot, sides::NTuple{2, HorizonSide})
    cond_s = sides[1]
    end_move!(robot, cond_s)
    while !isborder(robot, sides[2])
        move!(robot, sides[2])
        cond_s = inverse(cond_s)
        end_move!(robot, cond_s)
    end
end

inverse(side::HorizonSide) = HorizonSide((Int(side) + 2) % 4)
HorizonSideRobots.isborder(robot::markChessRobot, side) = isborder(robot.robot, side)
HorizonSideRobots.isborder(robot, sides::NTuple{2, HorizonSide}) = isborder(robot, sides[1]) && isborder(robot, sides[2])

