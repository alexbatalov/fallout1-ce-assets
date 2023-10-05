local fallout = require("fallout")

local start
local map_update_p_proc

function start()
    if fallout.script_action() == 23 then
        map_update_p_proc()
    end
end

function map_update_p_proc()
    if (fallout.game_time_hour() >= 700) and (fallout.game_time_hour() < 1800) then
        fallout.obj_set_light_level(fallout.self_obj(), 100, 8)
    else
        if (fallout.game_time_hour() >= 1900) or (fallout.game_time_hour() < 600) then
            fallout.obj_set_light_level(fallout.self_obj(), 40, 8)
        else
            if (fallout.game_time_hour() >= 600) and (fallout.game_time_hour() < 700) then
                fallout.obj_set_light_level(fallout.self_obj(), fallout.game_time_hour() - 600 + 40, 8)
            else
                if (fallout.game_time_hour() >= 1800) and (fallout.game_time_hour() < 1900) then
                    fallout.obj_set_light_level(fallout.self_obj(), 100 - (fallout.game_time_hour() - 1800), 8)
                end
            end
        end
    end
end

local exports = {}
exports.start = start
exports.map_update_p_proc = map_update_p_proc
return exports
