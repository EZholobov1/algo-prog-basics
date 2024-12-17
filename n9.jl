using HorizonSideRobots

robot = Robot(animate=true)
inverse(side::HorizonSide) = HorizonSide((Int(side)+2)%4)

function chess_board(robot)
    x, y  = diagonal(robot)
    moves(robot, ((x + y) % 2 == 0))
    main(robot, x, y)
end

function diagonal(robot)
    x::Int = 0
    y::Int = 0

    while !isborder(robot, West) == true
        move!(robot, West)
        x += 1

    while !isborder(robot, Sud) == true
        move!(robot, Sud)
        y+=1
    end

    end

    return x, y
end


function moves(robot, f)
    dv::Int = 2
    side = Ost
    if f == true
        while !isborder(robot, Nord) || !isborder(robot, Ost)
            while !isborder(robot, side)
                if dv % 2 == 0
                    putmarker!(robot)
                    move!(robot, side)
                else
                    move!(robot, side)
                end
                dv += 1          
            end
            if dv % 2 == 0
                putmarker!(robot)
            end
            if !isborder(robot, Nord) || !isborder(robot, Ost)
                side = inverse(side)
                move!(robot, Nord)
                dv += 1
            end
        end
    else
        move!(robot,Ost)
        return moves(robot, true)
    end    
end

function main(robot, x, y)
    for side in (Sud, West)
        while !isborder(robot, side)
            move!(robot, side)
        end
    end
    for _ in 1:x
        move!(robot, Ost)
    end
    for _ in 1:y
        move!(robot, Nord)
    end
end
