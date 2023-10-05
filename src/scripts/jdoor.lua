local fallout = require("fallout")

local start
local use_p_proc
local look_at_p_proc
local use_obj_on_p_proc
local use_skill_p_proc
local map_update_p_proc
local map_enter_p_proc
local damage_p_proc

local cantopen = 0

function start()
    if fallout.script_action() == 15 then
        map_enter_p_proc()
    else
        if (fallout.script_action() == 21) or (fallout.script_action() == 3) then
            look_at_p_proc()
        else
            if fallout.script_action() == 6 then
                use_p_proc()
            else
                if fallout.script_action() == 8 then
                    use_skill_p_proc()
                else
                    if fallout.script_action() == 7 then
                        use_obj_on_p_proc()
                    else
                        if fallout.script_action() == 14 then
                            damage_p_proc()
                        else
                            if fallout.script_action() == 22 then
                                if not(fallout.combat_is_initialized()) then
                                    fallout.obj_close(fallout.self_obj())
                                end
                            else
                                if fallout.script_action() == 23 then
                                    map_update_p_proc()
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

function use_p_proc()
    cantopen = 0
    if fallout.source_obj() == fallout.dude_obj() then
        cantopen = 1
        if fallout.tile_num(fallout.dude_obj()) == 27913 then
            cantopen = 0
        else
            if fallout.tile_num(fallout.dude_obj()) == 28113 then
                cantopen = 0
            else
                if fallout.tile_num(fallout.dude_obj()) == 28313 then
                    cantopen = 0
                end
            end
        end
    end
    if (fallout.local_var(0) == 0) and cantopen then
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
    local v0 = 0
    local v1 = 0
    v0 = fallout.obj_being_used_with()
    v1 = fallout.roll_vs_skill(fallout.dude_obj(), 9, 20)
    if fallout.obj_pid(v0) == 84 then
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
    fallout.set_obj_visibility(fallout.self_obj(), 1)
    fallout.set_local_var(1, 1)
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
return exports
