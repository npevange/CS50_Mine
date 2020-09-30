--[[
    GD50
    Final Project

    -- constants --

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]
-- size of push emulator
VIRTUAL_WIDTH = 384
VIRTUAL_HEIGHT = 216

-- actual size
WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

-- global standard tile size
TILE_SIZE = 32

-- width and height of screen in tiles
SCREEN_TILE_WIDTH = VIRTUAL_WIDTH / TILE_SIZE
SCREEN_TILE_HEIGHT = VIRTUAL_HEIGHT / TILE_SIZE

TILE_ID_GRASS = 1
TILE_ID_TREE = 2