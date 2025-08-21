function love.load()
    love.graphics.setDefaultFilter("nearest", "nearest")

    Enemy = {}

    Enemy.y = -150
    Enemy.x = 800

    Player = {}

    Player.y = 600
    Player.x = -100



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

end

function love.draw()
    love.graphics.setColor(100, 0, 0)

    love.graphics.rectangle('fill', Enemy.x, Enemy.y, 100, 100)

    love.graphics.setColor(0, 0, 100)

    love.graphics.rectangle('fill', Player.x, Player.y, 100, 100)
end 