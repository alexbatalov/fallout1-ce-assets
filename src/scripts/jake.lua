local fallout = require("fallout")
local reputation = require("lib.reputation")
local time = require("lib.time")

local start
local critter_p_proc
local destroy_p_proc
local look_at_p_proc
local map_update_p_proc
local pickup_p_proc
local talk_p_proc
local timed_event_p_proc
local Jake00
local Jake01
local Jake02
local Jake03
local Jake04
local Jake05
local Jake06
local Jake07
local Jake08
local Jake09
local Jake10
local Jake11
local Jake12
local Jake13
local Jake14
local Jake15
local Jake16
local Jake17
local Jake18
local JakeCombat
local JakeEnd

local hostile = 0
local initialized = 0

function start()
    if not(initialized) then
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 34)
        initialized = 1
    else
        if fallout.script_action() == 12 then
            critter_p_proc()
        else
            if fallout.script_action() == 22 then
                timed_event_p_proc()
            else
                if fallout.script_action() == 18 then
                    destroy_p_proc()
                else
                    if fallout.script_action() == 21 then
                        look_at_p_proc()
                    else
                        if fallout.script_action() == 23 then
                            map_update_p_proc()
                        else
                            if fallout.script_action() == 4 then
                                pickup_p_proc()
                            else
                                if fallout.script_action() == 11 then
                                    talk_p_proc()
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

function critter_p_proc()
    if fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) and (fallout.map_var(1) == 1) then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(268, 143), 3)
        fallout.animate_move_obj_to_tile(fallout.self_obj(), 15484, 0)
        fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(15), 1)
    end
    if fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) and (fallout.map_var(1) == 2) then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(268, 144), 3)
        hostile = 1
    end
    if hostile then
        hostile = 0
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    end
end

function destroy_p_proc()
    reputation.inc_evil_critter()
end

function look_at_p_proc()
    fallout.script_overrides()
    if fallout.local_var(4) == 1 then
        fallout.display_msg(fallout.message_str(268, 100))
    else
        fallout.display_msg(fallout.message_str(268, 101))
    end
end

function map_update_p_proc()
    if fallout.global_var(129) == 2 then
        fallout.kill_critter(fallout.self_obj(), 57)
    end
end

function pickup_p_proc()
    hostile = 1
end

function talk_p_proc()
    if not(fallout.local_var(5)) then
        fallout.start_gdialog(268, fallout.self_obj(), 4, -1, -1)
        fallout.gsay_start()
        fallout.set_local_var(4, 1)
        if time.is_night() then
            Jake14()
        else
            if fallout.global_var(132) then
                Jake17()
            else
                if fallout.global_var(133) == 2 then
                    Jake16()
                else
                    if fallout.global_var(133) == 1 then
                        Jake15()
                    else
                        Jake00()
                    end
                end
            end
        end
        fallout.gsay_end()
        fallout.end_dialogue()
    end
end

function timed_event_p_proc()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(268, 143), 3)
    fallout.set_map_var(1, 2)
end

function Jake00()
    fallout.gsay_reply(268, 102)
    fallout.giq_option(-3, 268, 103, Jake01, 50)
    fallout.giq_option(4, 268, 104, Jake02, 50)
    fallout.giq_option(4, 268, 105, Jake12, 50)
    fallout.giq_option(4, 268, 106, Jake13, 50)
    if (fallout.global_var(129) == 1) and (fallout.obj_is_carrying_obj_pid(fallout.dude_obj(), 72) ~= 0) then
        fallout.giq_option(4, 268, 141, Jake18, 50)
    end
end

function Jake01()
    fallout.gsay_message(268, 107, 50)
end

function Jake02()
    fallout.gsay_reply(268, 108)
    fallout.giq_option(4, 268, 109, Jake03, 50)
    fallout.giq_option(4, 268, 110, JakeEnd, 50)
    fallout.giq_option(4, 268, 111, Jake04, 50)
end

function Jake03()
    fallout.gsay_reply(268, 112)
    fallout.giq_option(4, 268, 113, JakeEnd, 50)
end

function Jake04()
    fallout.gsay_reply(268, 114)
    fallout.giq_option(4, 268, 115, Jake05, 50)
    fallout.giq_option(4, 268, 116, Jake06, 50)
end

function Jake05()
    fallout.gsay_message(268, 117, 50)
    fallout.set_local_var(5, 1)
end

function Jake06()
    fallout.gsay_reply(268, 118)
    fallout.giq_option(4, 268, 119, Jake07, 50)
    fallout.giq_option(4, 268, 120, Jake11, 50)
end

function Jake07()
    fallout.gsay_reply(268, 121)
    fallout.giq_option(4, 268, 122, Jake08, 50)
    fallout.giq_option(4, 268, 123, Jake09, 50)
    fallout.giq_option(4, 268, 124, Jake10, 50)
end

function Jake08()
    fallout.set_global_var(133, 1)
    fallout.gsay_message(268, 125, 50)
end

function Jake09()
    fallout.gsay_reply(268, 126)
    fallout.giq_option(4, 268, 127, Jake08, 50)
    fallout.giq_option(4, 268, 128, Jake10, 50)
end

function Jake10()
    fallout.gsay_message(268, 129, 50)
    JakeCombat()
end

function Jake11()
    fallout.gsay_message(268, 130, 50)
end

function Jake12()
    fallout.gsay_reply(268, 131)
    fallout.giq_option(4, 268, 132, Jake07, 50)
    fallout.giq_option(4, 268, 133, Jake08, 50)
    fallout.giq_option(4, 268, 134, Jake09, 50)
    fallout.giq_option(4, 268, 135, Jake10, 50)
end

function Jake13()
    fallout.gsay_message(268, 136, 50)
end

function Jake14()
    fallout.gsay_message(268, 137, 50)
end

function Jake15()
    fallout.gsay_message(268, 138, 50)
end

function Jake16()
    fallout.gsay_message(268, 139, 50)
end

function Jake17()
    fallout.gsay_message(268, 140, 50)
end

function Jake18()
    local v0 = 0
    v0 = fallout.obj_carrying_pid_obj(fallout.dude_obj(), 72)
    fallout.rm_obj_from_inven(fallout.dude_obj(), v0)
    fallout.destroy_object(v0)
    fallout.gsay_message(268, 142, 50)
end

function JakeCombat()
    hostile = 1
end

function JakeEnd()
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
exports.map_update_p_proc = map_update_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.timed_event_p_proc = timed_event_p_proc
return exports
