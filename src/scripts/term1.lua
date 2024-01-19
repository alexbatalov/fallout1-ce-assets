local fallout = require("fallout")

local start
local map_update_p_proc
local map_enter_p_proc
local use_p_proc
local look_at_p_proc

function start()
    local script_action = fallout.script_action()
    if script_action == 15 then
        map_enter_p_proc()
    elseif script_action == 23 then
        map_update_p_proc()
    elseif script_action == 21 then
        look_at_p_proc()
    elseif script_action == 6 then
        use_p_proc()
    end
end

function map_update_p_proc()
    fallout.set_external_var("term1_ptr", fallout.self_obj())
end

function map_enter_p_proc()
    fallout.set_external_var("term1_ptr", fallout.self_obj())
end

function use_p_proc()
    if fallout.source_obj() == fallout.external_var("Vree_ptr") then
        fallout.set_local_var(0, 1)
        fallout.float_msg(fallout.self_obj(), fallout.message_str(58, 133), 8)
    else
        if fallout.local_var(0) == 0 then
            fallout.display_msg(fallout.message_str(725, 101))
        elseif fallout.local_var(0) == 1 then
            fallout.gfade_out(600)
            fallout.critter_mod_skill(fallout.dude_obj(), 12, 15)
            fallout.set_local_var(0, 2)
            fallout.gfade_in(600)
            fallout.display_msg(fallout.message_str(725, 102))
        elseif fallout.local_var(0) == 2 then
            fallout.display_msg(fallout.message_str(725, 103))
        end
    end
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(725, 100))
end

local exports = {}
exports.start = start
exports.use_p_proc = use_p_proc
exports.map_update_p_proc = map_update_p_proc
exports.map_enter_p_proc = map_enter_p_proc
exports.look_at_p_proc = look_at_p_proc
return exports
