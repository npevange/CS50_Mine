--[[
    GD50
    Final Project

    -- constants --

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]
-- size of push emulator
VIRTUAL_WIDTH = 384 --576 --768
VIRTUAL_HEIGHT = 216 --324 --432

-- actual size
WINDOW_WIDTH = 1280 --1360
WINDOW_HEIGHT = 720 --768

-- global standard tile size
TILE_SIZE = 32

-- width and height of screen in tiles
SCREEN_TILE_WIDTH = VIRTUAL_WIDTH / TILE_SIZE
SCREEN_TILE_HEIGHT = VIRTUAL_HEIGHT / TILE_SIZE

--Randomizer Tiles
TILE_ID_GRASS = 1
TILE_ID_TREE = 2
TILE_ID_LAKE = 3
TILE_ID_HOUSE = 5

--Boss Zone tiles
TILE_ID_CASTLE = 4
--TODO: TILE_ID_OCEAN ??? Kraken?
-- Golem something
-- Werewolf something
-- Hell? Pentagram

gTiles = {
    1,2,3,5
}

gQuotes = {
    "Andrew: This isn't going to be easy.\nChristian: Then let's get started." , 'Andrew: ' , 'If your name is Mike please stand up, this concludes my mic test'
}

gBossQuotes = {
    'Vampire Quote' , 'Golem Quote', 'Kraken Warning', 'WereWolf', 'Demon Knight'
}

gEndings = {
    'You lose'
}