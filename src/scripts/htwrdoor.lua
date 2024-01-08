local fallout = require("fallout")

local start
local use_p_proc
local timer_p_proc

local initialized = false

function start()
    if not initialized then
        local self_obj = fallout.self_obj()
        fallout.set_external_var("Front_Door_Ptr", self_obj)
        fallout.obj_close(self_obj)
        initialized = true
    end

    local script_action = fallout.script_action()
    if script_action == 6 then
        use_p_proc()
    elseif script_action == 22 then
        timer_p_proc()
    end
end

function use_p_proc()
    local source_obj = fallout.source_obj()
    local dude_obj = fallout.dude_obj()
    local self_obj = fallout.self_obj()
    if source_obj == dude_obj and fallout.tile_num(dude_obj) == 21927 then
        fallout.obj_open(self_obj)
    else
        if fallout.map_var(3) == 0 and source_obj == dude_obj and fallout.map_var(4) == 0 then
            fallout.script_overrides()
            fallout.set_map_var(2, 1)
        else
            fallout.obj_open(self_obj)
            if source_obj ~= dude_obj and fallout.map_var(4) == 0 then
                fallout.add_timer_event(self_obj, fallout.game_ticks(1), 0)
            end
        end
    end
end

function timer_p_proc()
    local self_obj = fallout.self_obj()
    fallout.use_obj(self_obj)
    fallout.rm_timer_event(self_obj)
end

local exports = {}
exports.start = start
exports.use_p_proc = use_p_proc
exports.timer_p_proc = timer_p_proc
return exports
