

function love.load()
    love.graphics.setDefaultFilter("nearest", "nearest")

    PixelFont = love.graphics.newFont('assets/fonts/PixelFont.ttf', 24)
    AttackButtonSprite = love.graphics.newImage('assets/AttackButton.png')
    DefendButtonSprite = love.graphics.newImage('assets/DefendButton.png')

    print(PixelFont:hasGlyphs("0123456789"))

    
    state = "Player Attack"

    Enemy = {}

    Enemy.y = -150
    Enemy.x = 800
    Enemy.Health = 100
    Enemy.Alive = true
    Enemy.AttackDamage = love.math.random(10, 16)

    Player = {}

    Player.y = 600
    Player.x = -100
    Player.Health = 100
    Player.Defence = 0
    Player.Alive = true
    Player.AttackDamage = love.math.random(10, 16)



    DefendbuttonX = 400
    DefendbuttonY = 450
    DefendbuttonWidth = 46 * 2  -- 92
    DefendbuttonHeight = 16 * 2 -- 32


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

    if Enemy.Alive == false then

        state = "BattleWon"
        Enemy.Health = 100
        Player.y = 600
        Player.x = -100
        Enemy.y = -150
        Enemy.x = 800
        Enemy.Alive = true
    end

    if Player.Alive == false then
        state = "Lose"
        Player.Alive = true
        Enemy.Health = 100
        Player.Health = 100
        Player.y = 600
        Player.x = -100
        Enemy.y = -150
        Enemy.x = 800
        Enemy.Alive = true   

    end


end

function love.draw()
    love.graphics.setColor(100, 0, 0)
    love.graphics.setFont(PixelFont)


    if Enemy.Alive then    
        love.graphics.rectangle('fill', Enemy.x, Enemy.y, 100, 100)
    end

    love.graphics.setColor(0, 0, 100)

    if Player.Alive then
    love.graphics.rectangle('fill', Player.x, Player.y, 100, 100)
    end

    love.graphics.setColor(100, 100, 100)

    if Player.Alive then    
    love.graphics.print(Player.Health, 80, 350, 0, 1, 1)
    end

    if Enemy.Alive then
        love.graphics.print(Enemy.Health, 630, 50, 0, 1, 1)
    end

    if state == "BattleWon" then
        love.graphics.print("You Won", 400, 300)
    end

    if state == "Lose" then
        love.graphics.print("You Lose", 400, 300)
    end

    love.graphics.draw(AttackButtonSprite, 400, 400, 0, 2, 2)
    love.graphics.draw(DefendButtonSprite, 400, 450, 0, 2, 2)
end


function love.mousepressed(x, y, button)
    if button == 1 then
        if x > 400 and x < 600 and y > 400 and y < 420 then
            if Player.Alive then
                Enemy.Health = Enemy.Health -Player.AttackDamage
                state = "Enemy Attack"
                EnemyState()
            end
        end
    
        if x >= DefendbuttonX and x <= DefendbuttonX + DefendbuttonWidth
        and y >= DefendbuttonY and y <= DefendbuttonY + DefendbuttonHeight then
            if Player.Alive then

                Player.Defence = Player.Defence + love.math.random(5,10)
                state = "Enemy Attack"
                EnemyState()
            end
        end
    end


end





function EnemyState()
        if Enemy.Alive then
            
            Player.Health = Player.Health - Enemy.AttackDamage + Player.Defence
            Player.Defence = 0
            State = "Player Attack"
        end
    
end

