local fallout = require("fallout")

local start
local critter_p_proc
local destroy_p_proc
local look_at_p_proc
local talk_p_proc
local ChdScout0
local ChdScout1
local ChdScout2
local ChdScout3
local ChdScout4
local ChdScout5
local ChdScout6
local ChdScout7
local ChdScout8
local ChdScout9
local ChdScout10
local ChdScout11
local ChdScout12
local ChdScout13
local ChdScout14
local ChdScout15
local ChdScout16
local ChdScout17
local ChdScout17a
local ChdScout18
local ChdScout19
local ChdScout20
local ChdScout21
local ChdScout22
local ChdScout23
local ChdScout24
local ChdScout25
local ChdScout26
local ChdScout27
local ChdScout28
local ChdScout29
local ChdScout30
local ChdScout31
local ChdScout32
local ChdScout33
local ChdScout34
local ChdScout35
local ChdScoutend
local combat

local hostile = 0
local initialized = 0

function start()
    if not(initialized) then
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 20)
        initialized = 1
    else
        if fallout.script_action() == 12 then
            critter_p_proc()
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

function critter_p_proc()
    if hostile then
        hostile = 0
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
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
        fallout.set_global_var(160, fallout.global_var(160) + 1)
        if (fallout.global_var(160) % 6) == 0 then
            fallout.set_global_var(155, fallout.global_var(155) + 1)
        end
    end
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(276, 100))
end

function talk_p_proc()
    if fallout.local_var(0) then
        ChdScout35()
    else
        fallout.set_local_var(0, 1)
        fallout.start_gdialog(276, fallout.self_obj(), 4, -1, -1)
        fallout.gsay_start()
        ChdScout0()
        fallout.gsay_end()
        fallout.end_dialogue()
    end
end

function ChdScout0()
    fallout.gsay_reply(276, 101)
    fallout.giq_option(-3, 276, 102, ChdScout1, 50)
    fallout.giq_option(4, 276, 103, ChdScout13, 50)
    fallout.giq_option(4, 276, 104, ChdScout25, 50)
    fallout.giq_option(6, 276, 105, ChdScout26, 50)
    fallout.giq_option(6, 276, 106, ChdScout27, 50)
end

function ChdScout1()
    fallout.gsay_reply(276, 107)
    fallout.giq_option(-3, 276, 108, ChdScout2, 50)
    fallout.giq_option(-3, 276, 109, combat, 50)
    fallout.giq_option(-3, 276, 110, ChdScout9, 50)
end

function ChdScout2()
    fallout.gsay_reply(276, 111)
    fallout.giq_option(-3, 276, 112, combat, 50)
    fallout.giq_option(-3, 276, 113, ChdScout3, 50)
    fallout.giq_option(-3, 276, 114, ChdScout4, 50)
end

function ChdScout3()
    fallout.gsay_message(276, 115, 50)
end

function ChdScout4()
    fallout.gsay_reply(276, 116)
    fallout.giq_option(-3, 276, 117, ChdScout5, 50)
    fallout.giq_option(-3, 276, 118, combat, 50)
    fallout.giq_option(-3, 276, 119, ChdScout6, 50)
end

function ChdScout5()
    fallout.gsay_message(276, 120, 50)
end

function ChdScout6()
    fallout.gsay_reply(276, 121)
    fallout.giq_option(-3, 276, 122, ChdScout7, 50)
    fallout.giq_option(-3, 276, 123, ChdScout5, 50)
    fallout.giq_option(-3, 276, 124, ChdScout8, 50)
end

function ChdScout7()
    fallout.gsay_message(276, 125, 50)
end

function ChdScout8()
    fallout.gsay_message(276, 126, 50)
end

function ChdScout9()
    fallout.gsay_reply(276, 127)
    fallout.giq_option(-3, 276, 128, ChdScout10, 50)
    fallout.giq_option(-3, 276, 129, ChdScout12, 50)
    fallout.giq_option(-3, 276, 130, ChdScoutend, 50)
end

function ChdScout10()
    fallout.gsay_reply(276, 131)
    fallout.giq_option(-3, 276, 132, ChdScout11, 50)
    fallout.giq_option(-3, 276, 133, ChdScoutend, 50)
end

function ChdScout11()
    fallout.gsay_message(276, 134, 50)
end

function ChdScout12()
    fallout.gsay_reply(276, 135)
    fallout.giq_option(-3, 276, 136, ChdScoutend, 50)
end

function ChdScout13()
    fallout.gsay_reply(276, 137)
    fallout.giq_option(4, 276, 138, ChdScout14, 50)
    fallout.giq_option(4, 276, 139, ChdScout15, 50)
    fallout.giq_option(4, 276, fallout.message_str(276, 140) + fallout.proto_data(fallout.obj_pid(fallout.dude_obj()), 1) + fallout.message_str(276, 141), ChdScout22, 50)
    fallout.giq_option(4, 276, 142, ChdScout24, 50)
    fallout.giq_option(4, 276, 143, combat, 50)
end

function ChdScout14()
    fallout.gsay_message(276, 144, 50)
    combat()
end

function ChdScout15()
    fallout.gsay_reply(276, 145)
    fallout.giq_option(4, 276, 146, ChdScout16, 50)
    fallout.giq_option(4, 276, 147, ChdScout17, 50)
end

function ChdScout16()
    fallout.gsay_message(276, 148, 50)
    combat()
end

function ChdScout17()
    fallout.gsay_reply(276, 149)
    fallout.giq_option(4, 276, fallout.message_str(276, 150) + fallout.proto_data(fallout.obj_pid(fallout.dude_obj()), 1) + fallout.message_str(276, 151), ChdScout17a, 50)
    fallout.giq_option(4, 276, 152, ChdScout20, 50)
    fallout.giq_option(4, 276, 153, combat, 50)
end

function ChdScout17a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        ChdScout18()
    else
        ChdScout19()
    end
end

function ChdScout18()
    fallout.gsay_message(276, 154, 50)
end

function ChdScout19()
    fallout.gsay_message(276, 155, 50)
    combat()
end

function ChdScout20()
    fallout.gsay_reply(276, 156)
    fallout.giq_option(4, 276, fallout.message_str(276, 157) + fallout.proto_data(fallout.obj_pid(fallout.dude_obj()), 1) + fallout.message_str(276, 158), ChdScout21, 50)
    fallout.giq_option(4, 276, 159, combat, 50)
end

function ChdScout21()
    fallout.gsay_message(276, 160, 50)
    ChdScout17a()
end

function ChdScout22()
    fallout.gsay_reply(276, fallout.message_str(276, 161) + fallout.proto_data(fallout.obj_pid(fallout.dude_obj()), 1) + fallout.message_str(276, 162))
    fallout.giq_option(4, 276, 163, ChdScout23, 50)
    fallout.giq_option(4, 276, 164, ChdScout23, 50)
    fallout.giq_option(4, 276, 165, combat, 50)
end

function ChdScout23()
    fallout.gsay_message(276, 166, 50)
    combat()
end

function ChdScout24()
    fallout.gsay_message(276, 167, 50)
    combat()
end

function ChdScout25()
    fallout.gsay_reply(276, 168)
    fallout.giq_option(4, 276, 169, ChdScout14, 50)
    fallout.giq_option(4, 276, 170, ChdScout15, 50)
    fallout.giq_option(4, 276, fallout.message_str(276, 171) + fallout.proto_data(fallout.obj_pid(fallout.dude_obj()), 1) + fallout.message_str(276, 172), ChdScout22, 50)
    fallout.giq_option(4, 276, 173, ChdScout24, 50)
    fallout.giq_option(4, 276, 174, combat, 50)
end

function ChdScout26()
    fallout.gsay_message(276, 175, 50)
    combat()
end

function ChdScout27()
    fallout.gsay_reply(276, 176)
    fallout.giq_option(6, 276, 177, ChdScout28, 50)
    fallout.giq_option(6, 276, 178, ChdScout29, 50)
    fallout.giq_option(6, 276, 179, ChdScout30, 50)
    fallout.giq_option(6, 276, 180, ChdScout34, 50)
end

function ChdScout28()
    fallout.gsay_message(276, 181, 50)
end

function ChdScout29()
    fallout.gsay_message(276, 182, 50)
end

function ChdScout30()
    fallout.gsay_reply(276, 183)
    fallout.giq_option(6, 276, 184, ChdScout31, 50)
    fallout.giq_option(6, 276, 185, ChdScout32, 50)
    fallout.giq_option(6, 276, 186, combat, 50)
end

function ChdScout31()
    fallout.gsay_message(276, 187, 50)
    combat()
end

function ChdScout32()
    fallout.gsay_reply(276, 188)
    fallout.giq_option(6, 276, 189, ChdScout33, 50)
    fallout.giq_option(6, 276, 190, ChdScout33, 50)
    fallout.giq_option(6, 276, 191, combat, 50)
end

function ChdScout33()
    fallout.gsay_reply(276, 192)
    fallout.giq_option(6, 276, 193, ChdScoutend, 50)
    fallout.giq_option(6, 276, 194, combat, 50)
end

function ChdScout34()
    fallout.gsay_message(276, 195, 50)
    combat()
end

function ChdScout35()
    fallout.gsay_message(276, 196, 50)
    combat()
end

function ChdScoutend()
end

function combat()
    hostile = 1
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
exports.talk_p_proc = talk_p_proc
return exports
