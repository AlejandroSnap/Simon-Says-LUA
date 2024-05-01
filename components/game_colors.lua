local colors = require("utils.colors")

local game_colors = {}
game_colors.__index = game_colors

function game_colors:new(id)
    local self = setmetatable({}, game_colors)
    self.id = id
    self.color = colors.game[id]
    self.size = 225
    self.offset = 250
    self.turn_off = 0
    self.turn_off_time = 0.8
    self.is_active = false

    if self.id % 2 ~= 0 then
        self.px = 100
        self.py = 100 + (self.offset * math.max(self.id - 2, 0))
    else
        self.px = 100 + self.offset
        self.py = 100 + (self.offset * math.max(self.id - 3, 0))
    end
    
    return self
end

function game_colors:ON()
    self.color[4] = 1
    self.turn_off = 0
    self.is_active = true
end

function game_colors:OFF()
    self.color[4] = 0.5
    self.is_active = false
end

function game_colors:draw()
    love.graphics.setColor(unpack(self.color))

    love.graphics.rectangle("fill", self.px, self.py, self.size, self.size)
end

return game_colors