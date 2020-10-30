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
        local moveX = 0
        local moveY = enemy.Move
        if relativeY > 0 then -- Case 1: Hero out of range(Move plus attack range)
            if relativeY > (enemy.Move + enemy.Range) then
                checkMove = CheckMove(enemy, moveX, moveY, levelStage) -- Check if this move is in range and won't land on an allied unit.
                while(checkMove == false) do
                    moveX, moveY = AdjustMove(enemy, moveX, moveY, levelStage)
                    checkMove = CheckMove(enemy, moveX, moveY, levelStage)
                    if moveX == 0 and moveY == 0 then
                        break
                    end
                end
                enemy.x = enemy.x + moveX
                enemy.y = enemy.y + moveY
            else -- Case 2: Hero is in range(Move + attack)
                checkMove = CheckMove(enemy, moveX, (relativeY - enemy.Range), levelStage)
                while(checkMove == false) do
                    moveX, moveY = AdjustMove(enemy, moveX, moveY, levelStage)
                    checkMove = CheckMove(enemy, moveX, moveY, levelStage)
                    if moveX == 0 and moveY == 0 then
                        break
                    end
                end
                enemy.y = enemy.y + (relativeY - enemy.Range)
                checkRange = CheckRange(enemy, levelStage.entities[closestHeroIndex])
                if checkRange == true then
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
        else -- RelativeY < 0 -- Case 1: Hero out of range(Move plus attack range)
            if math.abs(relativeY) > (enemy.Move + enemy.Range) then
                checkMove = CheckMove(enemy, moveX, moveY, levelStage) -- Check if this move is in range and won't land on an allied unit.
                while(checkMove == false) do
                    moveX, moveY = AdjustMove(enemy, moveX, moveY, levelStage)
                    checkMove = CheckMove(enemy, moveX, moveY, levelStage)
                    if moveX == 0 and moveY == 0 then
                        break
                    end
                end
                enemy.x = enemy.x + moveX
                enemy.y = enemy.y + moveY
            else -- Case 2: Hero is in range(Move + attack)
                checkMove = CheckMove(enemy, moveX, (relativeX + enemy.Range), levelStage)
                while(checkMove == false) do
                    moveX, moveY = AdjustMove(enemy, moveX, moveY, levelStage)
                    checkMove = CheckMove(enemy, moveX, moveY, levelStage)
                    if moveX == 0 and moveY == 0 then
                        break
                    end
                end
                enemy.y = enemy.y + (relativeY + enemy.Range)
                -- enemy.y = enemy.y - (math.abs(relativeY) - enemy.Range)
                checkRange = CheckRange(enemy, levelStage.entities[closestHeroIndex])
                if checkRange == true then
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

    -- Horizontal
    elseif relativeY == 0 then
        local moveX = enemy.Move
        local moveY = 0
        if relativeX > 0 then -- Case 1: Hero out of range(Move plus attack range)
            if relativeX > (enemy.Move + enemy.Range) then
                enemy.y = enemy.y + enemy.Move
            else -- Case 2: Hero is in range(Move + attack)
                enemy.y = enemy.y + (relativeX - enemy.Range)
                checkRange = CheckRange(enemy, levelStage.entities[closestHeroIndex])
                if checkRange == true then
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
        else -- RelativeX < 0 -- Case 1: Hero out of range(Move plus attack range)
            if math.abs(relativeX) > (enemy.Move + enemy.Range) then
                enemy.y = enemy.y - enemy.Move
            else -- Case 2: Hero is in range(Move + attack)
                enemy.y = enemy.y - (math.abs(relativeX) - enemy.Range)
                checkRange = CheckRange(enemy, levelStage.entities[closestHeroIndex])
                if checkRange == true then
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
    -- Triangles
    else
        -- Triangle math
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

        if (math.abs(moveX) + math.abs(moveY) + math.abs(enemy.Range)) < distance then -- Case 1: Hero is out of range (Move plus attack range)
            checkMove = CheckMove(enemy, moveX, moveY, levelStage) -- Check if this move is in range and won't land on an allied unit.
            while(checkMove == false) do
                moveX, moveY = AdjustMove(enemy, moveX, moveY, levelStage)
                checkMove = CheckMove(enemy, moveX, moveY, levelStage)
                if moveX == 0 and moveY == 0 then
                    break
                end
            end
            enemy.x = enemy.x + moveX
            enemy.y = enemy.y + moveY
        else -- Case 2: Hero is in range (Move + attack)
            moveX = relativeX
            moveY = relativeY
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
end