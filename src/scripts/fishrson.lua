local fallout = require("fallout")
local behaviour = require("lib.behaviour")
local misc = require("lib.misc")
local reaction = require("lib.reaction")
local reputation = require("lib.reputation")

local start
local critter_p_proc
local damage_p_proc
local destroy_p_proc
local look_at_p_proc
local pickup_p_proc
local talk_p_proc
local FishrSon00
local FishrSon01
local FishrSon02
local FishrSon02a
local FishrSon03
local FishrSon04
local FishrSon05
local FishrSon05a
local FishrSon06
local FishrSon07
local FishrSon08
local FishrSon09
local FishrSon10
local FishrSon11
local FishrSon11a
local FishrSon12
local FishrSon13
local FishrSon14
local FishrSon15
local FishrSon16
local FishrSon17
local FishrSon18
local FishrSon19
local FishrSon20
local FishrSon21

local initialized = false
local known = 0

local exit_line = 0

function start()
    if not initialized then
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 2)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 68)
        fallout.set_external_var("dude_enemy", fallout.global_var(334))
        initialized = true
    else
        if fallout.script_action() == 12 then
            critter_p_proc()
        else
            if fallout.script_action() == 14 then
                damage_p_proc()
            else
                if fallout.script_action() == 18 then
                    destroy_p_proc()
                else
                    if fallout.script_action() == 21 then
                        look_at_p_proc()
                    else
                        if fallout.script_action() == 4 then
                            pickup_p_proc()
                        else
                            if fallout.script_action() == 11 then
                                talk_p_proc()
                            end
                        end
                    end
                end
            end
        end
    end
end

function critter_p_proc()
    if fallout.external_var("dude_enemy") and (fallout.tile_distance_objs(fallout.dude_obj(), fallout.self_obj()) < 8) then
        behaviour.flee_dude(1)
    end
end

function damage_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.set_external_var("dude_enemy", 1)
        fallout.set_global_var(334, 1)
    end
end

function destroy_p_proc()
    reputation.inc_good_critter()
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(645, 100))
end

function pickup_p_proc()
    fallout.set_external_var("dude_enemy", 1)
    fallout.set_global_var(334, 1)
end

function talk_p_proc()
    reaction.get_reaction()
    if fallout.external_var("dude_enemy") ~= 0 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(669, 103), 0)
    else
        if (fallout.global_var(158) > 2) or (fallout.local_var(1) < 2) or (fallout.global_var(155) < -30) then
            FishrSon00()
        else
            if misc.is_armed(fallout.dude_obj()) then
                FishrSon01()
            else
                fallout.start_gdialog(645, fallout.self_obj(), 4, -1, -1)
                fallout.gsay_start()
                if known or (fallout.global_var(155) < 30) then
                    FishrSon04()
                else
                    FishrSon02()
                end
                fallout.gsay_end()
                fallout.end_dialogue()
            end
        end
    end
end

function FishrSon00()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(645, 101), 0)
end

function FishrSon01()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(645, 102), 0)
end

function FishrSon02()
    known = 1
    fallout.gsay_reply(645, 103)
    FishrSon02a()
end

function FishrSon02a()
    fallout.giq_option(4, 645, 104, FishrSon06, 50)
    fallout.giq_option(4, 645, 105, FishrSon07, 50)
    fallout.giq_option(4, 645, 106, FishrSon08, 50)
    fallout.giq_option(4, 645, 107, FishrSon10, 50)
    fallout.giq_option(-3, 645, 108, FishrSon09, 50)
end

function FishrSon03()
    known = 1
    fallout.gsay_reply(645, 109)
    fallout.giq_option(4, 645, 110, FishrSon05, 50)
    FishrSon02a()
end

function FishrSon04()
    fallout.gsay_reply(645, 111)
    fallout.giq_option(4, 645, 110, FishrSon05, 50)
    FishrSon02a()
end

function FishrSon05()
    fallout.gsay_reply(645, 112)
    fallout.giq_option(0, 634, 106, FishrSon05a, 50)
end

function FishrSon05a()
    fallout.gsay_reply(645, 113)
    fallout.giq_option(4, 645, 104, FishrSon06, 50)
    fallout.giq_option(4, 645, 105, FishrSon07, 50)
    fallout.giq_option(4, 645, 106, FishrSon08, 50)
    fallout.giq_option(4, 645, 114, FishrSon12, 50)
    fallout.giq_option(4, 645, 115, FishrSon13, 50)
end

function FishrSon06()
    fallout.gsay_reply(645, 116)
    fallout.giq_option(4, 645, 117, FishrSon14, 50)
    fallout.giq_option(4, 645, 104, FishrSon06, 50)
    fallout.giq_option(4, 645, 105, FishrSon07, 50)
    fallout.giq_option(4, 645, 106, FishrSon08, 50)
    fallout.giq_option(4, 645, 114, FishrSon12, 50)
end

function FishrSon07()
    fallout.gsay_message(645, 118, 50)
end

function FishrSon08()
    fallout.gsay_reply(645, 119)
    fallout.giq_option(4, 645, 110, FishrSon05, 50)
    fallout.giq_option(4, 645, 104, FishrSon06, 50)
    fallout.giq_option(4, 645, 105, FishrSon07, 50)
    fallout.giq_option(4, 645, 106, FishrSon08, 50)
    fallout.giq_option(4, 645, 120, FishrSon15, 50)
end

function FishrSon09()
    fallout.gsay_message(645, 121, 50)
end

function FishrSon10()
    fallout.gsay_reply(645, 122)
    fallout.giq_option(4, 645, 123, FishrSon16, 49)
    fallout.giq_option(4, 645, 124, FishrSon16, 49)
    fallout.giq_option(4, 645, 125, FishrSon16, 49)
end

function FishrSon11()
    fallout.gsay_reply(645, 126)
    fallout.giq_option(0, 634, 106, FishrSon11a, 49)
end

function FishrSon11a()
    fallout.gsay_message(645, 127, 49)
end

function FishrSon12()
    fallout.gsay_reply(645, 128)
    fallout.giq_option(4, 645, 110, FishrSon05, 50)
    fallout.giq_option(4, 645, 104, FishrSon06, 50)
    fallout.giq_option(4, 645, 105, FishrSon07, 50)
    fallout.giq_option(4, 645, 106, FishrSon08, 50)
end

function FishrSon13()
    fallout.gsay_reply(645, 129)
    fallout.giq_option(4, 645, 110, FishrSon05, 50)
    fallout.giq_option(4, 645, 104, FishrSon06, 50)
    fallout.giq_option(4, 645, 105, FishrSon07, 50)
    fallout.giq_option(4, 645, 106, FishrSon08, 50)
    fallout.giq_option(4, 645, 130, FishrSon17, 50)
end

function FishrSon14()
    fallout.gsay_message(645, 131, 50)
end

function FishrSon15()
    fallout.gsay_reply(645, 132)
    fallout.giq_option(4, 645, 110, FishrSon05, 50)
    fallout.giq_option(4, 645, 104, FishrSon06, 50)
    fallout.giq_option(4, 645, 105, FishrSon07, 50)
    fallout.giq_option(4, 645, 133, FishrSon18, 50)
    fallout.giq_option(4, 645, 134, FishrSon19, 50)
end

function FishrSon16()
    fallout.gsay_message(645, 135, 49)
end

function FishrSon17()
    fallout.gsay_reply(645, 136)
    fallout.giq_option(4, 645, 137, FishrSon20, 50)
    if fallout.global_var(74) > 0 then
        fallout.giq_option(4, 645, 138, FishrSon21, 50)
    end
end

function FishrSon18()
    fallout.gsay_reply(645, 139)
    fallout.giq_option(4, 645, 110, FishrSon05, 50)
    fallout.giq_option(4, 645, 104, FishrSon06, 50)
    fallout.giq_option(4, 645, 105, FishrSon07, 50)
    fallout.giq_option(4, 645, 134, FishrSon18, 50)
end

function FishrSon19()
    fallout.gsay_message(645, 140, 50)
end

function FishrSon20()
    fallout.gsay_message(645, 141, 49)
end

function FishrSon21()
    fallout.gsay_message(645, 142, 50)
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.damage_p_proc = damage_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
return exports
