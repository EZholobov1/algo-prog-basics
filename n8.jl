using HorizonSideRobots

robot = Robot(animate = true)
reverse(side::HorizonSide) = HorizonSide((Int(side) + 2) % 4)


function findmarker!(robot)
    step = 1
    side = Nord
    while !ismarker(robot)
        for _ in 1:step
            !ismarker(robot) && move!(robot, side)
            ismarker(robot) && return nothing
        end
        side = HorizonSide((Int(side)+1)%4)
        side == Nord && (step += 1)
        side == Sud && (step += 1)
    end
end
