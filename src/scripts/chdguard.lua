local fallout = require("fallout")
local reputation = require("lib.reputation")

local start
local critter_p_proc
local destroy_p_proc
local look_at_p_proc
local talk_p_proc
local ChdGuard0
local ChdGuard1
local ChdGuard2
local ChdGuard3
local ChdGuard4
local ChdGuard5
local ChdGuard6
local ChdGuard7
local ChdGuard8
local ChdGuard9
local ChdGuard10
local ChdGuard11
local ChdGuard12
local ChdGuard13
local ChdGuard14
local ChdGuard15
local ChdGuard16
local ChdGuard17
local ChdGuard17a
local ChdGuard18
local ChdGuard19
local ChdGuard20
local ChdGuard21
local ChdGuard22
local ChdGuard23
local ChdGuard24
local ChdGuard25
local ChdGuard26
local ChdGuard27
local ChdGuard28
local ChdGuard29
local ChdGuard30
local ChdGuard31
local ChdGuard32
local ChdGuard33
local ChdGuard34
local ChdGuard35
local ChdGuardend
local combat

local hostile = false
local initialized = false

function start()
    if not initialized then
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 20)
        initialized = true
    end

    local script_action = fallout.script_action()
    if script_action == 12 then
        critter_p_proc()
    elseif script_action == 18 then
        destroy_p_proc()
    elseif script_action == 21 then
        look_at_p_proc()
    elseif script_action == 11 then
        talk_p_proc()
    end
end

function critter_p_proc()
    if hostile then
        hostile = false
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    end
end

function destroy_p_proc()
    reputation.inc_evil_critter()
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(275, 100))
end

function talk_p_proc()
    fallout.script_overrides()
    if fallout.local_var(0) ~= 0 then
        ChdGuard35()
    else
        fallout.set_local_var(0, 1)
        fallout.start_gdialog(275, fallout.self_obj(), 4, -1, -1)
        fallout.gsay_start()
        ChdGuard0()
        fallout.gsay_end()
        fallout.end_dialogue()
    end
end

function ChdGuard0()
    fallout.gsay_reply(275, 101)
    fallout.giq_option(-3, 275, 102, ChdGuard1, 50)
    fallout.giq_option(4, 275, 103, ChdGuard13, 50)
    fallout.giq_option(4, 275, 104, ChdGuard25, 50)
    fallout.giq_option(6, 275, 105, ChdGuard26, 50)
    fallout.giq_option(6, 275, 106, ChdGuard27, 50)
end

function ChdGuard1()
    fallout.gsay_reply(275, 107)
    fallout.giq_option(-3, 275, 108, ChdGuard2, 50)
    fallout.giq_option(-3, 275, 109, combat, 50)
    fallout.giq_option(-3, 275, 110, ChdGuard9, 50)
end

function ChdGuard2()
    fallout.gsay_reply(275, 111)
    fallout.giq_option(-3, 275, 112, combat, 50)
    fallout.giq_option(-3, 275, 113, ChdGuard3, 50)
    fallout.giq_option(-3, 275, 114, ChdGuard4, 50)
end

function ChdGuard3()
    fallout.gsay_message(275, 115, 50)
end

function ChdGuard4()
    fallout.gsay_reply(275, 116)
    fallout.giq_option(-3, 275, 117, ChdGuard5, 50)
    fallout.giq_option(-3, 275, 118, combat, 50)
    fallout.giq_option(-3, 275, 119, ChdGuard6, 50)
end

function ChdGuard5()
    fallout.gsay_message(275, 120, 50)
end

function ChdGuard6()
    fallout.gsay_reply(275, 121)
    fallout.giq_option(-3, 275, 122, ChdGuard7, 50)
    fallout.giq_option(-3, 275, 123, ChdGuard5, 50)
    fallout.giq_option(-3, 275, 124, ChdGuard8, 50)
end

function ChdGuard7()
    fallout.gsay_message(275, 125, 50)
end

function ChdGuard8()
    fallout.gsay_message(275, 126, 50)
end

function ChdGuard9()
    fallout.gsay_reply(275, 127)
    fallout.giq_option(-3, 275, 128, ChdGuard10, 50)
    fallout.giq_option(-3, 275, 129, ChdGuard12, 50)
    fallout.giq_option(-3, 275, 130, ChdGuardend, 50)
end

function ChdGuard10()
    fallout.gsay_reply(275, 131)
    fallout.giq_option(-3, 275, 132, ChdGuard11, 50)
    fallout.giq_option(-3, 275, 133, ChdGuardend, 50)
end

function ChdGuard11()
    fallout.gsay_message(275, 134, 50)
end

function ChdGuard12()
    fallout.gsay_reply(275, 135)
    fallout.giq_option(-3, 275, 136, ChdGuardend, 50)
end

function ChdGuard13()
    fallout.gsay_reply(275, 137)
    fallout.giq_option(4, 275, 138, ChdGuard14, 50)
    fallout.giq_option(4, 275, 139, ChdGuard15, 50)
    fallout.giq_option(4, 275,
        fallout.message_str(275, 140) ..
        fallout.proto_data(fallout.obj_pid(fallout.dude_obj()), 1) .. fallout.message_str(275, 141), ChdGuard22, 50)
    fallout.giq_option(4, 275, 142, ChdGuard24, 50)
    fallout.giq_option(4, 275, 143, combat, 50)
end

function ChdGuard14()
    fallout.gsay_message(275, 144, 50)
    combat()
end

function ChdGuard15()
    fallout.gsay_reply(275, 145)
    fallout.giq_option(4, 275, 146, ChdGuard16, 50)
    fallout.giq_option(4, 275, 147, ChdGuard17, 50)
end

function ChdGuard16()
    fallout.gsay_message(275, 148, 50)
    combat()
end

function ChdGuard17()
    fallout.gsay_reply(275, 149)
    fallout.giq_option(4, 275,
        fallout.message_str(275, 150) ..
        fallout.proto_data(fallout.obj_pid(fallout.dude_obj()), 1) .. fallout.message_str(275, 151), ChdGuard17a, 50)
    fallout.giq_option(4, 275, 152, ChdGuard20, 50)
    fallout.giq_option(4, 275, 153, combat, 50)
end

function ChdGuard17a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        ChdGuard18()
    else
        ChdGuard19()
    end
end

function ChdGuard18()
    fallout.gsay_message(275, 154, 50)
end

function ChdGuard19()
    fallout.gsay_message(275, 155, 50)
    combat()
end

function ChdGuard20()
    fallout.gsay_reply(275, 156)
    fallout.giq_option(4, 275,
        fallout.message_str(275, 157) ..
        fallout.proto_data(fallout.obj_pid(fallout.dude_obj()), 1) .. fallout.message_str(275, 158), ChdGuard21, 50)
    fallout.giq_option(4, 275, 159, combat, 50)
end

function ChdGuard21()
    fallout.gsay_message(275, 160, 50)
    ChdGuard17a()
end

function ChdGuard22()
    fallout.gsay_reply(275,
        fallout.message_str(275, 161) ..
        fallout.proto_data(fallout.obj_pid(fallout.dude_obj()), 1) .. fallout.message_str(275, 162))
    fallout.giq_option(4, 275, 163, ChdGuard23, 50)
    fallout.giq_option(4, 275, 164, ChdGuard23, 50)
    fallout.giq_option(4, 275, 165, combat, 50)
end

function ChdGuard23()
    fallout.gsay_message(275, 166, 50)
    combat()
end

function ChdGuard24()
    fallout.gsay_message(275, 167, 50)
    combat()
end

function ChdGuard25()
    fallout.gsay_reply(275, 168)
    fallout.giq_option(4, 275, 169, ChdGuard14, 50)
    fallout.giq_option(4, 275, 170, ChdGuard15, 50)
    fallout.giq_option(4, 275,
        fallout.message_str(275, 171) ..
        fallout.proto_data(fallout.obj_pid(fallout.dude_obj()), 1) .. fallout.message_str(275, 172), ChdGuard22, 50)
    fallout.giq_option(4, 275, 173, ChdGuard24, 50)
    fallout.giq_option(4, 275, 174, combat, 50)
end

function ChdGuard26()
    fallout.gsay_message(275, 175, 50)
    combat()
end

function ChdGuard27()
    fallout.gsay_reply(275, 176)
    fallout.giq_option(6, 275, 177, ChdGuard28, 50)
    fallout.giq_option(6, 275, 178, ChdGuard29, 50)
    fallout.giq_option(6, 275, 179, ChdGuard30, 50)
    fallout.giq_option(6, 275, 180, ChdGuard34, 50)
end

function ChdGuard28()
    fallout.gsay_message(275, 181, 50)
end

function ChdGuard29()
    fallout.gsay_message(275, 182, 50)
end

function ChdGuard30()
    fallout.gsay_reply(275, 183)
    fallout.giq_option(6, 275, 184, ChdGuard31, 50)
    fallout.giq_option(6, 275, 185, ChdGuard32, 50)
    fallout.giq_option(6, 275, 186, combat, 50)
end

function ChdGuard31()
    fallout.gsay_message(275, 187, 50)
    combat()
end

function ChdGuard32()
    fallout.gsay_reply(275, 188)
    fallout.giq_option(6, 275, 189, ChdGuard33, 50)
    fallout.giq_option(6, 275, 190, ChdGuard33, 50)
    fallout.giq_option(6, 275, 191, combat, 50)
end

function ChdGuard33()
    fallout.gsay_reply(275, 192)
    fallout.giq_option(6, 275, 193, ChdGuardend, 50)
    fallout.giq_option(6, 275, 194, combat, 50)
end

function ChdGuard34()
    fallout.gsay_message(275, 195, 50)
    combat()
end

function ChdGuard35()
    fallout.gsay_message(275, 196, 50)
    combat()
end

function ChdGuardend()
end

function combat()
    hostile = true
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
exports.talk_p_proc = talk_p_proc
return exports
