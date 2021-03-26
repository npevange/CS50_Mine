--[[
    GD50
    Final Project

    Author: Nathan Evangelista
    npevangelista@ucdavis.edu

    -- Adjusts enemy movement toward zero from the designated values toward closest player character.

    -- 
]]


function AdjustMove(enemy, moveX, moveY, levelStage)
    local tempmoveX = moveX
    local tempmoveY = moveY
    local rand = math.random(1,2)
    if tempmoveX == 0 and tempmoveY == 0 then
        return tempmoveX, tempmoveY
    elseif tempmoveY == 0 then
        rand = 2
    elseif tempmoveY == 0 then
        rand = 1
    end
    local checkMove = false
    if rand == 1 then
        tempmoveX = ToZero(tempmoveX)
        checkMove = CheckMove(enemy, tempmoveX, tempmoveY, levelStage)
        if checkMove == false then
            tempmoveX = tempmoveX
            tempmoveY = ToZero(tempmoveY)
        else
            return tempmoveX, tempmoveY
        end
    else
        tempmoveY = ToZero(tempmoveY)
        checkMove = CheckMove(enemy, tempmoveX, tempmoveY, levelStage)
        if checkMove == false then
            tempmoveY = tempmoveY
            tempmoveX = ToZero(tempmoveX)
        else
            return tempmoveX, tempmoveY
        end
    end
    return tempmoveX, tempmoveY
end