class SolarSystem
  def initialize
    @planets = [] #empty solar system
    @formation_year = 1500
  end

  def add_a_planet(planet)
    if planet.is_a? Planet
      @planets.push(planet)
    else
      puts "#{planet} is not a Planet"
    end
  end

  def add_planets(planets) # assumes input is an array
    if planets.is_a? Array
      planets.each do |planet|
        add_a_planet(planet)
      end
    end
  end

  def planet_names # returns an array of planet names
    @planet_names = []
    @planets.each do |planet|
      @planet_names.push(planet.name.capitalize)
    end
    @planet_names
  end

  def speak_about_self # talk about given planet until told to quit
    while true
      puts "Which planet can I tell you more about?"
      planet_names.each_with_index do |planet, i|
        print "#{i+1}. #{planet}, "
      end
      print "#{@planet_names.length}. Exit\n"
      print ">> "

      answer = gets.chomp.capitalize
      break if answer == "Exit"
      planet = find_planet(answer)
      if !planet.nil?
        print "\nThe current year on #{planet.name} is " +
              "#{find_local_year(planet.name)}. " + planet.get_planet_info + "\n\n"
      end
    end
  end

  # Calculates the distance (in million kms) between two given planets
  def find_distance(planet1_name, planet2_name)
    planet1 = find_planet(planet1_name)
    planet2 = find_planet(planet2_name)
    if !planet1.nil? && !planet1.nil?
      return (planet1.sun_distance - planet2.sun_distance).abs
    end
    return nil
  end

  # Determines the age of a planet given the solar system formation year
  def find_local_year(planet_name)
    planet = find_planet(planet_name)
    if !planet.nil?
      ((@formation_year*365)/planet.planetary_year).to_i
    end
  end

  # Prints the distance between two given planets if in solar system
  def print_planet_distance
    puts "\nWhich planets do you want to know the distance between? "
    print "Planet #1: "
    planet1 = gets.chomp.capitalize
    print "Planet #2: "
    planet2 = gets.chomp.capitalize
    if in_my_solar_system?(planet1) && in_my_solar_system?(planet2)
      distance = find_distance(planet1, planet2)
      puts "The distance between #{planet1} and #{planet2} is " +
           "#{'%.1f' % distance} million kilometers."
    end
  end

  # Determines if a given planet is in the solar system
  def in_my_solar_system?(planet_name)
    !find_planet(planet_name).nil?
  end

  private

  # Matches the name of a planet with a Planet object in the solar system
  def find_planet(planet_name) # input is a string, returns a Planet object
    planet_names.each_with_index do |planet, i|
      return @planets[i] if planet == planet_name.capitalize
    end
    puts "#{planet_name.capitalize} is not in my solar system.\n\n"
    return nil
  end
end

class Planet
  attr_reader :name, :moons, :sun_distance, :planetary_year, :mass, :diameter,
              :temp, :gravity

  def initialize(planet_hash)
    @name = planet_hash[:name].capitalize
    @moons = planet_hash[:moons] #number of moons
    @sun_distance = planet_hash[:sun_distance] #million km
    @planetary_year = planet_hash[:planetary_year] # earth days
    @mass = planet_hash[:mass] # kg
    @diameter = planet_hash[:diameter] # km, mean
    @temp = planet_hash[:temp] # mean surface temperature in kelvin
    @gravity = planet_hash[:gravity] # surface, gravity m/s^2
  end

  # Returns a string of information on the planet
  def get_planet_info
    "#{@name} has a mass of #{@mass} kilograms, a mean diameter of " +
      "#{@diameter} kilometers, and #{@moons} moon(s). It is #{@sun_distance}" +
      " million kilometers from the sun and one planetary year on #{@name} is" +
      " equal to #{@planetary_year} Earth days. If you were to stand on the " +
      " surface of #{@name}, you would experience a gravitational force of " +
      "#{@gravity} meters per second squared and a mean temperature of " +
      "#{@temp} degrees Kelvin. That's approximately " +
      "#{kelvin_to_fahrenheit(@temp).to_i} degrees Fahrenheit! "
  end

  # Converts a given temperature in kelvin to fahrenheit
  def kelvin_to_fahrenheit(temp)
    1.8 * (temp - 273) + 32
  end
end

planet_data = [
  {
    name: "mercury",
    moons: 0,
    sun_distance: 57.9,
    planetary_year: 87.96,
    mass: 3.30e+23, diameter: 4878,
    temp: 452,
    gravity: 3.7
  },
  {
    name: "venus",
    moons: 0,
    sun_distance: 108.2,
    planetary_year: 224.68,
    mass: 4.87e+24,
    diameter: 12104,
    temp: 737,
    gravity: 8.87
  },
  {
    name: "earth",
    moons: 1,
    sun_distance: 149.6,
    planetary_year: 365.26,
    mass: 5.98e+24,
    diameter: 12756,
    temp: 288,
    gravity: 9.807
  },
  {
    name: "mars",
    moons: 2,
    sun_distance: 227.9,
    planetary_year: 686.98,
    mass: 6.42e+23,
    diameter: 6787,
    temp: 210,
    gravity: 3.711
  },
  {
    name: "jupiter",
    moons: 67,
    sun_distance: 778.3,
    planetary_year: (11.862*365.26),
    mass: 1.90e+27,
    diameter: 142796 ,
    temp: 165,
    gravity: 24.79
  },
  {
    name: "saturn",
    moons: 62,
    sun_distance: 1427.0,
    planetary_year: (29.456*365.26),
    mass: 5.69e+26,
    diameter: 120660,
    temp: 134,
    gravity: 10.44
  },
  {
    name: "uranus",
    moons: 27,
    sun_distance: 2871.0,
    planetary_year: (84.07*365.26),
    mass: 8.68e+25,
    diameter: 51118,
    temp: 76,
    gravity: 8.69
  },
  {
    name: "neptune",
    moons: 13,
    sun_distance: 4497.1,
    planetary_year: (164.81*365.26),
    mass: 1.02e+26,
    diameter: 48600,
    temp: 72,
    gravity: 11.15
  }
]

# initalizes an array of Planets, and then a solar system object
# my_solar_system = Array.new
# planet_data.each do |planet|
#   my_solar_system << Planet.new(planet)
# end
# solar_system = SolarSystem.new
# solar_system.add_planets(my_solar_system)

# Initalize a Solar System object using above the planet data
solar_system = SolarSystem.new
planet_data.each do |planet|
  solar_system.add_a_planet(Planet.new(planet))
end

solar_system.speak_about_self
solar_system.print_planet_distance
