--[[
    GD50
    Final Project

    Author: Nathan Evangelista
    npevangelista@ucdavis.edu
]]

--NOTE
-- Need to normalize the moveX, moveY for + / - 

function FindClosestHero(enemy, levelStage, index)
    local closestHeroIndex = 1
    local distance = 10000
    local checkMove = false
    local checkRange = false
    local deadUnit = false
    for i, hero in pairs(levelStage.entities) do
        love.window.setTitle(string.format("Check hero"))
        local tempDistanceX = enemy.x - levelStage.entities[i].x
        local tempDistanceY = enemy.y - levelStage.entities[i].y
        local tempDistance = math.abs(tempDistanceX) + math.abs(tempDistanceY)
        if tempDistance < distance then
            closestHeroIndex = i
            distance = tempDistance
        end
    end
    local relativeX = levelStage.entities[closestHeroIndex].x - enemy.x
    local relativeY = levelStage.entities[closestHeroIndex].y - enemy.y


    -- Vertical
    if relativeX == 0 then
        love.window.setTitle(string.format("Vert".. index))
        local moveX = 0
        local moveY = enemy.Move
        if relativeY < 0 then
            moveY = moveY * -1
        end
        -- Movement
        checkMove = CheckMove(enemy, moveX, moveY, levelStage)
        -- STUCK IN LOOP

        while(checkMove == false) do
            moveX, moveY = AdjustMove(enemy, moveX, moveY, levelStage)
            checkMove = CheckMove(enemy, moveX, moveY, levelStage)
            if moveX == 0 and moveY == 0 then
                break
            end
        end
        enemy.x = enemy.x + moveX
        enemy.y = enemy.y + moveY
        -- Attack if Possible
        checkRange = CheckRange(enemy, levelStage.entities[closestHeroIndex])
        if checkRange == true then
            love.window.setTitle(string.format("Vert Combat" .. index))
            deadUnit = CombatCalculator(enemy, levelStage.entities[closestHeroIndex], levelStage)
            if deadUnit == true then
                if enemy.HP < 1 then
                    table.remove(levelStage.enemies, index)
                end
                if levelStage.entities[closestHeroIndex].HP < 1 then
                    table.remove(levelStage.entities, closestHeroIndex)
                end
            end
        end

    -- Horizontal
    elseif relativeY == 0 then
        love.window.setTitle(string.format("Horiz" .. index))
        local moveX = enemy.Move
        local moveY = 0
        if relativeX < 0 then
            moveX = moveX * -1
        end
        -- Movement
        checkMove = CheckMove(enemy, moveX, moveY, levelStage)
        while(checkMove == false) do
            moveX, moveY = AdjustMove(enemy, moveX, moveY, levelStage)
            checkMove = CheckMove(enemy, moveX, moveY, levelStage)
            if moveX == 0 and moveY == 0 then
                break
            end
        end
        enemy.x = enemy.x + moveX
        enemy.y = enemy.y + moveY
        -- Attack if Possible
        checkRange = CheckRange(enemy, levelStage.entities[closestHeroIndex])
        if checkRange == true then
            love.window.setTitle(string.format("Horiz Combat" .. index))
            deadUnit = CombatCalculator(enemy, levelStage.entities[closestHeroIndex], levelStage)
            if deadUnit == true then
                if enemy.HP < 1 then
                    table.remove(levelStage.enemies, index)
                end
                if levelStage.entities[closestHeroIndex].HP < 1 then
                    table.remove(levelStage.entities, closestHeroIndex)
                end
            end
        end

    -- Triangles
    else
        -- Triangle math
        love.window.setTitle(string.format("Triangle Math" .. index))
        local hypotenuse = math.sqrt((relativeX ^ 2) + (relativeY ^ 2))
        local moveX = (relativeX * enemy.Move) / hypotenuse
        local moveY = (relativeY * enemy.Move) / hypotenuse
        if moveX > 0 then
            moveX = math.floor(moveX)
        else
            moveX = math.ceil(moveX)
        end
        if moveY > 0 then
            moveY = math.floor(moveY)
        else
            moveY = math.ceil(moveY)
        end
        checkMove = CheckMove(enemy, moveX, moveY, levelStage)
        while(checkMove == false) do
            moveX, moveY = AdjustMove(enemy, moveX, moveY, levelStage)
            checkMove = CheckMove(enemy, moveX, moveY, levelStage)
            if moveX == 0 and moveY == 0 then
                break
            end
        end
        enemy.x = enemy.x + moveX
        enemy.y = enemy.y + moveY
        checkRange = CheckRange(enemy, levelStage.entities[closestHeroIndex])
        if checkRange == true then
            love.window.setTitle(string.format("Tri Combat" .. index))
            deadUnit = CombatCalculator(enemy, levelStage.entities[closestHeroIndex], levelStage)
            if deadUnit == true then
                if enemy.HP < 1 then
                    table.remove(levelStage.enemies, index)
                end
                if levelStage.entities[closestHeroIndex].HP < 1 then
                    table.remove(levelStage.entities, closestHeroIndex)
                end
            end
        end
    end
end