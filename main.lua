<<<<<<< HEAD
<<<<<<<< HEAD:main.lua
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
========
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

>>>>>>>> a49115d28e735aec574f4a52fd2e52a5ca8d5947:LegendOfGoblins/main.lua
=======
function love.load()
    love.graphics.setDefaultFilter("nearest", "nearest")



    
    state = "Player Attack"



    Enemy = {}

    Enemy.y = -150
    Enemy.x = 800
    Enemy.Health = 100
    Enemy.Alive = true
    Enemy.AttackDamage = love.math.random(10, 15)

    Player = {}

    Player.y = 600
    Player.x = -100
    Player.Health = 100
    Player.Alive = true
    Player.AttackDamage = love.math.random(10, 16)


end

function lerp(a, b, t)
    return a + (b - a) * t
end



function love.update(dt)


    local EnemyLocalX = 600
    local EnemyLocalY = 100

    Enemy.x = lerp(Enemy.x, EnemyLocalX, 2 * dt)
    Enemy.y = lerp(Enemy.y, EnemyLocalY, 2 * dt)

    local PlayerLocalX = 50
    local PlayerLocalY = 400

    Player.x = lerp(Player.x, PlayerLocalX, 2 * dt)
    Player.y = lerp(Player.y, PlayerLocalY, 2 * dt)

    if Enemy.Health < 1 then
        Enemy.Alive = false
    end

    if Player.Health < 1 then
        Player.Alive = false
    end




end

function love.draw()
    love.graphics.setColor(100, 0, 0)


    if Enemy.Alive then    
        love.graphics.rectangle('fill', Enemy.x, Enemy.y, 100, 100)
    end

    love.graphics.setColor(0, 0, 100)

    if Player.Alive then
    love.graphics.rectangle('fill', Player.x, Player.y, 100, 100)
    end

    love.graphics.setColor(100, 100, 100)

    if Player.Alive then    
    love.graphics.print(Player.Health, 80, 350, 0, 2, 2)
    end

    if Enemy.Alive then
        love.graphics.print(Enemy.Health, 630, 50, 0, 2, 2)
    end

    

    love.graphics.rectangle("line", 400, 400, 100, 40)
    love.graphics.print("Attack", 410, 410, 0, 2, 2)
end


function love.mousepressed(x, y, button)
    if button == 1 then
        if x > 400 and x < 450 and y > 400 and y < 440 then
            if Player.Alive then
                Enemy.Health = Enemy.Health -Player.AttackDamage
                state = "Enemy Attack"
                EnemyState()
            end
        end
    end
end




function EnemyState()
        if Enemy.Alive then
            Player.Health = Player.Health - Enemy.AttackDamage
            State = "Player Attack"
        end
    
end
>>>>>>> a49115d28e735aec574f4a52fd2e52a5ca8d5947
