local fallout = require("fallout")

local start
local use_p_proc
local timer_p_proc

local OnlyOnce = 1

function start()
    if OnlyOnce then
        OnlyOnce = 0
        fallout.set_external_var("Front_Door_Ptr", fallout.self_obj())
        fallout.obj_close(fallout.self_obj())
    end
    if fallout.script_action() == 6 then
        use_p_proc()
    end
    if fallout.script_action() == 22 then
        timer_p_proc()
    end
end

function use_p_proc()
    if (fallout.source_obj() == fallout.dude_obj()) and (fallout.tile_num(fallout.dude_obj()) == 21927) then
        fallout.obj_open(fallout.self_obj())
    else
        if (fallout.map_var(3) == 0) and (fallout.source_obj() == fallout.dude_obj()) and (fallout.map_var(4) == 0) then
            fallout.script_overrides()
            fallout.set_map_var(2, 1)
        else
            fallout.obj_open(fallout.self_obj())
            if (fallout.source_obj() ~= fallout.dude_obj()) and (fallout.map_var(4) == 0) then
                fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(1), 0)
            end
        end
    end
end

function timer_p_proc()
    fallout.use_obj(fallout.self_obj())
    fallout.rm_timer_event(fallout.self_obj())
end

local exports = {}
exports.start = start
exports.use_p_proc = use_p_proc
exports.timer_p_proc = timer_p_proc
return exports
