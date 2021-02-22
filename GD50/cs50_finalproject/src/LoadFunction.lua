--[[
    GD50
    Final Project

    Author: Nathan Evangelista
    npevangelista@ucdavis.edu
]]

function LoadFunction(inputs)
    -- inputs[1] == party information
    -- inputs[2] == levelNum
    -- inputs[3] == BossNum
    -- inputs[4] == BossLevel
    -- inputs[5] == SaveState

    party = LoadParty:init(inputs[1])

    if InList(gQuoteLevels, inputs[2]) then
        gStateMachine:change('textstate', {gQuotes[inputs[2]], 'gamestate', {party, inputs[2], inputs[3], inputs[4], inputs[5]}})
    else
        gStateMachine:change('textstate', {gSaveQuotes[1], 'gamestate', {party, inputs[2], inputs[3], inputs[4], inputs[5]}})
    end
end