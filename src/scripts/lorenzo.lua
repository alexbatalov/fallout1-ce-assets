local fallout = require("fallout")
local time = require("lib.time")

local start
local combat
local critter_p_proc
local pickup_p_proc
local talk_p_proc
local destroy_p_proc
local look_at_p_proc
local timed_event_p_proc
local SendInsideHouse
local Lorenzo00
local Lorenzo01
local Lorenzo02
local Lorenzo02a
local Lorenzo04
local Lorenzo05
local Lorenzo06
local Lorenzo07
local Lorenzo08
local Lorenzo09
local Lorenzo09a
local Lorenzo12
local Lorenzo13
local Lorenzo14
local Lorenzo15
local Lorenzo15a
local Lorenzo15b
local Lorenzo15c
local Lorenzo15d
local Lorenzo15e
local Lorenzo15f
local Lorenzo16
local Lorenzo16a
local Lorenzo19
local Lorenzo20
local Lorenzo21
local Lorenzo22
local Lorenzo23
local Lorenzo24
local Lorenzo25
local Lorenzo26
local Lorenzo27
local Lorenzo28
local Lorenzo29
local Lorenzo30
local Lorenzo31
local Lorenzo32
local Lorenzo33
local Lorenzo34
local Lorenzo35
local Lorenzo36
local Lorenzo37
local Lorenzo38
local Lorenzo39
local Lorenzo40
local Lorenzo41

local hostile = 0
local Only_Once = 1
local SetDayNight = 0
local Destination = 0
local LastMove = 0
local VaultCount = 0

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
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 73)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 85)
        LastMove = 23309
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

function combat()
    hostile = 1
end

function critter_p_proc()
    local v0 = 0
    if hostile then
        hostile = 0
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    end
    if SetDayNight == 0 then
        fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(fallout.random(5, 20)), 1)
        SetDayNight = 1
    end
    if fallout.map_var(55) == 2 then
        hostile = 1
        fallout.float_msg(fallout.self_obj(), fallout.message_str(597, 247), 2)
    else
        if fallout.map_var(55) == 1 then
            fallout.set_map_var(55, 0)
            VaultCount = VaultCount + 1
            fallout.float_msg(fallout.self_obj(), fallout.message_str(597, 246), 2)
            if VaultCount >= 2 then
                hostile = 1
                fallout.float_msg(fallout.self_obj(), fallout.message_str(597, 247), 2)
            end
        end
    end
    v0 = fallout.tile_num(fallout.self_obj())
    if (v0 == 22312) or (v0 == 23106) or (v0 == 24106) then
        if fallout.anim_busy(fallout.self_obj()) == 0 then
            if fallout.has_trait(1, fallout.self_obj(), 10) ~= 0 then
                fallout.anim(fallout.self_obj(), 1000, 0)
            end
        end
    else
        if v0 == 21112 then
            if fallout.anim_busy(fallout.self_obj()) == 0 then
                if fallout.has_trait(1, fallout.self_obj(), 10) ~= 5 then
                    fallout.anim(fallout.self_obj(), 1000, 5)
                end
            end
        end
    end
end

function pickup_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        hostile = 1
    end
end

function talk_p_proc()
    local v0 = 0
    if fallout.item_caps_total(fallout.dude_obj()) < 1000 then
        v0 = fallout.item_caps_adjust(fallout.self_obj(), 3000)
    else
        if fallout.item_caps_total(fallout.dude_obj()) < 2000 then
            v0 = fallout.item_caps_adjust(fallout.self_obj(), 2000)
        else
            v0 = fallout.item_caps_adjust(fallout.self_obj(), 1000)
        end
    end
    get_reaction()
    if fallout.map_var(22) == 1 then
        Lorenzo04()
    else
        if (fallout.map_var(22) == 0) and ((fallout.map_var(11) == 1) or (fallout.map_var(44) == 1)) then
            Lorenzo00()
        else
            if (fallout.local_var(6) > 0) and ((time.game_time_in_days() - fallout.local_var(5)) > 10) then
                Lorenzo01()
            else
                if fallout.local_var(6) > 0 then
                    Lorenzo02()
                else
                    Lorenzo05()
                end
            end
        end
    end
    v0 = fallout.item_caps_adjust(fallout.self_obj(), -fallout.item_caps_total(fallout.self_obj()))
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
        fallout.set_global_var(160, fallout.global_var(160) + 1)
        if (fallout.global_var(160) % 6) == 0 then
            fallout.set_global_var(155, fallout.global_var(155) + 1)
        end
    end
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(597, 100))
end

function timed_event_p_proc()
    SendInsideHouse()
end

function SendInsideHouse()
    local v0 = 0
    Destination = 0
    v0 = fallout.random(10, 30)
    while Destination == 0 do
        Destination = fallout.random(1, 5)
        if Destination == 1 then
            Destination = 23309
        else
            if Destination == 2 then
                Destination = 21112
            else
                if Destination == 3 then
                    Destination = 22312
                else
                    if Destination == 4 then
                        Destination = 23106
                    else
                        if Destination == 5 then
                            Destination = 24104
                        end
                    end
                end
            end
        end
        if Destination == LastMove then
            Destination = 0
        end
    end
    LastMove = Destination
    fallout.reg_anim_func(2, fallout.self_obj())
    fallout.reg_anim_func(1, 1)
    fallout.reg_anim_obj_move_to_tile(fallout.self_obj(), Destination, -1)
    fallout.reg_anim_func(3, 0)
    fallout.rm_timer_event(fallout.self_obj())
    fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(v0), 1)
end

function Lorenzo00()
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(597, 101), 2)
    else
        fallout.float_msg(fallout.self_obj(), fallout.message_str(597, 102), 2)
    end
    fallout.set_map_var(22, 1)
    fallout.set_map_var(18, 1)
end

function Lorenzo01()
    local v0 = 0
    fallout.start_gdialog(597, fallout.self_obj(), 4, -1, -1)
    fallout.gsay_start()
    v0 = (fallout.local_var(6) // 10 * (time.game_time_in_days() - fallout.local_var(5))) + fallout.local_var(6)
    fallout.gsay_reply(597, 103)
    fallout.giq_option(4, 597, 104, Lorenzo14, 51)
    fallout.giq_option(4, 597, 105, Lorenzo15, 51)
    if (fallout.local_var(6) > 0) == 1 then
        fallout.giq_option(4, 597, fallout.message_str(597, 106) .. v0 .. fallout.message_str(597, 107), Lorenzo16, 50)
    end
    fallout.giq_option(4, 597, 108, Lorenzo15, 51)
    fallout.gsay_end()
    fallout.end_dialogue()
end

function Lorenzo02()
    local v0 = 0
    fallout.start_gdialog(597, fallout.self_obj(), 4, -1, -1)
    fallout.gsay_start()
    v0 = (fallout.local_var(6) // 10 * (time.game_time_in_days() - fallout.local_var(5))) + fallout.local_var(6)
    fallout.gsay_reply(597, 109)
    fallout.giq_option(4, 597, 110, Lorenzo02a, 50)
    fallout.giq_option(4, 597, 111, Lorenzo08, 50)
    if fallout.local_var(6) > 0 then
        fallout.giq_option(4, 597, fallout.message_str(597, 106) .. v0 .. fallout.message_str(597, 107), Lorenzo09, 50)
    end
    fallout.giq_option(4, 597, 112, Lorenzo12, 50)
    fallout.giq_option(-3, 597, 113, Lorenzo13, 50)
    fallout.gsay_end()
    fallout.end_dialogue()
end

function Lorenzo02a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        Lorenzo06()
    else
        Lorenzo07()
    end
end

function Lorenzo04()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(597, 114), 2)
    combat()
end

function Lorenzo05()
    fallout.start_gdialog(597, fallout.self_obj(), 4, -1, -1)
    fallout.gsay_start()
    fallout.set_map_var(18, 1)
    fallout.gsay_reply(597, 115)
    fallout.giq_option(4, 597, 110, Lorenzo02a, 50)
    fallout.giq_option(4, 597, 116, Lorenzo19, 50)
    fallout.giq_option(4, 597, 117, Lorenzo20, 51)
    fallout.giq_option(4, 597, 112, Lorenzo12, 50)
    fallout.giq_option(-3, 597, 113, Lorenzo21, 50)
    fallout.gsay_end()
    fallout.end_dialogue()
end

function Lorenzo06()
    fallout.gsay_reply(597, 118)
    if fallout.global_var(106) == 1 then
        fallout.giq_option(4, 597, 119, Lorenzo22, 50)
    end
    if fallout.global_var(219) == 1 then
        fallout.giq_option(4, 597, 120, Lorenzo23, 50)
    end
    fallout.giq_option(4, 597, 121, Lorenzo24, 50)
    fallout.giq_option(4, 597, 122, Lorenzo25, 50)
    fallout.giq_option(4, 597, 123, Lorenzo26, 50)
    fallout.giq_option(4, 597, 124, Lorenzo27, 50)
end

function Lorenzo07()
    if fallout.map_var(19) == 0 then
        fallout.gsay_message(597, 125, 51)
        fallout.set_map_var(19, 1)
    else
        fallout.set_map_var(22, 1)
        fallout.gsay_message(597, 126, 51)
    end
end

function Lorenzo08()
    fallout.gsay_message(597, 127, 50)
end

function Lorenzo09()
    local v0 = 0
    local v1 = 0
    v0 = (fallout.local_var(6) // 10 * (time.game_time_in_days() - fallout.local_var(5))) + fallout.local_var(6)
    if fallout.item_caps_total(fallout.dude_obj()) >= v0 then
        v1 = fallout.item_caps_adjust(fallout.dude_obj(), -1 * v0)
        fallout.set_local_var(6, 0)
        fallout.set_local_var(5, 0)
        fallout.gsay_reply(597, 128)
        fallout.giq_option(4, 597, 130, Lorenzo09a, 50)
        fallout.giq_option(4, 597, 131, Lorenzo19, 50)
        fallout.giq_option(4, 597, 132, Lorenzo12, 50)
    else
        fallout.gsay_reply(597, 129)
        fallout.giq_option(4, 597, 130, Lorenzo07, 50)
        fallout.giq_option(4, 597, 131, Lorenzo08, 50)
        fallout.giq_option(4, 597, 132, Lorenzo12, 50)
    end
end

function Lorenzo09a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 20)) then
        Lorenzo06()
    else
        Lorenzo07()
    end
end

function Lorenzo12()
    fallout.gsay_message(597, 133, 50)
end

function Lorenzo13()
    fallout.set_map_var(22, 1)
    fallout.gsay_message(597, 134, 51)
end

function Lorenzo14()
    fallout.set_map_var(44, 1)
    fallout.set_map_var(11, 1)
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        fallout.gsay_message(597, 135, 51)
    else
        fallout.gsay_message(597, 136, 51)
    end
    combat()
end

function Lorenzo15()
    local v0 = 0
    v0 = (fallout.local_var(6) // 10 * (time.game_time_in_days() - fallout.local_var(5))) + fallout.local_var(6)
    fallout.gsay_reply(597, 248)
    if fallout.item_caps_total(fallout.dude_obj()) < v0 then
        fallout.giq_option(4, 597, 249, Lorenzo15a, 50)
    else
        fallout.giq_option(4, 597, 250, Lorenzo15b, 50)
        fallout.giq_option(4, 597, fallout.message_str(597, 251) .. (v0 * 3 // 4) .. fallout.message_str(597, 252), Lorenzo15c, 50)
        fallout.giq_option(4, 597, fallout.message_str(597, 251) .. (v0 // 2) .. fallout.message_str(597, 252), Lorenzo15d, 50)
        fallout.giq_option(4, 597, fallout.message_str(597, 251) .. (v0 // 4) .. fallout.message_str(597, 252), Lorenzo15e, 50)
    end
    fallout.giq_option(4, 597, 253, Lorenzo15f, 51)
end

function Lorenzo15a()
    local v0 = 0
    local v1 = 0
    v0 = (fallout.local_var(6) // 10 * (time.game_time_in_days() - fallout.local_var(5))) + fallout.local_var(6)
    v1 = fallout.item_caps_adjust(fallout.dude_obj(), -fallout.item_caps_total(fallout.dude_obj()))
    fallout.set_map_var(22, 1)
    fallout.set_local_var(6, 0)
    fallout.set_local_var(5, 0)
    fallout.gsay_message(597, 254, 50)
    fallout.gsay_message(597, 259, 51)
end

function Lorenzo15b()
    local v0 = 0
    local v1 = 0
    v0 = (fallout.local_var(6) // 10 * (time.game_time_in_days() - fallout.local_var(5))) + fallout.local_var(6)
    v1 = fallout.item_caps_adjust(fallout.dude_obj(), -1 * v0)
    fallout.set_map_var(22, 1)
    fallout.set_local_var(6, 0)
    fallout.set_local_var(5, 0)
    fallout.gsay_message(597, 260, 51)
end

function Lorenzo15c()
    local v0 = 0
    local v1 = 0
    v0 = (fallout.local_var(6) // 10 * (time.game_time_in_days() - fallout.local_var(5))) + fallout.local_var(6)
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, -20)) or fallout.is_success(fallout.do_check(fallout.dude_obj(), 3, -1)) then
        v1 = fallout.item_caps_adjust(fallout.dude_obj(), -1 * (v0 * 3 // 4))
        fallout.set_map_var(22, 1)
        fallout.set_local_var(6, 0)
        fallout.set_local_var(5, 0)
        fallout.gsay_message(597, fallout.message_str(597, 255) .. (v0 * 3 // 4) .. fallout.message_str(597, 256), 50)
        fallout.gsay_message(597, 259, 51)
    else
        fallout.set_map_var(22, 1)
        fallout.set_map_var(44, 1)
        fallout.set_map_var(11, 1)
        fallout.set_local_var(6, 0)
        fallout.set_local_var(5, 0)
        fallout.gsay_message(597, 257, 51)
        combat()
    end
end

function Lorenzo15d()
    local v0 = 0
    local v1 = 0
    v0 = (fallout.local_var(6) // 10 * (time.game_time_in_days() - fallout.local_var(5))) + fallout.local_var(6)
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, -30)) or fallout.is_success(fallout.do_check(fallout.dude_obj(), 3, -2)) then
        v1 = fallout.item_caps_adjust(fallout.dude_obj(), -1 * (v0 // 2))
        fallout.set_map_var(22, 1)
        fallout.set_local_var(6, 0)
        fallout.set_local_var(5, 0)
        fallout.gsay_message(597, fallout.message_str(597, 255) .. (v0 // 2) .. fallout.message_str(597, 256), 50)
        fallout.gsay_message(597, 259, 51)
    else
        fallout.set_map_var(22, 1)
        fallout.set_map_var(44, 1)
        fallout.set_map_var(11, 1)
        fallout.set_local_var(6, 0)
        fallout.set_local_var(5, 0)
        fallout.gsay_message(597, 257, 51)
        combat()
    end
end

function Lorenzo15e()
    local v0 = 0
    local v1 = 0
    v0 = (fallout.local_var(6) // 10 * (time.game_time_in_days() - fallout.local_var(5))) + fallout.local_var(6)
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, -40)) or fallout.is_success(fallout.do_check(fallout.dude_obj(), 3, -3)) then
        v1 = fallout.item_caps_adjust(fallout.dude_obj(), -1 * (v0 // 4))
        fallout.set_map_var(22, 1)
        fallout.set_local_var(6, 0)
        fallout.set_local_var(5, 0)
        fallout.gsay_message(597, fallout.message_str(597, 255) .. (v0 // 4) .. fallout.message_str(597, 256), 50)
        fallout.gsay_message(597, 259, 51)
    else
        fallout.set_map_var(22, 1)
        fallout.set_map_var(44, 1)
        fallout.set_map_var(11, 1)
        fallout.set_local_var(6, 0)
        fallout.set_local_var(5, 0)
        fallout.gsay_message(597, 257, 51)
        combat()
    end
end

function Lorenzo15f()
    fallout.set_map_var(22, 1)
    fallout.set_map_var(44, 1)
    fallout.set_map_var(11, 1)
    fallout.set_local_var(6, 0)
    fallout.set_local_var(5, 0)
    fallout.gsay_message(597, 258, 51)
    combat()
end

function Lorenzo16()
    local v0 = 0
    local v1 = 0
    v0 = (fallout.local_var(6) // 10 * (time.game_time_in_days() - fallout.local_var(5))) + fallout.local_var(6)
    if fallout.item_caps_total(fallout.dude_obj()) >= v0 then
        v1 = fallout.item_caps_adjust(fallout.dude_obj(), -1 * v0)
        fallout.set_local_var(6, 0)
        fallout.set_local_var(5, 0)
        fallout.gsay_reply(597, 138)
        fallout.giq_option(4, 597, 139, Lorenzo16a, 50)
        fallout.giq_option(4, 597, 140, Lorenzo28, 50)
        fallout.giq_option(4, 597, 141, Lorenzo15, 50)
    else
        fallout.gsay_message(597, 261, 51)
        Lorenzo15()
    end
end

function Lorenzo16a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, -10)) then
        Lorenzo06()
    else
        Lorenzo07()
    end
end

function Lorenzo19()
    fallout.gsay_reply(597, 143)
    if fallout.local_var(7) >= 800 then
        fallout.giq_option(4, 597, fallout.message_str(597, 144) .. fallout.message_str(597, 145) .. fallout.message_str(597, 150), Lorenzo29, 50)
    end
    if fallout.local_var(7) >= 600 then
        fallout.giq_option(4, 597, fallout.message_str(597, 144) .. fallout.message_str(597, 146) .. fallout.message_str(597, 150), Lorenzo30, 50)
    end
    if fallout.local_var(7) >= 400 then
        fallout.giq_option(4, 597, fallout.message_str(597, 144) .. fallout.message_str(597, 147) .. fallout.message_str(597, 150), Lorenzo31, 50)
    end
    if fallout.local_var(7) >= 200 then
        fallout.giq_option(4, 597, fallout.message_str(597, 144) .. fallout.message_str(597, 148) .. fallout.message_str(597, 150), Lorenzo32, 50)
    end
    fallout.giq_option(4, 597, fallout.message_str(597, 144) .. fallout.message_str(597, 149) .. fallout.message_str(597, 150), Lorenzo33, 50)
    fallout.giq_option(4, 597, 151, Lorenzo34, 50)
end

function Lorenzo20()
    fallout.set_map_var(44, 1)
    fallout.set_map_var(11, 1)
    fallout.gsay_message(597, 152, 51)
    combat()
end

function Lorenzo21()
    fallout.set_map_var(22, 1)
    fallout.gsay_message(597, 153, 50)
end

function Lorenzo22()
    fallout.gsay_reply(597, 154)
    if fallout.global_var(106) == 1 then
        fallout.giq_option(4, 597, 155, Lorenzo35, 50)
    end
    if fallout.global_var(219) == 1 then
        fallout.giq_option(4, 597, 156, Lorenzo23, 50)
    end
    fallout.giq_option(4, 597, 157, Lorenzo24, 50)
    fallout.giq_option(4, 597, 158, Lorenzo25, 50)
    fallout.giq_option(4, 597, 159, Lorenzo26, 50)
    fallout.giq_option(4, 597, 160, Lorenzo27, 50)
end

function Lorenzo23()
    fallout.set_map_var(21, 1)
    fallout.gsay_reply(597, 161)
    if fallout.global_var(106) == 1 then
        fallout.giq_option(4, 597, 162, Lorenzo22, 50)
    end
    fallout.giq_option(4, 597, 163, Lorenzo36, 50)
    fallout.giq_option(4, 597, 164, Lorenzo24, 50)
    fallout.giq_option(4, 597, 165, Lorenzo25, 50)
    fallout.giq_option(4, 597, 166, Lorenzo26, 50)
    fallout.giq_option(4, 597, 167, Lorenzo27, 50)
end

function Lorenzo24()
    fallout.gsay_reply(597, 168)
    if fallout.global_var(106) == 1 then
        fallout.giq_option(4, 597, 169, Lorenzo22, 50)
    end
    if fallout.global_var(219) == 1 then
        fallout.giq_option(4, 597, 170, Lorenzo23, 50)
    end
    fallout.giq_option(4, 597, 171, Lorenzo37, 50)
    fallout.giq_option(4, 597, 172, Lorenzo25, 50)
    fallout.giq_option(4, 597, 173, Lorenzo26, 50)
    fallout.giq_option(4, 597, 174, Lorenzo27, 50)
end

function Lorenzo25()
    fallout.gsay_reply(597, 175)
    if fallout.global_var(106) == 1 then
        fallout.giq_option(4, 597, 176, Lorenzo22, 50)
    end
    if fallout.global_var(219) == 1 then
        fallout.giq_option(4, 597, 177, Lorenzo23, 50)
    end
    fallout.giq_option(4, 597, 178, Lorenzo24, 50)
    fallout.giq_option(4, 597, 179, Lorenzo38, 50)
    fallout.giq_option(4, 597, 180, Lorenzo26, 50)
    fallout.giq_option(4, 597, 181, Lorenzo27, 50)
end

function Lorenzo26()
    fallout.gsay_reply(597, 182)
    if fallout.global_var(106) == 1 then
        fallout.giq_option(4, 597, 183, Lorenzo22, 50)
    end
    if fallout.global_var(219) == 1 then
        fallout.giq_option(4, 597, 184, Lorenzo23, 50)
    end
    fallout.giq_option(4, 597, 185, Lorenzo24, 50)
    fallout.giq_option(4, 597, 186, Lorenzo25, 50)
    fallout.giq_option(4, 597, 187, Lorenzo39, 50)
    fallout.giq_option(4, 597, 188, Lorenzo27, 50)
end

function Lorenzo27()
    fallout.set_global_var(219, 1)
    fallout.set_map_var(21, 1)
    fallout.gsay_reply(597, 189)
    if fallout.global_var(106) == 1 then
        fallout.giq_option(4, 597, 190, Lorenzo22, 50)
    end
    if fallout.global_var(219) == 1 then
        fallout.giq_option(4, 597, 191, Lorenzo23, 50)
    end
    fallout.giq_option(4, 597, 192, Lorenzo24, 50)
    fallout.giq_option(4, 597, 193, Lorenzo25, 50)
    fallout.giq_option(4, 597, 194, Lorenzo26, 50)
    fallout.giq_option(4, 597, 195, Lorenzo40, 50)
end

function Lorenzo28()
    fallout.set_map_var(22, 1)
    fallout.gsay_message(597, 196, 51)
end

function Lorenzo29()
    local v0 = 0
    fallout.set_local_var(6, 1000)
    fallout.set_local_var(5, time.game_time_in_days())
    v0 = fallout.item_caps_adjust(fallout.dude_obj(), 1000)
    if fallout.local_var(7) <= 1000 then
        fallout.set_local_var(7, 1000)
    end
    fallout.gsay_message(597, 197, 50)
end

function Lorenzo30()
    local v0 = 0
    fallout.set_local_var(6, 800)
    fallout.set_local_var(5, time.game_time_in_days())
    v0 = fallout.item_caps_adjust(fallout.dude_obj(), 800)
    if fallout.local_var(7) <= 800 then
        fallout.set_local_var(7, 800)
    end
    fallout.gsay_message(597, 198, 50)
end

function Lorenzo31()
    local v0 = 0
    fallout.set_local_var(6, 600)
    fallout.set_local_var(5, time.game_time_in_days())
    v0 = fallout.item_caps_adjust(fallout.dude_obj(), 600)
    if fallout.local_var(7) <= 600 then
        fallout.set_local_var(7, 600)
    end
    fallout.gsay_message(597, 199, 50)
end

function Lorenzo32()
    local v0 = 0
    fallout.set_local_var(6, 400)
    fallout.set_local_var(5, time.game_time_in_days())
    v0 = fallout.item_caps_adjust(fallout.dude_obj(), 400)
    if fallout.local_var(7) <= 400 then
        fallout.set_local_var(7, 400)
    end
    fallout.gsay_message(597, 200, 50)
end

function Lorenzo33()
    local v0 = 0
    fallout.set_local_var(6, 200)
    fallout.set_local_var(5, time.game_time_in_days())
    v0 = fallout.item_caps_adjust(fallout.dude_obj(), 200)
    if fallout.local_var(7) <= 200 then
        fallout.set_local_var(7, 200)
    end
    fallout.gsay_message(597, 201, 50)
end

function Lorenzo34()
    fallout.gsay_message(597, 202, 50)
end

function Lorenzo35()
    fallout.gsay_reply(597, 203)
    if fallout.global_var(219) == 1 then
        fallout.giq_option(4, 597, 204, Lorenzo23, 50)
    end
    fallout.giq_option(4, 597, 205, Lorenzo24, 50)
    fallout.giq_option(4, 597, 206, Lorenzo25, 50)
    fallout.giq_option(4, 597, 207, Lorenzo26, 50)
    fallout.giq_option(4, 597, 208, Lorenzo27, 50)
    fallout.giq_option(4, 597, 209, Lorenzo41, 50)
end

function Lorenzo36()
    fallout.gsay_reply(597, 210)
    if fallout.global_var(106) == 1 then
        fallout.giq_option(4, 597, 211, Lorenzo22, 50)
    end
    fallout.giq_option(4, 597, 212, Lorenzo24, 50)
    fallout.giq_option(4, 597, 213, Lorenzo25, 50)
    fallout.giq_option(4, 597, 214, Lorenzo26, 50)
    fallout.giq_option(4, 597, 215, Lorenzo27, 50)
    fallout.giq_option(4, 597, 216, Lorenzo41, 50)
end

function Lorenzo37()
    fallout.set_global_var(219, 1)
    fallout.gsay_reply(597, 217)
    if fallout.global_var(106) == 1 then
        fallout.giq_option(4, 597, 218, Lorenzo22, 50)
    end
    if fallout.global_var(219) == 1 then
        fallout.giq_option(4, 597, 219, Lorenzo23, 50)
    end
    fallout.giq_option(4, 597, 220, Lorenzo25, 50)
    fallout.giq_option(4, 597, 221, Lorenzo26, 50)
    fallout.giq_option(4, 597, 222, Lorenzo27, 50)
    fallout.giq_option(4, 597, 223, Lorenzo41, 50)
end

function Lorenzo38()
    fallout.set_global_var(196, 1)
    if fallout.global_var(75) == 0 then
        fallout.set_global_var(75, 1)
    end
    fallout.gsay_reply(597, 224)
    if fallout.global_var(106) == 1 then
        fallout.giq_option(4, 597, 225, Lorenzo22, 50)
    end
    if fallout.global_var(219) == 1 then
        fallout.giq_option(4, 597, 226, Lorenzo23, 50)
    end
    fallout.giq_option(4, 597, 227, Lorenzo24, 50)
    fallout.giq_option(4, 597, 228, Lorenzo26, 50)
    fallout.giq_option(4, 597, 229, Lorenzo27, 50)
    fallout.giq_option(4, 597, 230, Lorenzo41, 50)
end

function Lorenzo39()
    fallout.gsay_reply(597, 231)
    if fallout.global_var(106) == 1 then
        fallout.giq_option(4, 597, 232, Lorenzo22, 50)
    end
    if fallout.global_var(219) == 1 then
        fallout.giq_option(4, 597, 233, Lorenzo23, 50)
    end
    fallout.giq_option(4, 597, 234, Lorenzo24, 50)
    fallout.giq_option(4, 597, 235, Lorenzo25, 50)
    fallout.giq_option(4, 597, 236, Lorenzo27, 50)
    fallout.giq_option(4, 597, 237, Lorenzo41, 50)
end

function Lorenzo40()
    fallout.gsay_reply(597, 238)
    if fallout.global_var(106) == 1 then
        fallout.giq_option(4, 597, 239, Lorenzo22, 50)
    end
    if fallout.global_var(219) == 1 then
        fallout.giq_option(4, 597, 240, Lorenzo23, 50)
    end
    fallout.giq_option(4, 597, 241, Lorenzo24, 50)
    fallout.giq_option(4, 597, 242, Lorenzo25, 50)
    fallout.giq_option(4, 597, 243, Lorenzo26, 50)
    fallout.giq_option(4, 597, 244, Lorenzo41, 50)
end

function Lorenzo41()
    fallout.gsay_message(597, 245, 50)
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
exports.timed_event_p_proc = timed_event_p_proc
return exports
