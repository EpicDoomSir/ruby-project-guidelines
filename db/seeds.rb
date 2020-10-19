User.destroy_all
Ship.destroy_all
Game.destroy_all
Asteroid.destroy_all

eitan = User.create
shevaughn = User.create

game1 = Game.create
game2 = Game.create
game3 = Game.create

User.create(username: 'Eitan', email_address: 'eitan@test.com', password: '123', high_score: 9000 )
User.create(username: 'techtwin', email_address: 'twin@test.com', password: '123', high_score: 8400)

Ship.create(user_id: eitan.id, game_id: game2.id, hp: 100, scores: 4000)
Ship.create(user_id: shevaughn.id, game_id: game1.id, hp: 110, scores: 2349)

Game.create(difficulty: 'Easy')
Game.create(difficulty: 'Medium')
Game.create(difficulty: 'Hard')

Asteroid.create(game_id: game1.id, hp: 100, size: 40)
Asteroid.create(game_id: game1.id, hp: 30, size: 15)

