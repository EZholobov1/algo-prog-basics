using HorizonSideRobots

robot = Robot(animate = true)
reverse_side(side::HorizonSide) = HorizonSide((Int(side) + 2) % 4)
ccwise_side(side::HorizonSide) = HorizonSide((Int(side) + 1) % 4)

function move_steps!(robot, steps, side)
    for _ in 1:steps
        move!(robot, side)
    end
end

function goToLeftDownCornerAndCountMoves(robot)
    moves_left, moves_down = 0, 0
    data = [moves_left, moves_down]
    side = West
    for i in 1:2
        while !isborder(robot, side)
            move!(robot, side)
            data[i] += 1
        end
        side = ccwise_side(side)
    end
    return data
end

function moveToBorder(robot, side)
    while !isborder(robot, side)
        move!(robot, side)
    end
end


function test(robot)
    side = Ost
    tek_counter = 0
    counter = 0

    initial_moves = goToLeftDownCornerAndCountMoves(robot)

    while !isborder(robot, side) && !isborder(robot, Nord)
        while !isborder(robot, side)
            move!(robot, side)
            if isborder(robot, Nord)
                tek_counter += 1
            else
                if tek_counter != 0
                    counter += 1
                    tek_counter = 0
                end
            end
        end
        move!(robot, Nord)
        side = reverse_side(side)
    end

    moveToBorder(robot, Sud)
    move_steps!(robot, initial_moves[2], Nord)
    move_steps!(robot, initial_moves[1], Ost)
    println(counter)
end

