using HorizonSideRobots

revrerse(side::HorizonSide) = HorizonSide(mod(Int(side)+2, 4))

robot = Robot(animate = true)

function movemark!(robot, side)
    if !isborder(robot, side)  
        move!(robot, side) 
    else 
        putmarker!(robot)
        return
    end
    movemark!(robot, side)
    move!(robot, revrerse(side))
end

function movetoend!(robot, side)
    !isborder(robot, side) && (move!(robot, side); return) 
    movetoend!(robot, side)
end

