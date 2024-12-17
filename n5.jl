using HorizonSideRobots

robot = Robot(animate = true)
reverse(side::HorizonSide) = HorizonSide((Int(side) + 2) % 4)

function markPerimetr(r)
    initialCorner = (Sud, West)
    stepsToInitialPoint = goToCornerAndCountMoves(r, initialCorner)

    for side in (Nord, Ost, Sud, West)
        putMarkers!(r, side)
    end

    moveSteps(r, reverse(initialCorner[1]), stepsToInitialPoint[1])
    moveSteps(r, reverse(initialCorner[2]), stepsToInitialPoint[2])
end

function goToCornerAndCountMoves(r, corner::NTuple{2, HorizonSide})
    steps = [0, 0]
    for i in 1:2
        while !isborder(r, corner[i])
            move!(r, corner[i])
            steps[i] += 1
        end
    end
    return steps
end

function moveSteps(r, side, steps)
    for _ in 1:steps
        move!(r, side)
    end
end

function putMarkers!(r, side)
    while !isborder(r, side)
        move!(r, side)
        putmarker!(r)
    end
end

function main(robot)
    stepsToInitialPoint = goToCornerAndCountMoves(robot, (West, Sud))
    markPerimetr(robot)
    find_rect(robot)
    mark_rect(robot)
    goToCornerAndCountMoves(robot, (West, Sud))

    moveSteps(robot, Ost, stepsToInitialPoint[1])
    moveSteps(robot, Nord, stepsToInitialPoint[2])
end

function find_rect(robot)
    while true
        while !isborder(robot, Ost)
            move!(robot, Ost)
            if isborder(robot, Nord)
                return
            end
        end
        move!(robot, Nord)
        while !isborder(robot, West)
            move!(robot, West)
            if isborder(robot, Nord)
                return
            end
        end
        move!(robot, Nord)
    end
end

function mark_rect(robot)
    while isborder(robot, Nord)
        putmarker!(robot)
        move!(robot, West)
    end
    move!(robot, Nord)
    while isborder(robot, Ost)
        putmarker!(robot)
        move!(robot, Nord)
    end
    move!(robot, Ost)
    while isborder(robot, Sud)
        putmarker!(robot)
        move!(robot, Ost)
    end
    move!(robot, Sud)
    while isborder(robot, West)
        putmarker!(robot)
        move!(robot, Sud)
    end
    move!(robot, West)
    while isborder(robot, Nord)
        putmarker!(robot)
        move!(robot, West)
    end
end