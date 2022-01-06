
local menu = {}
menu.ballTimer = 0

menu.title = "Pong"
menu.subtitle = "By Killian Code"
menu.titleY = 100

menu.btn1 = {}
menu.btn1.title = "Jouer"
menu.btn1.hover = false
menu.btn2 = {}
menu.btn2.title = "Credits"
menu.btn2.hover = false
menu.btn3 = {}
menu.btn3.title = "Quitter"
menu.btn3.hover = false

menu.btnModePlayer = 'Joueur contre Joueur'
menu.btnModeBot = 'Robot contre Joueur'

menu.btnWidth = 20
menu.btnAnimation = false
menu.btnSpeed = 180
menu.btnMove = 60
menu.btnGameActive = false

function resetBtn()
  menu.btnAnimation = true
  menu.btnTimer = 0
  menu.btn1.y = screenHeight + 50
  menu.btn2.y = screenHeight + 50
  menu.btn3.y = screenHeight + 50
end

function menu.load()
  resetBtn()
  menu.btn1.x = screenWidth/2 - menu.btnWidth/2
  menu.btn2.x = screenWidth/2 - menu.btnWidth/2
  menu.btn3.x = screenWidth/2 - menu.btnWidth/2
  
end

function menu.update(dt)  
  if screen ~= 'game' then
    -- Autopilote
    if Game.ball.move == false then
      if menu.ballTimer >= 1 then
        autopilote = true
        menu.btnAnimation = true
        menu.ballTimer = 0
        Game.ball.move = true
        Game.ball.vx = -10
        Game.ball.vy = -10
      else
        menu.ballTimer = menu.ballTimer + 1*dt
      end
    end
    
    -- Animation Menu
    if menu.btnAnimation == true then
      if menu.btn1.y >= screenHeight - 220 then
          menu.btn1.y = menu.btn1.y - menu.btnSpeed*dt
      else
        if menu.btn2.y >= screenHeight - 160 then
          menu.btn2.y = menu.btn2.y - menu.btnSpeed*dt
        else
          if menu.btn3.y >= screenHeight - 100 then
            menu.btn3.y = menu.btn3.y - menu.btnSpeed*dt
          else
            menu.btnModeY = menu.btn1.y + 30
            menu.btnAnimation = false
          end
        end
      end
    end
  
    -- Hover Elements
    if menu.btnAnimation == false then
      -- Cursor hover
      if mouseX > screenWidth/2 - 60 and mouseX < screenWidth/2 + 60 and mouseY >= menu.btn1.y - 40
      and mouseY <= menu.btn3.y then
        cursorSelect = cursor.hand
        love.mouse.setCursor(cursorSelect)
      else
        cursorSelect = cursor.arrow
        love.mouse.setCursor(cursorSelect)
      end
      
      if menu.btnGameActive == true then
        if mouseX > screenWidth/2 - 220 and mouseX < screenWidth/2 + 220
        and mouseY > menu.btn1.y - 40 and mouseY < menu.btn2.y - 40 then
          cursorSelect = cursor.hand
          love.mouse.setCursor(cursorSelect)
        else
          cursorSelect = cursor.arrow
          love.mouse.setCursor(cursorSelect)
        end
      end
      
      -- Color hover
      if mouseY < menu.btn1.y and mouseY >= menu.btn1.y - 40 then
        menu.btn1.hover = true
      else
        menu.btn1.hover = false
      end
      if mouseY < menu.btn2.y and mouseY >= menu.btn2.y - 40 then
        menu.btn2.hover = true
      else
        menu.btn2.hover = false
      end
      if mouseY < menu.btn3.y and mouseY >= menu.btn3.y - 40 then
        menu.btn3.hover = true
      else
        menu.btn3.hover = false
      end
    end    
  end
end

function menu.draw()
  if screen == 'menu' then
    love.graphics.setColor(0, 0, 0, .6)
    love.graphics.rectangle('fill', 0, 0, screenWidth, screenHeight)
    love.graphics.setColor(1, 1, 1, 1)
    
    if menu.btn1.hover == true then
      love.graphics.setColor(.1, 1, .1)
    else
      love.graphics.setColor(1, 0, 0)
    end
    love.graphics.line(menu.btn1.x, menu.btn1.y, menu.btn1.x+menu.btnWidth, menu.btn1.y)
    
    if menu.btn2.hover == true then
      love.graphics.setColor(.1, 1, .1)
    else
      love.graphics.setColor(1, 0, 0)
    end
    love.graphics.line(menu.btn2.x, menu.btn2.y, menu.btn2.x+menu.btnWidth, menu.btn2.y)
    
    if menu.btn3.hover == true then
      love.graphics.setColor(.1, 1, .1)
    else
      love.graphics.setColor(1, 0, 0)
    end
    love.graphics.line(menu.btn3.x, menu.btn3.y, menu.btn3.x+menu.btnWidth, menu.btn3.y)
    love.graphics.setColor(1, 1, 1)
    
    love.graphics.setFont(font.title)
    local fontHeight = font.title:getHeight(menu.title)
    local fontWidth = font.title:getWidth(menu.title)
    love.graphics.print(menu.title, screenWidth/2 - fontWidth/2, menu.titleY)
    
    love.graphics.setColor(1, 0, 0)
    love.graphics.setFont(font.subtitle)
    fontWidth = font.subtitle:getWidth(menu.subtitle)
    love.graphics.print(menu.subtitle, screenWidth/2 - fontWidth/2, menu.titleY + fontHeight + 10)
    love.graphics.setColor(1, 1, 1)
    
    love.graphics.setFont(font.menu)
    fontWidth = font.menu:getWidth(menu.btn1.title)
    fontHeight = font.menu:getHeight(menu.btn1.title)
    love.graphics.print(menu.btn1.title, screenWidth/2 - fontWidth/2, menu.btn1.y - fontHeight - 5)
    
    fontWidth = font.menu:getWidth(menu.btn2.title)
    love.graphics.print(menu.btn2.title, screenWidth/2 - fontWidth/2, menu.btn2.y - fontHeight - 5)
    
    fontWidth = font.menu:getWidth(menu.btn3.title)
    love.graphics.print(menu.btn3.title, screenWidth/2 - fontWidth/2, menu.btn3.y - fontHeight - 5)
    
    if menu.btnGameActive == true then
      love.graphics.setFont(font.submenu)
      fontHeight = font.submenu:getHeight(menu.btnModePlayer)
      fontWidth = font.submenu:getWidth(menu.btnModePlayer)
      
      if mouseX > screenWidth/2 - 220 and mouseX < screenWidth/2 
      and mouseY > menu.btn1.y and mouseY < menu.btn2.y - 40 then
        love.graphics.setColor(.1, 1, .1)
      else
        love.graphics.setColor(1, 1, 1)
      end
      love.graphics.print(menu.btnModePlayer, screenWidth/2 - fontWidth - 15, menu.btnModeY)
      
      if mouseX < screenWidth/2 + 220 and mouseX > screenWidth/2 
      and mouseY > menu.btn1.y and mouseY < menu.btn2.y - 40 then
        love.graphics.setColor(.1, 1, .1)
      else
        love.graphics.setColor(1, 1, 1)
      end
      love.graphics.print(menu.btnModeBot, screenWidth/2 + 15, menu.btnModeY)
      
      love.graphics.setColor(1, 1, 1)
    end
  end
end

function menu.mousepressed(x, y, button)
  
  if screen == 'menu' and button == 1 and menu.btnAnimation == false then
    if x > screenWidth/2 - 60 and x < screenWidth/2 + 60 then    
      
      if y < menu.btn1.y and y >= menu.btn1.y - 40 then
        if menu.btnGameActive == false then
          menu.btnGameActive = true
          menu.btn2.y = menu.btn2.y + menu.btnMove
          menu.btn3.y = menu.btn3.y + menu.btnMove
        else
          menu.btnGameActive = false
          menu.btn2.y = menu.btn2.y - menu.btnMove
          menu.btn3.y = menu.btn3.y - menu.btnMove
        end
      elseif y < menu.btn2.y and y >= menu.btn2.y - 40 then
        screen = 'credits'
      elseif y < menu.btn3.y and y >= menu.btn3.y - 40 then
        love.event.quit()
      end
    end
    
    if menu.btnGameActive == true then
      if mouseX > screenWidth/2 - 220 and mouseX < screenWidth/2 
      and mouseY > menu.btn1.y and mouseY < menu.btn2.y - 40 then
        autopilote = false
        screen = 'game'
        Game.mode = '1v1'
        reset()
      elseif mouseX < screenWidth/2 + 220 and mouseX > screenWidth/2 
      and mouseY > menu.btn1.y and mouseY < menu.btn2.y - 40 then
        autopilote = false
        screen = 'game'
        Game.mode = '1vb'
        reset()
      end
    end
  end
end

return menu