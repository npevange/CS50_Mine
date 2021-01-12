--[[
    GD50
    Final Project

    Author: Nathan Evangelista
    npevangelista@ucdavis.edu
]]

SaveObject = Class{}

function SaveObject:init(party, levelNum, BossNum, BossLevel, SaveState)
    self.SaveData = {party, levelNum, BossNum, BossLevel, SaveState}
end