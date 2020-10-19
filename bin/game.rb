require 'ruby2d'

set background: 'navy'
set fps_cap: 15

# width = 640 / 20 = 32
# height = 480 / 20 = 24

GRID_SIZE = 20

class Ship # maybe to be moved to it's own file
    def initialize
        @position = [16, 20]
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
    end

    def move
        
    end
end

🚀 = Ship.new

update do
    clear
    🚀.draw
end

show