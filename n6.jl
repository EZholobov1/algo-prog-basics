using HorizonSideRobots

robot=Robot(animate=true)
nearSide(side::HorizonSide) = HorizonSide((Int(side)+1)%4)

function task(robot)
    left_ugol(robot)
    perimetr(robot)
end

function left_ugol(robot)
    while !isborder(robot, West) || !isborder(robot, Sud)
        for side in (Sud, West)
            while !isborder(robot, side)
                move!(robot, side)
            end
        end
    end
end

function perimetr(robot)
    for side in (Sud, Ost, Nord, West)
        while !isborder(robot, side) && !isborder(robot, nearSide(side))
            move!(robot, side)
        end
        putmarker!(robot)
    end
end