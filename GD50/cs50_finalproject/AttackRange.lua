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