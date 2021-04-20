-- Lua 5.1 Love 10.2
-- libraries
--

Class = require 'lib/class'
Event = require 'lib/knife.event'
push = require 'lib/push'
Timer = require 'lib/knife.timer'

require "src/AdjustMove"
require "src/CheckMove"
require "src/CheckRange"
require "src/CombatCalculator"
require "src/constants"
require "src/CurrentLocations"
require "src/DefaultMove"
require "src/Enemy_defs"
require "src/EnemyTurn"
require "src/FindClosestHero"
require "src/FindLowHP"
require "src/GameLevel"
require "src/GetSaveLevel"
require "src/GetUnitDef"
require "src/Hero_defs"
require "src/HighlightedTile"
require "src/InList"
require "src/LevelGenerator"
require "src/LoadFunction"
require "src/LoadObject"
require "src/LoadParty"
require "src/Locations"
require "src/Party"
require "src/PartyHeal"
require "src/PartyLoop2"
require "src/SaveObject"
require "src/SaveTable"
require "src/Sleep"
require "src/StateMachine"
require "src/Terrain_defs"
require "src/Tile"
require "src/TileMap"
require "src/ToZero"
require "src/Unit"
require "src/Util"

require "src/states/BaseState"
require "src/states/StateStack"

require "src/states/game/Controls"
require "src/states/game/DeleteMenu"
require "src/states/game/FadeInState"
require "src/states/game/Level"
require "src/states/game/MainMenu"
require "src/states/game/GameState"
require "src/states/game/GameMenu"
require "src/states/game/PlayState"
require "src/states/game/SaveMenu"
require "src/states/game/TextPage"

require "src/gui/CharacterMenu"
require "src/gui/CharacterStats"
require "src/gui/CombatMenu"
require "src/gui/CombatResults"
require "src/gui/Menu"
require "src/gui/Panel"
require "src/gui/ProgressBar"
require "src/gui/Selection"
require "src/gui/Textbox"

gTextures = {
    ['Scenery'] = love.graphics.newImage('graphics/Scenery.png'),
    ['Andrew'] = love.graphics.newImage('graphics/Andrew.png'),
    ['Christian'] = love.graphics.newImage('graphics/Christian.png'),
    ['Cameron'] = love.graphics.newImage('graphics/Cameron.png'),
    ['Nick'] = love.graphics.newImage('graphics/Nick.png'),
    ['Bandit'] = love.graphics.newImage('graphics/Bandit.png'),
    ['Swordsman'] = love.graphics.newImage('graphics/Swordsman.png'),
    ['OrcWarrior'] = love.graphics.newImage('graphics/OrcWarrior.png'),
    ['OrcBerserker'] = love.graphics.newImage('graphics/OrcBerserker.png'),
    ['cursor'] = love.graphics.newImage('graphics/cursor.png'),
    ['Goblin'] = love.graphics.newImage('graphics/Goblin.png'),
    ['SeaDweller'] = love.graphics.newImage('graphics/SeaDweller.png'),
    ['Vampire'] = love.graphics.newImage('graphics/Vampire.png'),
    ['Leviathan'] = love.graphics.newImage('graphics/Leviathan.png'),
    ['Golem'] = love.graphics.newImage('graphics/Golem.png'),
    ['WereWolf'] = love.graphics.newImage('graphics/WereWolf.png'),
    ['YoungWereWolf'] = love.graphics.newImage('graphics/YoungWereWolf.png'),
    ['Dhampir'] = love.graphics.newImage('graphics/VampireMinion.png'),
    ['EmeraldSerpent'] = love.graphics.newImage('graphics/EmeraldSerpent.png'),
    ['Ent'] = love.graphics.newImage('graphics/Ent.png'),
    ['DemonKnight'] = love.graphics.newImage('graphics/DemonKnight.png'),
    ['DemonKnight2'] = love.graphics.newImage('graphics/DemonKnightclone.png')
}

gFrames = {
    ['Scenery'] = GenerateQuads(gTextures['Scenery'], 32, 32),
    ['Andrew'] = GenerateQuads(gTextures['Andrew'], 32, 32),
    ['Christian'] = GenerateQuads(gTextures['Christian'], 32, 32),
    ['Cameron'] = GenerateQuads(gTextures['Cameron'], 32, 32),
    ['Nick'] = GenerateQuads(gTextures['Nick'], 32, 32),
    ['Bandit'] = GenerateQuads(gTextures['Bandit'], 32, 32),
    ['Swordsman'] = GenerateQuads(gTextures['Swordsman'], 32, 32),
    ['OrcWarrior'] = GenerateQuads(gTextures['OrcWarrior'], 32, 32),
    ['OrcBerserker'] = GenerateQuads(gTextures['OrcBerserker'], 32, 32),
    ['Goblin'] = GenerateQuads(gTextures['Goblin'], 32, 32),
    ['SeaDweller'] = GenerateQuads(gTextures['SeaDweller'], 32, 32),
    ['Vampire'] = GenerateQuads(gTextures['Vampire'], 32, 32),
    ['Leviathan'] = GenerateQuads(gTextures['Leviathan'], 32, 32),
    ['Golem'] = GenerateQuads(gTextures['Golem'], 32, 32),
    ['WereWolf'] = GenerateQuads(gTextures['WereWolf'], 32, 32),
    ['YoungWereWolf'] = GenerateQuads(gTextures['YoungWereWolf'], 32, 32),
    ['Dhampir'] = GenerateQuads(gTextures['Dhampir'], 32, 32),
    ['EmeraldSerpent'] = GenerateQuads(gTextures['EmeraldSerpent'], 32, 32),
    ['Ent'] = GenerateQuads(gTextures['Ent'], 32, 32),
    ['DemonKnight'] = GenerateQuads(gTextures['DemonKnight'], 32, 32),
    ['DemonKnight2'] = GenerateQuads(gTextures['DemonKnight2'], 32, 32)
}

gFonts = {
    ['small'] = love.graphics.newFont('fonts/font.ttf', 8),
    ['medium'] = love.graphics.newFont('fonts/font.ttf', 16),
    ['large'] = love.graphics.newFont('fonts/font.ttf', 32)
}

gSounds = {
    ['blip'] = love.audio.newSource('sounds/blip.wav')
}