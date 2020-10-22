class Ship < ActiveRecord::Base
    belongs_to :user
    belongs_to :game

    attr_accessor :position, :direction, :healthpoints, :score, :start_time, :crash

    @@all = []
    @@player_options = [
        {x: 430, hp_y: 10, score_y: 40, color: 'green'},
        {x: 10, hp_y: 10, score_y: 40, color: 'purple'}
    ]

    def initialize(mystery)
        @position = [16, 20]
        @direction = nil
        @healthpoints = 5
        @score = 0
        @start_time = Time.now
        @@all << self
        @player_num = @@all.count
        @chosen_option = @@player_options[@player_num - 1]

        # crash = Sound.new("./app/game_sounds/crash2.wav")
    end

    def self.all
        @@all
    end

    def draw # draws the ship in correct location and displays hp
        Square.new(x: @position[0] * $GRID_SIZE, y: @position[1] * $GRID_SIZE, size: $GRID_SIZE, color: @chosen_option[:color])
    end
    
    def draw_texts
        Text.new("HP: #{@healthpoints}", color: @chosen_option[:color], x: @chosen_option[:x], y: @chosen_option[:hp_y], z:1, size: 25)
        Text.new("Score: #{@score}", color: @chosen_option[:color], x: @chosen_option[:x], y: @chosen_option[:score_y], z:1, size: 25)
    end

    def move # logic for moving the ship 
        case @direction
        when 'left'
            if !(@position[0] <= 0) # stops ship from moving through th left wall
                @position[0] -= 1
            end
        when 'right'
            if !(@position[0] >= $GRID_WIDTH - 1) # stops ship from moving through th right wall
                @position[0] += 1
            end
        end
    end # move
    
    def record_hit # loosing life
        @healthpoints -= 1
    end

    def dead?
        @healthpoints <= 0
    end
    
    # access to position of the ship at a given time
    def x
        @position[0] * $GRID_SIZE
    end

    def y
        @position[1] * $GRID_SIZE
    end
end