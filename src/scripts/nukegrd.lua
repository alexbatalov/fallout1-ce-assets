local fallout = require("fallout")
local misc = require("lib.misc")
local reaction = require("lib.reaction")
local reputation = require("lib.reputation")

local start
local pickup_p_proc
local do_dialogue
local talk_p_proc
local critter_p_proc
local damage_p_proc
local destroy_p_proc
local look_at_p_proc
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

local hostile = false
local initialized = false
local Weapons = false
local disguised = false
local again = false

function start()
    if not initialized then
        local self_obj = fallout.self_obj()
        misc.set_team(self_obj, 34)
        misc.set_ai(self_obj, 48)
        initialized = true
    end

    local script_action = fallout.script_action()
    if script_action == 14 then
        damage_p_proc()
    elseif script_action == 11 then
        talk_p_proc()
    elseif script_action == 4 then
        pickup_p_proc()
    elseif script_action == 12 then
        critter_p_proc()
    elseif script_action == 21 then
        look_at_p_proc()
    elseif script_action == 18 then
        destroy_p_proc()
    end
end

function pickup_p_proc()
    hostile = true
end

function do_dialogue()
    fallout.set_local_var(3, 1)
    reaction.get_reaction()
    fallout.start_gdialog(525, fallout.self_obj(), 4, -1, -1)
    fallout.gsay_start()
    if Weapons then
        mutan01()
    else
        if fallout.local_var(4) ~= 0 then
            mutan13()
        else
            fallout.set_local_var(4, 1)
            mutan05()
        end
    end
    fallout.gsay_end()
    fallout.end_dialogue()
end

function talk_p_proc()
    if misc.is_wearing_coc_robe(fallout.dude_obj()) then
        if misc.party_member_count() > 1 then
            disguised = false
        else
            disguised = true
        end
    end
    if Weapons then
        if disguised then
            do_dialogue()
        else
            mutan00()
        end
    else
        if disguised then
            do_dialogue()
        else
            mutan00()
        end
    end
end

function critter_p_proc()
    local self_obj = fallout.self_obj()
    local dude_obj = fallout.dude_obj()
    local self_can_see_dude = fallout.obj_can_see_obj(self_obj, dude_obj)
    if self_can_see_dude and fallout.map_var(5) ~= 0 then
        hostile = true
    end
    if hostile then
        hostile = false
        fallout.attack(dude_obj, 0, 1, 0, 0, 30000, 0, 0)
    end
    if self_can_see_dude then
        if misc.is_armed(dude_obj) then
            if not Weapons then
                Weapons = true
                if fallout.tile_distance_objs(self_obj, dude_obj) < 6 then
                    fallout.dialogue_system_enter()
                end
            end
        end
        disguised = false
        if misc.is_wearing_coc_robe(dude_obj) then
            if misc.party_member_count() > 1 then
                disguised = false
            else
                disguised = true
            end
        end
        if not disguised and not again then
            if fallout.tile_distance_objs(self_obj, dude_obj) < 6 then
                again = true
                fallout.dialogue_system_enter()
            end
        end
    end
end

function damage_p_proc()
    if fallout.global_var(245) == 0 then
        fallout.set_global_var(245, 1)
    end
end

function destroy_p_proc()
    reputation.inc_evil_critter()
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(525, 200))
end

function mutan00()
    local rndx = fallout.random(1, 12)
    if rndx < 5 then
        if rndx == 1 then
            fallout.float_msg(fallout.self_obj(), fallout.message_str(524, 100), 2)
        elseif rndx == 2 then
            fallout.float_msg(fallout.self_obj(), fallout.message_str(524, 101), 2)
        elseif rndx == 3 then
            fallout.float_msg(fallout.self_obj(), fallout.message_str(524, 102), 2)
        elseif rndx == 4 then
            fallout.float_msg(fallout.self_obj(), fallout.message_str(524, 103), 2)
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
    if reputation.has_rep_berserker() then
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
    local rndx = fallout.random(1, 2)
    if rndx == 1 then
        fallout.gsay_message(525, 141, 50)
    elseif rndx == 2 then
        fallout.gsay_message(525, 142, 50)
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
    hostile = true
end

local exports = {}
exports.start = start
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.critter_p_proc = critter_p_proc
exports.damage_p_proc = damage_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
return exports
