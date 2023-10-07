local fallout = require("fallout")

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

local hostile = 0
local Only_Once = 1
local DayString = "None"

local get_reaction
local ReactToLevel
local LevelToReact
local UpReact
local DownReact
local BottomReact
local TopReact
local BigUpReact
local BigDownReact
local UpReactLevel
local DownReactLevel
local Goodbyes

local exit_line = 0

function start()
    if Only_Once then
        Only_Once = 0
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 37)
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
    FGTDriver10()
end

function talk_p_proc()
    local v0 = 0
    get_reaction()
    if fallout.local_var(10) == 1 then
        if fallout.local_var(7) < (fallout.game_time() // (10 * 60 * 60 * 24 * 365)) then
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
        FGTDriver14()
    else
        if fallout.map_var(35) == 1 then
            FGTDriver15()
        else
            if fallout.global_var(206) == 3 then
                fallout.start_gdialog(849, fallout.self_obj(), 4, -1, -1)
                fallout.gsay_start()
                FGTDriver19()
                fallout.gsay_end()
                fallout.end_dialogue()
            else
                if fallout.global_var(206) == 4 then
                    fallout.start_gdialog(849, fallout.self_obj(), 4, -1, -1)
                    fallout.gsay_start()
                    FGTDriver27()
                    fallout.gsay_end()
                    fallout.end_dialogue()
                else
                    if fallout.map_var(36) == 0 then
                        FGTDriver00()
                    else
                        if (fallout.map_var(36) == 1) and (fallout.local_var(10) == 0) then
                            fallout.start_gdialog(849, fallout.self_obj(), 4, -1, -1)
                            fallout.gsay_start()
                            if fallout.local_var(9) == 0 then
                                FGTDriver01()
                            else
                                FGTDriver03()
                            end
                            fallout.gsay_end()
                            fallout.end_dialogue()
                        else
                            if (fallout.local_var(10) == 1) and (v0 == fallout.get_day()) then
                                fallout.start_gdialog(849, fallout.self_obj(), 4, -1, -1)
                                fallout.gsay_start()
                                FGTDriver28()
                                fallout.gsay_end()
                                fallout.end_dialogue()
                            else
                                if (fallout.local_var(10) == 1) and (v0 ~= fallout.get_day()) then
                                    fallout.start_gdialog(849, fallout.self_obj(), 4, -1, -1)
                                    fallout.gsay_start()
                                    FGTDriver29()
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
    fallout.display_msg(fallout.message_str(849, 100))
end

function RecalcDate()
    local v0 = 0
    local v1 = 0
    local v2 = 0
    v0 = fallout.get_day()
    if (v0 >= 1) and (v0 <= 8) then
        v0 = 8
        v1 = fallout.get_month()
        v2 = fallout.game_time() // (10 * 60 * 60 * 24 * 365)
    else
        if (v0 > 8) and (v0 <= 18) then
            v0 = 18
            v1 = fallout.get_month()
            v2 = fallout.game_time() // (10 * 60 * 60 * 24 * 365)
        else
            if (v0 > 18) and (v0 <= 28) then
                v0 = 28
                v1 = fallout.get_month()
                v2 = fallout.game_time() // (10 * 60 * 60 * 24 * 365)
            else
                if v0 > 28 then
                    v0 = 8
                    v1 = fallout.get_month()
                    if v1 == 12 then
                        v1 = 1
                        v2 = (fallout.game_time() // (10 * 60 * 60 * 24 * 365)) + 1
                    else
                        v1 = v1 + 1
                        v2 = fallout.game_time() // (10 * 60 * 60 * 24 * 365)
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
        DayString = fallout.message_str(849, 204)
    else
        if v0 == 2 then
            DayString = fallout.message_str(849, 205)
        else
            if v0 == 3 then
                DayString = fallout.message_str(849, 206)
            else
                if v0 == 4 then
                    DayString = fallout.message_str(849, 207)
                else
                    if v0 == 5 then
                        DayString = fallout.message_str(849, 208)
                    else
                        if v0 == 6 then
                            DayString = fallout.message_str(849, 209)
                        else
                            if v0 == 7 then
                                DayString = fallout.message_str(849, 210)
                            else
                                if v0 == 8 then
                                    DayString = fallout.message_str(849, 211)
                                else
                                    if v0 == 9 then
                                        DayString = fallout.message_str(849, 212)
                                    else
                                        if v0 == 10 then
                                            DayString = fallout.message_str(849, 213)
                                        else
                                            if v0 == 11 then
                                                DayString = fallout.message_str(849, 214)
                                            else
                                                if v0 == 12 then
                                                    DayString = fallout.message_str(849, 215)
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
    if v1 == 8 then
        DayString = DayString .. fallout.message_str(849, 197)
    else
        if v1 == 18 then
            DayString = DayString .. fallout.message_str(849, 198)
        else
            if v1 == 28 then
                DayString = DayString .. fallout.message_str(849, 199)
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
    local v0 = 0
    RecalcDateString()
    v0 = fallout.local_var(5)
    if v0 == fallout.get_day() then
        fallout.gsay_reply(849, fallout.message_str(849, 106) .. fallout.message_str(849, 107))
    else
        fallout.gsay_reply(849, fallout.message_str(849, 106) .. fallout.message_str(849, 108) .. DayString .. fallout.message_str(849, 111))
    end
    FGTDriver04()
end

function FGTDriver03()
    local v0 = 0
    if fallout.local_var(1) ~= 1 then
        RecalcDateString()
        v0 = fallout.local_var(5)
        if v0 == fallout.get_day() then
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
    local v0 = 0
    fallout.set_local_var(10, 1)
    RecalcDate()
    v0 = fallout.local_var(5)
    if v0 == fallout.get_day() then
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
    local v0 = 0
    v0 = fallout.random(1, 4)
    if v0 == 1 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(849, 140), 2)
    else
        if v0 == 2 then
            fallout.float_msg(fallout.self_obj(), fallout.message_str(849, 141), 2)
        else
            if v0 == 3 then
                fallout.float_msg(fallout.self_obj(), fallout.message_str(849, 142), 2)
            else
                if v0 == 4 then
                    fallout.float_msg(fallout.self_obj(), fallout.message_str(849, 143), 2)
                end
            end
        end
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
    local v0 = 0
    fallout.set_global_var(201, 1)
    v0 = fallout.random(1, 7)
    if v0 == 1 then
        fallout.gsay_message(849, 160, 50)
    else
        if v0 == 2 then
            fallout.gsay_message(849, 161, 50)
        else
            if v0 == 3 then
                fallout.gsay_message(849, 162, 50)
            else
                if v0 == 4 then
                    fallout.gsay_message(849, 163, 50)
                else
                    if v0 == 5 then
                        fallout.gsay_message(849, 167, 50)
                    else
                        if v0 == 6 then
                            fallout.gsay_message(849, 168, 50)
                        else
                            if v0 == 7 then
                                fallout.gsay_message(849, 169, 50)
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

function FGTDriver21b()
    local v0 = 0
    fallout.set_global_var(201, 1)
    v0 = fallout.random(1, 7)
    if v0 == 1 then
        fallout.gsay_message(849, 160, 50)
    else
        if v0 == 2 then
            fallout.gsay_message(849, 161, 50)
        else
            if v0 == 3 then
                fallout.gsay_message(849, 162, 50)
            else
                if v0 == 4 then
                    fallout.gsay_message(849, 163, 50)
                else
                    if v0 == 5 then
                        fallout.gsay_message(849, 164, 50)
                    else
                        if v0 == 6 then
                            fallout.gsay_message(849, 165, 50)
                        else
                            if v0 == 7 then
                                fallout.gsay_message(849, 166, 50)
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

function FGTDriver21c()
    local v0 = 0
    fallout.set_global_var(201, 1)
    v0 = fallout.random(1, 8)
    if v0 == 1 then
        fallout.gsay_message(849, 160, 50)
    else
        if v0 == 2 then
            fallout.gsay_message(849, 161, 50)
        else
            if v0 == 3 then
                fallout.gsay_message(849, 162, 50)
            else
                if v0 == 4 then
                    fallout.gsay_message(849, 163, 50)
                else
                    if v0 == 5 then
                        fallout.gsay_message(849, 216, 50)
                    else
                        if v0 == 6 then
                            fallout.gsay_message(849, 217, 50)
                        else
                            if v0 == 7 then
                                fallout.gsay_message(849, 218, 50)
                            else
                                if v0 == 8 then
                                    fallout.gsay_message(849, 219, 50)
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    v0 = fallout.random(1, 4)
    if v0 < 4 then
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
    local v0 = 0
    RecalcDateString()
    v0 = fallout.local_var(5)
    fallout.gsay_message(849, fallout.message_str(849, 196) .. DayString .. fallout.message_str(849, 203) .. fallout.message_str(849, 195), 50)
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
    local v0 = 0
    fallout.set_local_var(10, 0)
    fallout.set_global_var(206, 1)
    v0 = fallout.local_var(9)
    fallout.set_local_var(9, v0 + 1)
end

function FGTDriver34()
    fallout.set_local_var(10, 0)
end

function FGTDriver35()
end

function get_reaction()
    if fallout.local_var(2) == 0 then
        fallout.set_local_var(0, 50)
        fallout.set_local_var(1, 2)
        fallout.set_local_var(2, 1)
        fallout.set_local_var(0, fallout.local_var(0) + (5 * fallout.get_critter_stat(fallout.dude_obj(), 3)) - 25)
        fallout.set_local_var(0, fallout.local_var(0) + (10 * fallout.has_trait(0, fallout.dude_obj(), 10)))
        if fallout.has_trait(0, fallout.dude_obj(), 39) then
            if fallout.global_var(155) > 0 then
                fallout.set_local_var(0, fallout.local_var(0) + fallout.global_var(155))
            else
                fallout.set_local_var(0, fallout.local_var(0) - fallout.global_var(155))
            end
        else
            if fallout.local_var(3) == 1 then
                fallout.set_local_var(0, fallout.local_var(0) - fallout.global_var(155))
            else
                fallout.set_local_var(0, fallout.local_var(0) + fallout.global_var(155))
            end
        end
        if fallout.global_var(158) > 2 then
            fallout.set_local_var(0, fallout.local_var(0) - 30)
        end
        if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(160) > (3 * fallout.global_var(159))) or (fallout.global_var(157) == 1)) then
            fallout.set_local_var(0, fallout.local_var(0) + 20)
        end
        if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1)) then
            fallout.set_local_var(0, fallout.local_var(0) - 20)
        end
        ReactToLevel()
    end
end

function ReactToLevel()
    if fallout.local_var(0) <= 25 then
        fallout.set_local_var(1, 1)
    else
        if fallout.local_var(0) <= 75 then
            fallout.set_local_var(1, 2)
        else
            fallout.set_local_var(1, 3)
        end
    end
end

function LevelToReact()
    if fallout.local_var(1) == 1 then
        fallout.set_local_var(0, fallout.random(1, 25))
    else
        if fallout.local_var(1) == 2 then
            fallout.set_local_var(0, fallout.random(26, 75))
        else
            fallout.set_local_var(0, fallout.random(76, 100))
        end
    end
end

function UpReact()
    fallout.set_local_var(0, fallout.local_var(0) + 10)
    ReactToLevel()
end

function DownReact()
    fallout.set_local_var(0, fallout.local_var(0) - 10)
    ReactToLevel()
end

function BottomReact()
    fallout.set_local_var(1, 1)
    fallout.set_local_var(0, 1)
end

function TopReact()
    fallout.set_local_var(0, 100)
    fallout.set_local_var(1, 3)
end

function BigUpReact()
    fallout.set_local_var(0, fallout.local_var(0) + 25)
    ReactToLevel()
end

function BigDownReact()
    fallout.set_local_var(0, fallout.local_var(0) - 25)
    ReactToLevel()
end

function UpReactLevel()
    fallout.set_local_var(1, fallout.local_var(1) + 1)
    if fallout.local_var(1) > 3 then
        fallout.set_local_var(1, 3)
    end
    LevelToReact()
end

function DownReactLevel()
    fallout.set_local_var(1, fallout.local_var(1) - 1)
    if fallout.local_var(1) < 1 then
        fallout.set_local_var(1, 1)
    end
    LevelToReact()
end

function Goodbyes()
    exit_line = fallout.message_str(634, fallout.random(100, 105))
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
