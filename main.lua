function love.load()
    love.graphics.setDefaultFilter("nearest", "nearest")

    character = {}
    character.x = 800
    character.y = 150
    character.speed = 200 
    character.sprite = love.graphics.newImage('assets/GoblinGirl.png')

    
    targetX = 550
    targetY = 150
end

function love.update(dt)
    
    local dx = targetX - character.x
    local dy = targetY - character.y

    
    local distance = math.sqrt(dx*dx + dy*dy)

    
    if distance > 1 then
        
        local dirX = dx / distance
        local dirY = dy / distance

        
        character.x = character.x + dirX * character.speed * dt
        character.y = character.y + dirY * character.speed * dt
    end
end

function love.draw()
    love.graphics.draw(character.sprite, character.x, character.y, 0, 4, 4)
end 