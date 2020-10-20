require 'pry'
require 'tty-prompt'

class CLI
    def initialize
        @prompt = TTY::Prompt.new
        @font = TTY::Font.new(:doom)
        @user = []
    end

    def welcome
        puts @font.write("🌑 Asteroids 🌑") # displays game title
        sleep(1)                          # input a delay before displaying the menu/selection screen below

        selection = @prompt.select('Please select one of the options below:') do |menu|
            menu.choice 'Create Account', 1
            menu.choice 'Sign In', 2
            menu.choice 'Exit', 3
        end
    end

    def new_acc
        selection = @prompt.ask('Please enter a username:', required: true)
        username = User.find_by(username: selection)
            if username == nil
                pass = @prompt.mask('Please enter a password:', required: true)
                puts "Your account has been created. Welcome to the game #{selection}"
            end
    end

    def login_acc
    end
end # class

