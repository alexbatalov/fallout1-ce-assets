local fallout = require("fallout")

local start
local do_dialogue
local pre_dialogue
local Darrel01
local Darrel02
local Darrel02a
local Darrel02b
local Darrel02c
local Darrel03
local Darrel04
local Darrel05
local Darrel06
local Darrel07
local Darrel08
local Darrel09
local Darrel10
local Darrel11
local Darrel12
local Darrel13
local Darrel14
local Darrel15
local Darrel16
local Darrel58
local Darrel59
local Darrel60
local Darrel61
local Darrel62
local Darrel63
local Darrel64
local Darrel66
local Darrel67
local Darrel68
local Darrel69
local Darrel70
local Darrel71
local Darrel72
local Darrel73
local Darrel75
local Darrel76
local DarrelEnd
local giveradx
local combat
local damage_p_proc
local critter_p_proc
local pickup_p_proc
local talk_p_proc
local destroy_p_proc
local look_at_p_proc

local known = 0
local only_once = 1
local hostile = 0
local radx = 0
local second = 0
local ccount = 0

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
    if only_once then
        only_once = 0
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 44)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 64)
    end
    if fallout.script_action() == 21 then
        look_at_p_proc()
    else
        if fallout.script_action() == 14 then
            damage_p_proc()
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
end

function do_dialogue()
    get_reaction()
    fallout.start_gdialog(316, fallout.self_obj(), 4, -1, -1)
    fallout.gsay_start()
    if fallout.global_var(108) == 1 then
        if second then
            Darrel71()
        else
            second = 1
            Darrel59()
        end
    else
        if fallout.local_var(4) == 0 then
            Darrel01()
        else
            Darrel16()
        end
    end
    fallout.gsay_end()
    fallout.end_dialogue()
    fallout.set_local_var(4, 1)
end

function pre_dialogue()
    if fallout.local_var(4) == 0 then
        do_dialogue()
    else
        if fallout.global_var(108) == 2 then
            Darrel73()
        else
            do_dialogue()
        end
    end
end

function Darrel01()
    fallout.gsay_reply(316, 102)
    fallout.giq_option(-3, 316, 103, Darrel02, 50)
    fallout.giq_option(4, 316, 104, Darrel03, 50)
    if fallout.global_var(30) ~= 1 then
        fallout.giq_option(4, 316, 105, Darrel04, 50)
    end
    if fallout.global_var(106) == 1 then
        fallout.giq_option(4, 316, 106, Darrel75, 50)
    end
    fallout.giq_option(4, 316, 107, DarrelEnd, 50)
end

function Darrel02()
    if fallout.local_var(6) == 0 then
        fallout.gsay_reply(316, 108)
        fallout.giq_option(-3, 316, 300, Darrel02a, 50)
    else
        fallout.gsay_message(316, 108, 50)
    end
end

function Darrel02a()
    fallout.gsay_reply(316, 209)
    fallout.giq_option(-3, 316, 300, Darrel02b, 50)
end

function Darrel02b()
    fallout.gsay_reply(316, 210)
    fallout.giq_option(-3, 316, 300, Darrel02c, 50)
end

function Darrel02c()
    fallout.gsay_reply(316, 211)
    fallout.giq_option(-3, 316, 300, giveradx, 50)
end

function Darrel03()
    fallout.gsay_reply(316, 110)
    fallout.giq_option(4, 316, 111, Darrel05, 50)
    fallout.giq_option(4, 316, 112, Darrel12, 50)
    fallout.giq_option(4, 316, 113, Darrel06, 50)
    fallout.giq_option(4, 316, 114, DarrelEnd, 50)
end

function Darrel04()
    fallout.gsay_reply(316, 115)
    fallout.giq_option(4, 316, 116, Darrel07, 50)
    fallout.giq_option(4, 316, 201, DarrelEnd, 50)
    fallout.giq_option(4, 316, 118, Darrel11, 50)
end

function Darrel05()
    fallout.gsay_reply(316, 119)
    if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1)) then
        fallout.giq_option(4, 316, 120, DarrelEnd, 50)
    end
    fallout.giq_option(4, 316, 121, Darrel08, 50)
    fallout.giq_option(4, 316, 122, Darrel09, 50)
end

function Darrel06()
    fallout.gsay_reply(316, 123)
    fallout.giq_option(4, 316, 202, DarrelEnd, 50)
    fallout.giq_option(4, 316, 125, Darrel04, 50)
end

function Darrel07()
    fallout.gsay_reply(316, 126)
    fallout.giq_option(4, 316, 202, DarrelEnd, 50)
    fallout.giq_option(4, 316, 127, Darrel03, 50)
end

function Darrel08()
    fallout.gsay_reply(316, 128)
    fallout.giq_option(4, 316, 129, Darrel10, 50)
    fallout.giq_option(4, 316, 130, Darrel11, 50)
end

function Darrel09()
    fallout.gsay_reply(316, 109)
    fallout.giq_option(4, 316, 129, Darrel10, 50)
    fallout.giq_option(4, 316, 130, Darrel11, 50)
end

function Darrel10()
    fallout.gsay_reply(316, 131)
    fallout.giq_option(4, 316, 132, Darrel07, 50)
    fallout.giq_option(4, 316, 133, Darrel11, 50)
end

function Darrel11()
    fallout.gsay_message(316, 134, 50)
end

function Darrel12()
    fallout.gsay_reply(316, 135)
    fallout.giq_option(4, 316, 136, Darrel13, 50)
    fallout.giq_option(4, 316, 137, Darrel15, 50)
    fallout.giq_option(4, 316, 203, DarrelEnd, 50)
end

function Darrel13()
    fallout.gsay_reply(316, 139)
    fallout.giq_option(4, 316, 140, Darrel13, 50)
    fallout.giq_option(4, 316, 132, Darrel07, 50)
    fallout.giq_option(4, 316, 204, DarrelEnd, 50)
end

function Darrel14()
    fallout.gsay_reply(316, 143)
    if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1)) then
        fallout.giq_option(4, 316, 144, combat, 51)
    end
    fallout.giq_option(4, 316, 141, Darrel07, 50)
    fallout.giq_option(4, 316, 145, DarrelEnd, 50)
    fallout.giq_option(4, 316, 146, Darrel05, 50)
end

function Darrel15()
    fallout.gsay_reply(316, 147)
    fallout.giq_option(4, 316, 148, Darrel14, 50)
    fallout.giq_option(4, 316, 149, Darrel07, 50)
    fallout.giq_option(4, 316, 203, DarrelEnd, 50)
end

function Darrel16()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(316, 151), 2)
end

function Darrel58()
    fallout.set_local_var(5, 1)
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(316, 152), 2)
    else
        fallout.float_msg(fallout.self_obj(), fallout.message_str(316, 153), 2)
    end
end

function Darrel59()
    fallout.gsay_reply(316, 154)
    fallout.giq_option(4, 316, 155, Darrel60, 50)
    fallout.giq_option(4, 316, 156, Darrel61, 50)
    fallout.giq_option(4, 316, 157, Darrel62, 50)
    fallout.giq_option(4, 316, 158, DarrelEnd, 50)
    fallout.giq_option(-3, 316, 103, Darrel02, 50)
end

function Darrel60()
    fallout.gsay_reply(316, 159)
    fallout.giq_option(4, 316, 160, Darrel63, 50)
    fallout.giq_option(4, 316, 161, Darrel63, 50)
    fallout.giq_option(4, 316, 162, Darrel64, 50)
    fallout.giq_option(4, 316, 163, Darrel61, 50)
end

function Darrel61()
    fallout.gsay_reply(316, 164)
    fallout.giq_option(4, 316, 165, Darrel66, 50)
    fallout.giq_option(4, 316, 166, Darrel67, 50)
end

function Darrel62()
    fallout.gsay_message(316, 167, 50)
end

function Darrel63()
    fallout.gsay_reply(316, 168)
    fallout.giq_option(4, 316, 203, DarrelEnd, 50)
    fallout.giq_option(4, 316, 170, Darrel72, 50)
end

function Darrel64()
    fallout.gsay_reply(316, 171)
    fallout.giq_option(4, 316, 205, DarrelEnd, 50)
    fallout.giq_option(4, 316, 170, Darrel69, 50)
end

function Darrel66()
    fallout.gsay_reply(316, 174)
    fallout.giq_option(4, 316, 175, Darrel68, 50)
    fallout.giq_option(4, 316, 176, DarrelEnd, 50)
    fallout.giq_option(4, 316, 177, Darrel63, 50)
    fallout.giq_option(4, 316, 206, DarrelEnd, 50)
end

function Darrel67()
    fallout.gsay_reply(316, 179)
    fallout.giq_option(4, 316, 180, Darrel64, 50)
    fallout.giq_option(4, 316, 203, DarrelEnd, 50)
end

function Darrel68()
    fallout.gsay_reply(316, 181)
    fallout.giq_option(4, 316, 182, DarrelEnd, 50)
    fallout.giq_option(4, 316, 183, Darrel63, 50)
    fallout.giq_option(4, 316, 184, DarrelEnd, 50)
end

function Darrel69()
    fallout.gsay_reply(316, 189)
    fallout.giq_option(4, 316, 203, DarrelEnd, 50)
    fallout.giq_option(4, 316, 190, Darrel72, 50)
end

function Darrel70()
    fallout.gsay_reply(316, 168)
    fallout.giq_option(4, 316, 203, DarrelEnd, 50)
    fallout.giq_option(4, 316, 190, Darrel72, 50)
end

function Darrel71()
    fallout.gsay_reply(316, 191)
    fallout.giq_option(4, 316, 188, Darrel72, 50)
    fallout.giq_option(4, 316, 192, DarrelEnd, 50)
    fallout.giq_option(-3, 316, 103, Darrel02, 50)
end

function Darrel72()
    fallout.gsay_reply(316, 193)
    fallout.giq_option(4, 316, 186, Darrel69, 50)
    fallout.giq_option(4, 316, 187, Darrel70, 50)
    if fallout.global_var(106) == 1 then
        fallout.giq_option(4, 316, 106, Darrel75, 50)
    end
    fallout.giq_option(4, 316, 207, DarrelEnd, 50)
end

function Darrel73()
    ccount = ccount + 1
    if ccount < 6 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(723, 200 + fallout.random(0, 2)), 2)
    else
        if ccount < 9 then
            fallout.float_msg(fallout.self_obj(), fallout.message_str(723, 203 + fallout.random(0, 4)), 2)
        else
            if ccount < 12 then
                fallout.float_msg(fallout.self_obj(), fallout.message_str(723, 209 + fallout.random(0, 3)), 2)
            else
                fallout.display_msg(fallout.message_str(723, 213))
            end
        end
    end
end

function Darrel75()
    fallout.gsay_reply(316, 195)
    fallout.giq_option(4, 316, 196, Darrel11, 50)
    fallout.giq_option(4, 316, 197, Darrel76, 50)
    fallout.giq_option(4, 316, 104, Darrel03, 50)
    fallout.giq_option(4, 316, 198, DarrelEnd, 50)
end

function Darrel76()
    fallout.gsay_reply(316, 199)
    fallout.giq_option(4, 316, 104, Darrel03, 50)
    if fallout.global_var(30) ~= 1 then
        fallout.giq_option(4, 316, 105, Darrel04, 50)
    end
    fallout.giq_option(4, 316, 208, DarrelEnd, 50)
end

function DarrelEnd()
end

function giveradx()
    fallout.set_local_var(6, 1)
    radx = fallout.create_object_sid(109, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), radx)
    fallout.gsay_reply(316, 212)
    fallout.giq_option(-3, 316, 300, DarrelEnd, 50)
end

function combat()
    hostile = 1
end

function damage_p_proc()
    fallout.set_global_var(250, 1)
end

function critter_p_proc()
    if fallout.global_var(250) then
        hostile = 1
    end
    if fallout.tile_distance_objs(fallout.self_obj(), fallout.dude_obj()) > 12 then
        hostile = 0
    end
    if hostile then
        fallout.set_global_var(250, 1)
        hostile = 0
        fallout.attack_complex(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    end
    if fallout.local_var(5) == 0 then
        if fallout.global_var(108) == 1 then
            Darrel58()
        end
    end
end

function pickup_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        hostile = 1
    end
end

function talk_p_proc()
    if fallout.global_var(108) == 5 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(40, 233), 2)
    else
        pre_dialogue()
    end
end

function destroy_p_proc()
    fallout.set_global_var(250, 1)
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
    if known then
        fallout.display_msg(fallout.message_str(316, 100))
    else
        fallout.display_msg(fallout.message_str(316, 101))
    end
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
exports.damage_p_proc = damage_p_proc
exports.critter_p_proc = critter_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
return exports
