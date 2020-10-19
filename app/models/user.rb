class User < ActiveRecord::Base
    has_many :ships
    has_many :games, through: :ships
end