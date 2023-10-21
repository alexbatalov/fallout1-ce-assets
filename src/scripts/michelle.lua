local fallout = require("fallout")
local reputation = require("lib.reputation")
local time = require("lib.time")

local start
local critter_p_proc
local destroy_p_proc
local look_at_p_proc
local pickup_p_proc
local timed_event_p_proc
local talk_p_proc
local show_true_name
local show_false_name
local Michelle00
local Michelle01
local Michelle02
local Michelle03
local Michelle04
local Michelle05
local Michelle06
local Michelle07
local Michelle08
local Michelle09
local Michelle10
local Michelle11
local Michelle12
local Michelle13
local Michelle14
local Michelle15
local Michelle16
local Michelle17
local MichelleCombat
local MichelleEnd

local hostile = 0
local initialized = false

function start()
    if not initialized then
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 47)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 27)
        initialized = true
    else
        if fallout.script_action() == 12 then
            critter_p_proc()
        else
            if fallout.script_action() == 18 then
                destroy_p_proc()
            else
                if fallout.script_action() == 21 then
                    look_at_p_proc()
                else
                    if fallout.script_action() == 4 then
                        pickup_p_proc()
                    else
                        if fallout.script_action() == 11 then
                            talk_p_proc()
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

function critter_p_proc()
    if fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) and (fallout.global_var(136) < 41) then
        hostile = 1
    end
    if hostile then
        hostile = 0
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    end
end

function destroy_p_proc()
    fallout.set_global_var(136, fallout.global_var(136) - 1)
    reputation.inc_good_critter()
end

function look_at_p_proc()
    if ((fallout.global_var(135) == 2) or fallout.get_critter_stat(fallout.dude_obj(), 6)) > 6 then
        show_true_name()
    else
        if fallout.get_critter_stat(fallout.dude_obj(), 6) < 4 then
            show_false_name()
        else
            if fallout.get_critter_stat(fallout.dude_obj(), 4) < 5 then
                show_false_name()
            else
                if fallout.random(0, 1) then
                    show_false_name()
                else
                    show_true_name()
                end
            end
        end
    end
end

function pickup_p_proc()
    hostile = 1
end

function timed_event_p_proc()
    if fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) then
        hostile = 1
    end
end

function talk_p_proc()
    fallout.start_gdialog(283, fallout.self_obj(), 4, -1, -1)
    fallout.gsay_start()
    fallout.set_local_var(0, 1)
    if time.is_night() then
        Michelle15()
    else
        if fallout.global_var(135) == 1 then
            Michelle16()
        else
            if fallout.global_var(135) == 2 then
                Michelle17()
            else
                Michelle00()
            end
        end
    end
    fallout.gsay_end()
    fallout.end_dialogue()
end

function show_true_name()
    fallout.script_overrides()
    if fallout.local_var(0) ~= 0 then
        fallout.display_msg(fallout.message_str(283, 100))
    else
        fallout.display_msg(fallout.message_str(283, 103))
    end
end

function show_false_name()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(283, fallout.random(104, 110)))
end

function Michelle00()
    fallout.gsay_reply(283, 111)
    fallout.giq_option(-3, 283, 112, Michelle01, 50)
    fallout.giq_option(4, 283, 113, Michelle02, 50)
    fallout.giq_option(5, 283, 114, Michelle09, 50)
    fallout.giq_option(4, 283, 115, MichelleCombat, 50)
end

function Michelle01()
    fallout.gsay_reply(283, 116)
    fallout.giq_option(-3, 283, 117, MichelleCombat, 50)
    fallout.giq_option(-3, 283, 118, MichelleEnd, 50)
end

function Michelle02()
    fallout.gsay_reply(283, 119)
    fallout.giq_option(4, 283, 120, Michelle03, 50)
    fallout.giq_option(5, 283, 121, Michelle04, 50)
    fallout.giq_option(5, 283, 122, Michelle08, 50)
    fallout.giq_option(4, 283, 123, MichelleCombat, 50)
end

function Michelle03()
    fallout.gsay_message(283, 124, 50)
    MichelleCombat()
end

function Michelle04()
    fallout.gsay_reply(283, 125)
    fallout.giq_option(5, 283, 126, Michelle05, 50)
    fallout.giq_option(5, 283, 127, Michelle06, 50)
    fallout.giq_option(7, 283, 128, Michelle07, 50)
end

function Michelle05()
    fallout.gsay_reply(283, 129)
    fallout.giq_option(5, 283, 130, MichelleEnd, 50)
    fallout.giq_option(5, 283, 131, MichelleEnd, 50)
end

function Michelle06()
    fallout.gsay_message(283, 132, 50)
    MichelleCombat()
end

function Michelle07()
    fallout.gsay_message(283, 133, 50)
    MichelleCombat()
end

function Michelle08()
    fallout.gsay_message(283, 134, 50)
    MichelleCombat()
end

function Michelle09()
    fallout.gsay_reply(283, 135)
    fallout.giq_option(5, 283, 136, Michelle10, 50)
    fallout.giq_option(5, 283, 137, Michelle11, 50)
    fallout.giq_option(5, 283, 138, Michelle04, 50)
    fallout.giq_option(5, 283, 139, Michelle12, 50)
    fallout.giq_option(5, 283, 140, MichelleCombat, 50)
end

function Michelle10()
    fallout.gsay_message(283, 141, 50)
    MichelleCombat()
end

function Michelle11()
    fallout.gsay_message(283, fallout.message_str(283, 142) .. " " .. fallout.message_str(283, 143), 50)
    MichelleCombat()
end

function Michelle12()
    fallout.gsay_reply(283, 144)
    fallout.giq_option(5, 283, 145, Michelle13, 50)
    fallout.giq_option(5, 283, 146, Michelle14, 50)
    fallout.giq_option(5, 283, 147, MichelleCombat, 50)
end

function Michelle13()
    fallout.gsay_message(283, 148, 50)
end

function Michelle14()
    fallout.gsay_message(283, 149, 50)
    MichelleCombat()
end

function Michelle15()
    fallout.gsay_message(283, 150, 50)
    fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(10), 1)
end

function Michelle16()
    fallout.gsay_message(283, 151, 50)
end

function Michelle17()
    fallout.gsay_message(283, 152, 50)
end

function MichelleCombat()
    hostile = 1
end

function MichelleEnd()
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.timed_event_p_proc = timed_event_p_proc
exports.talk_p_proc = talk_p_proc
return exports
