function love.load()
    love.graphics.setDefaultFilter("nearest", "nearest")

    character = {}
    character.x = 800
    character.y = -400
    character.speed = 200 -- Pixel pro Sekunde
    character.sprite = love.graphics.newImage('assets/GoblinGirl.png')

    -- Zielkoordinaten
    targetX = 400
    targetY = 200
end

function love.update(dt)
    -- Unterschied zwischen Ziel und aktueller Position
    local dx = targetX - character.x
    local dy = targetY - character.y

    -- Abstand berechnen
    local distance = math.sqrt(dx*dx + dy*dy)

    -- Nur bewegen, wenn noch nicht am Ziel
    if distance > 1 then
        -- Normalisierte Richtung
        local dirX = dx / distance
        local dirY = dy / distance

        -- Bewegung
        character.x = character.x + dirX * character.speed * dt
        character.y = character.y + dirY * character.speed * dt
    end
end

function love.draw()
    love.graphics.draw(character.sprite, character.x, character.y, 0, 4, 4)
end