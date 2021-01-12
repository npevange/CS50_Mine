--[[
    GD50
    Final Project

    Author: Nathan Evangelista
    npevangelista@ucdavis.edu
]]

function FindClosestHero(enemy, levelStage, index)
    local closestHeroIndex = 1
    local distance = 10000
    local checkMove = false
    local checkRange = false
    local deadUnit = false
    local moveX = 0
    local moveY = 0
    for i, hero in pairs(levelStage.entities) do
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
        moveX = 0
        moveY = enemy.Move
        -- Movement
        if math.abs(relativeY) < (enemy.Move + enemy.Range) then
            moveY = math.abs(relativeY)
        end
        if relativeY < 0 then
            moveY = moveY * -1
        end

    -- Horizontal
    elseif relativeY == 0 then
        moveX = enemy.Move
        moveY = 0
        if math.abs(relativeX) < (enemy.Move + enemy.Range) then
            moveX = math.abs(relativeX)
        end
        if relativeX < 0 then
            moveX = moveX * -1
        end

    -- Triangles
    else
        -- Triangle math
        local hypotenuse = math.sqrt((relativeX ^ 2) + (relativeY ^ 2))
        moveX = (relativeX * enemy.Move) / hypotenuse
        moveY = (relativeY * enemy.Move) / hypotenuse
        if math.abs(relativeX) + math.abs(relativeY) < (enemy.Move + enemy.Range) then
            moveX = relativeX
            moveY = relativeY
        end
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
        deadUnit = CombatCalculator(enemy, levelStage.entities[closestHeroIndex], levelStage)
        if deadUnit == true then
            if enemy.currentHP < 1 then
                table.remove(levelStage.enemies, index)
            end
            if levelStage.entities[closestHeroIndex].currentHP < 1 then
                table.remove(levelStage.entities, closestHeroIndex)
            end
        end
    end
end