

function love.load()
    anim8 = require('libraries/anim8')

    -- Load Sprites
    love.graphics.setDefaultFilter("nearest", "nearest")
    PixelFont = love.graphics.newFont('assets/fonts/PixelFont.ttf', 24)
    Background = love.graphics.newImage('assets/BackgroundImage.png')



    AttackButtonTable = {}

    AttackButtonTable.AttackButtonSpriteSheet = love.graphics.newImage('assets/AttackButton.png')
    AttackButtonTable.grid = anim8.newGrid(46, 18, AttackButtonTable.AttackButtonSpriteSheet:getWidth(), AttackButtonTable.AttackButtonSpriteSheet:getHeight())
    AttackButtonTable.animations = {}
    AttackButtonTable.animations.pressed = anim8.newAnimation( AttackButtonTable.grid('2-2', 1), 0.2)
    AttackButtonTable.animations.notpressed = anim8.newAnimation( AttackButtonTable.grid('1-1', 1), 0.2)
    AttackButtonTable.anim = AttackButtonTable.animations.notpressed
    

    DefendButtonTable = {}
    DefendButtonTable.DefendButtonSpriteSheet = love.graphics.newImage('assets/DefendButton.png')
    DefendButtonTable.grid = anim8.newGrid(46, 18, DefendButtonTable.DefendButtonSpriteSheet:getWidth(), DefendButtonTable.DefendButtonSpriteSheet:getHeight())
    DefendButtonTable.animations = {}
    DefendButtonTable.animations.pressed = anim8.newAnimation(DefendButtonTable.grid('2-2', 1), 0.2)
    DefendButtonTable.animations.notpressed = anim8.newAnimation(DefendButtonTable.grid('1-1', 1), 0.2)
    DefendButtonTable.anim = DefendButtonTable.animations.notpressed







    LargeTextBox = love.graphics.newImage('assets/LargeTextBox.png')







    
    state = "Player Attack"

    Enemy = {}

    Enemy.y = 176
    Enemy.x = 900
    Enemy.maxHealth = 100
    Enemy.Health = 100
    Enemy.Alive = true
    Enemy.AttackDamage = love.math.random(11, 17)
    Enemy.Sprite = love.graphics.newImage('assets/Ork.png')
    Enemy.Timer = 1

----------------------------------------------
--                PLAYER                    --
----------------------------------------------
    Player = {}
    Player.y = 176
    Player.x = -300
    Player.maxHealth = 100
    Player.Health = 100
    Player.maxXP = 100
    Player.XP = 0
    Player.Defence = 0
    Player.Alive = true
    Player.AttackDamage = love.math.random(14, 20)
    Player.Sprite = love.graphics.newImage('assets/Lucky.png')
    inventory = {
        HealthPotion = {
        name = "HealthPotion",
        quantity = 3,
        description = "Restore 50 HP",
        HealAmount = 50
        }
    }






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

    local EnemyLocalX = 550
    local EnemyLocalY = 176

    Enemy.x = lerp(Enemy.x, EnemyLocalX, 2 * dt)
    Enemy.y = lerp(Enemy.y, EnemyLocalY, 2 * dt)

    local PlayerLocalX = 50
    local PlayerLocalY = 176

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


    love.draw()


-----------------------------------------------------
--                 WIN OR LOSE?                    --
-----------------------------------------------------
    if Enemy.Alive == false then

        state = "BattleWon"
        Enemy.Health = Enemy.maxHealth
        Enemy.y = 176
        Enemy.x = 900
        Player.XP = Player.XP + love.math.random(5, 105)
        Enemy.Alive = true
        inventory.HealthPotion.quantity = inventory.HealthPotion.quantity +1
        AttackButtonTable.anim = AttackButtonTable.animations.notpressed
        DefendButtonTable.anim = DefendButtonTable.animations.notpressed
    end

    if Player.Alive == false then
        state = "Lose"
        Player.Alive = true
        Enemy.Health = Enemy.maxHealth 
        Player.Health = Player.maxHealth
        Player.y = 176
        Player.x = -900
        Enemy.y = 176
        Enemy.x = 900
        Enemy.Alive = true
        AttackButtonTable.anim = AttackButtonTable.animations.notpressed
        DefendButtonTable.anim = DefendButtonTable.animations.notpressed

    end

    EnemyState(dt)
    AttackButtonTable.anim:update(dt)
    DefendButtonTable.anim:update(dt)


    if Player.XP >= Player.maxXP then
        Player.XP = 0
        Player.maxXP = Player.maxXP * 1.05
        Player.maxHealth = Player.maxHealth + 10
        inventory.HealthPotion.quantity = inventory.HealthPotion.quantity + 1
    end


end

function love.keypressed(key)
    if key == "return" then
        usePotion()
    end
end






















---------------------------------------------------------------------------------------------------------------
--                                           DRAW FUNCTION                                                   --
---------------------------------------------------------------------------------------------------------------
function love.draw()
    love.graphics.setFont(PixelFont)
    love.graphics.draw(Background, 0, 0, 0, 14)

    --Draw UI
    love.graphics.draw(LargeTextBox, 0, 400, 0, 6.25, 3.25)


    if Enemy.Alive then    
        love.graphics.draw(Enemy.Sprite, Enemy.x, Enemy.y, nil, 3.5)
    end

    if Player.Alive then
    love.graphics.draw(Player.Sprite, Player.x, Player.y, nil, 3.5)
    end

    love.graphics.setColor(100, 100, 100)
-----------------------------------------------------
--                HEALTH BARS                      --
-----------------------------------------------------
    if Player.Alive then    
    love.graphics.print(Player.Health .."/" ..Player.maxHealth .." HP", Player.x, 200, 0, 1, 1)
    end

    if Player.Alive then    
    love.graphics.print(Player.XP .."/" ..Player.maxXP .."XP", Player.x, 158, 0, 1, 1)
    end

    if Enemy.Alive then
        love.graphics.print(Enemy.Health .."/" ..Enemy.maxHealth .." HP", Enemy.x, 200, 0, 1, 1)
    end


    love.graphics.print("HealthPotion: " .. inventory.HealthPotion.quantity, 40, 450)
    love.graphics.print(inventory.HealthPotion.description, 40, 480)
    love.graphics.print("Press Enter to use Heal Potion", 40, 540)




------------------------------------------------------------------------------------------------------
--                                      Player HEALTHBAR                                            --
------------------------------------------------------------------------------------------------------

    love.graphics.setColor(0, 0.4, 0)  
    love.graphics.rectangle("fill", Player.x, Player.y, 200, 20)  


    love.graphics.setColor(0, 0.8, 0)  
    local healthWidth = (Player.Health / Player.maxHealth) * 200
    love.graphics.rectangle("fill", Player.x, Player.y, healthWidth, 20)


    love.graphics.setColor(1, 1, 1)

------------------------------------------------------------------------------------------------------
--                                      Player XP Bar                                               --
------------------------------------------------------------------------------------------------------


    love.graphics.setColor(0.4, 0, 0.4)  
    love.graphics.rectangle("fill", Player.x, Player.y - 40, 200, 20)  


    love.graphics.setColor(0.8, 0, 0.8)  
    local xpWidth = (Player.XP / Player.maxXP) * 200
    love.graphics.rectangle("fill", Player.x, Player.y - 40, xpWidth, 20)


    love.graphics.setColor(1, 1, 1)
------------------------------------------------------------------------------------------------------
--                                  ENEMY HEALTHBAR                                                 --
------------------------------------------------------------------------------------------------------
    
    love.graphics.setColor(0.4, 0, 0)  
    love.graphics.rectangle("fill", Enemy.x, Enemy.y, 200, 20)  
    love.graphics.setColor(0.8, 0, 0)  
    local healthWidth = (Enemy.Health / Enemy.maxHealth) * 200
    love.graphics.rectangle("fill", Enemy.x, Enemy.y, healthWidth, 20)


    love.graphics.setColor(1, 1, 1)



-----------------------------------------------------
--               WIN LOSE TEXT                     --
-----------------------------------------------------
    if state == "BattleWon" then
        love.graphics.print("You Won", 350, 300)
        state = "Player Attack"
    end

    if state == "Lose" then
        love.graphics.print("You Lose", 350, 300)
        state = "Player Attack"
    end




-----------------------------------------------------
--               DRAW BUTTONS                      --
-----------------------------------------------------

    AttackButtonTable.anim:draw(AttackButtonTable.AttackButtonSpriteSheet, 610, 430, 0, 3.25)
    DefendButtonTable.anim:draw(DefendButtonTable.DefendButtonSpriteSheet, 610, 500, 0, 3.25)
end


function love.mousepressed(x, y, button)
    if state == "Player Attack" then
        if button == 1 then
            if x >= AttackbuttonX and x <= AttackbuttonX + AttackbuttonWidth
            and y >= AttackbuttonY and y <= AttackbuttonY + AttackbuttonHeight then
                if Player.Alive then
                    AttackButtonTable.anim = AttackButtonTable.animations.pressed
                    Enemy.Health = Enemy.Health -Player.AttackDamage
                    state = "Enemy Attack"
                    
                end
            end
    
            if x >= DefendbuttonX and x <= DefendbuttonX + DefendbuttonWidth
            and y >= DefendbuttonY and y <= DefendbuttonY + DefendbuttonHeight then
                if Player.Alive then
                    DefendButtonTable.anim = DefendButtonTable.animations.pressed
                    Player.Defence = Player.Defence + love.math.random(8, 10,14)
                    state = "Enemy Attack"
                end
            end
        end
    end
end





function EnemyState(dt)
    if state == "Enemy Attack" then
        if state ~= "Player Attack" then 
            if Enemy.Timer > 0 then
                Enemy.Timer = Enemy.Timer - dt
            end
            if Enemy.Timer <= 0 then
                AttackButtonTable.anim = AttackButtonTable.animations.notpressed
                DefendButtonTable.anim = DefendButtonTable.animations.notpressed
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
            state = "Player Attack"
            Enemy.Timer = 1
        end
    end
end




function usePotion()
    if Player.Health < 100 then

        local item = inventory["HealthPotion"]  -- immer HealthPotion
        if item and item.quantity > 0 then
            -- Spieler heilen
            Player.Health = math.min(Player.Health + item.HealAmount, Player.maxHealth)
            -- Menge reduzieren
            item.quantity = item.quantity - 1
            print(item.name .. " used! Player health: " .. Player.Health)
        else
            print("No HealthPotion left!")
        end
    end
end
