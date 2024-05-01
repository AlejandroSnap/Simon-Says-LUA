local states = require("states")

local text = require("utils.Text")

local score = {}
score.__index = score

function score.new()
    local self = setmetatable({}, score)
    self.x = 35 * 14
    self.y = 35
    self.w = 175
    self.h = 35
    self.size = text.Headers.h4
    self.text = "Level: " .. states.Level

    return self
end

function score:draw()
    self.text = "Level: " .. states.Level
    love.graphics.setFont(self.size)
    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle("line", self.x, self.y, self.w, self.h)

    local textWidth = self.size:getWidth(self.text)
    local textHeight = self.size:getHeight()
    local centerX = self.x + (self.w - textWidth) / 2
    local centerY = self.y + (self.h - textHeight) / 2
    love.graphics.print(self.text, centerX, centerY)
end

return score