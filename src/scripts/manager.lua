local fallout = require("fallout")
local misc = require("lib.misc")
local reputation = require("lib.reputation")

local start
local pickup_p_proc
local timed_event_p_proc
local talk_p_proc
local critter_p_proc
local destroy_p_proc
local look_at_p_proc
local ghoulcbt
local ghoul00
local ghoul01
local ghoul02
local ghoul03
local ghoul04
local ghoul05
local ghoul05a
local ghoul06
local ghoul07
local ghoul08
local ghoul09
local ghoul10
local ghoul11

local hostile = false
local initialized = false
local noevent = false
local loopcount = 0

function start()
    if not initialized then
        misc.set_team(fallout.self_obj(), 32)
        initialized = true
    end

    local script_action = fallout.script_action()
    if script_action == 22 then
        timed_event_p_proc()
    elseif script_action == 11 then
        talk_p_proc()
    elseif script_action == 21 or script_action == 3 then
        look_at_p_proc()
    elseif script_action == 4 then
        pickup_p_proc()
    elseif script_action == 12 then
        critter_p_proc()
    elseif script_action == 18 then
        destroy_p_proc()
    end
end

function pickup_p_proc()
    hostile = true
end

function timed_event_p_proc()
    if fallout.fixed_param() == 1 then
        hostile = true
    else
        if fallout.local_var(0) == 0 then
            fallout.dialogue_system_enter()
        end
    end
end

function talk_p_proc()
    fallout.start_gdialog(82, fallout.self_obj(), 4, -1, -1)
    fallout.gsay_start()
    if fallout.local_var(0) ~= 0 then
        ghoul08()
    else
        fallout.set_local_var(0, 1)
        ghoul00()
    end
    fallout.gsay_end()
    fallout.end_dialogue()
end

function critter_p_proc()
    if hostile then
        hostile = false
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    else
        loopcount = loopcount + 1
        if loopcount > 40 then
            loopcount = 0
            local self_obj = fallout.self_obj()
            local dude_obj = fallout.dude_obj()
            if fallout.tile_distance_objs(self_obj, dude_obj) < 7 then
                if fallout.obj_can_see_obj(self_obj, dude_obj) then
                    if not noevent then
                        noevent = true
                        fallout.add_timer_event(self_obj, fallout.game_ticks(5), 0)
                    end
                end
            end
        end
    end
end

function destroy_p_proc()
    reputation.inc_evil_critter()
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(82, 100))
end

function ghoulcbt()
    fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(2), 1)
end

function ghoul00()
    fallout.gsay_reply(82, 101)
    fallout.giq_option(6, 82, 102, ghoul01, 50)
    fallout.giq_option(4, 82, 103, ghoul04, 50)
    fallout.giq_option(4, 82, 118, ghoul09, 50)
    fallout.giq_option(3, 82, 104, ghoul05, 50)
    fallout.giq_option(-3, 82, 105, ghoul01, 50)
end

function ghoul01()
    fallout.gsay_reply(82, 106)
    fallout.giq_option(6, 82, 107, ghoul02, 50)
    fallout.giq_option(6, 82, 108, ghoul03, 50)
end

function ghoul02()
    fallout.gsay_message(82, 109, 50)
end

function ghoul03()
    fallout.gsay_message(82, 110, 50)
end

function ghoul04()
    fallout.gsay_message(82, 111, 50)
end

function ghoul05()
    fallout.gsay_reply(82, 112)
    fallout.giq_option(6, 82, 113, ghoul07, 50)
    fallout.giq_option(8, 82, 114, ghoul05a, 50)
end

function ghoul05a()
    if fallout.is_success(fallout.do_check(fallout.dude_obj(), 14, 0)) then
        ghoul06()
    else
        ghoul07()
    end
end

function ghoul06()
    fallout.gsay_message(82, 115, 50)
end

function ghoul07()
    fallout.gsay_message(82, 116, 50)
    ghoulcbt()
end

function ghoul08()
    fallout.gsay_message(82, 117, 50)
end

function ghoul09()
    fallout.gsay_reply(82, 119)
    fallout.giq_option(4, 82, 120, ghoul10, 50)
    fallout.giq_option(4, 82, 121, ghoul11, 50)
end

function ghoul10()
    fallout.gsay_message(82, 122, 50)
end

function ghoul11()
    fallout.gsay_message(82, 123, 50)
end

local exports = {}
exports.start = start
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.critter_p_proc = critter_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
exports.timed_event_p_proc = timed_event_p_proc
return exports
