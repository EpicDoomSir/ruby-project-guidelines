require 'pry'
require 'tty-prompt'

class CLI
    def initialize
        @prompt = TTY::Prompt.new
        @font = TTY::Font.new(:doom)
        @user = []
    end

    def welcome
        puts @font.write("ASTEROIDS", letter_spacing: 4) # displays game title
        sleep(1)                          # input a delay before displaying the menu/selection screen below

        selection = @prompt.select('Please select one of the options below:') do |menu|
            menu.choice 'Create Account', 1
            menu.choice 'Sign In', 2
            menu.choice 'Exit', 3
        end
        if selection == 1
            self.new_acc
        elsif selection == 2
            self.login_acc
        elsif selection == 3
            self.close
        end
    end

    def new_acc
        u_input = @prompt.ask('Please enter a username:', required: true)
        username = User.find_by(username: u_input)
        if username == nil
            pass = @prompt.mask('Please enter a password:', required: true)
            puts "Your account has been created. Welcome to the game #{u_input}"
            @user = User.create(username: u_input, password: pass)
        else
            puts "That username is already taken, please try again."
            self.welcome
        end
    end

    def login_acc
    end

    def close
        puts "Thank you for playing, see you again!"
        puts "by Shevaughn and Eitan"
        exit
    end
end # class

