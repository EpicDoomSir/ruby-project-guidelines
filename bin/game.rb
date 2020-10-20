require 'ruby2d'
require 'pry'


set background: 'navy'
set fps_cap: 15

# width = 640 / 20 = 32
# height = 480 / 20 = 24

GRID_SIZE = 20
GRID_WIDTH = Window.width / GRID_SIZE
GRID_HEIGHT = Window.height / GRID_SIZE

class Ship # maybe to be moved to it's own file
    attr_accessor :position, :direction, :healthpoints
    def initialize
        @position = [16, 20]
        @direction = nil
        @healthpoints = 5
    end

    def draw # draws the ship in correct location and displays hp
        Square.new(x: @position[0] * GRID_SIZE, y: @position[1] * GRID_SIZE, size: GRID_SIZE, color: 'green')
        # I want to add more to the ship but can be done later
        # Triangle.new(
            #     x1: 50,  y1: 0,
        #     x2: 100, y2: 100,
        #     x3: 0,   y3: 100,
        #     color: 'red',
        #     z: 100
        #   )
        Text.new("HP: #{@healthpoints}", color: 'red', x: 10, y: 10, size: 25)
    end

    def move # logic for moving the ship 
        case @direction
        when 'left'
            if !(@position[0] <= 0) # stops ship from moving through th left wall
                @position[0] -= 1
            end
        when 'right'
            if !(@position[0] >= GRID_WIDTH - 1) # stops ship from moving through th right wall
                @position[0] += 1
            end
        end
    end # move

    def asteroid_hit_ship(asteroid) # returns true if the asteroid and ship occupy the same space
        asteroid.rock.contains?(@position[0], @position[1])
    end
    
    def record_hit # loosing life
        @healthpoints -= 1
    end
    
    # access to position of the ship at a given time
    def x
        @position[0]
    end

    def y
        @position[1]
    end
    
end # ship

class Asteroid
    attr_accessor :rock
    def initialize
        @rock_x = rand(GRID_WIDTH)
        @rock_y = 0
        @rock = nil
    end

    def draw
        @rock = Square.new(x: @rock_x * GRID_SIZE, y: @rock_y * GRID_SIZE, size: GRID_SIZE * 2, color: 'red')
    end

    def move
        @rock_y += 1
        if @rock_y >= GRID_HEIGHT
            @rock_y = 0
            @rock_x = rand(GRID_WIDTH)
        end
    end
    
    # access to position of the asteroid at a given time
    def x
        @rock_x
    end
    
    def y
        @rock_y
    end
    
end # asteroid

🚀 = Ship.new
🌑 = Asteroid.new

update do # actual logic of the game, runs every frame (speed controlled by fps_cap)
    clear

    🚀.move
    🚀.draw

    🌑.move
    🌑.draw

    binding.pry

    if 🚀.asteroid_hit_ship(🌑) #🌑.rock.contains?(🚀.x, 🚀.y) need to look into making this work
        puts 🚀.x
        🚀.record_hit
    end
end

# events to catch user input, going to need to abstract these for the 2 player functionality
on :key_held do |event|
    if ['left', 'right'].include?(event.key)
        🚀.direction = event.key
    end
end

on :key_up do
    🚀.direction = nil
  end

show