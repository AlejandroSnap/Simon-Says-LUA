local game_colors = require("components.game_colors")

local game = {}

function game:red()
    local new = game_colors:new(1)
    
    return new
end

function game:green()
    local new = game_colors:new(2)
    
    return new
end

function game:blue()
    local new = game_colors:new(3)
    
    return new
end

function game:yellow()
    local new = game_colors:new(4)
    
    return new
end


return game