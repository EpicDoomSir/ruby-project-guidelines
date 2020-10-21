require 'pry'
require 'tty-prompt'

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
        system("clear")
        if username == nil
            pass = @prompt.mask('Please enter a password:', required: true)
            system("clear")
            @user = User.create(username: u_input, password: pass)
            system("clear")
            puts "Your account has been created. Welcome to ASTEROIDS, #{u_input}."
        else
            puts "That username is already taken, please try again."
            self.welcome
        end
        self.menu
    end

    def login_acc
        system("clear")
        u_input = @prompt.ask('Please enter a username:')
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
        puts "Main Menu\n\n".center(180) # add new line char
        selection = @prompt.select("Select an option:\n".center(180)) do |menu|
            menu.choice 'Game Start'.center(175), 1
            menu.choice 'Difficulty'.center(175), 2
            menu.choice 'Profile'.center(175), 3
            menu.choice 'Leaderboard'.center(175), 4
            menu.choice 'Back'.center(175), 5
            menu.choice 'Exit'.center(175), 6
        end     

        if selection == 1
            # start game in bin/game.rb
        elsif selection == 2
            self.difficulty  # user able to change difficulty of game
        elsif selection == 3
            self.profile
        elsif selection == 4
            self.leaderboard   # leaderboard
        elsif selection == 5
            self.welcome
        else selection == 6
            self.close
        end
    end

    def difficulty

    end

    def leaderboard
    end


    def profile
        selection = @prompt.select("") do |menu|
            menu.choice 'Change Password'.center(175), 1
            menu.choice 'Delete Account'.center(175), 2
            menu.choice 'High Score'.center(175), 3
            menu.choice 'Return to Main Menu'.center(175), 4
            menu.choice 'Exit'.center(175), 5
        end

        if selection == 1
            passinput = @prompt.mask("Please enter a new password:", required: true)
            User.update(password: passinput)   # Currently changes all users pass
            system("clear")
            puts "You successfully changed your password!"
            self.menu
        elsif selection == 2
            User.delete(@user)
            system("clear")
            puts "Your account was deleted. Returning to login screen."
            sleep(1)
            self.welcome
        elsif selection == 3
            # check personal score of player
        elsif selection == 4
            self.menu
        else selection == 5
            self.close
        end
    end

    def close
        system("clear")
        sleep(1)
        puts "Thank you for playing, see you again!"
        puts "by Shevaughn and Eitan"
        exit
    end
end # class

