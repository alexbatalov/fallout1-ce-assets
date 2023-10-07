local fallout = require("fallout")

local start
local look_at_p_proc
local map_enter_p_proc
local talk_p_proc
local use_skill_on_p_proc
local use_obj_on_p_proc
local destroy_p_proc
local combat_p_proc
local Jarvis01
local Jarvis02
local Jarvis03
local Jarvis04
local Jarvis05
local Jarvis06
local Jarvisend
local description_p_proc
local critter_p_proc
local pickup_p_proc
local timed_event_p_proc
local map_exit_p_proc

local use_skill = 0
local initialized = 0
local hostile = 0

function start()
    if fallout.script_action() == 11 then
        talk_p_proc()
    else
        if fallout.script_action() == 16 then
            map_exit_p_proc()
        else
            if fallout.script_action() == 15 then
                map_enter_p_proc()
            else
                if (fallout.script_action() == 21) or (fallout.script_action() == 3) then
                    look_at_p_proc()
                else
                    if fallout.script_action() == 7 then
                        use_obj_on_p_proc()
                    else
                        if fallout.script_action() == 4 then
                            pickup_p_proc()
                        else
                            if fallout.script_action() == 18 then
                                destroy_p_proc()
                            else
                                if fallout.script_action() == 13 then
                                    combat_p_proc()
                                else
                                    if fallout.script_action() == 8 then
                                        use_skill_on_p_proc()
                                    else
                                        if fallout.script_action() == 18 then
                                            destroy_p_proc()
                                        else
                                            if fallout.script_action() == 12 then
                                                critter_p_proc()
                                            else
                                                if fallout.script_action() == 22 then
                                                    timed_event_p_proc()
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

function look_at_p_proc()
    fallout.script_overrides()
    if fallout.local_var(4) == 0 then
        fallout.display_msg(fallout.message_str(440, 102))
    else
        fallout.display_msg(fallout.message_str(440, 103))
    end
end

function map_enter_p_proc()
    if fallout.local_var(5) == 0 then
        fallout.anim(fallout.self_obj(), 48, 0)
        fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(3600), 1)
    end
    fallout.critter_add_trait(fallout.self_obj(), 1, 6, 2)
    fallout.critter_add_trait(fallout.self_obj(), 1, 5, 6)
end

function talk_p_proc()
    if fallout.local_var(5) == 0 then
        Jarvis01()
    else
        fallout.start_gdialog(440, fallout.self_obj(), 4, -1, -1)
        fallout.gsay_start()
        if fallout.local_var(4) == 0 then
            Jarvis02()
        else
            Jarvis03()
        end
        fallout.gsay_end()
        fallout.end_dialogue()
    end
end

function use_skill_on_p_proc()
    local v0 = 0
    v0 = fallout.roll_vs_skill(fallout.dude_obj(), fallout.action_being_used(), 0)
    if fallout.local_var(5) == 0 then
        fallout.script_overrides()
        if fallout.action_being_used() == 6 then
            if fallout.is_success(v0) then
                fallout.display_msg(fallout.message_str(440, 112))
            else
                fallout.display_msg(fallout.message_str(440, 113))
            end
        else
            if fallout.action_being_used() == 7 then
                if fallout.is_success(v0) then
                    fallout.display_msg(fallout.message_str(440, 114))
                else
                    fallout.display_msg(fallout.message_str(440, 115))
                end
            else
                fallout.display_msg(fallout.message_str(440, 116))
            end
        end
    end
end

function use_obj_on_p_proc()
    if (fallout.obj_pid(fallout.obj_being_used_with()) == 49) and (fallout.local_var(5) == 0) then
        fallout.script_overrides()
        fallout.rm_timer_event(fallout.self_obj())
        fallout.set_local_var(5, 1)
        fallout.rm_obj_from_inven(fallout.dude_obj(), fallout.obj_being_used_with())
        fallout.destroy_object(fallout.obj_being_used_with())
        fallout.display_msg(fallout.message_str(440, 117))
        fallout.give_exp_points(400)
        fallout.set_global_var(155, fallout.global_var(155) + 1)
        fallout.display_msg(fallout.message_str(440, 200))
    end
end

function destroy_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.set_global_var(246, 1)
    end
    if fallout.source_obj() == fallout.dude_obj() then
        if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1)) then
            fallout.set_global_var(156, 1)
            fallout.set_global_var(157, 0)
        end
        if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(160) > (3 * fallout.global_var(159))) or (fallout.global_var(157) == 1)) then
            fallout.set_global_var(157, 1)
            fallout.set_global_var(156, 0)
        end
        fallout.set_global_var(159, fallout.global_var(159) + 1)
        if (fallout.global_var(159) % 2) == 0 then
            fallout.set_global_var(155, fallout.global_var(155) - 1)
        end
    end
    fallout.rm_timer_event(fallout.self_obj())
end

function combat_p_proc()
    if (fallout.fixed_param() == 4) and (fallout.local_var(5) == 0) then
        fallout.script_overrides()
    end
end

function Jarvis01()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(440, 104), 3)
end

function Jarvis02()
    fallout.gsay_reply(440, 105)
    fallout.set_local_var(4, 1)
    Jarvis04()
end

function Jarvis03()
    fallout.gsay_reply(440, 106)
    Jarvis04()
end

function Jarvis04()
    fallout.giq_option(4, 440, 107, Jarvis05, 50)
    fallout.giq_option(4, 440, 108, Jarvis06, 50)
    fallout.giq_option(4, 440, 109, Jarvisend, 50)
    fallout.giq_option(-3, 440, 118, Jarvis05, 50)
    fallout.giq_option(-3, 440, 119, Jarvis06, 50)
    fallout.giq_option(-3, 440, 120, Jarvisend, 50)
end

function Jarvis05()
    fallout.gsay_reply(440, 110)
    Jarvis04()
end

function Jarvis06()
    fallout.gsay_reply(440, 111)
    Jarvis04()
end

function Jarvisend()
end

function description_p_proc()
    fallout.script_overrides()
    if fallout.local_var(4) == 0 then
        fallout.display_msg(fallout.message_str(440, 102))
    else
        fallout.display_msg(fallout.message_str(440, 103))
    end
end

function critter_p_proc()
    if hostile then
        hostile = 0
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    end
end

function pickup_p_proc()
    hostile = 1
end

function timed_event_p_proc()
    if fallout.local_var(5) == 0 then
        fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(7200), 1)
    end
    if fallout.tile_distance_objs(fallout.dude_obj(), fallout.self_obj()) < fallout.get_critter_stat(fallout.dude_obj(), 1) then
        fallout.display_msg(fallout.message_str(440, 100))
        fallout.float_msg(fallout.self_obj(), fallout.message_str(440, 101), 0)
    end
end

function map_exit_p_proc()
    fallout.rm_timer_event(fallout.self_obj())
end

local exports = {}
exports.start = start
exports.look_at_p_proc = look_at_p_proc
exports.map_enter_p_proc = map_enter_p_proc
exports.talk_p_proc = talk_p_proc
exports.use_skill_on_p_proc = use_skill_on_p_proc
exports.use_obj_on_p_proc = use_obj_on_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.combat_p_proc = combat_p_proc
exports.description_p_proc = description_p_proc
exports.critter_p_proc = critter_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.timed_event_p_proc = timed_event_p_proc
exports.map_exit_p_proc = map_exit_p_proc
return exports
