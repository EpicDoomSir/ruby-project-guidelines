class Asteroid < ActiveRecord::Base
    belongs_to :game

    # attr_accessor :rock, :collided, :reached_end

    # @@all = []

    # def initialize(mystery)
    #     @rock_x = rand($GRID_WIDTH)
    #     @rock_y = rand(3)
    #     @rock = nil
    #     @reached_end = false
    #     @collided = false
    #     @@all << self
    # end

    def draw
        self.rock = Square.new(x: self.rock_x * $GRID_SIZE, y: self.rock_y * $GRID_SIZE, size: ($GRID_SIZE - 1) * 2, color: 'red')
    end

    def move
        self.rock_y += 1 # @speed
        if self.rock_y >= $GRID_HEIGHT # logic to respawn asteroid at top of screen
            self.rock_y = 0
            self.rock_x = rand($GRID_WIDTH)
            self.reached_end = true
            self.collided = false
        end
    end

    def reached_end?
        self.reached_end
    end

    def asteroid_hit_ship(ship) # returns true if the asteroid and ship occupy the same space
        if !self.collided # will only return true the first time the asteroid hits the ship
            if self.rock.contains?(ship.x, ship.y)
                self.collided = true
                return true
            end
        end
    end
    
    # access to position of the asteroid at a given time
    def x
        self.rock_x * $GRID_SIZE
    end
    
    def y
        self.rock_y * $GRID_SIZE
    end
end
