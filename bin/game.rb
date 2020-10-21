require 'ruby2d'
require 'pry'

FPS = 15 # controls the speed of the game, difficulty will raise it. easy: 15, medium: 20, hard: 25
set background: 'navy'
set fps_cap: FPS

# game over ✅
# 2 players ✅
# 3.2.1 go ✅
# music & sound effect
# background
# life up?

# width = 640 / 20 = 32
# height = 480 / 20 = 24

GRID_SIZE = 20
GRID_WIDTH = Window.width / GRID_SIZE
GRID_HEIGHT = Window.height / GRID_SIZE

class Ship # maybe to be moved to it's own file
    attr_accessor :position, :direction, :healthpoints, :score, :start_time

    @@all = []
    @@player_options = [
        {x: 450, hp_y: 10, score_y: 40, color: 'green'},
        {x: 10, hp_y: 10, score_y: 40, color: 'purple'}
    ]

    def initialize
        # if players == 2 set coords to 2 player position
        @position = [16, 20]
        @direction = nil
        @healthpoints = 5
        @score = 0
        @start_time = Time.now
        @@all << self
        @player_num = @@all.count
        @chosen_option = @@player_options[@player_num - 1]
    end

    def self.all
        @@all
    end

    def draw # draws the ship in correct location and displays hp
        Square.new(x: @position[0] * GRID_SIZE, y: @position[1] * GRID_SIZE, size: GRID_SIZE, color: @chosen_option[:color])
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
            if !(@position[0] >= GRID_WIDTH - 1) # stops ship from moving through th right wall
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
        @position[0] * GRID_SIZE
    end

    def y
        @position[1] * GRID_SIZE
    end
    
end # ship

class Asteroid
    attr_accessor :rock, :collided, :reached_end

    @@all = []

    def initialize(rock_x=rand(GRID_WIDTH), rock_y=rand(3))
        @rock_x = rock_x
        @rock_y = rock_y
        @rock = nil
        @reached_end = false
        @collided = false
        @@all << self
    end

    def draw
        @rock = Square.new(x: @rock_x * GRID_SIZE, y: @rock_y * GRID_SIZE, size: (GRID_SIZE - 1) * 2, color: 'red')
    end

    def move
        @rock_y += 1 # @speed
        if @rock_y >= GRID_HEIGHT # logic to respawn asteroid at top of screen
            @rock_y = 0
            @rock_x = rand(GRID_WIDTH)
            @reached_end = true
            @collided = false
        end
    end

    def reached_end?
        @reached_end
    end

    def asteroid_hit_ship(ship) # returns true if the asteroid and ship occupy the same space
        if !@collided # will only return true the first time the asteroid hits the ship
            if self.rock.contains?(ship.x, ship.y)
                @collided = true
                return true
            end
        end
    end
    
    # access to position of the asteroid at a given time
    def x
        @rock_x * GRID_SIZE
    end
    
    def y
        @rock_y * GRID_SIZE
    end
    
end # asteroid

class Game
    attr_accessor :players, :start_timer, :started

    def initialize(players=1)
        @players = players
        @start_timer = FPS * 3
        @started = false
    end

    def game_over_text
        Text.new("Game Over", color: 'orange', x: Window.width / 6, y: Window.height / 3, z: 1, size: 80) # need to find a way to make it centered and scaled with window size
        Text.new("Press 'R' to restart", color: 'orange', x: (Window.width / 6) + 45, y: (Window.height / 3) + 85, z: 1, size: 40)
    end

    def starting_text
        Text.new("#{(@start_timer / FPS) + 1}", color: 'white', x: (Window.width / 2) - 30, y: Window.height / 3, z: 1, size: 100)
    end
end

game = Game.new # change to Game.new(2) for two player game

🚀 = []
🚀 << Ship.new

if game.players == 2
    🚀 << Ship.new
    🚀[0].position = [22, 20]
    🚀[1].position = [11, 20]
end

🎇 = []

🌑 = []
🌑 << Asteroid.new

update do # actual logic of the game, runs every frame (speed controlled by fps_cap)
    clear

    unless 🚀.count == 🎇.count # stops the player and asteroid if hp is 0
        if game.start_timer == 0 # logic for 3.2.1 timer at the start of the game

            if !game.started # setting start time for only after the timer finished
                🚀.each{|x| x.start_time = Time.now}
            end

            game.started = true

            🚀.each{|x| x.move}
            🌑.each{|x| x.move}

            if 🌑.all?{|x| x.reached_end?} 
                🌑 << Asteroid.new
            end
    
            🚀.each{|x| !x.dead? ? (x.score = (Time.now - x.start_time)) : nil }

        else # code for showing the timer
            game.starting_text
            game.start_timer -= 1
        end

    else
        game.game_over_text

        on :key_down do |event| # restart logic, resets all the pieces
            if event.key == 'r'
                game.started = false
                game.start_timer = FPS * 3

                🚀.each do |x|
                    x.healthpoints = 5
                    x.score = 0
                    x.start_time = Time.now
                end
        
                if game.players == 2
                    🚀[0].position = [22, 20]
                    🚀[1].position = [11, 20]
                else
                    🚀[0].position = [16, 20]
                end
        
                🎇 = []
        
                🌑 = []
                🌑 << Asteroid.new
            end
        end
    end # end of unless loop
    
    🚀.each{|x| !x.dead? ? x.draw : nil }
    Ship.all.each{|x| x.draw_texts}
    🌑.each{|x| x.draw}

    
    # binding.pry
    🌑.each do |rock|
        🚀.each do |ship|
            if !ship.dead?
                if rock.asteroid_hit_ship(ship) # tracks the collision and lowers hp
                    ship.record_hit
                    if ship.dead?
                        🎇 << ship
                    end
                end
            end
        end
    end
end

# events to catch user input, going to need to abstract these for the 2 player functionality
on :key_held do |event|
    if ['left', 'right'].include?(event.key)
        🚀[0].direction = event.key
    end

    if game.players == 2
        if ['a', 'd'].include?(event.key)
            case event.key
            when 'a'
                🚀[1].direction = 'left'
            when 'd'
                🚀[1].direction = 'right'
            end
        end
    end
end

on :key_up do
    🚀[0].direction = nil
    if game.players == 2
        🚀[1].direction = nil
    end
end


show