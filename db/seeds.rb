User.destroy_all
Ship.destroy_all
Game.destroy_all
Asteroid.destroy_all




eitan = User.create(username: 'Eitan', email_address: 'eitan@test.com', password: '123', high_score: 9000 )
shevaughn = User.create(username: 'techtwin', email_address: 'twin@test.com', password: '123', high_score: 8400)

game1 = Game.create(difficulty: 'Easy')
game2 = Game.create(difficulty: 'Medium')
game3 = Game.create(difficulty: 'Hard')

rock1 = Asteroid.create(game_id: game1.id, hp: 100, size: 40)
rock2 = Asteroid.create(game_id: game1.id, hp: 30, size: 15)

ship1 = Ship.create(user_id: eitan.id, game_id: game2.id, hp: 100, scores: 4000)
ship2 = Ship.create(user_id: shevaughn.id, game_id: game1.id, hp: 110, scores: 2349)
