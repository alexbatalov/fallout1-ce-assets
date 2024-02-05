local fallout = require("fallout")
local misc = require("lib.misc")
local reaction = require("lib.reaction")
local reputation = require("lib.reputation")
local time = require("lib.time")

local start
local combat
local critter_p_proc
local pickup_p_proc
local talk_p_proc
local destroy_p_proc
local look_at_p_proc
local RecalcDate
local RecalcDateString
local damage_p_proc
local FGTDriver00
local FGTDriver01
local FGTDriver02
local FGTDriver03
local FGTDriver04
local FGTDriver04a
local FGTDriver05
local FGTDriver06
local FGTDriver07
local FGTDriver08
local FGTDriver10
local FGTDriver10a
local FGTDriver11
local FGTDriver12
local FGTDriver13
local FGTDriver14
local FGTDriver15
local FGTDriver17
local FGTDriver18
local FGTDriver19
local FGTDriver20
local FGTDriver21a
local FGTDriver21b
local FGTDriver21c
local FGTDriver27
local FGTDriver28
local FGTDriver29
local FGTDriver30
local FGTDriver31
local FGTDriver32
local FGTDriver33
local FGTDriver34
local FGTDriver35

local hostile = false
local initialized = false
local DayString = "None"

function start()
    if not initialized then
        local self_obj = fallout.self_obj()
        misc.set_team(self_obj, 37)
        fallout.critter_add_trait(self_obj, 1, 5, 50)
        initialized = true
    end

    local script_action = fallout.script_action()
    if script_action == 21 then
        look_at_p_proc()
    elseif script_action == 4 then
        pickup_p_proc()
    elseif script_action == 11 then
        talk_p_proc()
    elseif script_action == 12 then
        critter_p_proc()
    elseif script_action == 18 then
        destroy_p_proc()
    end
end

function combat()
    hostile = true
end

function critter_p_proc()
    if hostile then
        hostile = false
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    end
end

function pickup_p_proc()
    FGTDriver10()
end

function talk_p_proc()
    reaction.get_reaction()
    if fallout.local_var(10) == 1 then
        if fallout.local_var(7) < time.game_time_in_years() then
            fallout.set_local_var(10, 0)
        elseif fallout.local_var(6) < fallout.get_month() or fallout.local_var(6) == 12 and fallout.get_month() == 1 and (fallout.local_var(6) ~= 1 or fallout.get_month() ~= 12) then
            fallout.set_local_var(10, 0)
        elseif fallout.local_var(5) < fallout.get_day() and (fallout.local_var(6) ~= 1 or fallout.get_month() ~= 12) then
            fallout.set_local_var(10, 0)
        end
    end
    RecalcDate()
    local day = fallout.local_var(5)
    if fallout.local_var(8) > 0 then
        FGTDriver14()
    elseif fallout.map_var(35) == 1 then
        FGTDriver15()
    elseif fallout.global_var(206) == 3 then
        fallout.start_gdialog(849, fallout.self_obj(), 4, -1, -1)
        fallout.gsay_start()
        FGTDriver19()
        fallout.gsay_end()
        fallout.end_dialogue()
    elseif fallout.global_var(206) == 4 then
        fallout.start_gdialog(849, fallout.self_obj(), 4, -1, -1)
        fallout.gsay_start()
        FGTDriver27()
        fallout.gsay_end()
        fallout.end_dialogue()
    elseif fallout.map_var(36) == 0 then
        FGTDriver00()
    elseif fallout.map_var(36) == 1 and fallout.local_var(10) == 0 then
        fallout.start_gdialog(849, fallout.self_obj(), 4, -1, -1)
        fallout.gsay_start()
        if fallout.local_var(9) == 0 then
            FGTDriver01()
        else
            FGTDriver03()
        end
        fallout.gsay_end()
        fallout.end_dialogue()
    elseif fallout.local_var(10) == 1 and day == fallout.get_day() then
        fallout.start_gdialog(849, fallout.self_obj(), 4, -1, -1)
        fallout.gsay_start()
        FGTDriver28()
        fallout.gsay_end()
        fallout.end_dialogue()
    elseif fallout.local_var(10) == 1 and day ~= fallout.get_day() then
        fallout.start_gdialog(849, fallout.self_obj(), 4, -1, -1)
        fallout.gsay_start()
        FGTDriver29()
        fallout.gsay_end()
        fallout.end_dialogue()
    end
    fallout.set_local_var(4, 1)
end

function destroy_p_proc()
    reputation.inc_good_critter()
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(849, 100))
end

function RecalcDate()
    local month = 0
    local year = 0
    local day = fallout.get_day()
    if day >= 1 and day <= 8 then
        day = 8
        month = fallout.get_month()
        year = time.game_time_in_years()
    elseif day > 8 and day <= 18 then
        day = 18
        month = fallout.get_month()
        year = time.game_time_in_years()
    elseif day > 18 and day <= 28 then
        day = 28
        month = fallout.get_month()
        year = time.game_time_in_years()
    elseif day > 28 then
        day = 8
        month = fallout.get_month()
        if month == 12 then
            month = 1
            year = time.game_time_in_years() + 1
        else
            month = month + 1
            year = time.game_time_in_years()
        end
    end
    fallout.set_local_var(5, day)
    fallout.set_local_var(6, month)
    fallout.set_local_var(7, year)
end

local MONTHS <const> = {
    [1] = 204,
    [2] = 205,
    [3] = 206,
    [4] = 207,
    [5] = 208,
    [6] = 209,
    [7] = 210,
    [8] = 211,
    [9] = 212,
    [10] = 213,
    [11] = 214,
    [12] = 215,
}

local DAYS <const> = {
    [8] = 197,
    [18] = 198,
    [28] = 199,
}

function RecalcDateString()
    RecalcDate()
    local month = fallout.local_var(6)
    local day = fallout.local_var(5)
    DayString = fallout.message_str(849, MONTHS[month]) .. fallout.message_str(849, DAYS[day])
end

function damage_p_proc()
    local pid = fallout.obj_pid(fallout.source_obj())
    if fallout.party_member_obj(pid) ~= nil then
        fallout.set_global_var(248, 1)
    end
end

function FGTDriver00()
    if fallout.local_var(4) == 0 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(849, 101), 2)
        fallout.set_local_var(4, 1)
    else
        fallout.float_msg(fallout.self_obj(), fallout.message_str(849, 102), 2)
    end
end

function FGTDriver01()
    if fallout.global_var(71) == 0 then
        fallout.set_global_var(71, 1)
    end
    if fallout.global_var(75) == 0 then
        fallout.set_global_var(75, 1)
    end
    if fallout.global_var(74) == 0 then
        fallout.set_global_var(74, 1)
    end
    fallout.gsay_reply(849, 103)
    fallout.giq_option(4, 849, 104, FGTDriver02, 50)
    fallout.giq_option(-3, 849, 105, FGTDriver02, 50)
end

function FGTDriver02()
    RecalcDateString()
    if fallout.local_var(5) == fallout.get_day() then
        fallout.gsay_reply(849, fallout.message_str(849, 106) .. fallout.message_str(849, 107))
    else
        fallout.gsay_reply(849,
            fallout.message_str(849, 106) .. fallout.message_str(849, 108) .. DayString .. fallout.message_str(849, 111))
    end
    FGTDriver04()
end

function FGTDriver03()
    if fallout.local_var(1) ~= 1 then
        RecalcDateString()
        if fallout.local_var(5) == fallout.get_day() then
            fallout.gsay_reply(849, fallout.message_str(849, 107))
        else
            fallout.gsay_reply(849, fallout.message_str(849, 108) .. DayString .. fallout.message_str(849, 111))
        end
        FGTDriver04()
    else
        fallout.gsay_reply(849, 112)
        FGTDriver04()
    end
end

function FGTDriver04()
    fallout.giq_option(4, 849, 113, FGTDriver04a, 50)
    fallout.giq_option(4, 849, 114, FGTDriver05, 50)
    fallout.giq_option(4, 849, 115, FGTDriver06, 50)
    fallout.giq_option(-3, 849, 116, FGTDriver07, 50)
    fallout.giq_option(-3, 849, 117, FGTDriver07, 50)
end

function FGTDriver04a()
    fallout.set_local_var(10, 1)
    RecalcDate()
    if fallout.local_var(5) == fallout.get_day() then
        FGTDriver17()
    else
        FGTDriver18()
    end
end

function FGTDriver05()
    fallout.set_local_var(10, 0)
    fallout.gsay_message(849, 118, 50)
end

function FGTDriver06()
    fallout.set_local_var(10, 0)
    fallout.gsay_message(849, 120, 50)
end

function FGTDriver07()
    fallout.gsay_message(849, 121, 50)
end

function FGTDriver08()
    fallout.gsay_message(849, 123, 50)
end

function FGTDriver10()
    if fallout.local_var(8) == 0 then
        fallout.set_local_var(8, 1)
        fallout.set_map_var(35, 1)
        fallout.set_map_var(10, 0)
        fallout.gsay_reply(849, 125)
        fallout.giq_option(4, 849, 126, FGTDriver08, 50)
        fallout.giq_option(4, 849, 127, FGTDriver10a, 50)
        fallout.giq_option(4, 849, 128, FGTDriver31, 51)
        fallout.giq_option(-3, 849, 130, FGTDriver31, 51)
    else
        fallout.gsay_message(849, 131, 51)
        combat()
    end
end

function FGTDriver10a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 20)) == 1 then
        FGTDriver11()
    else
        FGTDriver12()
    end
end

function FGTDriver11()
    fallout.set_map_var(36, 0)
    fallout.set_map_var(35, 1)
    fallout.set_map_var(10, 0)
    fallout.gsay_message(849, 132, 50)
end

function FGTDriver12()
    fallout.gsay_message(849, 133, 51)
    combat()
end

function FGTDriver13()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(849, 137), 2)
end

function FGTDriver14()
    if fallout.local_var(8) > 0 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(849, 138), 2)
    else
        fallout.float_msg(fallout.self_obj(), fallout.message_str(849, 139), 2)
        FGTDriver31()
    end
end

function FGTDriver15()
    local rnd = fallout.random(1, 4)
    if rnd == 1 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(849, 140), 2)
    elseif rnd == 2 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(849, 141), 2)
    elseif rnd == 3 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(849, 142), 2)
    elseif rnd == 4 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(849, 143), 2)
    end
end

function FGTDriver17()
    fallout.gsay_reply(849, 145)
    FGTDriver33()
    FGTDriver20()
end

function FGTDriver18()
    RecalcDateString()
    fallout.gsay_reply(849, fallout.message_str(849, 146) .. DayString .. fallout.message_str(849, 153))
    fallout.giq_option(4, 849, 154, FGTDriver30, 50)
    fallout.giq_option(4, 849, 155, FGTDriver34, 50)
end

function FGTDriver19()
    fallout.set_map_var(35, 1)
    fallout.set_map_var(10, 0)
    fallout.set_global_var(206, 0)
    fallout.gsay_message(849, 156, 51)
end

function FGTDriver20()
    fallout.giq_option(4, 849, 157, FGTDriver21a, 50)
    fallout.giq_option(4, 849, 158, FGTDriver21b, 50)
    fallout.giq_option(4, 849, 152, FGTDriver21c, 50)
    fallout.giq_option(4, 849, 159, FGTDriver34, 50)
end

function FGTDriver21a()
    fallout.set_global_var(201, 1)
    local rnd = fallout.random(1, 7)
    if rnd == 1 then
        fallout.gsay_message(849, 160, 50)
    elseif rnd == 2 then
        fallout.gsay_message(849, 161, 50)
    elseif rnd == 3 then
        fallout.gsay_message(849, 162, 50)
    elseif rnd == 4 then
        fallout.gsay_message(849, 163, 50)
    elseif rnd == 5 then
        fallout.gsay_message(849, 167, 50)
    elseif rnd == 6 then
        fallout.gsay_message(849, 168, 50)
    elseif rnd == 7 then
        fallout.gsay_message(849, 169, 50)
    end

    if fallout.random(1, 4) < 4 then
        fallout.load_map(58, 3)
    else
        fallout.load_map(10, 1)
    end
end

function FGTDriver21b()
    fallout.set_global_var(201, 1)
    local rnd = fallout.random(1, 7)
    if rnd == 1 then
        fallout.gsay_message(849, 160, 50)
    elseif rnd == 2 then
        fallout.gsay_message(849, 161, 50)
    elseif rnd == 3 then
        fallout.gsay_message(849, 162, 50)
    elseif rnd == 4 then
        fallout.gsay_message(849, 163, 50)
    elseif rnd == 5 then
        fallout.gsay_message(849, 164, 50)
    elseif rnd == 6 then
        fallout.gsay_message(849, 165, 50)
    elseif rnd == 7 then
        fallout.gsay_message(849, 166, 50)
    end

    if fallout.random(1, 4) < 3 then
        fallout.load_map(56, 3)
    else
        fallout.load_map(28, 1)
    end
end

function FGTDriver21c()
    fallout.set_global_var(201, 1)
    local rnd = fallout.random(1, 8)
    if rnd == 1 then
        fallout.gsay_message(849, 160, 50)
    elseif rnd == 2 then
        fallout.gsay_message(849, 161, 50)
    elseif rnd == 3 then
        fallout.gsay_message(849, 162, 50)
    elseif rnd == 4 then
        fallout.gsay_message(849, 163, 50)
    elseif rnd == 5 then
        fallout.gsay_message(849, 216, 50)
    elseif rnd == 6 then
        fallout.gsay_message(849, 217, 50)
    elseif rnd == 7 then
        fallout.gsay_message(849, 218, 50)
    elseif rnd == 8 then
        fallout.gsay_message(849, 219, 50)
    end

    if fallout.random(1, 4) < 4 then
        fallout.load_map(59, 3)
    else
        fallout.load_map(13, 1)
    end
end

function FGTDriver27()
    fallout.gsay_reply(849, 185)
    fallout.giq_option(4, 849, 186, FGTDriver04a, 50)
    fallout.giq_option(4, 849, 187, FGTDriver05, 50)
    fallout.giq_option(4, 849, 188, FGTDriver06, 50)
    fallout.giq_option(-3, 849, 189, FGTDriver07, 50)
    fallout.giq_option(-3, 849, 190, FGTDriver07, 50)
end

function FGTDriver28()
    fallout.gsay_reply(849, 191)
    fallout.giq_option(4, 849, 192, FGTDriver17, 50)
    fallout.giq_option(4, 849, 193, FGTDriver35, 50)
    fallout.giq_option(-3, 849, 194, FGTDriver07, 50)
end

function FGTDriver29()
    RecalcDateString()
    fallout.gsay_message(849,
        fallout.message_str(849, 196) .. DayString .. fallout.message_str(849, 203) .. fallout.message_str(849, 195), 50)
end

function FGTDriver30()
    fallout.set_local_var(10, 1)
end

function FGTDriver31()
    combat()
end

function FGTDriver32()
end

function FGTDriver33()
    fallout.set_local_var(10, 0)
    fallout.set_global_var(206, 1)
    fallout.set_local_var(9, fallout.local_var(9) + 1)
end

function FGTDriver34()
    fallout.set_local_var(10, 0)
end

function FGTDriver35()
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
exports.damage_p_proc = damage_p_proc
return exports
