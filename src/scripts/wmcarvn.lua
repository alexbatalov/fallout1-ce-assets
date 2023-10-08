local fallout = require("fallout")
local reaction = require("lib.reaction")
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

local hostile = 0
local Only_Once = 1
local DayString = "None"

local exit_line = 0

function start()
    if Only_Once then
        Only_Once = 0
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 35)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 50)
    end
    if fallout.script_action() == 21 then
        look_at_p_proc()
    else
        if fallout.script_action() == 4 then
            pickup_p_proc()
        else
            if fallout.script_action() == 11 then
                talk_p_proc()
            else
                if fallout.script_action() == 12 then
                    critter_p_proc()
                else
                    if fallout.script_action() == 18 then
                        destroy_p_proc()
                    end
                end
            end
        end
    end
end

function combat()
    hostile = 1
end

function critter_p_proc()
    if hostile then
        hostile = 0
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    end
end

function pickup_p_proc()
    WMDriver10()
end

function talk_p_proc()
    local v0 = 0
    reaction.get_reaction()
    if fallout.local_var(10) == 1 then
        if fallout.local_var(7) < time.game_time_in_years() then
            fallout.set_local_var(10, 0)
        else
            if (fallout.local_var(6) < fallout.get_month()) or (fallout.local_var(6) == 12) and (fallout.get_month() == 1) and ((fallout.local_var(6) ~= 1) or (fallout.get_month() ~= 12)) then
                fallout.set_local_var(10, 0)
            else
                if (fallout.local_var(5) < fallout.get_day()) and ((fallout.local_var(6) ~= 1) or (fallout.get_month() ~= 12)) then
                    fallout.set_local_var(10, 0)
                end
            end
        end
    end
    RecalcDate()
    v0 = fallout.local_var(5)
    if fallout.local_var(8) > 0 then
        WMDriver14()
    else
        if fallout.map_var(2) == 0 then
            WMDriver15()
        else
            if fallout.global_var(205) == 3 then
                fallout.start_gdialog(605, fallout.self_obj(), 4, -1, -1)
                fallout.gsay_start()
                WMDriver19()
                fallout.gsay_end()
                fallout.end_dialogue()
            else
                if fallout.global_var(205) == 4 then
                    fallout.start_gdialog(605, fallout.self_obj(), 4, -1, -1)
                    fallout.gsay_start()
                    WMDriver27()
                    fallout.gsay_end()
                    fallout.end_dialogue()
                else
                    if fallout.map_var(1) == 0 then
                        WMDriver00()
                    else
                        if (fallout.map_var(1) == 1) and (fallout.local_var(10) == 0) then
                            fallout.start_gdialog(605, fallout.self_obj(), 4, -1, -1)
                            fallout.gsay_start()
                            if fallout.local_var(9) == 0 then
                                WMDriver01()
                            else
                                WMDriver03()
                            end
                            fallout.gsay_end()
                            fallout.end_dialogue()
                        else
                            if (fallout.local_var(10) == 1) and (v0 == fallout.get_day()) then
                                fallout.start_gdialog(605, fallout.self_obj(), 4, -1, -1)
                                fallout.gsay_start()
                                WMDriver28()
                                fallout.gsay_end()
                                fallout.end_dialogue()
                            else
                                if (fallout.local_var(10) == 1) and (v0 ~= fallout.get_day()) then
                                    fallout.start_gdialog(605, fallout.self_obj(), 4, -1, -1)
                                    fallout.gsay_start()
                                    WMDriver29()
                                    fallout.gsay_end()
                                    fallout.end_dialogue()
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    fallout.set_local_var(4, 1)
end

function destroy_p_proc()
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
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(605, 100))
end

function RecalcDate()
    local v0 = 0
    local v1 = 0
    local v2 = 0
    v0 = fallout.get_day()
    if (v0 > 1) and (v0 <= 5) then
        v0 = 5
        v1 = fallout.get_month()
        v2 = time.game_time_in_years()
    else
        if (v0 > 5) and (v0 <= 10) then
            v0 = 10
            v1 = fallout.get_month()
            v2 = time.game_time_in_years()
        else
            if (v0 > 10) and (v0 <= 15) then
                v0 = 15
                v1 = fallout.get_month()
                v2 = time.game_time_in_years()
            else
                if (v0 > 15) and (v0 <= 20) then
                    v0 = 20
                    v1 = fallout.get_month()
                    v2 = time.game_time_in_years()
                else
                    if (v0 > 20) and (v0 <= 25) then
                        v0 = 25
                        v1 = fallout.get_month()
                        v2 = time.game_time_in_years()
                    else
                        if v0 > 25 then
                            v0 = 1
                            v1 = fallout.get_month()
                            if v1 == 12 then
                                v1 = 1
                                v2 = time.game_time_in_years() + 1
                            else
                                v1 = v1 + 1
                                v2 = time.game_time_in_years()
                            end
                        else
                            if v0 == 1 then
                                v1 = fallout.get_month()
                                v2 = time.game_time_in_years()
                            end
                        end
                    end
                end
            end
        end
    end
    fallout.set_local_var(5, v0)
    fallout.set_local_var(6, v1)
    fallout.set_local_var(7, v2)
end

function RecalcDateString()
    local v0 = 0
    local v1 = 0
    RecalcDate()
    v0 = fallout.local_var(6)
    v1 = fallout.local_var(5)
    if v0 == 1 then
        DayString = fallout.message_str(605, 204)
    else
        if v0 == 2 then
            DayString = fallout.message_str(605, 205)
        else
            if v0 == 3 then
                DayString = fallout.message_str(605, 206)
            else
                if v0 == 4 then
                    DayString = fallout.message_str(605, 207)
                else
                    if v0 == 5 then
                        DayString = fallout.message_str(605, 208)
                    else
                        if v0 == 6 then
                            DayString = fallout.message_str(605, 209)
                        else
                            if v0 == 7 then
                                DayString = fallout.message_str(605, 210)
                            else
                                if v0 == 8 then
                                    DayString = fallout.message_str(605, 211)
                                else
                                    if v0 == 9 then
                                        DayString = fallout.message_str(605, 212)
                                    else
                                        if v0 == 10 then
                                            DayString = fallout.message_str(605, 213)
                                        else
                                            if v0 == 11 then
                                                DayString = fallout.message_str(605, 214)
                                            else
                                                if v0 == 12 then
                                                    DayString = fallout.message_str(605, 215)
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
    if v1 == 1 then
        DayString = DayString .. fallout.message_str(605, 197)
    else
        if v1 == 5 then
            DayString = DayString .. fallout.message_str(605, 198)
        else
            if v1 == 10 then
                DayString = DayString .. fallout.message_str(605, 199)
            else
                if v1 == 15 then
                    DayString = DayString .. fallout.message_str(605, 200)
                else
                    if v1 == 20 then
                        DayString = DayString .. fallout.message_str(605, 201)
                    else
                        if v1 == 25 then
                            DayString = DayString .. fallout.message_str(605, 202)
                        end
                    end
                end
            end
        end
    end
end

function damage_p_proc()
    local v0 = 0
    v0 = fallout.obj_pid(fallout.source_obj())
    if fallout.party_member_obj(v0) ~= 0 then
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
    local v0 = 0
    RecalcDateString()
    v0 = fallout.local_var(5)
    if v0 == fallout.get_day() then
        fallout.gsay_reply(605, fallout.message_str(605, 106) .. fallout.message_str(605, 107))
    else
        fallout.gsay_reply(605, fallout.message_str(605, 106) .. fallout.message_str(605, 108) .. DayString .. fallout.message_str(605, 111))
    end
    WMDriver04()
end

function WMDriver03()
    local v0 = 0
    if fallout.local_var(1) ~= 1 then
        RecalcDateString()
        v0 = fallout.local_var(5)
        if v0 == fallout.get_day() then
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
    local v0 = 0
    fallout.set_local_var(10, 1)
    RecalcDate()
    v0 = fallout.local_var(5)
    if v0 == fallout.get_day() then
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
    local v0 = 0
    v0 = fallout.random(1, 4)
    if v0 == 1 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(605, 140), 2)
    else
        if v0 == 2 then
            fallout.float_msg(fallout.self_obj(), fallout.message_str(605, 141), 2)
        else
            if v0 == 3 then
                fallout.float_msg(fallout.self_obj(), fallout.message_str(605, 142), 2)
            else
                if v0 == 4 then
                    fallout.float_msg(fallout.self_obj(), fallout.message_str(605, 143), 2)
                end
            end
        end
    end
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
    local v0 = 0
    fallout.set_global_var(200, 1)
    v0 = fallout.random(1, 7)
    if v0 == 1 then
        fallout.gsay_message(605, 160, 50)
    else
        if v0 == 2 then
            fallout.gsay_message(605, 161, 50)
        else
            if v0 == 3 then
                fallout.gsay_message(605, 162, 50)
            else
                if v0 == 4 then
                    fallout.gsay_message(605, 163, 50)
                else
                    if v0 == 5 then
                        fallout.gsay_message(605, 167, 50)
                    else
                        if v0 == 6 then
                            fallout.gsay_message(605, 168, 50)
                        else
                            if v0 == 7 then
                                fallout.gsay_message(605, 169, 50)
                            end
                        end
                    end
                end
            end
        end
    end
    v0 = fallout.random(1, 4)
    if v0 < 4 then
        fallout.load_map(58, 3)
    else
        fallout.load_map(10, 1)
    end
end

function WMDriver21b()
    local v0 = 0
    fallout.set_global_var(200, 1)
    v0 = fallout.random(1, 7)
    if v0 == 1 then
        fallout.gsay_message(605, 160, 50)
    else
        if v0 == 2 then
            fallout.gsay_message(605, 161, 50)
        else
            if v0 == 3 then
                fallout.gsay_message(605, 162, 50)
            else
                if v0 == 4 then
                    fallout.gsay_message(605, 163, 50)
                else
                    if v0 == 5 then
                        fallout.gsay_message(605, 164, 50)
                    else
                        if v0 == 6 then
                            fallout.gsay_message(605, 165, 50)
                        else
                            if v0 == 7 then
                                fallout.gsay_message(605, 166, 50)
                            end
                        end
                    end
                end
            end
        end
    end
    v0 = fallout.random(1, 4)
    if v0 < 3 then
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
    local v0 = 0
    RecalcDateString()
    v0 = fallout.local_var(5)
    fallout.gsay_message(605, fallout.message_str(605, 196) .. DayString .. fallout.message_str(605, 203) .. fallout.message_str(605, 195), 50)
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
    local v0 = 0
    fallout.set_local_var(10, 0)
    fallout.set_global_var(205, 1)
    v0 = fallout.local_var(9)
    fallout.set_local_var(9, v0 + 1)
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
