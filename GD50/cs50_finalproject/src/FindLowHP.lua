--[[
    GD50
    Final Project

    Author: Nathan Evangelista
    npevangelista@ucdavis.edu

    -Initial Enemy AI, finds closest enemy to target, if enemies are same range then defaults to priority 1.
]]

--[[
    GD50
    Final Project

    Author: Nathan Evangelista
    npevangelista@ucdavis.edu

    -Test Enemy AI, finds lowest HP enemy to target.
]]

function FindLowHP(enemy, levelStage, index, combatMenu)
    local targetHeroIndex = 1
    local tempHPCurrent = 1000000
    local checkMove = false
    local checkRange = false
    local deadUnit = false
    local moveX = 0
    local moveY = 0
    for i, hero in pairs(levelStage.entities) do
        local tempHP = levelStage.entities[i].currentHP
        if tempHP < tempHPCurrent then
            targetHeroIndex = i
            tempHPCurrent = tempHP
        end
    end


    local relativeX = levelStage.entities[targetHeroIndex].x - enemy.x
    local relativeY = levelStage.entities[targetHeroIndex].y - enemy.y

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
    Timer.tween(0.5, {
        [enemy] = {x = enemy.x + moveX, y = enemy.y + moveY},
    })
    enemy.x = enemy.x + moveX
    enemy.y = enemy.y + moveY
    checkRange = CheckRange(enemy, levelStage.entities[targetHeroIndex])
    if checkRange == true then
        deadUnit = CombatCalculator(enemy, levelStage.entities[targetHeroIndex], levelStage, combatMenu)
        if deadUnit == true then
            if enemy.currentHP < 1 then
                table.remove(levelStage.enemies, index)
            end
            if levelStage.entities[targetHeroIndex].currentHP < 1 then
                table.remove(levelStage.entities, targetHeroIndex)
            end
        end
    end
end