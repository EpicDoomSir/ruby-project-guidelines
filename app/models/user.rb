class User < ActiveRecord::Base
    has_many :ships
    has_many :games, through: :ships
    has_many :highscores
    has_many :games, through: :highscores

    def leaderboard
        puts "LEADERBOARD".center(112)
        puts ""
        puts ""
    end

    def all_ships
        self.all.map { |user| user.ships }
    end

    def score
        Ship.all.select do |score|
            score == self
        end
    end
end