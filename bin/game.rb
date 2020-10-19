require 'ruby2d'

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

    def draw
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

    def move
        case @direction
        when 'left'
            if !(@position[0] <= 0)
                @position[0] -= 1
            end
        when 'right'
            if !(@position[0] >= GRID_WIDTH - 1)
                @position[0] += 1
            end
        end
    end # move

    def asteroid_hit_ship(x, y)
        @position[0] == x && @position[1] == y
    end

    def record_hit
        @healthpoints -= 1
    end
    
end # ship

class Asteroid
    def initialize
        @rock_x = rand(GRID_WIDTH)
        @rock_y = 0
    end

    def draw
        Square.new(x: @rock_x * GRID_SIZE, y: @rock_y * GRID_SIZE, size: GRID_SIZE * 2, color: 'red')
    end

    def move
        @rock_y += 1
        if @rock_y >= GRID_HEIGHT
            @rock_y = 0
            @rock_x = rand(GRID_WIDTH)
        end
    end

    def x
        @rock_x
    end

    def y
        @rock_y
    end

end # asteroid

🚀 = Ship.new
🌑 = Asteroid.new

update do
    clear

    🚀.move
    🚀.draw

    🌑.move
    🌑.draw

    if 🚀.asteroid_hit_ship(🌑.x, 🌑.y)
        🚀.record_hit
    end
end

on :key_held do |event|
    if ['left', 'right'].include?(event.key)
        🚀.direction = event.key
    end
end

on :key_up do
    🚀.direction = nil
  end

show