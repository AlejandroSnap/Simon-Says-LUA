local game = require("game")

local states = require("states")

local score = require("components.score")
local level = require("components.level")
local max_score = require("components.max_score")

local loaded = {
    game = {},
    score = {},
    max_score = {},
    level = {},
}

math.randomseed(os.time())

function love.load()
    loaded.game = game.new()
    loaded.score = score.new()
    loaded.level = level.new()
    loaded.max_score = max_score.new()
end

function love.mousepressed(x, y, button)
    if states.CanClick == true or states.FastMode == true then
        if button == 1 then
            local color = loaded.game:is_clicking_any_color(x, y)
            if color ~= false and loaded.game.colors[color].is_active == false then
                if loaded.game:is_correct(color) == true then
                    table.remove(loaded.game.game, 1)
                    if #loaded.game.game == 0 then
                        print("ya ganaste!")
                        states.Level = states.Level + 1
                        states.Score = states.Score + 1 * (states.Level - 1)
                        loaded.game.game = loaded.game:rng(states.Level)
                        states.CanClick = false
                    end
                else
                    if states.Score > states.MaxScore then
                        states.MaxScore = states.Score
                    end
                    love.event.quit("restart")
                    states.CanClick = false
                end
                loaded.game.colors[color]:ON()
            end
        end
    end
end

function love.keypressed(key)
    if key == "m" then
        if states.Auto == true then
            states.Auto = false
        else
            states.Auto = true
        end
        print("Auto:",states.Auto)
    elseif key == "k" then
        if states.FastMode == true then
            states.FastMode = false
            states.CanClick = false
        else
            states.FastMode = true
        end
        print("FastMode:", states.FastMode)
    end
end

function love.update(dt)
    if states.Auto == true then
        local current_color = loaded.game.game[1]
        local real_color = loaded.game.colors[current_color]
        love.mouse.setPosition((real_color.px), (real_color.py))
        love.mousepressed(real_color.px, real_color.py, 1)
        --print(current_color, real_color)
    end

    for index, value in pairs(loaded.game.colors) do
        if value.turn_off <= value.turn_off_time then
            value.turn_off = value.turn_off + dt
        end

        if value.turn_off >= value.turn_off_time then
            value:OFF()
            value.turn_off = 10
        end
    end

    if states.FastMode == true then
        return
    end

    if states.CanClick == true then
        return
    end

    if loaded.game.show_case.current > #loaded.game.game then
        loaded.game.show_case.current = 1
        states.CanClick = true
        return
    end

    if loaded.game.show_case.update_time <= loaded.game.show_case.min_update_time then
        loaded.game.show_case.update_time = loaded.game.show_case.update_time + dt
    end

    if loaded.game.show_case.update_time >= loaded.game.show_case.min_update_time then
        loaded.game.colors[loaded.game.game[loaded.game.show_case.current]]:ON()
        loaded.game.show_case.update_time = 0
        loaded.game.show_case.current = loaded.game.show_case.current + 1
    end
end

function love.draw()
    loaded.game:draw()
    loaded.score:draw()
    loaded.level:draw()
    loaded.max_score:draw()
end
