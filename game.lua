
local game = {}
game.mode = "bvb"
game.racket = {}
game.racket.width = 20
game.racket.height = 150
game.racket.speed = 8
game.racket.autopiloteSpeed = 6.58

game.score = {}

game.racket1 = {}
game.racket1.x = 0
game.racket1.y = 0

game.racket2 = {}
game.racket2.x = 0
game.racket2.y = 0

game.ball = {}
game.ball.x = 0
game.ball.y = 0
game.ball.vx = 0
game.ball.vy = 0
game.ball.size = 20
game.ball.move = false

function resetBall()
  autopilote = false
  game.ball.move = false
  game.ball.x = screenWidth/2 - game.ball.size/2
  game.ball.y = screenHeight/2 - game.ball.size/2
  game.ball.vx = 0 - game.ball.vx
  game.ball.vy = 0 - game.ball.vy
end

function reset()
  game.racket1.x = 0
  game.racket1.y = 0
  game.racket2.x = screenWidth - game.racket.width
  game.racket2.y = screenHeight - game.racket.height
  game.score[0] = 0
  game.score[1] = 0
  resetBall()
end

function game.load()
  reset()
end

function game.update(dt)
  local ball = game.ball
  local racket = game.racket
  
  -- Add Velocity in coords X/Y
  if ball.move == true then
    ball.x = ball.x + ball.vx
    ball.y = ball.y + ball.vy
  end
  
  -- Collision
  if ball.y < 0 then
    ball.y = 0
    ball.vy = 0 - ball.vy
    song:stop()
    song:play()
  end
  if ball.y+ball.size > screenHeight then
    ball.y = screenHeight - ball.size
    ball.vy = 0 - ball.vy
    song:stop()
    song:play()
  end
  if ball.x < 0 + racket.width and ball.y+ball.size/2 > game.racket1.y 
  and ball.y < game.racket1.y+racket.height then
    ball.x = 0 + racket.width
    ball.vx = 0 - ball.vx
    song:stop()
    song:play()
  end
  if ball.x+ball.size > screenWidth - racket.width and ball.y+ball.size/2 > game.racket2.y 
  and ball.y < game.racket2.y+racket.height then
    ball.x = screenWidth - racket.width - ball.size
    ball.vx = 0 - ball.vx
    song:stop()
    song:play()
  end
  
  if ball.x+ball.size < 0 then
    game.score[1] = game.score[1] + 1
    resetBall()
  end
  if ball.x > screenWidth then
    game.score[0] = game.score[0] + 1
    resetBall()
  end
  
  -- Controls
  if screen == 'game' then
    if love.keyboard.isDown('z') and game.racket1.y > 0 and game.mode == "1v1" then
      game.racket1.y = game.racket1.y - racket.speed
    elseif love.keyboard.isDown('s') and game.racket1.y+racket.height < screenHeight and game.mode == "1v1" then
      game.racket1.y = game.racket1.y + racket.speed
    end
    if love.keyboard.isDown('up') and game.racket2.y > 0 then
      game.racket2.y = game.racket2.y - racket.speed
    elseif love.keyboard.isDown('down') and game.racket2.y+racket.height < screenHeight then
      game.racket2.y = game.racket2.y + racket.speed
    end
  end
end

function game.draw()
  love.graphics.line(screenWidth/2, 0, screenWidth/2, screenHeight)
  love.graphics.rectangle("fill", game.racket1.x, game.racket1.y, game.racket.width, game.racket.height, 2)
  love.graphics.rectangle("fill", game.racket2.x, game.racket2.y, game.racket.width, game.racket.height, 2)
  love.graphics.rectangle("fill", game.ball.x, game.ball.y, game.ball.size, game.ball.size, 2)
  
  love.graphics.setFont(font.score)
  local score1 = font.score:getWidth(tostring(game.score[0]))
  local score2 = font.score:getWidth(tostring(game.score[1]))
  love.graphics.print(game.score[0], screenWidth/2 - score1-15, 20)
  love.graphics.print(game.score[1], screenWidth/2 + 15, 20)
end

function game.mousepressed(x, y, button)
end

function game.keypressed(key)
  if screen == 'game' then
    if key == 'space' then
      Bot.imgCurrent = 1
      autopilote = true
      game.ball.move = true
      game.ball.vx = -10
      game.ball.vy = -10
    end
    if key == 'escape' then
      Menu.btnGameActive = false
      screen = 'menu'
      game.mode = 'bvb'
      reset()
    end
  end
end

return game