local fallout = require("fallout")

local start
local do_dialogue
local pre_dialogue
local mutan00
local mutan01
local mutan02
local mutan03
local mutan03a
local mutan04
local mutan05
local mutan05a
local mutan05b
local mutan06
local mutan07
local mutan08
local mutan08a
local mutan08b
local mutan09
local mutan10
local mutan11
local mutan11a
local mutan12
local mutan13
local mutan13a
local mutan13b
local mutan14
local mutan15
local mutan21
local mutan22
local mutan23
local mutan23a
local mutan24
local mutan24a
local mutan25
local mutan26
local mutanend
local mutancbt

local HOSTILE = 0
local only_once = 1
local Weapons = 0
local DISGUISED = 0
local again = 0
local rndx = 0

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
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 34)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 48)
    else
        if fallout.script_action() == 14 then
            if fallout.global_var(245) == 0 then
                fallout.set_global_var(245, 1)
            end
        else
            if fallout.script_action() == 11 then
                pre_dialogue()
            else
                if fallout.script_action() == 4 then
                    HOSTILE = 1
                end
            end
        end
    end
    if fallout.script_action() == 12 then
        if fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) and fallout.map_var(5) then
            HOSTILE = 1
        end
        if HOSTILE then
            HOSTILE = 0
            fallout.attack_complex(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
        end
        if fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) then
            if (fallout.obj_item_subtype(fallout.critter_inven_obj(fallout.dude_obj(), 1)) == 3) or (fallout.obj_item_subtype(fallout.critter_inven_obj(fallout.dude_obj(), 2)) == 3) then
                if Weapons == 0 then
                    Weapons = 1
                    if fallout.tile_distance_objs(fallout.self_obj(), fallout.dude_obj()) < 6 then
                        fallout.dialogue_system_enter()
                    end
                end
            end
            DISGUISED = 0
            if fallout.obj_pid(fallout.critter_inven_obj(fallout.dude_obj(), 0)) == 113 then
                if fallout.metarule(16, 0) > 1 then
                    DISGUISED = 0
                else
                    DISGUISED = 1
                end
            end
            if (DISGUISED == 0) and (again == 0) then
                if fallout.tile_distance_objs(fallout.self_obj(), fallout.dude_obj()) < 6 then
                    again = 1
                    fallout.dialogue_system_enter()
                end
            end
        end
    else
        if fallout.script_action() == 21 then
            fallout.script_overrides()
            fallout.display_msg(fallout.message_str(525, 200))
        else
            if fallout.script_action() == 18 then
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
        end
    end
end

function do_dialogue()
    fallout.set_local_var(3, 1)
    get_reaction()
    fallout.start_gdialog(525, fallout.self_obj(), 4, -1, -1)
    fallout.gsay_start()
    if Weapons == 1 then
        mutan01()
    else
        if fallout.local_var(4) then
            mutan13()
        else
            fallout.set_local_var(4, 1)
            mutan05()
        end
    end
    fallout.gsay_end()
    fallout.end_dialogue()
end

function pre_dialogue()
    if fallout.obj_pid(fallout.critter_inven_obj(fallout.dude_obj(), 0)) == 113 then
        if fallout.metarule(16, 0) > 1 then
            DISGUISED = 0
        else
            DISGUISED = 1
        end
    end
    if Weapons == 1 then
        if DISGUISED then
            do_dialogue()
        else
            mutan00()
        end
    else
        if DISGUISED then
            do_dialogue()
        else
            mutan00()
        end
    end
end

function mutan00()
    rndx = fallout.random(1, 12)
    if rndx < 5 then
        if rndx == 1 then
            fallout.float_msg(fallout.self_obj(), fallout.message_str(524, 100), 2)
        else
            if rndx == 2 then
                fallout.float_msg(fallout.self_obj(), fallout.message_str(524, 101), 2)
            else
                if rndx == 3 then
                    fallout.float_msg(fallout.self_obj(), fallout.message_str(524, 102), 2)
                else
                    if rndx == 4 then
                        fallout.float_msg(fallout.self_obj(), fallout.message_str(524, 103), 2)
                    end
                end
            end
        end
    end
    mutancbt()
end

function mutan01()
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        fallout.gsay_reply(525, 107)
    else
        fallout.gsay_reply(525, 108)
    end
    fallout.giq_option(4, 525, 110, mutan02, 51)
    fallout.giq_option(6, 525, 111, mutan03, 50)
    fallout.giq_option(9, 525, 112, mutan04, 50)
    fallout.giq_option(-3, 525, 109, mutan02, 51)
end

function mutan02()
    fallout.gsay_message(525, 113, 51)
    mutancbt()
end

function mutan03()
    fallout.gsay_reply(525, 114)
    fallout.giq_option(6, 525, 115, mutan03a, 50)
    fallout.giq_option(6, 525, 116, mutancbt, 51)
end

function mutan03a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        mutan04()
    else
        mutan02()
    end
end

function mutan04()
    fallout.gsay_message(525, 117, 50)
    fallout.set_local_var(5, 1)
end

function mutan05()
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        fallout.gsay_reply(525, 118)
    else
        fallout.gsay_reply(525, 119)
    end
    fallout.giq_option(4, 525, 121, mutan05a, 50)
    fallout.giq_option(6, 525, 122, mutan05b, 50)
    fallout.giq_option(6, 525, 201, mutan21, 50)
    fallout.giq_option(-3, 525, 109, mutan06, 50)
end

function mutan05a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        mutan08()
    else
        mutan07()
    end
end

function mutan05b()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        mutan10()
    else
        mutan11()
    end
end

function mutan06()
    fallout.gsay_message(525, 123, 50)
    fallout.set_local_var(5, 1)
end

function mutan07()
    fallout.gsay_message(525, 124, 51)
    mutancbt()
end

function mutan08()
    fallout.gsay_reply(525, 125)
    fallout.giq_option(4, 525, 126, mutan08a, 50)
    if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1)) then
        fallout.giq_option(4, 525, 127, mutancbt, 51)
    end
    fallout.giq_option(7, 525, 128, mutan08b, 50)
end

function mutan08a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        mutan04()
    else
        mutan07()
    end
end

function mutan08b()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 20)) then
        mutan04()
    else
        mutan09()
    end
end

function mutan09()
    fallout.gsay_message(525, 129, 51)
    mutancbt()
end

function mutan10()
    fallout.gsay_message(525, 130, 50)
    fallout.set_local_var(5, 1)
end

function mutan11()
    fallout.gsay_reply(525, 131)
    fallout.giq_option(6, 525, 132, mutan11a, 50)
    fallout.giq_option(6, 525, 133, mutancbt, 51)
end

function mutan11a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        mutan12()
    else
        mutan09()
    end
end

function mutan12()
    fallout.gsay_message(525, 134, 50)
    fallout.set_local_var(5, 1)
end

function mutan13()
    fallout.gsay_reply(525, 135)
    fallout.giq_option(4, 525, 137, mutancbt, 51)
    fallout.giq_option(4, 525, 138, mutan13a, 50)
    fallout.giq_option(6, 525, 139, mutan13b, 50)
    fallout.giq_option(6, 525, 201, mutan21, 50)
    fallout.giq_option(-3, 525, 136, mutan14, 51)
end

function mutan13a()
    if fallout.is_success(fallout.do_check(fallout.dude_obj(), 6, 0)) then
        mutan12()
    else
        mutan09()
    end
end

function mutan13b()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 20)) then
        mutan10()
    else
        mutan11()
    end
end

function mutan14()
    fallout.gsay_message(525, 140, 51)
    mutancbt()
end

function mutan15()
    rndx = fallout.random(1, 2)
    if rndx == 1 then
        fallout.gsay_message(525, 141, 50)
    else
        if rndx == 2 then
            fallout.gsay_message(525, 142, 50)
        end
    end
end

function mutan21()
    fallout.gsay_reply(525, 202)
    fallout.giq_option(6, 525, 203, mutan22, 50)
    fallout.giq_option(6, 525, 204, mutan23, 50)
end

function mutan22()
    fallout.gsay_message(525, 205, 50)
end

function mutan23()
    fallout.gsay_reply(525, 206)
    fallout.giq_option(6, 525, 207, mutan22, 50)
    fallout.giq_option(6, 525, 208, mutan23a, 50)
end

function mutan23a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, -25)) then
        mutan24()
    else
        mutan26()
    end
end

function mutan24()
    fallout.gsay_reply(525, 209)
    fallout.giq_option(6, 525, 210, mutan22, 50)
    fallout.giq_option(7, 525, 211, mutan24a, 50)
end

function mutan24a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, -25)) then
        mutan25()
    else
        mutan26()
    end
end

function mutan25()
    fallout.gsay_reply(525, 212)
    fallout.giq_option(6, 525, 213, mutan22, 50)
end

function mutan26()
    fallout.gsay_message(525, 214, 51)
    mutancbt()
end

function mutanend()
end

function mutancbt()
    HOSTILE = 1
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
return exports
