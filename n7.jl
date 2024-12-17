using HorizonSideRobots

robot = Robot(animate=true)

function main(robot)
    i = 1
    while isborder(robot, Nord)
        move_steps(robot, Ost, i)
        i+=1
        move_steps(robot, West, i)
        i+=1
    end
end

function move_steps(robot, side, steps)
    for _ in 1:steps
        if !isborder(robot, Nord)
            return
        end
        move!(robot, side)
    end
end