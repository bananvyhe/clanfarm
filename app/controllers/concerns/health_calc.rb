module HealthCalc 

def calculate_health_points(level)
  base_health = 250
  health_increment = 150
  max_level = 50

  if level <= max_level
    base_health + (level - 1) * health_increment
  else
    puts "Invalid level. Please enter a level between 1 and #{max_level}."
  end
end
 
end