using HorizonSideRobots

robot = Robot(animate = true)
reverse(side::HorizonSide) = HorizonSide((Int(side) + 2) % 4)

function krest(robot)
    putmarker!(robot)
    steps = 0
    for side1 in [Nord, Sud]
        for side2 in [West, Ost]
            while !isborder(robot, side1) && !isborder(robot, side2)
                move!(robot, side1)
                move!(robot, side2)
                putmarker!(robot)
                steps += 1
            end
            move_back_steps!(robot, steps, side1, side2)
            steps = 0
        end
    end
end

function move_back_steps!(robot, steps, side1, side2)
    while steps != 0
        move!(robot, inverse(side1))
        move!(robot, inverse(side2))
        steps -= 1
    end
end