using HorizonSideRobots

robot = Robot(animate = true)
ccwise_side(side::HorizonSide) = HorizonSide((Int(side) + 1) % 4)

function goToNordBorderAndCountMoves!(robot)
    moves = 0
    while !isborder(robot, Nord)
        move!(robot, Nord)
        moves += 1
    end
    return moves
end

function move_steps!(robot, side, steps)
    for _ in 1:steps
        move!(robot, side)
    end
end

function mark_perimetr!(robot)
    movesToNord = goToNordBorderAndCountMoves!(robot)
    println(movesToNord)
    side = West
    while !ismarker(robot)
        while !isborder(robot, side)
            if ismarker(robot)
                break
            end
            putmarker!(robot)
            move!(robot, side)     
        end
        side = ccwise_side(side)
    end
    move_steps!(robot, Sud, movesToNord)
end