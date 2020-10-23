require 'pry'
require 'tty-prompt'
require_relative '../../bin/globalvariable'
class CLI
  def initialize
    @prompt = TTY::Prompt.new
    @font = TTY::Font.new(:doom)
    @pastel = Pastel.new
      # @user = []
  end

  def welcome
    system("clear")
    puts @pastel.magenta.bold(@font.write("ASTEROIDS".center(30), letter_spacing: 4)) # displays game title
    sleep(1)                          # input a delay before displaying the menu/selection screen below

    selection = @prompt.select("\n".center(185)) do |menu|
      menu.choice 'Create Account'.center(180), 1
      menu.choice 'Sign In'.center(180), 2
      menu.choice 'Exit'.center(180), 3
    end
    if selection == 1
      new_acc
    elsif selection == 2
      login_acc
    elsif selection == 3
      close
    end
  end

  def new_acc
    u_input = @prompt.ask('Please enter a username:', required: true)
    username = User.find_by(username: u_input)
    system('clear')
    sleep(1)
    email_input = @prompt.ask('Please enter your email address:') { |q| q.validate :email }
    email = User.find_by(email_address: email_input)
    system("clear")
    if username == nil
      pass = @prompt.mask('Please enter a password:', required: true)
      system("clear")
      @user = User.create(username: u_input, email_address: email_input, password: pass)
      system("clear")
      puts "Your account has been created. Welcome to ASTEROIDS, #{u_input}."
      sleep(1)
    else
      puts "That username is already taken, please try again."
      sleep(2)
      welcome
    end
    menu
  end

  def login_acc
    system("clear")
    u_input = @prompt.ask('Please enter a username:')
    e_user = User.find_by(username: u_input)
    system("clear")
    sleep(1)
    if e_user == nil
      puts "User not found, please try again!".center(175)
      sleep(2)
      welcome
    else pass = @prompt.mask('Please enter a password:', required: true)
         @user = User.find_by(username: u_input, password: pass)
         system("clear")
         sleep(1)
         if @user == nil
           puts "Incorrect password, please sign in again!".center(175)
           sleep(1)
           welcome
         else
           puts "Welcome back #{e_user.username}!"
         end
    end
    menu
  end

  def menu
    puts "Main Menu\n\n".center(180) # add new line char
    selection = @prompt.select("Select an option:\n".center(180)) do |menu|
      menu.choice 'Game Start'.center(175), 1
      menu.choice 'Choose Difficulty'.center(175), 2
      menu.choice 'Profile'.center(175), 3
      menu.choice "Leaderboard".center(176), 4
      menu.choice 'Choose Players'.center(175), 5
      menu.choice 'Back'.center(175), 6
      menu.choice 'Exit'.center(175), 7
    end
    case selection
    when 1
      game = Game.create(difficulty: $DIFFICULTY, players: $PLAYERS, start_timer: $FPS * 3, started: false, finish_flag: 0) # change to Game.new(2) for two player game
      🚀 = []
      🚀 << Ship.create(user_id: @user.id, game_id: game.id, hp: 5, scores: 0, position_x: 16, position_y: 20, start_time: Time.now, player_option: 0)
      
      if game.players == 2 # if players == 2 set coords to 2 player position
          🚀 << Ship.create(user_id: @user2.id, game_id: game.id, hp: 5, scores: 0, position_x: 11, position_y: 20, start_time: Time.now, player_option: 1)
          🚀[0].position_x = 22
          🚀[0].position_y = 20
      end

      🎇 = []

      🌑 = []
      🌑 << Asteroid.create(rock_x: rand($GRID_WIDTH), rock_y: rand(3), reached_end: false, collided: false)

      $MUSIC.play

      game.run(🚀, 🎇, 🌑, @user)
    #   menu
    when 2
      difficulty  # user able to change difficulty of game
    when 3
      profile
    when 4
      leaderboard   # leaderboard
    when 5
      players
    when 6
      system('clear')
      welcome
    when 7
      close

    else
      raise ArgumentError, "bad selection #{selection}"
    end
  end

  def login_acc2
    system("clear")
    u_input = @prompt.ask('Please enter a username:')
    e_user = User.find_by(username: u_input)
    system("clear")
    sleep(1)
    if e_user == nil
      puts "User not found, please try again!".center(175)
      sleep(2)
      welcome
    else pass = @prompt.mask('Please enter a password:', required: true)
         @user2 = User.find_by(username: u_input, password: pass)
         system("clear")
         sleep(1)
         if @user2 == nil
           puts "Incorrect password, please sign in again!".center(175)
           sleep(1)
           welcome
         else
           puts "Welcome back #{e_user.username}!"
         end
    end
  end

  def players
    amount = @prompt.select("") do |menu|
      menu.choice 'One Player'.center(175), 1
      menu.choice 'Two Players'.center(175), 2
    end

    case amount
    when 1
      $PLAYERS
      system('clear')
      sleep(1)
      puts 'Playing with one player'.center(175)
      sleep(1)
      system('clear')
      menu
    when 2
      $PLAYERS = 2
      system('clear')
      sleep(1)
      login_acc2
      puts 'Playing with two players'.center(175)
      sleep(1)
      system('clear')
      menu
    end

  end

  def difficulty
    diff = @prompt.select("") do |menu|
      menu.choice 'Easy'.center(175), 1
      menu.choice 'Medium'.center(175), 2
      menu.choice "Hard\n".center(175), 3
      menu.choice 'Back'.center(175), 4
    end

    case diff
    when 1
      $FPS
      $DIFFICULTY
      system('clear')
      sleep(1)
      puts 'Difficulty changed to Easy'.center(175)
      sleep(1)
      system('clear')
      menu
    when 2
      $FPS = 20
      $DIFFICULTY = "Medium"
      system('clear')
      sleep(1)
      puts 'Difficulty changed to Medium'.center(175)
      sleep(1)
      system('clear')
      menu
    when 3
      $FPS = 25
      $DIFFICULTY = "Hard"
      system('clear')
      sleep(1)
      puts 'Difficulty changed to Hard'.center(175)
      sleep(1)
      system('clear')
      menu
    when 4
      menu
    end
  end

  def leaderboard
    puts "===================".center(175)
    puts "Ship 1".center(175)
    puts "Score: \n".center(175)
    puts "===========".center(175)
    puts "Ship 2".center(175)
    puts "Score: \n".center(175)
    puts "===================".center(175)
    sleep(2)
    selection = @prompt.select("") do |menu|
      menu.choice 'Return to Main Menu'.center(175), 1
    end
    if selection == 1
      system('clear')
      menu
    end
  end


  def profile
    selection = @prompt.select("") do |menu|
      menu.choice 'Change Password'.center(175), 1
      menu.choice 'Delete Account'.center(175), 2
      menu.choice "High Score\n".center(175), 3
      menu.choice 'Return to Main Menu'.center(175), 4
      menu.choice 'Exit'.center(175), 5
    end

    case selection
    when 1
      passinput = @prompt.mask("Please enter a new password:", required: true)
      @user.update(password: passinput)   # Currently changes all users pass
      system("clear")
      puts "You successfully changed your password!\n".center(175)
      sleep(2)
      self.menu
    when 2
      User.delete(@user)
      system("clear")
      puts "Your account was deleted. Returning to login screen.".center(175)
      sleep(2)
      welcome
    when 3
        # check personal score of player
    when 4
      system('clear')
      self.menu
    when 5
      close
    end
  end

  def close
    system("clear")
    sleep(1)
    puts "Thank you for playing, see you again!".center(175)
    puts "by Shevaughn and Eitan".center(175)
    exit
  end
end # class

