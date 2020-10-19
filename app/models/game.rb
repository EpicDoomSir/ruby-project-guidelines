class Game < ActiveRecord::Base
    has_many :asteroids
    has_many :ships
    has_many :users, through: :ships
end