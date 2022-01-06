io.stdout:setvbuf('no')
if arg[#arg] == '-debug' then require('mobdebug').start() end

--[[
Attributions
- Robot Vecteurs par Vecteezy

]]

Game = require('game')
Menu = require('menu')
Bot = require('bot')
Credits = require('credits')

screen = 'menu'
autopilote = false
cursorSelect = nil

font = {}
font.score = love.graphics.newFont('fonts/vipnagorgialla rg.otf', 46)
font.menu = love.graphics.newFont('fonts/vipnagorgialla rg.otf', 25)
font.submenu = love.graphics.newFont('fonts/vipnagorgialla rg.otf', 14)
font.credits = love.graphics.newFont('fonts/vipnagorgialla rg.otf', 20)
font.title = love.graphics.newFont('fonts/vipnagorgialla rg.otf', 68)
font.subtitle = love.graphics.newFont('fonts/vipnagorgialla rg.otf', 22)

music = love.audio.newSource('musics/Dungeon Theme.mp3', 'stream')
music:play()
music:setVolume(.2)
music:setLooping(true)
song = love.audio.newSource('songs/beep.wav', 'static')

function love.load()
  love.window.setTitle('Pong By Killian Code')
  love.window.setMode(800, 600)
  screenWidth = love.graphics.getWidth()
  screenHeight = love.graphics.getHeight()
  
  cursor = {}
  cursor.hand = love.mouse.getSystemCursor('hand')
  cursor.arrow = love.mouse.getSystemCursor('arrow')
  
  Game.load()
  Menu.load()
  Bot.load()
  Credits.load()
end

function love.update(dt)
  mouseX = love.mouse.getX()
  mouseY = love.mouse.getY()
  
  Game.update(dt)
  Menu.update(dt)
  Bot.update(dt)
  Credits.update(dt)
end

function love.draw()
  Game.draw()
  Menu.draw()
  Bot.draw()
  Credits.draw()
end

function love.mousepressed(x, y, button)
  Game.mousepressed(x, y, button)
  Menu.mousepressed(x, y, button)
  Credits.mousepressed(x, y, button)
end

function love.keypressed(key)
  Game.keypressed(key)
end

