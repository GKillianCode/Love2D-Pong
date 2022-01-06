
local credits = {}

cross = {}
cross.x = 15
cross.y = 15

function credits.load()
  cross.img = love.graphics.newImage('assets/cross.png')  
end

function credits.update(dt)
  if screen == 'credits' then
    if mouseX > cross.x and mouseX < cross.x + cross.img:getWidth() 
    and mouseY > cross.y and mouseY < cross.y + cross.img:getHeight() then
      cursorSelect = cursor.hand
      love.mouse.setCursor(cursorSelect)
    else
      cursorSelect = cursor.arrow
      love.mouse.setCursor(cursorSelect)
    end
  end
end

function credits.draw()
  if screen == 'credits' then
    love.graphics.setColor(0, 0, 0, .8)
    love.graphics.rectangle('fill', 0, 0, screenWidth, screenHeight)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(cross.img, cross.x, cross.y)
    
    love.graphics.setFont(font.credits)
    love.graphics.print('Pong développé par Killian Code', 40, 50)
    love.graphics.print('Image : Robot Vecteurs par Vecteezy', 40, 80)
    love.graphics.print('Musique : https://opengameart.org/users/codemanu', 40, 110)
    love.graphics.print('Sons : https://opengameart.org/users/bart', 40, 140)
  end
end

function credits.mousepressed(x, y, button)
  if screen == 'credits' and button == 1 then
    if mouseX > cross.x and mouseX < cross.x + cross.img:getWidth() 
    and mouseY > cross.y and mouseY < cross.y + cross.img:getHeight() then
      screen = "menu"
    end
  end
end

return credits