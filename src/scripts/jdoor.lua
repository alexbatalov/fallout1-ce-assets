local fallout = require("fallout")

local start
local use_p_proc
local look_at_p_proc
local use_obj_on_p_proc
local use_skill_p_proc
local map_update_p_proc
local map_enter_p_proc
local damage_p_proc
local timed_event_p_proc

function start()
    local script_action = fallout.script_action()
    if script_action == 15 then
        map_enter_p_proc()
    elseif script_action == 21 or script_action == 3 then
        look_at_p_proc()
    elseif script_action == 6 then
        use_p_proc()
    elseif script_action == 8 then
        use_skill_p_proc()
    elseif script_action == 7 then
        use_obj_on_p_proc()
    elseif script_action == 14 then
        damage_p_proc()
    elseif script_action == 22 then
        timed_event_p_proc()
    elseif script_action == 23 then
        map_update_p_proc()
    end
end

function use_p_proc()
    local cantopen = false
    local dude_obj = fallout.dude_obj()
    if fallout.source_obj() == dude_obj then
        cantopen = true
        local dude_tile_num = fallout.tile_num(dude_obj)
        if dude_tile_num == 27913 then
            cantopen = false
        elseif dude_tile_num == 28113 then
            cantopen = false
        elseif dude_tile_num == 28313 then
            cantopen = false
        end
    end
    if fallout.local_var(0) == 0 and cantopen then
        fallout.script_overrides()
        fallout.display_msg(fallout.message_str(63, 104))
    end
    fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(20), 1)
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(63, 201))
end

function use_obj_on_p_proc()
    local item_obj = fallout.obj_being_used_with()
    if fallout.obj_pid(item_obj) == 84 then
        fallout.script_overrides()
        fallout.display_msg(fallout.message_str(63, 200))
    end
end

function use_skill_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(63, 200))
end

function map_update_p_proc()
    fallout.set_external_var("J_Door_Ptr", fallout.self_obj())
end

function map_enter_p_proc()
    fallout.set_external_var("J_Door_Ptr", fallout.self_obj())
end

function damage_p_proc()
    fallout.set_obj_visibility(fallout.self_obj(), true)
    fallout.set_local_var(1, 1)
end

function timed_event_p_proc()
    if not fallout.combat_is_initialized() then
        fallout.obj_close(fallout.self_obj())
    end
end

local exports = {}
exports.start = start
exports.use_p_proc = use_p_proc
exports.look_at_p_proc = look_at_p_proc
exports.use_obj_on_p_proc = use_obj_on_p_proc
exports.use_skill_p_proc = use_skill_p_proc
exports.map_update_p_proc = map_update_p_proc
exports.map_enter_p_proc = map_enter_p_proc
exports.damage_p_proc = damage_p_proc
exports.timed_event_p_proc = timed_event_p_proc
return exports
