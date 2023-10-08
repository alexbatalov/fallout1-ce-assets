local fallout = require("fallout")
local reaction = require("lib.reaction")
local reputation = require("lib.reputation")

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
local mutanend
local mutancbt

local HOSTILE = 0
local only_once = 1
local Weapons = 0
local DISGUISED = 0
local again = 0
local rndx = 0

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
        if HOSTILE then
            HOSTILE = 0
            fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
        else
            if fallout.external_var("signal_mutants") == 1 then
                fallout.set_external_var("signal_mutants", 0)
                mutancbt()
            else
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
            end
        end
    else
        if (fallout.script_action() == 21) or (fallout.script_action() == 3) then
            fallout.script_overrides()
        else
            if fallout.script_action() == 18 then
                reputation.inc_evil_critter()
            end
        end
    end
end

function do_dialogue()
    fallout.set_local_var(3, 1)
    reaction.get_reaction()
    fallout.start_gdialog(524, fallout.self_obj(), 4, -1, -1)
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
    rndx = fallout.random(1, 8)
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
        fallout.gsay_reply(524, 104)
    else
        fallout.gsay_reply(524, 105)
    end
    fallout.giq_option(4, 524, 107, mutan02, 51)
    fallout.giq_option(6, 524, 108, mutan03, 50)
    fallout.giq_option(9, 524, 109, mutan04, 50)
    fallout.giq_option(-3, 524, 106, mutan02, 51)
end

function mutan02()
    fallout.gsay_message(524, 110, 51)
    mutancbt()
end

function mutan03()
    fallout.gsay_reply(524, 111)
    fallout.giq_option(6, 524, 112, mutan03a, 50)
    fallout.giq_option(6, 524, 113, mutancbt, 51)
end

function mutan03a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        mutan04()
    else
        mutan02()
    end
end

function mutan04()
    fallout.gsay_message(524, 114, 50)
    fallout.set_local_var(5, 1)
end

function mutan05()
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        fallout.gsay_reply(524, 115)
    else
        fallout.gsay_reply(524, 116)
    end
    fallout.giq_option(4, 524, 118, mutan05a, 50)
    fallout.giq_option(6, 524, 119, mutan05b, 50)
    fallout.giq_option(-3, 524, 106, mutan06, 50)
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
    fallout.gsay_message(524, 120, 50)
    fallout.set_local_var(5, 1)
end

function mutan07()
    fallout.gsay_message(524, 121, 51)
    mutancbt()
end

function mutan08()
    fallout.gsay_reply(524, 122)
    fallout.giq_option(4, 524, 123, mutan08a, 50)
    if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1)) then
        fallout.giq_option(4, 524, 124, mutancbt, 51)
    end
    fallout.giq_option(7, 524, 125, mutan08b, 50)
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
    fallout.gsay_message(524, 126, 51)
    mutancbt()
end

function mutan10()
    fallout.gsay_message(524, 127, 50)
    fallout.set_local_var(5, 1)
end

function mutan11()
    fallout.gsay_reply(524, 128)
    fallout.giq_option(6, 524, 129, mutan11a, 50)
    fallout.giq_option(6, 524, 130, mutancbt, 51)
end

function mutan11a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        mutan12()
    else
        mutan09()
    end
end

function mutan12()
    fallout.gsay_message(524, 131, 50)
    fallout.set_local_var(5, 1)
end

function mutan13()
    fallout.gsay_reply(524, 132)
    fallout.giq_option(4, 524, 134, mutancbt, 51)
    fallout.giq_option(4, 524, 135, mutan13a, 50)
    fallout.giq_option(6, 524, 136, mutan13b, 50)
    fallout.giq_option(-3, 524, 133, mutan14, 51)
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
    fallout.gsay_message(524, 137, 51)
    mutancbt()
end

function mutan15()
    rndx = fallout.random(1, 3)
    if rndx == 1 then
        fallout.gsay_message(524, 138, 50)
    else
        if rndx == 2 then
            fallout.gsay_message(524, 139, 50)
        else
            if rndx == 3 then
                fallout.gsay_message(524, 140, 50)
            end
        end
    end
end

function mutanend()
end

function mutancbt()
    HOSTILE = 1
end

local exports = {}
exports.start = start
return exports
