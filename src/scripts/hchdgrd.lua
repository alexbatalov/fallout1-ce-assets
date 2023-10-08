local fallout = require("fallout")
local reaction = require("lib.reaction")

local start
local combat
local critter_p_proc
local pickup_p_proc
local talk_p_proc
local destroy_p_proc
local look_at_p_proc
local damage_p_proc
local ChildGuard00
local ChildGuard01
local ChildGuard02
local ChildGuard02a
local ChildGuard03
local ChildGuard04
local ChildGuard05
local ChildGuard06
local ChildGuard07
local ChildGuard08
local ChildGuard09
local ChildGuard10
local ChildGuard11
local ChildGuard12
local ChildGuard13
local ChildGuard14
local ChildGuard15
local ChildGuard16
local ChildGuard17
local ChildGuard18
local ChildGuard19
local ChildGuard20
local ChildGuard21
local ChildGuard22
local ChildGuard23
local ChildGuard24
local ChildGuard25
local ChildGuard26
local ChildGuard27
local ChildGuard28
local ChildGuard29
local ChildGuard30
local ChildGuard31
local ChildGuard32
local ChildGuard33
local ChildGuard34
local ChildGuard35
local ChildGuard36
local ChildGuard37

local hostile = 0
local Only_Once = 1

local exit_line = 0

function start()
    if Only_Once then
        Only_Once = 0
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 72)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 77)
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
    if (fallout.map_var(6) == 1) and (fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) == 1) then
        combat()
    end
    if fallout.map_var(4) == 1 then
        fallout.dialogue_system_enter()
    end
end

function pickup_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        hostile = 1
    end
end

function talk_p_proc()
    reaction.get_reaction()
    if fallout.map_var(4) == 1 then
        fallout.set_map_var(4, 0)
        if fallout.local_var(6) == 0 then
            fallout.start_gdialog(579, fallout.self_obj(), 4, -1, -1)
            fallout.gsay_start()
            ChildGuard32()
            fallout.gsay_end()
            fallout.end_dialogue()
        else
            ChildGuard37()
        end
    else
        if fallout.global_var(255) == 1 then
            ChildGuard00()
        else
            if fallout.map_var(0) == 1 then
                ChildGuard36()
            else
                if (fallout.global_var(158) == 1) or (fallout.global_var(156) == 1) then
                    ChildGuard01()
                else
                    if fallout.local_var(5) == 0 then
                        fallout.start_gdialog(579, fallout.self_obj(), 4, -1, -1)
                        fallout.gsay_start()
                        ChildGuard02()
                        fallout.gsay_end()
                        fallout.end_dialogue()
                    else
                        ChildGuard30()
                    end
                end
            end
        end
    end
end

function destroy_p_proc()
    fallout.set_map_var(5, 1)
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
    fallout.display_msg(fallout.message_str(579, 100))
end

function damage_p_proc()
    local v0 = 0
    v0 = fallout.obj_pid(fallout.source_obj())
    if fallout.party_member_obj(v0) ~= 0 then
        fallout.set_map_var(6, 1)
    end
end

function ChildGuard00()
    fallout.set_global_var(255, 1)
    fallout.float_msg(fallout.self_obj(), fallout.message_str(579, 101), 2)
    combat()
end

function ChildGuard01()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(579, 102), 2)
end

function ChildGuard02()
    fallout.set_local_var(5, 1)
    fallout.gsay_reply(579, 103)
    fallout.giq_option(7, 579, 104, ChildGuard03, 50)
    fallout.giq_option(4, 579, 105, ChildGuard04, 50)
    if fallout.global_var(101) ~= 2 then
        fallout.giq_option(4, 579, 106, ChildGuard05, 49)
    end
    if fallout.global_var(219) == 1 then
        fallout.giq_option(4, 579, 107, ChildGuard06, 49)
    end
    fallout.giq_option(4, 579, 108, ChildGuard02a, 49)
    fallout.giq_option(-3, 579, 109, ChildGuard09, 50)
end

function ChildGuard02a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) == 1 then
        ChildGuard07()
    else
        ChildGuard08()
    end
end

function ChildGuard03()
    fallout.gsay_reply(579, 110)
    fallout.giq_option(7, 579, 111, ChildGuard10, 50)
    fallout.giq_option(4, 579, 112, ChildGuard11, 50)
    fallout.giq_option(4, 579, 113, ChildGuard12, 50)
    fallout.giq_option(4, 579, 114, ChildGuard13, 50)
    fallout.giq_option(4, 579, 115, ChildGuard14, 51)
    fallout.giq_option(4, 579, 116, ChildGuard15, 50)
end

function ChildGuard04()
    fallout.gsay_reply(579, 117)
    fallout.giq_option(7, 579, 118, ChildGuard16, 50)
    fallout.giq_option(4, 579, 119, ChildGuard17, 50)
    fallout.giq_option(4, 579, 120, ChildGuard12, 50)
    fallout.giq_option(4, 579, 121, ChildGuard18, 50)
end

function ChildGuard05()
    fallout.gsay_reply(579, 122)
    fallout.giq_option(4, 579, 123, ChildGuard19, 50)
    fallout.giq_option(4, 579, 124, ChildGuard20, 51)
    fallout.giq_option(4, 579, 125, ChildGuard21, 50)
    fallout.giq_option(4, 579, 126, ChildGuard22, 50)
end

function ChildGuard06()
    fallout.gsay_reply(579, 127)
    fallout.giq_option(4, 579, 128, ChildGuard23, 50)
    fallout.giq_option(4, 579, 129, ChildGuard24, 50)
    fallout.giq_option(4, 579, 130, ChildGuard25, 50)
    fallout.giq_option(4, 579, 131, ChildGuard21, 50)
end

function ChildGuard07()
    fallout.gsay_reply(579, 132)
    fallout.giq_option(7, 579, 133, ChildGuard26, 50)
    fallout.giq_option(4, 579, 134, ChildGuard27, 50)
    fallout.giq_option(4, 579, 135, ChildGuard28, 50)
    if fallout.global_var(101) ~= 2 then
        fallout.giq_option(4, 579, 136, ChildGuard29, 50)
    end
    if fallout.global_var(219) == 1 then
        fallout.giq_option(4, 579, 137, ChildGuard06, 50)
    end
end

function ChildGuard08()
    fallout.gsay_message(579, 138, 50)
end

function ChildGuard09()
    fallout.gsay_message(579, 139, 50)
end

function ChildGuard10()
    fallout.gsay_message(579, 140, 50)
end

function ChildGuard11()
    fallout.gsay_message(579, 141, 50)
end

function ChildGuard12()
    fallout.gsay_message(579, 142, 50)
end

function ChildGuard13()
    fallout.gsay_message(579, 143, 50)
end

function ChildGuard14()
    fallout.set_global_var(255, 1)
    fallout.gsay_message(579, 144, 50)
    combat()
end

function ChildGuard15()
    fallout.gsay_message(579, 145, 50)
end

function ChildGuard16()
    fallout.gsay_message(579, 146, 50)
end

function ChildGuard17()
    fallout.gsay_message(579, 147, 50)
end

function ChildGuard18()
    fallout.gsay_message(579, 148, 50)
end

function ChildGuard19()
    fallout.gsay_message(579, 149, 50)
end

function ChildGuard20()
    fallout.gsay_message(579, 150, 50)
end

function ChildGuard21()
    fallout.gsay_message(579, 151, 50)
end

function ChildGuard22()
    fallout.gsay_message(579, 152, 50)
end

function ChildGuard23()
    fallout.gsay_message(579, 153, 50)
end

function ChildGuard24()
    fallout.gsay_message(579, 154, 50)
end

function ChildGuard25()
    fallout.gsay_message(579, 155, 50)
end

function ChildGuard26()
    fallout.gsay_message(579, 156, 50)
end

function ChildGuard27()
    fallout.gsay_message(579, 157, 50)
end

function ChildGuard28()
    fallout.set_global_var(219, 1)
    fallout.gsay_message(579, 158, 50)
end

function ChildGuard29()
    fallout.gsay_message(579, 159, 50)
end

function ChildGuard30()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(579, 160), 2)
end

function ChildGuard31()
    fallout.set_global_var(255, 1)
    fallout.gsay_message(579, 161, 50)
    combat()
end

function ChildGuard32()
    fallout.set_local_var(6, 1)
    fallout.gsay_reply(579, 162)
    fallout.giq_option(4, 579, 163, ChildGuard33, 50)
    fallout.giq_option(4, 579, 164, ChildGuard34, 50)
    fallout.giq_option(4, 579, 165, ChildGuard35, 50)
    fallout.giq_option(4, 579, 166, ChildGuard37, 50)
end

function ChildGuard33()
    fallout.gsay_message(579, 167, 50)
end

function ChildGuard34()
    fallout.gsay_message(579, 168, 50)
end

function ChildGuard35()
    fallout.gsay_message(579, 169, 50)
end

function ChildGuard36()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(579, 170), 2)
end

function ChildGuard37()
    fallout.set_global_var(255, 1)
    combat()
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
