local fallout = require("fallout")

local start
local critter_p_proc
local description_p_proc
local talk_p_proc
local timed_event_p_proc
local use_obj_on_p_proc
local use_skill_on_p_proc
local damage_p_proc
local destroy_p_proc

local critter_tile = 0
local initialized = 0

function start()
    if fallout.script_action() == 12 then
        critter_p_proc()
    else
        if fallout.script_action() == 3 then
            description_p_proc()
        else
            if fallout.script_action() == 11 then
                talk_p_proc()
            else
                if fallout.script_action() == 22 then
                    timed_event_p_proc()
                else
                    if fallout.script_action() == 7 then
                        use_obj_on_p_proc()
                    else
                        if fallout.script_action() == 8 then
                            use_skill_on_p_proc()
                        end
                    end
                end
            end
        end
    end
end

function critter_p_proc()
    if not(initialized) then
        fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(fallout.random(1, 5)), 1)
        initialized = 1
    end
end

function description_p_proc()
    fallout.display_msg(fallout.message_str(34, 100))
end

function talk_p_proc()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(34, 103), 0)
end

function timed_event_p_proc()
    if ((fallout.critter_state(fallout.self_obj()) & 2) == 0) and not(fallout.combat_is_initialized()) then
        critter_tile = fallout.tile_num_in_direction(fallout.tile_num(fallout.self_obj()), fallout.random(0, 5), 3)
        fallout.reg_anim_func(2, fallout.self_obj())
        fallout.reg_anim_func(1, 1)
        fallout.reg_anim_obj_move_to_tile(fallout.self_obj(), critter_tile, -1)
        fallout.reg_anim_func(3, 0)
    end
    fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(fallout.random(3, 5)), 1)
end

function use_obj_on_p_proc()
    local v0 = 0
    if (fallout.obj_pid(fallout.obj_being_used_with()) == 124) or (fallout.obj_pid(fallout.obj_being_used_with()) == 125) then
        fallout.script_overrides()
        v0 = fallout.obj_being_used_with()
        fallout.rm_obj_from_inven(fallout.source_obj(), fallout.obj_being_used_with())
        fallout.destroy_object(v0)
        fallout.reg_anim_func(2, fallout.self_obj())
        fallout.reg_anim_func(1, 1)
        fallout.reg_anim_animate(fallout.self_obj(), 14, -1)
        fallout.reg_anim_animate(fallout.self_obj(), 20, 5)
        fallout.reg_anim_animate(fallout.self_obj(), 48, -1)
        fallout.reg_anim_func(3, 0)
        fallout.critter_injure(fallout.self_obj(), 2)
    end
end

function use_skill_on_p_proc()
    if fallout.action_being_used() == 12 then
        fallout.script_overrides()
        if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), fallout.action_being_used(), 0)) then
            fallout.display_msg(fallout.message_str(34, 101))
        else
            fallout.display_msg(fallout.message_str(34, 102))
        end
    end
end

function damage_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.set_global_var(247, 1)
    end
end

function destroy_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.set_global_var(247, 1)
    end
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.description_p_proc = description_p_proc
exports.talk_p_proc = talk_p_proc
exports.timed_event_p_proc = timed_event_p_proc
exports.use_obj_on_p_proc = use_obj_on_p_proc
exports.use_skill_on_p_proc = use_skill_on_p_proc
exports.damage_p_proc = damage_p_proc
exports.destroy_p_proc = destroy_p_proc
return exports
