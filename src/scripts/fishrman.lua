local fallout = require("fallout")
local reaction = require("lib.reaction")
local reputation = require("lib.reputation")

local start
local critter_p_proc
local damage_p_proc
local destroy_p_proc
local look_at_p_proc
local pickup_p_proc
local talk_p_proc
local FishrMan00
local FishrMan01
local FishrMan02
local FishrMan03
local FishrMan03a
local FishrMan04
local FishrMan04a
local FishrMan04b
local FishrMan05
local FishrMan05a
local FishrMan06
local FishrMan07
local FishrMan07a
local FishrMan08
local FishrMan08a
local FishrMan09
local FishrMan09a
local FishrMan10
local FishrMan11
local FishrMan12
local FishrMan12a
local FishrMan13
local FishrMan14
local FishrMan15
local FishrMan15a
local FishrMan16
local FishrMan17
local FishrMan18
local FishrMan19
local FishrMan20
local FishrMan21
local FishrMan22
local FishrMan23
local FishrMan24
local FishrMan25
local FishrManBarter
local FishrManCombat
local FishrManEnd
local FishrManEnd1
local FishrManEnd2

local hostile = 0
local initialized = 0
local known = 0

fallout.create_external_var("dude_enemy")

local exit_line = 0

function start()
    if not(initialized) then
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 2)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 6)
        hostile = fallout.global_var(334)
        initialized = 1
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
                        if fallout.script_action() == 11 then
                            talk_p_proc()
                        end
                    end
                end
            end
        end
    end
end

function critter_p_proc()
    if hostile then
        hostile = 0
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    end
    if fallout.external_var("dude_enemy") then
        if fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) then
            hostile = 1
            fallout.set_global_var(334, 1)
        end
    end
end

function damage_p_proc()
    fallout.set_external_var("dude_enemy", 1)
    fallout.set_global_var(334, 1)
end

function destroy_p_proc()
    reputation.inc_good_critter()
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(644, 100))
end

function pickup_p_proc()
    fallout.set_external_var("dude_enemy", 1)
    hostile = 1
    fallout.set_global_var(334, 1)
end

function talk_p_proc()
    reaction.get_reaction()
    if fallout.external_var("dude_enemy") then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(669, 101), 0)
    else
        if (fallout.local_var(1) < 2) or (fallout.global_var(158) > 2) or (fallout.global_var(155) < -30) then
            FishrMan00()
        else
            if (fallout.obj_item_subtype(fallout.critter_inven_obj(fallout.dude_obj(), 1)) == 3) or (fallout.obj_item_subtype(fallout.critter_inven_obj(fallout.dude_obj(), 2)) == 3) then
                FishrMan25()
            else
                fallout.start_gdialog(644, fallout.self_obj(), 4, -1, -1)
                fallout.gsay_start()
                if known then
                    FishrMan03()
                else
                    if fallout.global_var(155) >= 30 then
                        FishrMan02()
                    else
                        FishrMan01()
                    end
                end
                fallout.gsay_end()
                fallout.end_dialogue()
            end
        end
    end
end

function FishrMan00()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(644, 101 + (fallout.get_critter_stat(fallout.dude_obj(), 34) == 1)), 0)
end

function FishrMan01()
    known = 1
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        fallout.gsay_reply(644, 103)
    else
        fallout.gsay_reply(644, 104)
    end
    if (fallout.global_var(101) == 1) and (fallout.obj_is_carrying_obj_pid(fallout.dude_obj(), 55) == 0) then
        fallout.giq_option(4, 644, 105, FishrMan04, 50)
    end
    fallout.giq_option(7, 644, 106, FishrMan05, 50)
    fallout.giq_option(4, 644, 107, FishrMan06, 50)
    fallout.giq_option(4, 644, 108, FishrMan07, 50)
    if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1)) then
        fallout.giq_option(4, 644, 109, FishrMan08, 51)
    end
    fallout.giq_option(-3, 644, 110, FishrMan09, 50)
end

function FishrMan02()
    known = 1
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        fallout.gsay_reply(644, 111)
    else
        fallout.gsay_reply(644, 112)
    end
    if (fallout.global_var(101) == 1) and (fallout.obj_is_carrying_obj_pid(fallout.dude_obj(), 55) == 0) then
        fallout.giq_option(4, 644, 105, FishrMan04, 50)
    end
    fallout.giq_option(7, 644, 106, FishrMan05, 50)
    fallout.giq_option(4, 644, 108, FishrMan07, 50)
    fallout.giq_option(4, 644, 113, FishrMan13, 50)
    fallout.giq_option(-3, 644, 110, FishrMan14, 50)
end

function FishrMan03()
    fallout.gsay_reply(644, 114)
    fallout.giq_option(4, 644, 115, FishrMan15, 51)
    fallout.giq_option(4, 644, 116, FishrMan16, 50)
    fallout.giq_option(4, 644, 117, FishrMan03a, 50)
    fallout.giq_option(-3, 644, 110, FishrMan19, 50)
end

function FishrMan03a()
    if fallout.get_critter_stat(fallout.dude_obj(), 3) >= 6 then
        FishrMan17()
    else
        FishrMan18()
    end
end

function FishrMan04()
    fallout.gsay_reply(644, 118)
    fallout.giq_option(0, 634, 106, FishrMan04a, 50)
end

function FishrMan04a()
    fallout.gsay_reply(644, 119)
    fallout.giq_option(0, 634, 106, FishrMan04b, 50)
end

function FishrMan04b()
    fallout.gsay_reply(644, 120)
    fallout.giq_option(0, 634, 106, FishrManEnd1, 50)
end

function FishrMan05()
    fallout.gsay_reply(644, 122)
    fallout.giq_option(0, 634, 106, FishrMan05a, 50)
end

function FishrMan05a()
    fallout.gsay_reply(644, 123)
    fallout.giq_option(0, 634, 106, FishrManEnd1, 50)
end

function FishrMan06()
    fallout.gsay_reply(644, 124)
    fallout.giq_option(0, 634, 106, FishrManEnd1, 50)
end

function FishrMan07()
    fallout.gsay_reply(644, 125)
    fallout.giq_option(0, 634, 106, FishrMan07a, 50)
end

function FishrMan07a()
    fallout.gsay_reply(644, 126)
    fallout.giq_option(0, 634, 106, FishrManEnd1, 50)
end

function FishrMan08()
    reaction.DownReactLevel()
    reaction.DownReactLevel()
    fallout.gsay_reply(644, 127)
    fallout.giq_option(4, 644, 128, FishrMan08a, 51)
    fallout.giq_option(4, 644, 129, FishrManCombat, 51)
    fallout.giq_option(4, 644, 130, FishrMan22, 50)
end

function FishrMan08a()
    if (fallout.get_critter_stat(fallout.dude_obj(), 0) >= 8) or fallout.obj_is_carrying_obj_pid(fallout.dude_obj(), 11) or fallout.obj_is_carrying_obj_pid(fallout.dude_obj(), 12) or fallout.obj_is_carrying_obj_pid(fallout.dude_obj(), 13) or fallout.obj_is_carrying_obj_pid(fallout.dude_obj(), 118) or fallout.obj_is_carrying_obj_pid(fallout.dude_obj(), 15) then
        FishrMan20()
    else
        FishrMan21()
    end
end

function FishrMan09()
    fallout.gsay_reply(644, 131 + (fallout.get_critter_stat(fallout.dude_obj(), 34) == 1))
    fallout.giq_option(0, 634, 106, FishrMan09a, 50)
end

function FishrMan09a()
    local v0 = 0
    if fallout.obj_is_carrying_obj_pid(fallout.self_obj(), 109) then
        v0 = fallout.obj_carrying_pid_obj(fallout.self_obj(), 109)
        fallout.rm_obj_from_inven(fallout.self_obj(), v0)
        fallout.add_obj_to_inven(fallout.dude_obj(), v0)
        fallout.gsay_message(644, 133, 50)
    else
        fallout.gsay_message(644, 134, 50)
    end
end

function FishrMan10()
    fallout.gsay_reply(644, 135)
    fallout.giq_option(0, 634, 106, FishrManEnd2, 50)
end

function FishrMan11()
    fallout.gsay_reply(644, 137)
    fallout.giq_option(0, 634, 106, FishrManEnd2, 50)
end

function FishrMan12()
    fallout.gsay_reply(644, 138)
    fallout.giq_option(0, 634, 106, FishrMan12a, 50)
end

function FishrMan12a()
    fallout.gsay_reply(644, 139)
    fallout.giq_option(0, 634, 106, FishrManEnd2, 50)
end

function FishrMan13()
    fallout.gsay_reply(644, 140)
    FishrManBarter()
end

function FishrMan14()
    fallout.gsay_reply(644, 141)
    fallout.giq_option(0, 634, 106, FishrManEnd2, 50)
end

function FishrMan15()
    fallout.gsay_reply(644, 142)
    fallout.giq_option(0, 634, 106, FishrMan15a, 50)
end

function FishrMan15a()
    fallout.gsay_message(644, 143, 50)
end

function FishrMan16()
    fallout.gsay_message(644, 144, 50)
end

function FishrMan17()
    fallout.gsay_reply(644, 145)
    if (fallout.global_var(101) == 1) and (fallout.obj_is_carrying_obj_pid(fallout.dude_obj(), 55) == 0) then
        fallout.giq_option(4, 644, 146, FishrMan04, 50)
    end
    fallout.giq_option(4, 644, 147, FishrMan11, 50)
    fallout.giq_option(4, 644, 148, FishrMan23, 50)
    fallout.giq_option(4, 644, 149, FishrMan24, 50)
    fallout.giq_option(4, 644, 108, FishrMan07, 50)
end

function FishrMan18()
    fallout.gsay_message(644, 150, 50)
end

function FishrMan19()
    fallout.gsay_message(644, 151, 50)
end

function FishrMan20()
    fallout.gsay_reply(644, 152)
    FishrManBarter()
end

function FishrMan21()
    fallout.gsay_message(644, 153, 51)
    FishrManCombat()
end

function FishrMan22()
    fallout.gsay_message(644, 154, 51)
end

function FishrMan23()
    fallout.gsay_message(644, 155, 50)
end

function FishrMan24()
    fallout.gsay_message(644, 156, 50)
end

function FishrMan25()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(644, 157), 0)
end

function FishrManBarter()
    fallout.gdialog_mod_barter(0)
    fallout.giq_option(0, 634, 100, FishrManEnd, 50)
end

function FishrManCombat()
    hostile = 1
    fallout.set_global_var(334, 1)
end

function FishrManEnd()
end

function FishrManEnd1()
    fallout.gsay_message(644, 121, 50)
end

function FishrManEnd2()
    fallout.gsay_message(644, 136, 50)
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
