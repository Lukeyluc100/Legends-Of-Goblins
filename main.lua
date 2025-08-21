function love.load()
     love.graphics.setDefaultFilter("nearest", "nearest")


    character = {}
    character.sprite = love.graphics.newImage('assets/GoblinGirl.png')





    dialog = {
        "Hello",
        "Who are you?",
        "Whats you name?",
        "I Have A Quest For You."
    }
    choice = {
        "Just A Random traveler",
        "A Hero",
        "Did you need Something?",
        "Lucky",

    }





    currentDialogLine = 1
    currentTravelerLine = 1  -- Start mit der ersten Zeile
end

function love.update(dt)
end

function love.draw()
    love.graphics.print(dialog[currentDialogLine], 400, 300)
    love.graphics.print(choice[currentTravelerLine], 400, 400)
    love.graphics.print(choice[currentTravelerLine+ 1], 400, 450)
    love.graphics.draw(character.sprite, 100, 100, 0 , 4, 4)
end

function love.keypressed(key)
    if key == "1" then
        currentDialogLine = currentDialogLine +1
        currentTravelerLine = currentTravelerLine+2
    end

    if key == "2" then
        currentDialogLine = currentDialogLine +2
    end


end