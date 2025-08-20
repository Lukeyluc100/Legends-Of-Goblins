function love.load()
     love.graphics.setDefaultFilter("nearest", "nearest")


    character = {}
    character.x = 100
    character.y = 100
    character.sprite = love.graphics.newImage('assets/GoblinGirl.png')










end

function love.update(dt)
end

function love.draw()
    love.graphics.draw(character.sprite, character.y, character.x , 0 , 4, 4)
end

