
bot = {}
bot.position = "left"

bot.imgs = {}
bot.imgSize = 1/10000
bot.imgCurrent = 0

function bot.load()
  bot.imgs[0] = love.graphics.newImage('assets/bot/say-hi.png')
  bot.imgs[1] = love.graphics.newImage('assets/bot/waving-hand.png')
  bot.imgs[2] = love.graphics.newImage('assets/bot/cute.png')
  bot.imgs[3] = love.graphics.newImage('assets/bot/question.png')
  bot.imgs[4] = love.graphics.newImage('assets/bot/error-and-crash.png')
  bot.imgs[5] = love.graphics.newImage('assets/bot/error404.png')
end

function bot.update(dt)
  local racket = Game.racket
  local ball = Game.ball
  
  if autopilote == true and Game.mode ~= "1v1" then
    if ball.x < screenWidth/2 then
      if ball.y < Game.racket1.y+racket.height/2 and Game.racket1.y > 0 then
        Game.racket1.y = Game.racket1.y - racket.autopiloteSpeed
      elseif ball.y > Game.racket1.y+racket.height/2 and Game.racket1.y+racket.height < screenHeight then
        Game.racket1.y = Game.racket1.y + racket.autopiloteSpeed
      end
    end
    
    if ball.x > screenWidth/2 and Game.mode ~= "1v1" and Game.mode ~= "1vb" then
      if ball.y < Game.racket2.y+racket.height/2 and Game.racket2.y > 0 then
        Game.racket2.y = Game.racket2.y - racket.autopiloteSpeed
      elseif ball.y > Game.racket2.y+racket.height/2 and Game.racket2.y+racket.height < screenHeight then
        Game.racket2.y = Game.racket2.y + racket.autopiloteSpeed
      end
    end    
  end
  
  if Game.score[0] > Game.score[1] then
    bot.imgCurrent = 2
  else
    bot.imgCurrent = 1
  end
  
  if Game.score[1] - Game.score[0] >= 4 then
    bot.imgCurrent = 3
  end
  if Game.score[1] - Game.score[0] >= 10 then
    bot.imgCurrent = 4
  end
  if Game.score[1] - Game.score[0] >= 16 then
    bot.imgCurrent = 5
  end
  
end

function bot.draw()
  if screen == "game" and Game.mode ~= "1v1" then
    if bot.position == "left" then
      love.graphics.draw(bot.imgs[bot.imgCurrent], 5, 0)
    end
  end
end

return bot