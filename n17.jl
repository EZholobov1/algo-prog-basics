using HorizonSideRobots

robot = Robot(animate = true)

function spiral!(stop_condition::Function, robot) 
    nmax_steps = 1
    s = Nord 
    while !find(stop_condition::Function, robot, s, nmax_steps) 
        (s in (Nord, Sud)) && (nmax_steps += 1) 
        s = left(s) 
    end 
end 

function find(stop_condition::Function, robot, side, nmax_steps) 
    n = 0 
    while !stop_condition() && (n < nmax_steps)
        move!(robot, side) 
        n += 1 
    end 
    return stop_condition()
end

left(side::HorizonSide) = HorizonSide(mod(Int(side)+1, 4))