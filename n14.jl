using HorizonSideRobots

mutable struct markChessRobot
    robot::Robot
    flag::Bool
end

r = Robot(animate=true)
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
    full_num = end_move!(robot, cond_s)
    while !isborder(robot, sides[2])
        move!(robot, sides[2])
        cond_s = inverse(cond_s)
        num = end_move!(robot, cond_s)
        while full_num > num
            bypass!(robot, cond_s)
            num += end_move!(robot, cond_s) + 1
        end
    end
end


function first_place!(robot, side_x, side_y, x, y)
    edge!(robot, (side_x, side_y))
    side_x, side_y = inverse(side_x), inverse(side_y)
    move!(robot, side_x, x); move!(robot, side_y, y)
end


function bypass!(robot, side)
    !isborder(robot, side) && (move!(robot, side); return)
    move!(robot, right(side))
    bypass!(robot, side)
    move!(robot, left(side))
end

HorizonSideRobots.isborder(robot, sides::NTuple{2, HorizonSide}) = isborder(robot, sides[1]) && isborder(robot, sides[2])
inverse(side::HorizonSide) = HorizonSide((Int(side) + 2) % 4)
right(side::HorizonSide) = HorizonSide((Int(side) + 3) % 4)
left(side::HorizonSide) = HorizonSide((Int(side) + 1) % 4)
HorizonSideRobots.move!(robot, side, num) = for _ in 1:num move!(robot, side) end
HorizonSideRobots.isborder(robot::markChessRobot, side) = isborder(robot.robot, side)
HorizonSideRobots.isborder(robot::markChessRobot, sides::NTuple{2, HorizonSide}) = isborder(robot::markChessRobot, sides[1]) && isborder(robot::markChessRobot, sides[2])