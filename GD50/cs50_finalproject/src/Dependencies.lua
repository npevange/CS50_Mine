--
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
require "src/Enemy_defs"
require "src/EnemyTurn"
require "src/FindClosestHero"
require "src/GameLevel"
require "src/GetUnitDef"
require "src/Hero_defs"
require "src/HighlightedTile"
require "src/LevelGenerator"
require "src/Locations"
require "src/Party"
require "src/PartyHeal"
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
require "src/states/game/FadeInState"
require "src/states/game/Level"
require "src/states/game/MainMenu"
require "src/states/game/NewGameState"
require "src/states/game/PlayState"
require "src/states/game/SaveMenu"

require "src/gui/CharacterMenu"
require "src/gui/CharacterStats"
require "src/gui/Menu"
require "src/gui/Panel"
require "src/gui/ProgressBar"
require "src/gui/Selection"
require "src/gui/Textbox"

gTextures = {
    ['Scenery'] = love.graphics.newImage('graphics/Scenery.png'),
    ['Andrew'] = love.graphics.newImage('graphics/Andrew.png'),
    ['Christian'] = love.graphics.newImage('graphics/Christian.png'),
    ['Bandit'] = love.graphics.newImage('graphics/Bandit.png'),
    ['Swordsman'] = love.graphics.newImage('graphics/Swordsman.png'),
    ['TestingCube'] = love.graphics.newImage('graphics/TestingCube.png'),
    ['cursor'] = love.graphics.newImage('graphics/cursor.png'),
    ['Goblin'] = love.graphics.newImage('graphics/Goblin.png'),
    ['SeaDweller'] = love.graphics.newImage('graphics/SeaDweller.png'),
    ['Vampire.png'] = love.graphics.newImage('graphics/Vampire.png')
}

gFrames = {
    ['Scenery'] = GenerateQuads(gTextures['Scenery'], 32, 32),
    ['Andrew'] = GenerateQuads(gTextures['Andrew'], 32, 32),
    ['Christian'] = GenerateQuads(gTextures['Christian'], 32, 32),
    ['Bandit'] = GenerateQuads(gTextures['Bandit'], 32, 32),
    ['Swordsman'] = GenerateQuads(gTextures['Swordsman'], 32, 32),
    ['TestingCube'] = GenerateQuads(gTextures['TestingCube'], 32, 32),
    ['Goblin'] = GenerateQuads(gTextures['Goblin'], 32, 32),
    ['SeaDweller'] = GenerateQuads(gTextures['SeaDweller'], 32, 32),
    ['Vampire'] = GenerateQuads(gTextures['Vampire'], 32, 32),
}

gFonts = {
    ['small'] = love.graphics.newFont('fonts/font.ttf', 8),
    ['medium'] = love.graphics.newFont('fonts/font.ttf', 16),
    ['large'] = love.graphics.newFont('fonts/font.ttf', 32)
}

gSounds = {
    ['blip'] = love.audio.newSource('sounds/blip.wav')
}