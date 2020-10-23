require 'ruby2d'
class Game < ActiveRecord::Base
    has_many :asteroids
    has_many :ships
    has_many :users, through: :ships
    has_many :highscores
    has_many :users, through: :highscores

    # attr_accessor :players, :start_timer, :started, :finish_flag
    # attr_reader :starting_sound, :music, :game_over_sound

    # def initialize(players=1)
    #     @players = players
    #     @start_timer = $FPS * 3
    #     @started = false
    #     @finish_flag = 0
    #     # @music = Music.new('./app/game_sounds/abackground_and_engine.wav')
    #     # @starting_sound = Sound.new('./app/game_sounds/321_countdown.mp3')
    #     # @game_over_sound = Sound.new('./app/game_sounds/gameover.mp3')
    #     # @music.volume = 50
    # end

    def game_over_text
        Text.new("Game Over", color: 'orange', x: Window.width / 6, y: Window.height / 3, z: 1, size: 80) # need to find a way to make it centered and scaled with window size
        Text.new("Press 'R' to restart", color: 'orange', x: (Window.width / 6) + 45, y: (Window.height / 3) + 85, z: 1, size: 40)
    end

    def starting_text
        Text.new("#{(self.start_timer / $FPS) + 1}", color: 'white', x: (Window.width / 2) - 30, y: Window.height / 3, z: 1, size: 100)
    end

    def run(🚀, 🎇, 🌑, user)
        Window.set title: 'Asteroids'
        Window.set background: 'navy'
        Window.set fps_cap: $FPS
        Window.update do # actual logic of the game, runs every frame (speed controlled by fps_cap)
            Window.clear
        
            unless 🚀.count == 🎇.count # stops the player and asteroid if hp is 0
                if self.start_timer == 0 # logic for 3.2.1 timer at the start of the game
        
                    if !self.started # setting start time for only after the timer.finish_flag
                        🚀.each{|x| x.start_time = Time.now}
                    end
        
                    self.started = true
        
                    🚀.each{|x| x.move}
                    🌑.each{|x| x.move}
        
                    if 🌑.all?{|x| x.reached_end?} 
                        🌑 << Asteroid.create(rock_x: rand($GRID_WIDTH), rock_y: rand(3), reached_end: false, collided: false)
                    end
            
                    🚀.each do |x| 
                        if !x.dead? 
                            (x.scores = (Time.now - x.start_time)) 
                        else 
                            nil
                        end
                    end
        
                else # code for showing the timer
                    self.starting_text

                    if self.start_timer % $FPS == 0
                        $STARTING_SOUND.play
                    end

                    self.start_timer -= 1
                end
        
            else
                if self.finish_flag == 0
                    $GAME_OVER_SOUND.play
                    self.finish_flag +=1
                end
                self.game_over_text
                $MUSIC.fadeout(1500)
                
                
                🚀.each do |x|
                    x.update_attribute(:scores, x.scores)
                    if x.scores != 0 && self.finish_flag == 1
                        Highscore.create(user_id: user.id, game_id: self.id, score: x.scores)
                    end
                end
                self.finish_flag += 1
                
                Window.on :key_down do |event| # restart logic, resets all the pieces
                    if event.key == 'r'
                        self.started = false
                        self.start_timer = $FPS * 3
                        
                        self.finish_flag = 0
                        
                        $MUSIC.play
        
                        🚀.each do |x|
                            x.hp = 5
                            x.scores = 0
                            x.start_time = Time.now
                        end
                
                        if self.players == 2
                            🚀[0].position_x = 22
                            🚀[0].position_y = 20
                            🚀[1].position_x = 11
                            🚀[1].position_y = 20
                        else
                            🚀[0].position_x = 16
                            🚀[0].position_y = 20
                        end
                
                        🎇 = []
                
                        🌑 = []
                        if 🌑.count == 0
                            🌑 << Asteroid.create(rock_x: rand($GRID_WIDTH), rock_y: rand(3), reached_end: false, collided: false)
                        end

                    end

        
                end
            end # end of unless loop
            
            🚀.each{|x| !x.dead? ? x.draw : nil }
            🚀.each{|x| x.draw_texts}
            🌑.each{|x| x.draw}
            
            
            
            # binding.pry
            🌑.each do |rock|
                🚀.each do |ship|
                    if !ship.dead?
                        if rock.asteroid_hit_ship(ship) # tracks the collision and lowers hp
                            $CRASH.play
                            ship.record_hit
                            if ship.dead?
                                🎇 << ship
                            end
                        end
                    end
                end
            end
        end
        
        Window.on :key_held do |event|
            if ['left', 'right'].include?(event.key)
                🚀[0].direction = event.key
            end
            
            if self.players == 2
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
        
        Window.on :key_up do
            🚀[0].direction = nil
            if self.players == 2
                🚀[1].direction = nil
            end
        end
        Window.show
    end
end