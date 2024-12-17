using HorizonSideRobots

robot = Robot(animate = true)

function movetoend!(robot, side)
    !isborder(robot, side) ? move!(robot, side) : return
    movetoend!(robot, side)
end