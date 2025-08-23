

function love.load()
    anim8 = require('libraris/anim8')

    -- Load Sprites
    love.graphics.setDefaultFilter("nearest", "nearest")
    PixelFont = love.graphics.newFont('assets/fonts/PixelFont.ttf', 24)






    AttackButtonSpriteSheet = love.graphics.newImage('assets/AttackButton.png')




    
    DefendButtonSprite = love.graphics.newImage('assets/DefendButton.png')









    LargeTextBox = love.graphics.newImage('assets/LargeTextBox.png')







    
    state = "Player Attack"

    Enemy = {}

    Enemy.y = 300
    Enemy.x = 900
    Enemy.Health = 100
    Enemy.Alive = true
    Enemy.AttackDamage = love.math.random(10, 16)
    Enemy.Timer = 0.5



    Player = {}

    Player.y = 300
    Player.x = -300
    Player.Health = 100
    Player.Defence = 0
    Player.Alive = true
    Player.AttackDamage = love.math.random(14, 20)



    DefendbuttonX = 610
    DefendbuttonY = 500
    DefendbuttonWidth = 46 * 3.25
    DefendbuttonHeight = 16 * 3.25

    AttackbuttonX = 610
    AttackbuttonY = 410
    AttackbuttonWidth = 46 * 3.25  
    AttackbuttonHeight = 16 * 3.25

end

function lerp(a, b, t)
    return a + (b - a) * t
end



function love.update(dt)
-------------------------------------------------------
--                      INTRO                        --
-------------------------------------------------------

    local EnemyLocalX = 600
    local EnemyLocalY = 300

    Enemy.x = lerp(Enemy.x, EnemyLocalX, 2 * dt)
    Enemy.y = lerp(Enemy.y, EnemyLocalY, 2 * dt)

    local PlayerLocalX = 100
    local PlayerLocalY = 300

    Player.x = lerp(Player.x, PlayerLocalX, 2 * dt)
    Player.y = lerp(Player.y, PlayerLocalY, 2 * dt)
-----------------------------------------------------
--                  DEATH CHECK                    --
-----------------------------------------------------

    if Enemy.Health < 1 then
        Enemy.Alive = false
    end

    if Player.Health < 1 then
        Player.Alive = false
    end




-----------------------------------------------------
--                 WIN OR LOSE?                    --
-----------------------------------------------------
    if Enemy.Alive == false then

        state = "BattleWon"
        Enemy.Health = 100
        Player.Health = 100
        Player.y = 300
        Player.x = -800
        Enemy.y = 300
        Enemy.x = 900
        Enemy.Alive = true
    end

    if Player.Alive == false then
        state = "Lose"
        Player.Alive = true
        Enemy.Health = 100
        Player.Health = 100
        Player.y = 300
        Player.x = -900
        Enemy.y = 300
        Enemy.x = 900
        Enemy.Alive = true   

    end

    EnemyState(dt)
end

function love.draw()
    love.graphics.setFont(PixelFont)

    --Draw UI
    love.graphics.draw(LargeTextBox, 0, 400, 0, 6.25, 3)

    love.graphics.setColor(100, 0, 0)

    if Enemy.Alive then    
        love.graphics.rectangle('fill', Enemy.x, Enemy.y, 100, 100)
    end

    love.graphics.setColor(0, 0, 100)

    if Player.Alive then
    love.graphics.rectangle('fill', Player.x, Player.y, 100, 100)
    end

    love.graphics.setColor(100, 100, 100)
-----------------------------------------------------
--                HEALTH BARS                      --
-----------------------------------------------------
    if Player.Alive then    
    love.graphics.print("HP " ..Player.Health, 130, 150, 0, 1, 1)
    end

    if Enemy.Alive then
        love.graphics.print("HP " ..Enemy.Health, 630, 150, 0, 1, 1)
    end






-----------------------------------------------------
--               WIN LOSE TEXT                     --
-----------------------------------------------------
    if state == "BattleWon" then
        love.graphics.print("You Won", 350, 300)
    end

    if state == "Lose" then
        love.graphics.print("You Lose", 350, 300)
    end




-----------------------------------------------------
--               DRAW BUTTONS                      --
-----------------------------------------------------

    love.graphics.draw(AttackButtonSprite, 610, 430, 0, 3.25, 3.25)
    love.graphics.draw(DefendButtonSprite, 610, 500, 0, 3.25, 3.25)
end


function love.mousepressed(x, y, button)
    if state == "Player Attack" then
        if button == 1 then
            if x >= AttackbuttonX and x <= AttackbuttonX + AttackbuttonWidth
            and y >= AttackbuttonY and y <= AttackbuttonY + AttackbuttonHeight then
                if Player.Alive then
                    Enemy.Health = Enemy.Health -Player.AttackDamage
                    state = "Enemy Attack"
                end
            end
    
            if x >= DefendbuttonX and x <= DefendbuttonX + DefendbuttonWidth
            and y >= DefendbuttonY and y <= DefendbuttonY + DefendbuttonHeight then
                if Player.Alive then

                    Player.Defence = Player.Defence + love.math.random(8, 10,14)
                    state = "Enemy Attack"
                end
            end
        end
    end
end





function EnemyState(dt)
    if state == "Enemy Attack" then
        if state ~= "Player Attack" then  -- Schreibweise angleichen
            if Enemy.Timer > 0 then
                Enemy.Timer = Enemy.Timer - dt
            end
            if Enemy.Timer <= 0 then
                EnemyAttacking()
            end
        end
    end
end

function EnemyAttacking()
    if Enemy.Alive then
        if state == "Enemy Attack" then
            Player.Health = Player.Health - Enemy.AttackDamage + Player.Defence
            Player.Defence = 0
            state = "Player Attack"  -- klein schreiben, wie oben geprüft
            Enemy.Timer = 0.5
        end
    end
end