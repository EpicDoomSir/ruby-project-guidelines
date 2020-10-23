class Ship < ActiveRecord::Base
    belongs_to :user
    belongs_to :game

    # attr_accessor :position, :direction, :healthpoints, :score, :start_time, :crash

    # @@all = []
    # @@player_options = [
    #     {x: 430, hp_y: 10, score_y: 40, color: 'green'},
    #     {x: 10, hp_y: 10, score_y: 40, color: 'purple'}
    # ]

    # def initialize(mystery)
    #     @position = [16, 20]
    #     @direction = nil
    #     @healthpoints = 5
    #     @score = 0
    #     @start_time = Time.now
    #     @@all << self
    #     @player_num = @@all.count
    #     $PLAYER_OPTIONS = @@player_options[@player_num - 1]

        # crash = Sound.new("./app/game_sounds/crash2.wav")
    # end

    # def self.all
    #     @@all
    # end

    def draw # draws the ship in correct location and displays hp
        Square.new(x: self.position_x * $GRID_SIZE, y: self.position_y * $GRID_SIZE, size: $GRID_SIZE, color: $PLAYER_OPTIONS[self.player_option][:color])
    end
    
    def draw_texts
        Text.new("HP: #{self.hp}", color: $PLAYER_OPTIONS[self.player_option][:color], x: $PLAYER_OPTIONS[self.player_option][:x], y: $PLAYER_OPTIONS[self.player_option][:hp_y], z:1, size: 25)
        Text.new("Score: #{self.scores}", color: $PLAYER_OPTIONS[self.player_option][:color], x: $PLAYER_OPTIONS[self.player_option][:x], y: $PLAYER_OPTIONS[self.player_option][:score_y], z:1, size: 25)
    end

    def move # logic for moving the ship 
        case self.direction
        when 'left'
            if !(self.position_x <= 0) # stops ship from moving through th left wall
                self.position_x -= 1
            end
        when 'right'
            if !(self.position_x >= $GRID_WIDTH - 1) # stops ship from moving through th right wall
                self.position_x += 1
            end
        end
    end # move
    
    def record_hit # loosing life
        self.hp -= 1
    end

    def dead?
        self.hp <= 0
    end
    
    # access to position of the ship at a given time
    def x
        self.position_x * $GRID_SIZE
    end

    def y
        self.position_y * $GRID_SIZE
    end
end