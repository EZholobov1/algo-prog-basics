using HorizonSideRobots

robot = Robot(animate = true)

reverse(side::HorizonSide) = HorizonSide((Int(side)+2)%4)
HorizonSideRobots.move!(robot, side, num_steps) = for i in 1:num_steps move!(robot, side) end

function shuttle!(stop_condition::Function, robot, side) 
    s = Ost
    n = 0 
    while !stop_condition(side) 
        move!(robot, s, n) 
        s = reverse(s) 
        n += 1 
    end 
end

