local fallout = require("fallout")
local misc = require("lib.misc")
local reputation = require("lib.reputation")

local start
local combat
local critter_p_proc
local pickup_p_proc
local talk_p_proc
local destroy_p_proc
local timed_event_p_proc
local look_at_p_proc
local combat_p_proc
local gideon00
local gideon01
local gideon01a
local gideon02
local gideon02a
local gideon03
local gideon04
local gideon04a
local gideon04b
local gideon04c
local gideon05
local gideon05a
local gideon05b
local gideon06
local gideon06a
local gideon07
local gideon07a
local gideon07b
local gideon07c
local gideon08
local gideon09
local gideon09a
local gideon09b
local gideon09c
local gideon10
local gideon11
local gideon12
local gideon12a
local gideon12b
local gideon13
local gideon13a
local gideonnull
local dialog_end

local hostile = false
local initialized = false

function start()
    if not initialized then
        local self_obj = fallout.self_obj()
        misc.set_team(self_obj, 50)
        misc.set_ai(self_obj, 67)
        initialized = true
    end

    local script_action = fallout.script_action()
    if script_action == 21 then
        look_at_p_proc()
    elseif script_action == 13 then
        combat_p_proc()
    elseif script_action == 4 then
        pickup_p_proc()
    elseif script_action == 11 then
        talk_p_proc()
    elseif script_action == 22 then
        timed_event_p_proc()
    elseif script_action == 12 then
        critter_p_proc()
    elseif script_action == 18 then
        destroy_p_proc()
    end
end

function combat()
    fallout.use_obj(fallout.external_var("contpan"))
    hostile = true
end

function critter_p_proc()
    if hostile then
        hostile = false
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    end
end

function pickup_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        hostile = true
    end
end

function talk_p_proc()
    fallout.start_gdialog(671, fallout.self_obj(), 4, -1, -1)
    fallout.gsay_start()
    if fallout.local_var(4) == 0 then
        gideon00()
    else
        gideon01()
    end
    fallout.set_local_var(4, 1)
    fallout.gsay_end()
    fallout.end_dialogue()
end

function destroy_p_proc()
    reputation.inc_evil_critter()
end

function timed_event_p_proc()
    fallout.animate_move_obj_to_tile(fallout.self_obj(), 15319, 0)
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(671, 100))
end

function combat_p_proc()
end

function gideon00()
    fallout.gsay_reply(671, 101)
    fallout.giq_option(8, 671, 102, gideon03, 49 + fallout.random(0, 2))
    fallout.giq_option(4, 671, 103, gideon02, 49 + fallout.random(0, 2))
    fallout.giq_option(4, 671, 104, gideon07, 49 + fallout.random(0, 2))
    if reputation.has_rep_berserker() then
        fallout.giq_option(4, 671, 105, gideon07, 49 + fallout.random(0, 2))
    end
    fallout.giq_option(-3, 671, 106, gideon08, 49 + fallout.random(0, 2))
end

function gideon01()
    fallout.gsay_reply(671, 107)
    fallout.giq_option(8, 671, 108, gideon04, 49 + fallout.random(0, 2))
    fallout.giq_option(4, 671, 109, dialog_end, 49 + fallout.random(0, 2))
    fallout.giq_option(4, 671, 112, gideon01a, 49 + fallout.random(0, 2))
end

function gideon01a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, -20)) then
        gideon03()
    else
        gideon08()
    end
end

function gideon02()
    fallout.gsay_reply(671, 113)
    fallout.giq_option(4, 671, 114, dialog_end, 49 + fallout.random(0, 2))
    fallout.giq_option(4, 671, 112, gideon02a, 49 + fallout.random(0, 2))
    fallout.giq_option(-3, 671, 115, gideon08, 49 + fallout.random(0, 2))
end

function gideon02a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, -20)) then
        gideon09()
    else
        gideon08()
    end
end

function gideon03()
    fallout.gsay_reply(671, 116)
    fallout.giq_option(8, 671, 108, gideon04, 49 + fallout.random(0, 2))
    fallout.giq_option(4, 671, 117, gideon04, 49 + fallout.random(0, 2))
    fallout.giq_option(4, 671, 118, dialog_end, 49 + fallout.random(0, 2))
end

function gideon04()
    fallout.gsay_reply(671, 119)
    fallout.giq_option(8, 671, 120, gideon05, 49 + fallout.random(0, 2))
    fallout.giq_option(4, 671, 121, gideon04a, 49 + fallout.random(0, 2))
    fallout.giq_option(4, 671, 122, gideon04b, 49 + fallout.random(0, 2))
    fallout.giq_option(4, 671, 124, dialog_end, 49 + fallout.random(0, 2))
end

function gideon04a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, -30)) then
        gideon05()
    else
        gideon08()
    end
end

function gideon04b()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, -30)) then
        gideon03()
    else
        gideon11()
    end
end

function gideon04c()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, -30)) then
        gideon07()
    else
        gideon08()
    end
end

function gideon05()
    fallout.gsay_reply(671, 125)
    fallout.giq_option(8, 671, 126, gideon06, 49 + fallout.random(0, 2))
    fallout.giq_option(4, 671, 127, gideon05a, 49 + fallout.random(0, 2))
    if reputation.has_rep_berserker() then
        fallout.giq_option(4, 671, 128, gideon05b, 49 + fallout.random(0, 2))
    end
    fallout.giq_option(4, 671, 129, dialog_end, 49 + fallout.random(0, 2))
end

function gideon05a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, -20)) then
        gideon07()
    else
        gideon11()
    end
end

function gideon05b()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, -20)) then
        gideon10()
    else
        gideon06()
    end
end

function gideon06()
    fallout.gsay_reply(671, 130)
    fallout.giq_option(8, 671, 131, gideonnull, 49 + fallout.random(0, 2))
    if reputation.has_rep_berserker() then
        fallout.giq_option(4, 671, 132, combat, 49 + fallout.random(0, 2))
    end
    fallout.giq_option(4, 671, 133, gideon06a, 49 + fallout.random(0, 2))
    fallout.giq_option(4, 671, 134, dialog_end, 49 + fallout.random(0, 2))
end

function gideon06a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, -30)) then
        gideonnull()
    else
        gideon08()
    end
end

function gideon07()
    fallout.gsay_reply(671, 135)
    if reputation.has_rep_berserker() then
        fallout.giq_option(4, 671, 136, gideon07b, 49 + fallout.random(0, 2))
    end
    fallout.giq_option(4, 671, 137, gideon07c, 49 + fallout.random(0, 2))
    fallout.giq_option(4, 671, 138, dialog_end, 49 + fallout.random(0, 2))
end

function gideon07a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, -30)) then
        gideon10()
    else
        gideon08()
    end
end

function gideon07b()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, -20)) then
        gideon10()
    else
        gideon11()
    end
end

function gideon07c()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, -30)) then
        gideon06()
    else
        gideon10()
    end
end

function gideon08()
    fallout.gsay_message(671, 139, 49 + fallout.random(0, 2))
    dialog_end()
end

function gideon09()
    fallout.gsay_reply(671, 107)
    fallout.giq_option(4, 671, 141, gideon09a, 49 + fallout.random(0, 2))
    fallout.giq_option(4, 671, 127, gideon09b, 49 + fallout.random(0, 2))
    fallout.giq_option(4, 671, 124, dialog_end, 49 + fallout.random(0, 2))
end

function gideon09a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, -30)) then
        gideon04()
    else
        gideon08()
    end
end

function gideon09b()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, -20)) then
        gideon07()
    else
        gideon11()
    end
end

function gideon09c()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, -30)) then
        gideon10()
    else
        gideon08()
    end
end

function gideon10()
    fallout.gsay_message(671, 143, 49 + fallout.random(0, 2))
    combat()
end

function gideon11()
    fallout.gsay_message(671, 144, 49 + fallout.random(0, 2))
    dialog_end()
end

function gideon12()
    fallout.gsay_reply(671, 145)
    fallout.giq_option(8, 671, 146, gideon06, 49 + fallout.random(0, 2))
    fallout.giq_option(4, 671, 147, gideon12a, 49 + fallout.random(0, 2))
    fallout.giq_option(4, 671, 148, gideon13, 49 + fallout.random(0, 2))
    if reputation.has_rep_berserker() then
        fallout.giq_option(4, 671, 136, gideon12a, 49 + fallout.random(0, 2))
    end
    fallout.giq_option(4, 671, 150, dialog_end, 49 + fallout.random(0, 2))
end

function gideon12a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        gideon13()
    else
        gideon07()
    end
end

function gideon12b()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        gideon10()
    else
        gideon08()
    end
end

function gideon13()
    fallout.gsay_reply(671, 130)
    fallout.giq_option(8, 671, 131, gideonnull, 49 + fallout.random(0, 2))
    if reputation.has_rep_berserker() then
        fallout.giq_option(4, 671, 132, combat, 49 + fallout.random(0, 2))
    end
    fallout.giq_option(4, 671, 133, gideon13a, 49 + fallout.random(0, 2))
    fallout.giq_option(4, 671, 151, gideon07, 49 + fallout.random(0, 2))
    fallout.giq_option(4, 671, 134, dialog_end, 49 + fallout.random(0, 2))
end

function gideon13a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, -30)) then
        gideonnull()
    else
        gideon08()
    end
end

function gideonnull()
    if fallout.local_var(5) == 0 then
        fallout.set_local_var(5, 1)
        fallout.use_obj(fallout.external_var("contpan"))
        fallout.use_obj(fallout.dude_obj())
        fallout.add_obj_to_inven(fallout.dude_obj(), fallout.create_object_sid(123, 0, 0, -1))
        local xp = 1000
        fallout.display_msg(fallout.message_str(671, 501) .. xp .. fallout.message_str(671, 502))
        fallout.give_exp_points(xp)
        fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(10), 1)
    end
end

function dialog_end()
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.timed_event_p_proc = timed_event_p_proc
exports.look_at_p_proc = look_at_p_proc
exports.combat_p_proc = combat_p_proc
return exports
