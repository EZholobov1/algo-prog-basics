using HorizonSideRobots

robot = Robot(animate = true)
reverse(side::HorizonSide) = HorizonSide((Int(side) + 2) % 4)

function markCross!(r)
    for side in [Nord, West, Sud, Ost]
        putMarkers!(r, side)
        moveByMarkers(r, reverse(side))
    end
    putmarker!(r)
end

function putMarkers!(r, side) 
    while !isborder(r, side) 
        move!(r, side)
        putmarker!(r)
    end
end

function moveByMarkers(r, side) 
    while ismarker(r) 
        move!(r, side) 
    end
end