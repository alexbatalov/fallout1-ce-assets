local fallout = require("fallout")
local misc = require("lib.misc")
local reaction = require("lib.reaction")
local reputation = require("lib.reputation")

local start
local pickup_p_proc
local combat_p_proc
local map_update_p_proc
local talk_p_proc
local critter_p_proc
local destroy_p_proc
local look_at_p_proc
local travel
local no_travel
local pick_start
local Seth01
local Seth02
local Seth03
local Seth04
local Seth05
local Seth06
local Seth07
local Seth08
local Seth08a
local Seth09
local Seth10
local Seth11
local Seth12
local Seth13
local Seth14
local Sethend
local TanSeth00
local TanSeth01
local TanSeth02
local TanSeth03
local TanSeth04
local TanSeth05
local TanSeth06
local TanSeth07

local night_person = false
local wake_time = 0
local sleep_time = 0
local home_tile = 0
local sleep_tile = 0
local hostile = false
local initialized = false
local round_counter = 0

function start()
    local script_action = fallout.script_action()
    if script_action == 13 then
        combat_p_proc()
    elseif script_action == 23 then
        map_update_p_proc()
    elseif script_action == 11 then
        talk_p_proc()
    elseif script_action == 18 then
        destroy_p_proc()
    elseif script_action == 21 or script_action == 3 then
        look_at_p_proc()
    elseif script_action == 4 then
        pickup_p_proc()
    elseif script_action == 18 then
        -- FIXME: Conflicts with `destroy_p_proc`.
        fallout.set_global_var(124, 3)
        reputation.inc_good_critter()
    elseif script_action == 12 then
        critter_p_proc()
    end
end

function pickup_p_proc()
    hostile = true
end

function combat_p_proc()
    if fallout.fixed_param() == 4 then
        round_counter = round_counter + 1
    end
    if round_counter > 3 then
        if fallout.global_var(246) == 0 then
            fallout.set_global_var(246, 1)
            fallout.set_global_var(155, fallout.global_var(155) - 5)
        end
    end
end

function map_update_p_proc()
    if not initialized then
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 2)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 4)
        home_tile = 14108
        sleep_tile = 15925
        wake_time = 600
        sleep_time = 2100
        initialized = true
    end
end

function talk_p_proc()
    reaction.get_reaction()
    if fallout.local_var(9) == 1 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(183, 320), 2)
        hostile = true
    else
        if fallout.global_var(26) == 1 and fallout.get_critter_stat(fallout.dude_obj(), 4) > 3 then
            fallout.set_global_var(218, 1)
            if fallout.local_var(8) == 0 then
                fallout.set_local_var(8, 1)
                fallout.start_gdialog(183, fallout.self_obj(), 4, -1, -1)
                fallout.gsay_start()
                TanSeth00()
                fallout.gsay_end()
                fallout.end_dialogue()
            else
                fallout.start_gdialog(183, fallout.self_obj(), 4, -1, -1)
                fallout.gsay_start()
                TanSeth01()
                fallout.gsay_end()
                fallout.end_dialogue()
            end
        else
            if fallout.local_var(5) == 1 then
                fallout.float_msg(fallout.self_obj(), fallout.message_str(185, 166), 0)
            else
                if fallout.global_var(246) == 1 then
                    fallout.float_msg(fallout.self_obj(), fallout.message_str(183, 101), 2)
                    hostile = true
                else
                    fallout.start_gdialog(183, fallout.self_obj(), 4, -1, -1)
                    fallout.gsay_start()
                    pick_start()
                    fallout.gsay_end()
                    fallout.end_dialogue()
                end
            end
        end
    end
end

function critter_p_proc()
    if fallout.local_var(6) == 0 then
        fallout.set_local_var(6, 1)
        if misc.is_armed(fallout.dude_obj()) then
            fallout.float_msg(fallout.self_obj(), fallout.message_str(183, 204), 8)
        else
            fallout.float_msg(fallout.self_obj(), fallout.message_str(183, 205), 8)
        end
    end
    if hostile then
        hostile = false
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    end
end

function destroy_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.set_global_var(246, 1)
    end
    reputation.inc_good_critter()
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(183, 100))
end

function travel()
    fallout.game_time_advance(fallout.game_ticks(60 * 30))
    if fallout.global_var(43) == 0 and fallout.global_var(43) ~= 2 then
        fallout.set_global_var(43, 1)
    end
    fallout.load_map("caves.map", 1)
end

function no_travel()
    if fallout.global_var(43) == 2 then
        fallout.gsay_message(183, 203, 50)
    else
        fallout.gsay_message(183, 128, 50)
    end
end

function pick_start()
    if fallout.global_var(124) == 0 then
        if fallout.local_var(1) < 2 then
            Seth04()
        else
            Seth05()
        end
    else
        if fallout.global_var(43) == 2 then
            reaction.BigUpReact()
            fallout.gsay_message(183, 200, 49)
            if fallout.get_critter_stat(fallout.dude_obj(), 4) > 3 then
                Seth07()
            end
        else
            if fallout.local_var(1) < 2 then
                Seth09()
            else
                Seth07()
            end
        end
    end
end

function Seth01()
    fallout.gsay_message(183, 101, 50)
    hostile = true
end

function Seth02()
    fallout.gsay_message(183, 102, 50)
    hostile = true
end

function Seth03()
    fallout.gsay_reply(183, 103)
    fallout.set_local_var(4, 1)
    fallout.gsay_option(183, 104, Seth13, 50)
    fallout.gsay_option(183, 105, Seth08a, 50)
end

function Seth04()
    fallout.gsay_reply(183, 106)
    fallout.set_global_var(124, 1)
    fallout.giq_option(4, 183, 107, Seth02, 50)
    fallout.giq_option(4, 183, 108, Seth06, 50)
    fallout.giq_option(-3, 183, 109, Seth03, 50)
end

function Seth05()
    fallout.gsay_reply(183, 110)
    fallout.set_global_var(124, 1)
    fallout.giq_option(4, 183, 111, Seth06, 50)
    fallout.giq_option(-3, 183, 112, Seth03, 50)
end

function Seth06()
    fallout.gsay_reply(183, 113)
    Seth08()
end

function Seth07()
    fallout.gsay_reply(183, 114)
    Seth08()
end

function Seth08()
    if fallout.global_var(43) == 1 then
        fallout.giq_option(4, 183, 115, Seth10, 50)
    end
    if fallout.global_var(26) == 1 then
        fallout.giq_option(4, 183, 116, Seth11, 50)
    end
    fallout.giq_option(4, 183, 117, Seth12, 50)
    if fallout.local_var(4) == 1 and fallout.global_var(43) ~= 2 then
        fallout.giq_option(4, 183, 118, Seth13, 50)
        fallout.giq_option(-3, 183, 119, Seth13, 50)
    end
    fallout.giq_option(4, 183, 120, Seth08a, 50)
end

function Seth08a()
    if fallout.local_var(7) == 0 then
        fallout.set_local_var(7, 1)
        Seth14()
    else
        Sethend()
    end
end

function Seth09()
    fallout.gsay_reply(183, 121)
    if fallout.global_var(43) == 1 then
        fallout.giq_option(4, 183, 115, Seth10, 50)
    end
    if fallout.global_var(26) == 1 then
        fallout.giq_option(4, 183, 116, Seth11, 50)
    end
    fallout.giq_option(4, 183, 117, Seth12, 50)
    if fallout.local_var(4) == 1 then
        fallout.giq_option(4, 183, 118, Seth13, 50)
        fallout.giq_option(-3, 183, 119, Seth13, 50)
    end
    fallout.giq_option(4, 183, 120, Seth08a, 50)
end

function Seth10()
    if fallout.global_var(43) == 2 then
        fallout.gsay_reply(183, 201)
    else
        fallout.gsay_reply(183, 122)
    end
    fallout.set_local_var(4, 1)
    if fallout.global_var(26) == 1 then
        fallout.giq_option(4, 183, 116, Seth11, 50)
    end
    fallout.giq_option(4, 183, 117, Seth12, 50)
    if fallout.local_var(4) == 1 then
        fallout.giq_option(4, 183, 118, Seth13, 50)
        fallout.giq_option(-3, 183, 119, Seth13, 50)
    end
    fallout.giq_option(4, 183, 120, Seth08a, 50)
end

function Seth11()
    fallout.set_global_var(69, 1)
    fallout.gsay_reply(183, 123)
    if fallout.global_var(43) == 1 then
        fallout.giq_option(4, 183, 115, Seth10, 50)
    end
    fallout.giq_option(4, 183, 117, Seth12, 50)
    if fallout.local_var(4) == 1 then
        fallout.giq_option(4, 183, 118, Seth13, 50)
        fallout.giq_option(-3, 183, 119, Seth13, 50)
    end
    fallout.giq_option(4, 183, 120, Seth08a, 50)
end

function Seth12()
    fallout.gsay_reply(183, 124)
    fallout.giq_option(4, 183, 115, Seth10, 50)
    fallout.giq_option(4, 183, 116, Seth11, 50)
    if fallout.local_var(4) == 1 then
        fallout.giq_option(4, 183, 118, Seth13, 50)
        fallout.giq_option(-3, 183, 119, Seth13, 50)
    end
    fallout.giq_option(4, 183, 120, Seth08a, 50)
end

function Seth13()
    if fallout.global_var(43) == 2 then
        fallout.gsay_reply(183, 202)
    else
        fallout.gsay_reply(183, 125)
    end
    fallout.giq_option(4, 183, 126, travel, 50)
    fallout.giq_option(4, 183, 127, no_travel, 50)
    fallout.giq_option(-3, 183, 130, travel, 50)
    fallout.giq_option(-3, 183, 131, no_travel, 50)
end

function Seth14()
    fallout.gsay_message(183, 206, 50)
end

function Sethend()
end

function TanSeth00()
    fallout.gsay_reply(183, 300)
    fallout.giq_option(4, 183, 301, TanSeth03, 50)
    fallout.giq_option(4, 183, 302, TanSeth02, 51)
    fallout.giq_option(4, 183, 303, TanSeth02, 50)
    if fallout.global_var(43) == 1 then
        fallout.giq_option(4, 183, 304, TanSeth07, 50)
    end
end

function TanSeth01()
    fallout.gsay_reply(183, 305)
    fallout.giq_option(4, 183, 306, TanSeth06, 50)
    fallout.giq_option(4, 183, 307, TanSeth05, 51)
    fallout.giq_option(4, 183, 308, TanSeth06, 50)
    if fallout.global_var(43) == 1 then
        fallout.giq_option(4, 183, 309, TanSeth07, 50)
    end
end

function TanSeth02()
    fallout.gsay_message(183, 310, 50)
end

function TanSeth03()
    fallout.set_global_var(69, 1)
    fallout.gsay_reply(183, 311)
    fallout.giq_option(4, 183, 312, Sethend, 50)
    fallout.giq_option(4, 183, 313, TanSeth02, 51)
    fallout.giq_option(4, 183, 314, TanSeth04, 51)
    fallout.giq_option(4, 183, 315, TanSeth02, 51)
end

function TanSeth04()
    fallout.gsay_reply(183, 316)
    fallout.giq_option(4, 183, 317, TanSeth05, 51)
    fallout.giq_option(4, 183, 318, Sethend, 50)
    fallout.giq_option(4, 183, 319, TanSeth02, 51)
end

function TanSeth05()
    fallout.set_local_var(9, 1)
    hostile = true
    fallout.gsay_message(183, 320, 51)
end

function TanSeth06()
    fallout.gsay_message(183, 321, 50)
end

function TanSeth07()
    fallout.gsay_reply(183, 322)
    fallout.giq_option(4, 183, 323, travel, 50)
    fallout.giq_option(4, 183, 324, TanSeth02, 51)
    fallout.giq_option(4, 183, 325, Sethend, 50)
end

local exports = {}
exports.start = start
exports.pickup_p_proc = pickup_p_proc
exports.combat_p_proc = combat_p_proc
exports.map_update_p_proc = map_update_p_proc
exports.talk_p_proc = talk_p_proc
exports.critter_p_proc = critter_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
return exports
