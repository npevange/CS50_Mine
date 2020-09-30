--[[
    GD50
    Pokemon

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

PlayState = Class{__includes = BaseState}

function PlayState:init()
    self.level = Level()

    gSounds['field-music']:setLooping(true)
    gSounds['field-music']:play()

    self.dialogueOpened = false
end

function PlayState:update(dt)
    if not self.dialogueOpened and love.keyboard.wasPressed('p') then
        
        -- heal player pokemon
        gSounds['heal']:play()
        self.level.player.party.pokemon[1].currentHP = self.level.player.party.pokemon[1].HP
        
        -- show a dialogue for it, allowing us to do so again when closed
        gStateStack:push(DialogueState('Your Pokemon has been healed!',
    
        function()
            self.dialogueOpened = false
        end))
    elseif not self.dialogueOpened and love.keyboard.wasPressed('t') then

        local testHP, testATK, testDFN, testSPD = 0, 0, 0, 0
        gStateStack:push(MenuState(self.level.player.party, testHP, testATK, testDFN, testSPD))
    end

    self.level:update(dt)
end

function PlayState:render()
    self.level:render()
end