using HorizonSideRobots

robot = Robot(animate = true)

function chess!(robot, N)

    s, w = 0, 0
    s += upor(robot, Sud)
    w += upor(robot, West)

    side = Ost
    f = false
    for i in 1:N
        !flag && putmarker!(robot)
        for j in 1:(N)
            move!(robot, side)
            f && putmarker!(robot)
            f = !flag
        end
        f = !flag
        side = inverse(side)
        move!(robot, Nord)
    end
    upor(robot, Sud)
    upor(robot, West)
    for _ in 1:w
        move!(robot, Ost)
    end
    for _ in 1:s
        move!(robot, Nord)
    end
end

function upor(robot, side)
    n = 0
    while !isborder(robot, side)
        move!(robot, side)
        n += 1
    end
    return n
end


inverse(side::HorizonSide) = HorizonSide((Int(side)+2)%4)