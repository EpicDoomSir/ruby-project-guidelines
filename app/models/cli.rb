require 'pry'
require 'tty-prompt'

class CLI
    def initialize
        @prompt = TTY::Prompt.new
        @font = TTY::Font.new(:doom)
        @pastel = Pastel.new
        @user = []
    end

    def welcome
        puts @pastel.magenta.bold(@font.write("ASTEROIDS".center(30), letter_spacing: 4)) # displays game title
        sleep(1)                          # input a delay before displaying the menu/selection screen below

        selection = @prompt.select('Please select one of the options below:'.center(180))do |menu|
            menu.choice 'Create Account'.center(180), 1
            menu.choice 'Sign In'.center(180), 2
            menu.choice 'Exit'.center(180), 3
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
        self.menu
    end

    def login_acc
        system("clear")
        u_input = @prompt.ask('Please enter a username:', required: true)
        e_user = User.find_by(username: u_input)
        system("clear")
        if e_user == nil
            puts "User not found, try again!"
            self.login_acc
        else pass = @prompt.mask('Please enter a password:', required: true)
            login = User.find_by(username: u_input, password: pass)
            system("clear")
            if login == nil
                puts "Wrong password, try again!"
                self.login_acc
            else
                puts "Welcome back #{e_user.username}!"
            end
        end
        self.menu
    end

    def menu
        
    end

    def close
        puts "Thank you for playing, see you again!"
        puts "by Shevaughn and Eitan"
        exit
    end
end # class

