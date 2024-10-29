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

function mark_dCross!(robot, side)
    s_side = side
    d_side = Sud
    moves1 = 0
    moves2 = 0
    while !isborder(robot, d_side) && !isborder(robot, s_side)
        move!(robot, d_side)
        move!(robot, s_side)
        putmarker!(robot)
        moves1 += 1
    end

    s_side = reverse_side(s_side)
    d_side = reverse_side(d_side)

    while !isborder(robot, d_side) && !isborder(robot, s_side)
        move!(robot, d_side)
        move!(robot, s_side)
        putmarker!(robot)
        moves2 += 1
    end

    for _ in 1:(moves2-moves1)
        move!(robot, reverse_side(d_side))
        move!(robot, reverse_side(s_side))
    end

    
end

