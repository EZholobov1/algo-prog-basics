using HorizonSideRobots

robot = Robot(animate = true)
ccwise_side(side::HorizonSide) = HorizonSide((Int(side) + 1) % 4)
reverse_side(side::HorizonSide) = HorizonSide((Int(side) + 2) % 4)

function goToBorderAndCountMoves!(robot, border_side)
    moves = 0
    while !isborder(robot, border_side)
        move!(robot, border_side)
        moves += 1
    end
    return moves
end

function move_steps!(robot, side, steps)
    for _ in 1:steps
        move!(robot, side)
    end
end

function mark_field!(robot)
    movesToSud = goToBorderAndCountMoves!(robot, Sud)
    movesToWest = goToBorderAndCountMoves!(robot, West)
    side = Ost
    while !isborder(robot, side) && !isborder(robot, Nord)
        putmarker!(robot)
        while !isborder(robot, side)
            move!(robot, side)
            putmarker!(robot)
        end
        move!(robot, Nord)
        side = reverse_side(side)
    end
    putmarker!(robot)
    while !isborder(robot, side)
        move!(robot, side)
        putmarker!(robot)
    end
    goToBorderAndCountMoves!(robot, Sud)
    goToBorderAndCountMoves!(robot, West)
    move_steps!(robot, Ost, movesToWest)
    move_steps!(robot, Nord, movesToSud)
end
