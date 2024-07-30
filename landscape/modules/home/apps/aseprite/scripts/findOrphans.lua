------------------------------------------------------------------------
-- An Aseprite script that finds orphan pixels
--
-- by Willow & Edward Willis
-- MIT license: free for all uses, commercial or otherwise
------------------------------------------------------------------------
local sprite = app.activeSprite
if not sprite then
    return app.alert("There is no active sprite")
end

-- Simple search. Inspects every pixel and its neighbors
-- (could be more efficient, but meh)
local function selectOrphans()

    local img = app.activeImage
    local cel = img.cel
    local box = cel.bounds
    local xCel = box.x
    local yCel = box.y
    local i = 0
    local img_width = img.width - 1
    local img_height = img.height - 1;

    local newSel = Selection()

    -- create matrix init 0
    grid = {}
    for i = 1, 8 do
        grid[i] = {}
        for j = 1, 2 do
            grid[i][j] = 0 -- Fill the values here
        end
    end

    for y = 0, img_height do
        for x = 0, img_width do
            local color = img:getPixel(x, y)

            -- This stores the coordinates for the surrounding 8 pixels
            -- top left
            grid[1][1] = x - 1;
            grid[1][2] = y - 1;
            -- left
            grid[2][1] = x - 1;
            grid[2][2] = y;
            -- bottom left
            grid[3][1] = x - 1;
            grid[3][2] = y + 1;
            -- bottom
            grid[4][1] = x;
            grid[4][2] = y + 1;
            -- bottom right
            grid[5][1] = x + 1;
            grid[5][2] = y + 1;
            -- right
            grid[6][1] = x + 1;
            grid[6][2] = y;
            -- top right
            grid[7][1] = x + 1;
            grid[7][2] = y - 1;
            -- top
            grid[8][1] = x;
            grid[8][2] = y - 1;

            -- Check the color of those 8 pixels
            local isOrphan = true
            for i = 1, 8 do

                -- if x out of bounds
                if(grid[i][1] < 0 or grid[i][1] > img_width) then
                    goto continue
                end
                -- if y out of bounds
                if(grid[i][2] < 0 or grid[i][2] > img_height) then
                    goto continue
                end

                if(color == img:getPixel(grid[i][1], grid[i][2])) then
                    isOrphan = false;
                    goto endloop
                end
                ::continue::
            end

            ::endloop::
            if( isOrphan ) then
                local px = Rectangle(xCel + x, yCel + y, 1, 1)
                newSel:add(px)
            end
        end
    end

    local spr = app.activeSprite
    local prevSel = spr.selection
    if not prevSel.isEmpty then
        newSel:intersect(prevSel)
    end

    -- Set the new selection as the active one, and shrink the canvas again
    spr.selection = newSel
end

-- Run the script
do
    selectOrphans()
end
