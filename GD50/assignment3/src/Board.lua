--[[
    GD50
    Match-3 Remake

    -- Board Class --

    Author: Colton Ogden
    cogden@cs50.harvard.edu

    The Board is our arrangement of Tiles with which we must try to find matching
    sets of three horizontally or vertically.
]]

Board = Class{}

function Board:init(x, y, level)
    self.x = x
    self.y = y
    self.matches = {}
    self.level = level
    --math.randomseed(os.time())
    self:initializeTiles(self.level)
end

function Board:initializeTiles(level)
    self.tiles = {}

    for tileY = 1, 8 do
        
        -- empty table that will serve as a new row
        table.insert(self.tiles, {})

        for tileX = 1, 8 do
            
            -- create a new tile at X,Y with a random color and variety
            add_shiny = math.random(5)
            
            if add_shiny == 1 then
                table.insert(self.tiles[tileY], Tile(tileX, tileY, math.random(18), math.random(math.min(level,6)), true))
            else
                table.insert(self.tiles[tileY], Tile(tileX, tileY, math.random(18), math.random(math.min(level,6)), false))
            end
        end
    end

    local randomx = math.random(5)
    local randomy = math.random(5)
    local randomcolor = math.random(18)
    local randompattern = 1
    --local randompattern = math.random(2)
    if randompattern == 1 then
        self.tiles[randomy][randomx].color = randomcolor
        self.tiles[randomy + 1][randomx + 1].color = randomcolor
        self.tiles[randomy + 2][randomx + 1].color = randomcolor
    else
        self.tiles[randomy][randomx].color = randomcolor
        self.tiles[randomy + 1][randomx + 1].color = randomcolor
        self.tiles[randomy + 1][randomx + 2].color = randomcolor
    end

    self.tiles[1][1].shiny = true
    self.tiles[1][2].shiny = true
    self.tiles[1][3].shiny = true
    self.tiles[1][4].shiny = true
    self.tiles[1][5].shiny = true
    while self:calculateMatches() do
        
        -- recursively initialize if matches were returned so we always have
        -- a matchless board on start
        self:initializeTiles(level)
    end
end

--[[
    Goes left to right, top to bottom in the board, calculating matches by counting consecutive
    tiles of the same color. Doesn't need to check the last tile in every row or column if the 
    last two haven't been a match.
]]
function Board:calculateMatches()
    local matches = {}

    -- how many of the same color blocks in a row we've found
    local matchNum = 1

    -- horizontal matches first
    for y = 1, 8 do
        local colorToMatch = self.tiles[y][1].color

        matchNum = 1
        
        -- every horizontal tile
        for x = 2, 8 do
            
            -- if this is the same color as the one we're trying to match...
            if self.tiles[y][x].color == colorToMatch then
                matchNum = matchNum + 1
            else
                
                -- set this as the new color we want to watch for
                colorToMatch = self.tiles[y][x].color

                -- if we have a match of 3 or more up to now, add it to our matches table
                if matchNum >= 3 then
                    local match = {}

                    -- go backwards from here by matchNum
                    for x2 = x - 1, x - matchNum, -1 do
                        
                        -- add each tile to the match that's in that match
                        table.insert(match, self.tiles[y][x2])
                        self.tiles[y][x2].in_a_match = true
                    end

                    -- add this match to our total matches table
                    
                    table.insert(matches, match)
                end

                matchNum = 1

                -- don't need to check last two if they won't be in a match
                if x >= 7 then
                    break
                end
            end
        end

        -- account for the last row ending with a match
        if matchNum >= 3 then
            local match = {}
            
            -- go backwards from end of last row by matchNum
            for x = 8, 8 - matchNum + 1, -1 do
                table.insert(match, self.tiles[y][x])
                self.tiles[y][x].in_a_match = true
            end

            table.insert(matches, match)
        end
    end

    -- vertical matches
    for x = 1, 8 do
        local colorToMatch = self.tiles[1][x].color

        matchNum = 1

        -- every vertical tile
        for y = 2, 8 do
            if self.tiles[y][x].color == colorToMatch then
                matchNum = matchNum + 1
            else
                colorToMatch = self.tiles[y][x].color

                if matchNum >= 3 then
                    local match = {}

                    for y2 = y - 1, y - matchNum, -1 do
                        table.insert(match, self.tiles[y2][x])
                        self.tiles[y2][x].in_a_match = true
                    end

                    table.insert(matches, match)
                end

                matchNum = 1

                -- don't need to check last two if they won't be in a match
                if y >= 7 then
                    break
                end
            end
        end

        -- account for the last column ending with a match
        if matchNum >= 3 then
            local match = {}
            
            -- go backwards from end of last row by matchNum
            for y = 8, 8 - matchNum + 1, -1 do
                table.insert(match, self.tiles[y][x])
                self.tiles[y][x].in_a_match = true
            end

            table.insert(matches, match)
        end
    end
    for k, match in pairs(matches) do
        for i = 1, #match, 1 do
            if match[i].shiny == true then
                local line_match = {}
                for j = 1, 8, 1 do
                    if self.tiles[match[i].gridY][j].in_a_match == true then

                    else
                        table.insert(line_match, self.tiles[match[i].gridY][j])
                        self.tiles[match[i].gridY][j].in_a_match = true
                    end
                end
                table.insert(matches, line_match)
            end
        end
    end

    -- store matches for later reference
    self.matches = matches

    -- return matches table if > 0, else just return false
    return #self.matches > 0 and self.matches or false
end

--[[
    Remove the matches from the Board by just setting the Tile slots within
    them to nil, then setting self.matches to nil.
]]
function Board:removeMatches()
    for k, match in pairs(self.matches) do
        for k, tile in pairs(match) do
            self.tiles[tile.gridY][tile.gridX] = nil
        end
    end

    self.matches = nil
end

--[[
    Shifts down all of the tiles that now have spaces below them, then returns a table that
    contains tweening information for these new tiles.
]]
function Board:getFallingTiles(level)
    -- tween table, with tiles as keys and their x and y as the to values
    local tweens = {}

    -- for each column, go up tile by tile till we hit a space
    for x = 1, 8 do
        local space = false
        local spaceY = 0

        local y = 8
        while y >= 1 do
            
            -- if our last tile was a space...
            local tile = self.tiles[y][x]
            
            if space then
                
                -- if the current tile is *not* a space, bring this down to the lowest space
                if tile then
                    
                    -- put the tile in the correct spot in the board and fix its grid positions
                    self.tiles[spaceY][x] = tile
                    tile.gridY = spaceY

                    -- set its prior position to nil
                    self.tiles[y][x] = nil

                    -- tween the Y position to 32 x its grid position
                    tweens[tile] = {
                        y = (tile.gridY - 1) * 32
                    }

                    -- set Y to spaceY so we start back from here again
                    space = false
                    y = spaceY

                    -- set this back to 0 so we know we don't have an active space
                    spaceY = 0
                end
            elseif tile == nil then
                space = true
                
                -- if we haven't assigned a space yet, set this to it
                if spaceY == 0 then
                    spaceY = y
                end
            end

            y = y - 1
        end
    end
    -- create replacement tiles at the top of the screen
    for x = 1, 8 do
        for y = 8, 1, -1 do
            local tile = self.tiles[y][x]

            -- if the tile is nil, we need to add a new one
            if not tile then
                -- new tile with random color and variety
                add_shiny = math.random(7)
                local tile = Tile(x, y, math.random(18), (math.random(math.min(level, 6))), false)
                
            
                if add_shiny == 1 then
                    local tile = Tile(x, y, math.random(18), (math.random(math.min(level, 6))), true)
                else
                    local tile = Tile(x, y, math.random(18), (math.random(math.min(level, 6))), false)
                end
                tile.y = -32
                self.tiles[y][x] = tile

                -- create a new tween to return for this tile to fall down
                tweens[tile] = {
                    y = (tile.gridY - 1) * 32
                }
            end
        end
    end

    return tweens
end

function Board:checkPotentialMatches(tiles)
    -- returns true if found a potential match or false otherwise (Reset board)
    local bool3x2 = false
    local bool2x3 = false

    --check 3x2 patterns
    for y = 1, 6 do
        for x = 1, 7 do
            bool3x2 = Board:check3x2patterns(x, y, tiles)
            if bool3x2 == true then
                return true
            end
        end
    end

    -- check 2x3 pattterns
    for y = 1, 7 do
        for x = 1, 6 do
            bool2x3 = Board:check2x3patterns(x, y, tiles)
            if bool2x3 == true then
                return true
            end
        end
    end

    if bool2x3 == false and bool3x2 == false then
        return false
    end
end

function Board:check3x2patterns(x, y, tiles)
    patternbool3x2 = false

    if tiles[y][x].color == tiles[y + 1][x + 1].color and tiles[y][x].color == tiles[y + 2][x + 1].color then
        patternbool3x2 = true
    elseif tiles[y][x + 1].color == tiles[y + 1][x].color and tiles[y][x + 1].color == tiles[y + 2][x].color then
        patternbool3x2 = true
    elseif tiles[y][x].color == tiles[y + 1][x].color and tiles[y][x].color == tiles[y + 2][x + 1].color then
        patternbool3x2 = true
    elseif tiles[y][x + 1].color == tiles[y + 1][x + 1].color and tiles[y][x + 1].color == tiles[y + 2][x].color then
        patternbool3x2 = true
    elseif tiles[y][x].color == tiles[y + 1][x + 1].color and tiles[y][x].color == tiles[y + 2][x].color then
        patternbool3x2 = true
    elseif tiles[y][x + 1].color == tiles[y + 1][x].color and tiles[y][x + 1].color == tiles[y + 2][x + 1].color then
        patternbool3x2 = true
    end

    return patternbool3x2
end

function Board:check2x3patterns(x, y, tiles)
    patternbool2x3 = false

    if tiles[y][x].color == tiles[y][x + 1].color and tiles[y][x].color == tiles[y + 1][x + 2].color then
        patternbool2x3 = true
    elseif tiles[y + 1][x].color == tiles[y + 1][x + 1].color and tiles[y + 1][x].color == tiles[y][x + 2].color then
        patternbool2x3 = true
    elseif tiles[y][x].color == tiles[y + 1][x + 1].color and tiles[y][x].color == tiles[y + 1][x + 2].color then
        patternbool2x3 = true
    elseif tiles[y + 1][x].color == tiles[y][x + 1].color and tiles[y + 1][x].color == tiles[y][x + 2].color then
        patternbool2x3 = true
    elseif tiles[y][x].color == tiles[y + 1][x + 1].color and tiles[y][x].color == tiles[y][x + 2].color then
        patternbool2x3 = true
    elseif tiles[y + 1][x].color == tiles[y][x + 1].color and tiles[y + 1][x].color == tiles[y + 1][x + 2].color then
        patternbool2x3 = true
    end

    return patternbool2x3
end

function Board:render()
    for y = 1, #self.tiles do
        for x = 1, #self.tiles[1] do
            self.tiles[y][x]:render(self.x, self.y)
        end
    end
end