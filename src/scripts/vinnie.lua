local fallout = require("fallout")
local misc = require("lib.misc")
local reputation = require("lib.reputation")
local time = require("lib.time")

local start
local critter_p_proc
local destroy_p_proc
local look_at_p_proc
local map_enter_p_proc
local pickup_p_proc
local talk_p_proc
local Vinnie01
local Vinnie01a
local Vinnie02
local Vinnie03
local Vinnie04
local Vinnie05
local Vinnie06
local Vinnie07
local Vinnie08
local Vinnie09
local Vinnie10
local Vinnie14
local Vinnie14a
local Vinnie15
local Vinnie15a
local Vinnie16
local Vinnie17
local Vinnie18
local Vinnie19
local Vinnie20
local Vinnie21
local Vinnie22
local Vinnie23
local Vinnie24
local Vinnie25
local VinnieEnd
local VinnieCombat
local VinnieKillNeal

local hostile = false
local line160flag = false
local line162flag = false
local Vinnie_kill_Neal = false

local combat_p_proc
local timed_event_p_proc

function start()
    local script_action = fallout.script_action()
    if script_action == 12 then
        critter_p_proc()
    elseif script_action == 18 then
        destroy_p_proc()
    elseif script_action == 15 then
        map_enter_p_proc()
    elseif script_action == 21 then
        look_at_p_proc()
    elseif script_action == 4 then
        pickup_p_proc()
    elseif script_action == 11 then
        talk_p_proc()
    end
end

function critter_p_proc()
    if hostile then
        hostile = false
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    else
        if fallout.cur_map_index() == 11 and not line160flag then
            fallout.float_msg(fallout.self_obj(), fallout.message_str(385, 160), 2)
            fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(4), 1)
            line160flag = true
        end
    end
end

function destroy_p_proc()
    reputation.inc_evil_critter()
    if fallout.cur_map_index() == 11 then
        fallout.set_map_var(0, fallout.map_var(0) - 1)
    end
end

function look_at_p_proc()
    fallout.script_overrides()
    if fallout.local_var(0) ~= 0 then
        fallout.display_msg(fallout.message_str(385, 100))
    else
        fallout.display_msg(fallout.message_str(385, 101))
    end
end

function map_enter_p_proc()
    local self_obj = fallout.self_obj()
    misc.set_team(self_obj, 14)
    fallout.critter_add_trait(self_obj, 1, 5, 59)
    if fallout.global_var(555) == 2 or (fallout.cur_map_index() == 11 and fallout.global_var(284) == 1) then
        fallout.move_to(self_obj, 7000, 0)
        fallout.set_obj_visibility(self_obj, 1)
        fallout.set_external_var("removal_ptr", self_obj)
    end
end

function pickup_p_proc()
    hostile = true
end

function talk_p_proc()
    if fallout.global_var(285) == 2 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(385, 171), 4)
    elseif fallout.global_var(284) == 1 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(385, 170), 2)
    else
        fallout.start_gdialog(385, fallout.self_obj(), 4, -1, -1)
        fallout.gsay_start()
        if fallout.global_var(285) == 1 then
            Vinnie24()
        elseif fallout.local_var(2) == 1 then
            Vinnie19()
        elseif fallout.local_var(0) == 1 then
            Vinnie10()
        else
            Vinnie01()
        end
        fallout.gsay_end()
        fallout.end_dialogue()
    end
    if fallout.local_var(1) == 1 then
        fallout.display_msg(fallout.message_str(385, 163))
        fallout.give_exp_points(400)
        fallout.set_global_var(155, fallout.global_var(155) - 1)
        fallout.set_local_var(1, 2)
        if fallout.global_var(284) == 0 then
            fallout.set_global_var(283, time.game_time_in_days() + 2)
        end
    end
    if Vinnie_kill_Neal then
        Vinnie_kill_Neal = false
        fallout.load_map(11, 7)
    end
    if (fallout.global_var(283) > time.game_time_in_days()) and (fallout.global_var(284) == 0) then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(385, 159), 4)
    end
end

function Vinnie01()
    fallout.set_local_var(0, 1)
    fallout.gsay_reply(385, 103)
    fallout.giq_option(4, 385, 104, Vinnie02, 50)
    fallout.giq_option(4, 385, 105, Vinnie03, 50)
    if fallout.global_var(282) == 1 then
        fallout.giq_option(4, 385, 102, Vinnie01a, 50)
    end
    fallout.giq_option(-3, 385, 106, Vinnie04, 50)
end

function Vinnie01a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        Vinnie14()
    else
        Vinnie15()
    end
end

function Vinnie02()
    fallout.gsay_message(385, 107, 51)
end

function Vinnie03()
    fallout.gsay_reply(385, 108)
    fallout.giq_option(4, 385, 109, VinnieEnd, 50)
    fallout.giq_option(4, 385, 110, Vinnie06, 50)
    fallout.giq_option(6, 385, 111, Vinnie05, 50)
end

function Vinnie04()
    fallout.gsay_message(385, 112, 50)
end

function Vinnie05()
    fallout.gsay_reply(385, 113)
    fallout.giq_option(4, 385, 114, VinnieEnd, 50)
    fallout.giq_option(6, 385, 115, Vinnie07, 50)
end

function Vinnie06()
    fallout.gsay_message(385, 116, 51)
    VinnieCombat()
end

function Vinnie07()
    fallout.gsay_reply(385, 117)
    fallout.giq_option(4, 385, 118, VinnieEnd, 50)
    fallout.giq_option(6, 385, 119, Vinnie08, 50)
end

function Vinnie08()
    fallout.gsay_reply(385, 120)
    fallout.giq_option(4, 385, 121, VinnieEnd, 50)
    if fallout.global_var(39) ~= 0 then
        fallout.giq_option(6, 385, 122, Vinnie09, 50)
    end
end

function Vinnie09()
    fallout.gsay_message(385, 123, 50)
end

function Vinnie10()
    fallout.gsay_reply(385, 126)
    fallout.giq_option(4, 385, 127, VinnieEnd, 50)
    if fallout.global_var(282) == 1 then
        fallout.giq_option(4, 385, 102, Vinnie01a, 50)
    end
end

function Vinnie14()
    fallout.gsay_reply(385, 131)
    if reputation.has_rep_berserker() then
        fallout.giq_option(4, 385, 132, VinnieCombat, 51)
    end
    fallout.giq_option(4, 385, 133, Vinnie16, 50)
    fallout.giq_option(4, 385, 134, Vinnie14a, 50)
end

function Vinnie14a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        Vinnie16()
    else
        Vinnie15()
    end
end

function Vinnie15()
    fallout.gsay_reply(385, 135)
    fallout.giq_option(4, 385, 136, Vinnie15a, 50)
    if reputation.has_rep_berserker() then
        fallout.giq_option(4, 385, 137, VinnieCombat, 51)
    end
    fallout.giq_option(4, 385, 138, VinnieEnd, 50)
    fallout.giq_option(4, 385, 139, Vinnie03, 50)
end

function Vinnie15a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        Vinnie16()
    else
        Vinnie04()
    end
end

function Vinnie16()
    fallout.gsay_reply(385, 140)
    if fallout.global_var(284) == 1 then
        fallout.giq_option(4, 385, 145, Vinnie22, 49)
    else
        if fallout.global_var(286) == 1 then
            fallout.giq_option(4, 385, 144, Vinnie19, 49)
        else
            fallout.giq_option(4, 385, 141, Vinnie17, 50)
        end
    end
    fallout.giq_option(4, 385, 142, Vinnie18, 51)
    fallout.giq_option(4, 385, 143, Vinnie04, 51)
end

function Vinnie17()
    fallout.set_local_var(2, 1)
    fallout.gsay_message(385, 146, 49)
end

function Vinnie18()
    fallout.gsay_message(385, 147, 51)
end

function Vinnie19()
    fallout.gsay_reply(385, 148)
    if fallout.obj_is_carrying_obj_pid(fallout.dude_obj(), 112) then
        fallout.giq_option(4, 385, 149, Vinnie20, 49)
    else
        fallout.giq_option(4, 385, 150, Vinnie21, 51)
    end
    if fallout.global_var(284) == 1 then
        fallout.giq_option(4, 385, 151, Vinnie22, 49)
    end
end

function Vinnie20()
    fallout.set_local_var(2, 0)
    if fallout.local_var(1) == 0 then
        fallout.set_local_var(1, 1)
    end
    if fallout.global_var(284) == 1 then
        Vinnie22()
    else
        fallout.set_global_var(283, time.game_time_in_days() + 2)
        fallout.gsay_reply(385, 152)
        fallout.giq_option(4, 385, 153, Vinnie06, 51)
        fallout.giq_option(4, 385, 154, VinnieKillNeal, 49)
        fallout.giq_option(5, 385, 155, Vinnie23, 50)
    end
end

function Vinnie21()
    fallout.gsay_message(385, 156, 51)
end

function Vinnie22()
    fallout.set_local_var(2, 0)
    fallout.set_global_var(285, 2)
    fallout.gsay_message(385, 157, 49)
end

function Vinnie23()
    fallout.set_global_var(285, 1)
    fallout.gsay_message(385, 158, 50)
end

function Vinnie24()
    fallout.gsay_reply(385, 165)
    fallout.giq_option(4, 385, 166, VinnieKillNeal, 49)
    fallout.giq_option(4, 385, 167, Vinnie23, 50)
    fallout.giq_option(4, 385, 168, Vinnie25, 51)
end

function Vinnie25()
    fallout.gsay_message(385, 169, 51)
    VinnieCombat()
end

function VinnieEnd()
end

function VinnieCombat()
    hostile = true
end

function VinnieKillNeal()
    fallout.set_global_var(285, 2)
    Vinnie_kill_Neal = true
end

function combat_p_proc()
    if fallout.cur_map_index() == 11 then
        if fallout.map_var(1) ~= 0 and not line162flag then
            fallout.float_msg(fallout.self_obj(), fallout.message_str(385, 162), 2)
            line162flag = true
        end
    end
end

function timed_event_p_proc()
    if fallout.fixed_param() == 1 then
        fallout.attack(fallout.external_var("Neal_ptr"), 0, 1, 0, 0, 30000, 0, 0)
    end
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
exports.map_enter_p_proc = map_enter_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.combat_p_proc = combat_p_proc
exports.timed_event_p_proc = timed_event_p_proc
return exports
