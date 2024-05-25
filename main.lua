require "src/collision"
_G.love = require("love")

function love.load()
    math.randomseed(os.time())
    love.graphics.setBackgroundColor(0.25, 0.25, 0.25)

    _G.snake = {}
    snake.length = 10
    snake.x = 25
    snake.y = 25
    snake.direction = "E"
    
    _G.food = {}
    food.x = math.random(1,799)
    food.y = math.random(1,599)
    food.eaten = false

    _G.score = 0
end

function love.update()
    if food.eaten then
        snake.length = snake.length + 10
        food.x = math.random(1,799)
        food.y = math.random(1,599)
        food.eaten = false
    end

    if snake.direction == "E" then
        snake.x = snake.x + 3
    elseif snake.direction == "W" then
        snake.x = snake.x - 3
    elseif snake.direction == "N" then
        snake.y = snake.y - 3
    elseif snake.direction == "S" then
        snake.y = snake.y + 3
    end

    if love.keyboard.isDown("d") then
        snake.direction = "E"
    elseif love.keyboard.isDown("a") then
        snake.direction = "W"
    elseif love.keyboard.isDown("w") then
        snake.direction = "N"
    elseif love.keyboard.isDown("s") then
        snake.direction = "S"
    end

    if AABB(snake.x, snake.y, 10, 10, food.x, food.y, 10, 10) then
        food.eaten = true
        score = score + 1
    end

    if snake.x <= 0 then
        love.event.quit() 
    elseif snake.x >= 800 then
        love.event.quit() 
    end
    if snake.y <= 0 then
        love.event.quit() 
    elseif snake.y >= 600 then
        love.event.quit() 
    end
end

function love.draw()
    if not food.eaten then
        love.graphics.rectangle("fill", food.x, food.y, 10, 10)
    end

    if snake.direction == "E" then
        love.graphics.rectangle("fill", snake.x, snake.y, snake.length, 10)
    elseif snake.direction == "W" then   
        love.graphics.rectangle("fill", snake.x, snake.y, snake.length, 10)
    elseif snake.direction == "N" then
        love.graphics.rectangle("fill", snake.x, snake.y, 10, snake.length)
    elseif snake.direction == "S" then    
        love.graphics.rectangle("fill", snake.x, snake.y, 10, snake.length)
    end
end