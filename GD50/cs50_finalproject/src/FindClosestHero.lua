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
        love.window.setTitle(string.format("Vert"))
        local moveX = 0
        local moveY = enemy.Move
        if relativeY < 0 then
            moveY = moveY * -1
        end
        if relativeY > 0 then -- Case 1: Hero out of range(Move plus attack range)
            love.window.setTitle(string.format("Vert-O of R"))
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
                love.window.setTitle(string.format("Vert In Range"))
                checkMove = CheckMove(enemy, moveX, (relativeY - enemy.Range), levelStage)
                love.window.setTitle(string.format("Vert Check Move"))
                while(checkMove == false) do
                    moveX, moveY = AdjustMove(enemy, moveX, moveY, levelStage)
                    checkMove = CheckMove(enemy, moveX, moveY, levelStage)
                    if moveX == 0 and moveY == 0 then
                        break
                    end
                end
                -- enemy.y = enemy.y + (relativeY - enemy.Range)
                checkRange = CheckRange(enemy, levelStage.entities[closestHeroIndex])
                love.window.setTitle(string.format("Vert Check Range"))
                if checkRange == true then
                    love.window.setTitle(string.format("Vert Combat"))
                    deadUnit = CombatCalculator(enemy, levelStage.entities[closestHeroIndex], levelStage)
                    if deadUnit == true then
                        if enemy.HP < 1 then
                            love.window.setTitle(string.format("Vert Kill Hero"))
                            table.remove(levelStage.enemies, index)
                        end
                        if levelStage.entities[closestHeroIndex].HP < 1 then
                            table.remove(levelStage.entities, closestHeroIndex)
                        end
                    end
                end
            end
        else -- RelativeY < 0 -- Case 1: Hero out of range(Move plus attack range)
            love.window.setTitle(string.format("Vert Out of Range + Move"))
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
                love.window.setTitle(string.format("Vert In Range + Move" .. index))
                checkMove = CheckMove(enemy, moveX, (relativeX + enemy.Range), levelStage)
                while(checkMove == false) do
                    moveX, moveY = AdjustMove(enemy, moveX, moveY, levelStage)
                    checkMove = CheckMove(enemy, moveX, moveY, levelStage)
                    if moveX == 0 and moveY == 0 then
                        break
                    end
                end
                enemy.x = enemy.x + moveX
                enemy.y = enemy.y + moveY

                love.window.setTitle(string.format("Vert In Range + Move --> Check Range" .. index))
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
        love.window.setTitle(string.format("Horiz"))
        local moveX = enemy.Move
        local moveY = 0
        if relativeX < 0 then
            moveX = moveX * -1
        end
        if relativeX > 0 then -- Case 1: Hero out of range(Move plus attack range)
            love.window.setTitle(string.format("Horiz O of R"))
            if relativeX > (enemy.Move + enemy.Range) then
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
                love.window.setTitle(string.format("Horiz In Range"))
                -- enemy.y = enemy.y + (relativeX - enemy.Range)
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
            love.window.setTitle(string.format("Horiz Out of Range"))
            if math.abs(relativeX) > (enemy.Move + enemy.Range) then
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
                love.window.setTitle(string.format("Horiz In Range 2"))
                -- enemy.x = enemy.x - (math.abs(relativeX) - enemy.Range)
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
            -------------------------------------------
            -- ERROR HERE PROBLEM THIS IS IT PROBLEM --
            -------------------------------------------
            checkMove = CheckMove(enemy, moveX, moveY, levelStage)
            love.window.setTitle(string.format("Checking Move"))
            while(checkMove == false) do
                moveX, moveY = AdjustMove(enemy, moveX, moveY, levelStage)
                love.window.setTitle(string.format("Adjust Move" .. index))
                checkMove = CheckMove(enemy, moveX, moveY, levelStage)
                if moveX == 0 and moveY == 0 then
                    love.window.setTitle(string.format("Loop Break"))
                    break
                end
            end
            enemy.x = enemy.x + moveX
            enemy.y = enemy.y + moveY
            checkRange = CheckRange(enemy, levelStage.entities[closestHeroIndex])
            -- love.window.setTitle(string.format("Check Range"))
            if checkRange == true then
                -- love.window.setTitle(string.format("Enemy Combat Calc"))
                deadUnit = CombatCalculator(enemy, levelStage.entities[closestHeroIndex], levelStage)
                -- love.window.setTitle(string.format("Enemy Combat Calced"))
                if deadUnit == true then
                    if enemy.HP < 1 then
                        love.window.setTitle(string.format("Remove Hero"))
                        table.remove(levelStage.enemies, index)
                    end
                    if levelStage.entities[closestHeroIndex].HP < 1 then
                        love.window.setTitle(string.format("???"))
                        table.remove(levelStage.entities, closestHeroIndex)
                    end
                end
            end
        end
    end
end