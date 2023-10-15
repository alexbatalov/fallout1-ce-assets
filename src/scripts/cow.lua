local fallout = require("fallout")

local start
local talk_p_proc
local use_obj_on_p_proc
local use_skill_on_p_proc
local timed_event_p_proc

local initialized = false
local moo_counter = 0
local critter_tile = 0

function start()
    if not initialized then
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 3)
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 4)
        fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(fallout.random(1, 5)), 1)
        initialized = true
    else
        if fallout.script_action() == 22 then
            timed_event_p_proc()
        else
            if fallout.script_action() == 11 then
                talk_p_proc()
            else
                if fallout.script_action() == 7 then
                    use_obj_on_p_proc()
                else
                    if fallout.script_action() == 8 then
                        use_skill_on_p_proc()
                    else
                        if fallout.script_action() == 3 then
                            fallout.display_msg(fallout.message_str(5, 103))
                        end
                    end
                end
            end
        end
    end
end

function talk_p_proc()
    if moo_counter == 1 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(5, 102), 0)
    else
        fallout.float_msg(fallout.self_obj(), fallout.message_str(5, fallout.random(100, 101)), 0)
    end
    moo_counter = moo_counter + 1
    if moo_counter > 2 then
        moo_counter = 0
    end
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
            fallout.display_msg(fallout.message_str(5, 104))
        else
            fallout.display_msg(fallout.message_str(5, 105))
        end
    end
end

function timed_event_p_proc()
    if ((fallout.critter_state(fallout.self_obj()) & 2) == 0) and not(fallout.combat_is_initialized()) then
        critter_tile = fallout.tile_num_in_direction(fallout.tile_num(fallout.self_obj()), fallout.random(0, 5), 3)
        fallout.reg_anim_func(2, fallout.self_obj())
        fallout.reg_anim_func(1, 1)
        fallout.reg_anim_obj_move_to_tile(fallout.self_obj(), critter_tile, -1)
        fallout.reg_anim_func(3, 0)
    end
    if fallout.random(0, 1) then
        talk_p_proc()
    end
    fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(fallout.random(3, 5)), 1)
end

local exports = {}
exports.start = start
exports.talk_p_proc = talk_p_proc
exports.use_obj_on_p_proc = use_obj_on_p_proc
exports.use_skill_on_p_proc = use_skill_on_p_proc
exports.timed_event_p_proc = timed_event_p_proc
return exports
