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
local WMDriver00
local WMDriver01
local WMDriver02
local WMDriver03
local WMDriver04
local WMDriver04a
local WMDriver05
local WMDriver06
local WMDriver07
local WMDriver08
local WMDriver10
local WMDriver10a
local WMDriver11
local WMDriver12
local WMDriver13
local WMDriver14
local WMDriver15
local WMDriver17
local WMDriver18
local WMDriver19
local WMDriver20
local WMDriver21a
local WMDriver21b
local WMDriver27
local WMDriver28
local WMDriver29
local WMDriver30
local WMDriver31
local WMDriver32
local WMDriver33
local WMDriver34
local WMDriver35

local hostile = false
local initialized = false
local DayString = "None"

function start()
    if not initialized then
        local self_obj = fallout.self_obj()
        misc.set_team(self_obj, 35)
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
    WMDriver10()
end

function talk_p_proc()
    reaction.get_reaction()
    if fallout.local_var(10) == 1 then
        local day = fallout.local_var(5)
        local month = fallout.local_var(6)
        local year = fallout.local_var(7)
        if year < time.game_time_in_years() then
            fallout.set_local_var(10, 0)
        elseif month < fallout.get_month()
            or month == 12 and fallout.get_month() == 1 and (month ~= 1 or fallout.get_month() ~= 12) then
            fallout.set_local_var(10, 0)
        elseif day < fallout.get_day() and (month ~= 1 or fallout.get_month() ~= 12) then
            fallout.set_local_var(10, 0)
        end
    end
    RecalcDate()
    local day = fallout.local_var(5)
    if fallout.local_var(8) > 0 then
        WMDriver14()
    elseif fallout.map_var(2) == 0 then
        WMDriver15()
    elseif fallout.global_var(205) == 3 then
        fallout.start_gdialog(605, fallout.self_obj(), 4, -1, -1)
        fallout.gsay_start()
        WMDriver19()
        fallout.gsay_end()
        fallout.end_dialogue()
    elseif fallout.global_var(205) == 4 then
        fallout.start_gdialog(605, fallout.self_obj(), 4, -1, -1)
        fallout.gsay_start()
        WMDriver27()
        fallout.gsay_end()
        fallout.end_dialogue()
    elseif fallout.map_var(1) == 0 then
        WMDriver00()
    elseif fallout.map_var(1) == 1 and fallout.local_var(10) == 0 then
        fallout.start_gdialog(605, fallout.self_obj(), 4, -1, -1)
        fallout.gsay_start()
        if fallout.local_var(9) == 0 then
            WMDriver01()
        else
            WMDriver03()
        end
        fallout.gsay_end()
        fallout.end_dialogue()
    elseif fallout.local_var(10) == 1 and day == fallout.get_day() then
        fallout.start_gdialog(605, fallout.self_obj(), 4, -1, -1)
        fallout.gsay_start()
        WMDriver28()
        fallout.gsay_end()
        fallout.end_dialogue()
    elseif fallout.local_var(10) == 1 and day ~= fallout.get_day() then
        fallout.start_gdialog(605, fallout.self_obj(), 4, -1, -1)
        fallout.gsay_start()
        WMDriver29()
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
    fallout.display_msg(fallout.message_str(605, 100))
end

function RecalcDate()
    local day = fallout.get_day()
    local month
    local year
    if day > 1 and day <= 5 then
        day = 5
        month = fallout.get_month()
        year = time.game_time_in_years()
    elseif day > 5 and day <= 10 then
        day = 10
        month = fallout.get_month()
        year = time.game_time_in_years()
    elseif day > 10 and day <= 15 then
        day = 15
        month = fallout.get_month()
        year = time.game_time_in_years()
    elseif day > 15 and day <= 20 then
        day = 20
        month = fallout.get_month()
        year = time.game_time_in_years()
    elseif day > 20 and day <= 25 then
        day = 25
        month = fallout.get_month()
        year = time.game_time_in_years()
    elseif day > 25 then
        day = 1
        month = fallout.get_month()
        if month == 12 then
            month = 1
            year = time.game_time_in_years() + 1
        else
            month = month + 1
            year = time.game_time_in_years()
        end
    elseif day == 1 then
        month = fallout.get_month()
        year = time.game_time_in_years()
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
    [1] = 197,
    [5] = 198,
    [10] = 199,
    [15] = 200,
    [20] = 201,
    [25] = 202,
}

function RecalcDateString()
    RecalcDate()
    local month = fallout.local_var(6)
    local day = fallout.local_var(5)
    DayString = fallout.message_str(605, MONTHS[month]) .. fallout.message_str(605, DAYS[day])
end

function damage_p_proc()
    local pid = fallout.obj_pid(fallout.source_obj())
    if fallout.party_member_obj(pid) ~= nil then
        fallout.set_global_var(248, 1)
    end
end

function WMDriver00()
    if fallout.local_var(4) == 0 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(605, 101), 2)
        fallout.set_local_var(4, 1)
    else
        fallout.float_msg(fallout.self_obj(), fallout.message_str(605, 102), 2)
    end
end

function WMDriver01()
    if fallout.global_var(71) == 0 then
        fallout.set_global_var(71, 1)
    end
    if fallout.global_var(75) == 0 then
        fallout.set_global_var(75, 1)
    end
    fallout.gsay_reply(605, 103)
    fallout.giq_option(4, 605, 104, WMDriver02, 50)
    fallout.giq_option(-3, 605, 105, WMDriver02, 50)
end

function WMDriver02()
    RecalcDateString()
    if fallout.local_var(5) == fallout.get_day() then
        fallout.gsay_reply(605, fallout.message_str(605, 106) .. fallout.message_str(605, 107))
    else
        fallout.gsay_reply(605,
            fallout.message_str(605, 106) .. fallout.message_str(605, 108) .. DayString .. fallout.message_str(605, 111))
    end
    WMDriver04()
end

function WMDriver03()
    if fallout.local_var(1) ~= 1 then
        RecalcDateString()
        if fallout.local_var(5) == fallout.get_day() then
            fallout.gsay_reply(605, fallout.message_str(605, 107))
        else
            fallout.gsay_reply(605, fallout.message_str(605, 108) .. DayString .. fallout.message_str(605, 111))
        end
        WMDriver04()
    else
        fallout.gsay_reply(605, 112)
        WMDriver04()
    end
end

function WMDriver04()
    fallout.giq_option(4, 605, 113, WMDriver04a, 50)
    fallout.giq_option(4, 605, 114, WMDriver05, 50)
    fallout.giq_option(4, 605, 115, WMDriver06, 50)
    fallout.giq_option(-3, 605, 116, WMDriver07, 50)
    fallout.giq_option(-3, 605, 117, WMDriver07, 50)
end

function WMDriver04a()
    fallout.set_local_var(10, 1)
    RecalcDate()
    if fallout.local_var(5) == fallout.get_day() then
        WMDriver17()
    else
        WMDriver18()
    end
end

function WMDriver05()
    fallout.set_local_var(10, 0)
    fallout.gsay_message(605, 118, 50)
end

function WMDriver06()
    fallout.set_local_var(10, 0)
    fallout.gsay_message(605, 120, 50)
end

function WMDriver07()
    fallout.gsay_message(605, 121, 50)
end

function WMDriver08()
    fallout.gsay_message(605, 123, 50)
end

function WMDriver10()
    if fallout.local_var(8) == 0 then
        fallout.set_local_var(8, 1)
        fallout.set_map_var(2, 0)
        fallout.gsay_reply(605, 125)
        fallout.giq_option(4, 605, 126, WMDriver08, 50)
        fallout.giq_option(4, 605, 127, WMDriver10a, 50)
        fallout.giq_option(4, 605, 128, WMDriver31, 51)
        fallout.giq_option(-3, 605, 130, WMDriver31, 51)
    else
        fallout.gsay_message(605, 131, 51)
        combat()
    end
end

function WMDriver10a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 20)) == 1 then
        WMDriver11()
    else
        WMDriver12()
    end
end

function WMDriver11()
    fallout.set_map_var(1, 0)
    fallout.set_map_var(2, 0)
    fallout.gsay_message(605, 132, 50)
end

function WMDriver12()
    fallout.gsay_message(605, 133, 51)
    combat()
end

function WMDriver13()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(605, 137), 2)
end

function WMDriver14()
    if fallout.local_var(8) > 0 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(605, 138), 2)
    else
        fallout.float_msg(fallout.self_obj(), fallout.message_str(605, 139), 2)
        WMDriver31()
    end
end

function WMDriver15()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(605, fallout.random(140, 143)), 2)
end

function WMDriver17()
    fallout.gsay_reply(605, 145)
    WMDriver33()
    WMDriver20()
end

function WMDriver18()
    RecalcDateString()
    fallout.gsay_reply(605, fallout.message_str(605, 146) .. DayString .. fallout.message_str(605, 153))
    fallout.giq_option(4, 605, 154, WMDriver30, 50)
    fallout.giq_option(4, 605, 155, WMDriver34, 50)
end

function WMDriver19()
    fallout.set_map_var(2, 0)
    fallout.set_global_var(205, 0)
    fallout.gsay_message(605, 156, 51)
end

function WMDriver20()
    fallout.giq_option(4, 605, 157, WMDriver21a, 50)
    fallout.giq_option(4, 605, 158, WMDriver21b, 50)
    fallout.giq_option(4, 605, 159, WMDriver34, 50)
end

function WMDriver21a()
    fallout.set_global_var(200, 1)
    fallout.gsay_message(605, fallout.random(160, 169), 50)
    if fallout.random(1, 4) < 4 then
        fallout.load_map(58, 3)
    else
        fallout.load_map(10, 1)
    end
end

function WMDriver21b()
    fallout.set_global_var(200, 1)
    fallout.gsay_message(605, fallout.random(160, 166), 50)
    if fallout.random(1, 4) < 3 then
        fallout.load_map(56, 3)
    else
        fallout.load_map(28, 1)
    end
end

function WMDriver27()
    fallout.gsay_reply(605, 185)
    fallout.giq_option(4, 605, 186, WMDriver04a, 50)
    fallout.giq_option(4, 605, 187, WMDriver05, 50)
    fallout.giq_option(4, 605, 188, WMDriver06, 50)
    fallout.giq_option(-3, 605, 189, WMDriver07, 50)
    fallout.giq_option(-3, 605, 190, WMDriver07, 50)
end

function WMDriver28()
    fallout.gsay_reply(605, 191)
    fallout.giq_option(4, 605, 192, WMDriver17, 50)
    fallout.giq_option(4, 605, 193, WMDriver35, 50)
    fallout.giq_option(-3, 605, 194, WMDriver07, 50)
end

function WMDriver29()
    RecalcDateString()
    fallout.gsay_message(605,
        fallout.message_str(605, 196) .. DayString .. fallout.message_str(605, 203) .. fallout.message_str(605, 195), 50)
end

function WMDriver30()
    fallout.set_local_var(10, 1)
end

function WMDriver31()
    combat()
end

function WMDriver32()
end

function WMDriver33()
    fallout.set_local_var(10, 0)
    fallout.set_global_var(205, 1)
    fallout.set_local_var(9, fallout.local_var(9) + 1)
end

function WMDriver34()
    fallout.set_local_var(10, 0)
end

function WMDriver35()
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
