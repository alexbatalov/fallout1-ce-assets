local fallout = require("fallout")

local start
local critter_p_proc
local description_p_proc
local destroy_p_proc
local look_at_p_proc
local pickup_p_proc
local talk_p_proc
local Talius00
local Talius01
local Talius02
local Talius03
local Talius04
local Talius05
local Talius06
local Talius07
local Talius08
local Talius09
local Talius10
local Talius11
local Talius12
local Talius13
local Talius14
local Talius15
local Talius16
local Talius17
local Talius18
local Talius19
local Talius20
local Talius21
local Talius22
local Talius23
local Talius24
local Talius25
local Talius26
local Talius27
local Talius28
local Talius29
local Talius29a
local Talius30
local Talius31
local Talius32
local Talius33
local Talius34
local Talius35
local Talius36
local Talius37
local Talius38
local Talius39
local Talius40
local Talius41
local TaliusEnd
local combat

local hostile = 0
local initialized = 0

function start()
    if not(initialized) then
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 46)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 33)
        initialized = 1
        if fallout.global_var(129) == 2 then
            if fallout.random(0, 1) then
                fallout.kill_critter(fallout.self_obj(), 59)
            else
                fallout.kill_critter(fallout.self_obj(), 57)
            end
        end
    else
        if fallout.script_action() == 12 then
            critter_p_proc()
        else
            if fallout.script_action() == 3 then
                description_p_proc()
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
    if hostile then
        hostile = 0
        fallout.attack_complex(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    end
end

function description_p_proc()
    if fallout.is_success(fallout.do_check(fallout.dude_obj(), 1, fallout.has_trait(0, fallout.dude_obj(), 0))) then
        fallout.display_msg(fallout.message_str(274, 231))
    end
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
    if fallout.local_var(4) then
        fallout.display_msg(fallout.message_str(274, 100))
    else
        fallout.display_msg(fallout.message_str(274, 230))
    end
end

function pickup_p_proc()
    hostile = 1
end

function talk_p_proc()
    fallout.script_overrides()
    if fallout.global_var(133) == 2 then
        Talius41()
    else
        if fallout.global_var(133) == 1 then
            Talius40()
        else
            if (fallout.game_time_hour() < 600) or (fallout.game_time_hour() > 1800) then
                Talius00()
            else
                fallout.start_gdialog(274, fallout.self_obj(), 4, -1, -1)
                fallout.gsay_start()
                Talius01()
                fallout.gsay_end()
                fallout.end_dialogue()
            end
        end
    end
end

function Talius00()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(274, 101), 0)
end

function Talius01()
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 1 then
        fallout.gsay_reply(274, 102)
    else
        fallout.gsay_reply(274, 103)
    end
    fallout.giq_option(-3, 274, 104, Talius02, 50)
    fallout.giq_option(-3, 274, fallout.message_str(274, 105) + fallout.proto_data(fallout.obj_pid(fallout.dude_obj()), 1) + fallout.message_str(274, 106) + fallout.proto_data(fallout.obj_pid(fallout.dude_obj()), 1) + fallout.message_str(274, 107), Talius05, 50)
    fallout.giq_option(4, 274, fallout.message_str(274, 108) + fallout.proto_data(fallout.obj_pid(fallout.dude_obj()), 1) + fallout.message_str(274, 109), Talius06, 50)
    fallout.giq_option(4, 274, 110, combat, 50)
    fallout.giq_option(4, 274, 111, Talius36, 50)
    fallout.giq_option(6, 274, fallout.message_str(274, 112) + fallout.proto_data(fallout.obj_pid(fallout.dude_obj()), 1) + fallout.message_str(274, 113), Talius37, 50)
    fallout.giq_option(8, 274, 114, Talius37, 50)
end

function Talius02()
    fallout.gsay_reply(274, 115)
    fallout.giq_option(-3, 274, 116, Talius03, 50)
    fallout.giq_option(-3, 274, 117, combat, 50)
end

function Talius03()
    fallout.gsay_reply(274, 118)
    fallout.giq_option(-3, 274, 119, combat, 50)
    fallout.giq_option(-3, 274, 120, Talius04, 50)
end

function Talius04()
    local v0 = 0
    if fallout.local_var(5) == 0 then
        v0 = fallout.create_object_sid(53, 0, 0, -1)
        fallout.add_mult_objs_to_inven(fallout.dude_obj(), v0, 3)
        fallout.set_local_var(5, 1)
        fallout.gsay_message(274, 121, 50)
    else
        fallout.gsay_message(274, 232, 50)
    end
end

function Talius05()
    fallout.gsay_reply(274, fallout.message_str(274, 122) + fallout.proto_data(fallout.obj_pid(fallout.dude_obj()), 1) + fallout.message_str(274, 123))
    fallout.giq_option(-3, 274, 124, Talius02, 50)
    fallout.giq_option(-3, 274, 125, combat, 50)
end

function Talius06()
    fallout.gsay_reply(274, 126)
    fallout.giq_option(4, 274, 127, Talius07, 50)
    fallout.giq_option(4, 274, 128, Talius31, 50)
    fallout.giq_option(4, 274, 129, Talius32, 50)
end

function Talius07()
    fallout.gsay_reply(274, 130)
    fallout.giq_option(4, 274, 131, Talius08, 50)
    fallout.giq_option(4, 274, 132, Talius29, 50)
    fallout.giq_option(4, 274, 133, Talius30, 50)
    fallout.giq_option(4, 274, 134, combat, 50)
end

function Talius08()
    fallout.gsay_reply(274, 135)
    fallout.giq_option(4, 274, 136, TaliusEnd, 50)
    fallout.giq_option(4, 274, 137, Talius09, 50)
    fallout.giq_option(4, 274, 138, Talius09, 50)
    fallout.giq_option(4, 274, 139, combat, 50)
end

function Talius09()
    fallout.gsay_reply(274, 140)
    fallout.giq_option(4, 274, 141, Talius10, 50)
    fallout.giq_option(4, 274, 142, Talius15, 50)
    fallout.giq_option(5, 274, 143, Talius16, 50)
    fallout.giq_option(5, 274, 144, Talius17, 50)
end

function Talius10()
    fallout.gsay_reply(274, 145)
    fallout.giq_option(4, 274, 146, Talius11, 50)
    fallout.giq_option(4, 274, 147, TaliusEnd, 50)
    fallout.giq_option(4, 274, 148, Talius15, 50)
    fallout.giq_option(4, 274, 149, Talius16, 50)
    fallout.giq_option(4, 274, 150, Talius17, 50)
end

function Talius11()
    fallout.gsay_reply(274, 151)
    fallout.giq_option(4, 274, 152, Talius12, 50)
end

function Talius12()
    fallout.gsay_reply(274, 153)
    if fallout.local_var(6) == 0 then
        fallout.giq_option(4, 274, 154, Talius13, 50)
    end
    fallout.giq_option(4, 274, 155, Talius14, 50)
end

function Talius13()
    local v0 = 0
    fallout.set_local_var(6, 1)
    fallout.gsay_message(274, 156, 50)
    v0 = fallout.create_object_sid(32, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), v0)
    v0 = fallout.create_object_sid(32, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), v0)
    v0 = fallout.create_object_sid(11, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), v0)
end

function Talius14()
    fallout.gsay_message(274, 157, 50)
end

function Talius15()
    fallout.gsay_reply(274, 158)
    fallout.giq_option(4, 274, 159, Talius16, 50)
    fallout.giq_option(4, 274, 160, Talius17, 50)
    fallout.giq_option(4, 274, 161, Talius22, 50)
    fallout.giq_option(4, 274, 162, TaliusEnd, 50)
end

function Talius16()
    fallout.gsay_reply(274, fallout.message_str(274, 163) + " " + fallout.message_str(274, 164))
    fallout.giq_option(4, 274, 165, Talius17, 50)
    fallout.giq_option(4, 274, 166, Talius22, 50)
    fallout.giq_option(4, 274, 167, TaliusEnd, 50)
end

function Talius17()
    fallout.gsay_message(274, 168, 50)
    fallout.gsay_reply(274, 169)
    fallout.giq_option(4, 274, 170, Talius18, 50)
    fallout.giq_option(4, 274, 171, Talius19, 50)
    fallout.giq_option(4, 274, 172, Talius21, 50)
end

function Talius18()
    fallout.gsay_message(274, 173, 50)
    fallout.gsay_reply(274, 174)
    fallout.giq_option(4, 274, 175, TaliusEnd, 50)
    fallout.giq_option(4, 274, 176, TaliusEnd, 50)
    fallout.giq_option(4, 274, 177, Talius12, 50)
end

function Talius19()
    fallout.gsay_message(274, 178, 50)
    fallout.gsay_reply(274, 179)
    fallout.giq_option(4, 274, 180, TaliusEnd, 50)
    if (fallout.global_var(29) == 2) and (fallout.local_var(6) == 0) then
        fallout.giq_option(4, 274, 181, Talius20, 50)
    end
end

function Talius20()
    local v0 = 0
    fallout.set_local_var(6, 1)
    fallout.gsay_message(274, 182, 50)
    v0 = fallout.create_object_sid(11, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), v0)
end

function Talius21()
    fallout.gsay_message(274, 183, 50)
end

function Talius22()
    fallout.gsay_reply(274, 184)
    fallout.giq_option(4, 274, 185, Talius23, 50)
    fallout.giq_option(4, 274, 186, Talius26, 50)
    fallout.giq_option(4, 274, 187, Talius27, 50)
end

function Talius23()
    fallout.gsay_reply(274, 188)
    fallout.giq_option(4, 274, 189, Talius24, 50)
    fallout.giq_option(4, 274, 190, Talius24, 50)
    fallout.giq_option(4, 274, 191, Talius25, 50)
end

function Talius24()
    fallout.gsay_message(274, 192, 50)
end

function Talius25()
    fallout.gsay_message(274, 193, 50)
end

function Talius26()
    fallout.gsay_message(274, 194, 50)
end

function Talius27()
    fallout.gsay_reply(274, 195)
    fallout.giq_option(4, 274, 196, combat, 50)
    fallout.giq_option(4, 274, 197, Talius28, 50)
end

function Talius28()
    fallout.gsay_message(274, 198, 50)
    combat()
end

function Talius29()
    fallout.gsay_reply(274, 199)
    fallout.giq_option(4, 274, 200, Talius29a, 50)
    fallout.giq_option(4, 274, 201, combat, 50)
end

function Talius29a()
    fallout.set_global_var(133, 1)
end

function Talius30()
    fallout.gsay_message(274, 202, 50)
    combat()
end

function Talius31()
    fallout.gsay_message(274, 203, 50)
    fallout.gsay_reply(274, 204)
    fallout.giq_option(4, 274, 205, TaliusEnd, 50)
    fallout.giq_option(4, 274, 206, Talius09, 50)
    fallout.giq_option(4, 274, 207, Talius09, 50)
    fallout.giq_option(4, 274, 208, combat, 50)
end

function Talius32()
    fallout.gsay_reply(274, 209)
    fallout.giq_option(4, 274, 210, TaliusEnd, 50)
    fallout.giq_option(4, 274, 211, Talius33, 50)
end

function Talius33()
    fallout.gsay_reply(274, 212)
    fallout.giq_option(4, 274, 213, TaliusEnd, 50)
    fallout.giq_option(6, 274, 214, Talius34, 50)
end

function Talius34()
    fallout.gsay_reply(274, 215)
    fallout.giq_option(6, 274, 216, TaliusEnd, 50)
    fallout.giq_option(8, 274, 217, Talius35, 50)
end

function Talius35()
    fallout.gsay_reply(274, 218)
    fallout.giq_option(8, 274, 219, TaliusEnd, 50)
end

function Talius36()
    fallout.gsay_message(274, 220, 50)
end

function Talius37()
    fallout.gsay_reply(274, 221)
    fallout.giq_option(6, 274, 222, Talius38, 50)
end

function Talius38()
    fallout.gsay_reply(274, 223)
    fallout.giq_option(6, 274, 224, Talius39, 50)
end

function Talius39()
    fallout.gsay_reply(274, 225)
    fallout.giq_option(6, 274, 226, TaliusEnd, 50)
    fallout.giq_option(6, 274, 227, TaliusEnd, 50)
end

function Talius40()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(274, 228), 0)
end

function Talius41()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(274, 229), 0)
end

function TaliusEnd()
end

function combat()
    hostile = 1
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.description_p_proc = description_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
return exports
