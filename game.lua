local game_color = require("components.game_color")

local game = {}
game.__index = game


function game.new()
    local self = setmetatable({}, game)
    self.colors = {game_color:red(), game_color:green(), game_color:blue(), game_color:yellow()}
    self.current_color = 1
    self.game = self:rng(1)
    self.show_case = {
        current = 1,
        update_time = 0,
        min_update_time = 1.2
    }
    return self
end

function game:rng(times)
    local a = {}
    for x = 1, times do
        table.insert(a, math.random(4))
    end

    return a
end

function game:is_correct(color)
    if self.game[1] == color then

        return true
    end
    return false
end


function game:is_clicking_any_color(mx, my)
    for index, value in pairs(self.colors) do
        if mx >= value.px and mx <= value.px + value.size and my >= value.py and my <= value.py + value.size then
            return index
        end
    end
    return false
end

function game:draw()
    for index, value in pairs(self.colors) do
        value:draw()
    end
end

return game
