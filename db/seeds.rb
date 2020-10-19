User.destroy_all
Ship.destroy_all
Game.destroy_all
Asteroid.destroy_all

User.create(username: '', email_address: '', password: '', high_score: '')
User.create(username: '', email_address: '', password: '', high_score: '')

Ship.create(user_id: '', game_id: '', hp: '', scores: '')
Ship.create(user_id: '', game_id: '', hp: '', scores: '')

Game.create(difficulty: '')

Asteroid.create(game_id: '', hp: '', size: '')