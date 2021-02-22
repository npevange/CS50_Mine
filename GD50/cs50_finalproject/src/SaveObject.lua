--[[
    GD50
    Final Project

    Author: Nathan Evangelista
    npevangelista@ucdavis.edu
]]

function SaveObject(party, levelNum, BossNum, BossLevel, SaveState, type)
    SaveData = {party, levelNum, BossNum, BossLevel, SaveState}
    table = SaveTable(SaveData)
    if type == 'load' then
        returnTable = "LoadFunction(" .. table .. ")"

        return returnTable
    elseif type == 'level' then
        returnTable = "GetSaveLevel(" .. table .. ")"
        return returnTable
    elseif type == 'test' then
        returnTable = table
        return returnTable
    end
end