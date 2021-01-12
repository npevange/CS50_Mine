--[[
    GD50
    Final Project

    Author: Nathan Evangelista
    npevangelista@ucdavis.edu

    Trying this:
    https://www.reddit.com/r/love2d/comments/b7nnv8/saving_a_table_in_a_file_with_lovefilesystemwrite/
]]

function SaveTable(o)
    if type(o) == 'table' then
        local s = '{ '
        for k,v in pairs(o) do
           if type(k) ~= 'number' then k = '"'..k..'"' end
           s = s .. '['..k..'] = ' .. dump(v) .. ','
        end
        return s .. '} '
     else
        return tostring(o)
     end
end