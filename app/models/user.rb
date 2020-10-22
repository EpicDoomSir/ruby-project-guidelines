class User < ActiveRecord::Base
    has_many :ships
    has_many :games, through: :ships

    def self.leaderboard
        puts "LEADERBOARD".center(112)
        puts ""
        puts ""
    end

    def all_ships
        self.all.map { |user| user.ships}
    end

    def score
        
    end
end