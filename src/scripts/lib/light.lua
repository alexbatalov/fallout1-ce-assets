local fallout = require("fallout")

local function lighting()
    local game_time_hour = fallout.game_time_hour()
    if game_time_hour >= 600 and game_time_hour < 700 then
        fallout.set_light_level(game_time_hour - 600 + 40)
    elseif game_time_hour >= 700 and game_time_hour < 1800 then
        fallout.set_light_level(100)
    elseif game_time_hour >= 1800 and game_time_hour < 1900 then
        fallout.set_light_level(100 - (game_time_hour - 1800))
    else
        fallout.set_light_level(40)
    end
end

local function darkness()
    fallout.set_light_level(40)
end

local exports = {}
exports.lighting = lighting
exports.darkness = darkness
return exports
