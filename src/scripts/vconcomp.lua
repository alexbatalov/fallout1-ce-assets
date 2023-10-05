local fallout = require("fallout")

local start
local damage_p_proc
local description_p_proc
local look_at_p_proc
local talk_p_proc
local use_p_proc
local use_obj_on_p_proc
local use_skill_on_p_proc
local VConComp00
local VConComp01
local VConComp01a
local VConComp02
local VConComp02a
local VConComp03
local VConComp04
local VConComp05
local VConComp06
local VConComp07
local VConComp08
local VConComp09
local VConComp10
local VConComp11
local VConComp12
local VConComp12a
local VConComp13
local VConComp13a
local VConComp14
local VConComp15
local VConComp16
local VConComp17
local VConComp17a
local VConComp17b
local VConComp18
local VConComp18a
local VConComp19
local VConComp19a
local VConComp20
local VConComp21
local VConComp22
local VConComp23
local VConComp24
local VConComp25
local VConComp26
local VConComp27
local VConComp28
local VConComp29
local VConComp30
local VConComp31
local VConComp32
local VConCompEnd
local Update_Invasion

function start()
    if fallout.script_action() == 14 then
        damage_p_proc()
    else
        if fallout.script_action() == 21 then
            look_at_p_proc()
        else
            if fallout.script_action() == 3 then
                description_p_proc()
            else
                if fallout.script_action() == 11 then
                    talk_p_proc()
                else
                    if fallout.script_action() == 6 then
                        use_p_proc()
                    else
                        if fallout.script_action() == 7 then
                            use_obj_on_p_proc()
                        else
                            if fallout.script_action() == 8 then
                                use_skill_on_p_proc()
                            end
                        end
                    end
                end
            end
        end
    end
end

function damage_p_proc()
    if fallout.global_var(17) == 0 then
        fallout.set_global_var(147, fallout.game_time() // 10)
        fallout.set_global_var(155, fallout.global_var(155) + 5)
        fallout.set_global_var(17, 1)
        fallout.set_global_var(308, 2)
        Update_Invasion()
        fallout.display_msg(fallout.message_str(371, 179))
    end
end

function description_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(371, 200))
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(371, 100))
end

function talk_p_proc()
    if fallout.global_var(147) == 0 then
        if fallout.local_var(0) == 1 then
            fallout.start_gdialog(371, fallout.self_obj(), 4, -1, -1)
            fallout.gsay_start()
            VConComp01()
            fallout.gsay_end()
            fallout.end_dialogue()
        else
            fallout.start_gdialog(371, fallout.self_obj(), 4, -1, -1)
            fallout.gsay_start()
            VConComp00()
            fallout.gsay_end()
            fallout.end_dialogue()
        end
    end
end

function use_p_proc()
    fallout.script_overrides()
    if fallout.local_var(0) == 0 then
        fallout.display_msg(fallout.message_str(371, 177))
    else
        fallout.dialogue_system_enter()
    end
end

function use_obj_on_p_proc()
    if fallout.obj_pid(fallout.obj_being_used_with()) == 221 then
        if fallout.local_var(0) == 0 then
            fallout.script_overrides()
            fallout.display_msg(fallout.message_str(371, 180))
            fallout.set_local_var(0, 1)
            fallout.dialogue_system_enter()
        end
    end
end

function use_skill_on_p_proc()
    if fallout.action_being_used() == 12 then
        fallout.script_overrides()
        if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 12, 0)) then
            fallout.set_local_var(0, 1)
            fallout.display_msg(fallout.message_str(371, 176))
        else
            fallout.display_msg(fallout.message_str(371, 178))
        end
        fallout.game_time_advance(fallout.game_ticks(300))
    end
end

function VConComp00()
    fallout.gsay_message(371, 101, 51)
end

function VConComp01()
    fallout.gsay_reply(371, 102)
    VConComp01a()
end

function VConComp01a()
    fallout.giq_option(4, 371, 103, VConComp02, 50)
    fallout.giq_option(4, 371, 104, VConComp11, 50)
    fallout.giq_option(4, 371, 106, VConComp05, 50)
    fallout.giq_option(0, 371, 181, VConCompEnd, 50)
end

function VConComp02()
    fallout.gsay_reply(371, 140)
    fallout.giq_option(4, 371, 107, VConComp03, 50)
    fallout.giq_option(4, 371, 108, VConComp04, 50)
    fallout.giq_option(4, 371, 109, VConComp05, 50)
    fallout.giq_option(4, 371, 110, VConComp06, 50)
    fallout.giq_option(4, 371, 111, VConComp07, 50)
    fallout.giq_option(4, 371, 112, VConComp08, 50)
    fallout.giq_option(5, 371, 113, VConComp02a, 50)
end

function VConComp02a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 12, -10)) or (fallout.global_var(298) == 1) then
        VConComp09()
    else
        VConComp10()
    end
end

function VConComp03()
    fallout.gsay_message(371, 114, 50)
    fallout.set_global_var(147, (fallout.game_time() // 10) - 240)
    fallout.set_global_var(155, fallout.global_var(155) + 5)
    fallout.set_global_var(17, 1)
    fallout.set_global_var(308, 2)
end

function VConComp04()
    fallout.gsay_message(371, 115, 50)
    fallout.set_global_var(155, fallout.global_var(155) + 5)
    fallout.set_global_var(147, (fallout.game_time() // 10) - 30)
    fallout.set_global_var(17, 1)
    fallout.set_global_var(308, 2)
end

function VConComp05()
    fallout.gsay_message(371, 116, 50)
    fallout.set_global_var(146, 1)
end

function VConComp06()
    fallout.gsay_message(371, 117, 50)
    fallout.set_global_var(147, fallout.game_time() // 10)
    fallout.set_global_var(155, fallout.global_var(155) + 5)
    fallout.set_global_var(17, 1)
    fallout.set_global_var(308, 2)
end

function VConComp07()
    fallout.gsay_message(371, 118, 50)
    fallout.set_global_var(147, fallout.game_time() // 10)
    fallout.set_global_var(155, fallout.global_var(155) + 5)
    fallout.set_global_var(17, 1)
    fallout.set_global_var(308, 2)
end

function VConComp08()
    fallout.gsay_message(371, 119, 50)
    fallout.set_global_var(147, (fallout.game_time() // 10) - 299)
    fallout.set_global_var(155, fallout.global_var(155) + 5)
    fallout.set_global_var(17, 1)
    fallout.set_global_var(308, 2)
end

function VConComp09()
    fallout.gsay_reply(371, 120)
    fallout.giq_option(4, 371, 121, VConComp03, 50)
    fallout.giq_option(4, 371, 122, VConComp04, 50)
    fallout.giq_option(4, 371, 123, VConComp05, 50)
    fallout.giq_option(4, 371, 124, VConComp06, 50)
    fallout.giq_option(4, 371, 125, VConComp07, 50)
    fallout.giq_option(4, 371, 126, VConComp08, 50)
end

function VConComp10()
    if fallout.local_var(1) == 1 then
        fallout.set_global_var(146, 1)
    else
        fallout.set_local_var(1, 1)
    end
    fallout.gsay_message(371, 127, 51)
end

function VConComp11()
    fallout.gsay_reply(371, 127)
    fallout.giq_option(4, 371, 129, VConComp12, 50)
    fallout.giq_option(4, 371, 130, VConComp14, 50)
    fallout.giq_option(4, 371, 131, VConComp13, 50)
    fallout.giq_option(4, 371, 132, VConComp14, 50)
end

function VConComp12()
    fallout.gsay_reply(371, 133)
    fallout.giq_option(4, 371, 134, VConComp12a, 50)
    fallout.giq_option(4, 371, 135, VConComp15, 50)
end

function VConComp12a()
    fallout.set_global_var(234, 1)
    VConComp15()
end

function VConComp13()
    fallout.gsay_reply(371, 136)
    fallout.giq_option(4, 371, 134, VConComp13a, 50)
end

function VConComp13a()
    fallout.set_global_var(235, 1)
    VConComp15()
end

function VConComp14()
    fallout.gsay_reply(371, 139)
    VConComp01a()
end

function VConComp15()
    fallout.gsay_reply(371, 140)
    VConComp01a()
end

function VConComp16()
    fallout.gsay_reply(371, 141)
    fallout.giq_option(6, 371, 142, VConComp17, 50)
    fallout.giq_option(4, 371, 138, VConComp15, 50)
end

function VConComp17()
    fallout.gsay_reply(371, 143)
    fallout.giq_option(4, 634, 104, VConCompEnd, 50)
    fallout.giq_option(6, 371, 144, VConComp17a, 50)
    fallout.giq_option(6, 371, 145, VConComp17b, 50)
end

function VConComp17a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 12, 0)) then
        VConComp18()
    else
        VConComp20()
    end
end

function VConComp17b()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 7, 0)) then
        VConComp18()
    else
        VConComp20()
    end
end

function VConComp18()
    fallout.gsay_reply(371, 146)
    VConComp18a()
end

function VConComp18a()
    fallout.giq_option(6, 371, 147, VConComp19, 50)
    fallout.giq_option(6, 371, 148, VConComp19, 50)
    fallout.giq_option(7, 371, 149, VConComp19, 50)
    fallout.giq_option(4, 371, 150, VConCompEnd, 50)
end

function VConComp19()
    fallout.gsay_reply(371, 151)
    fallout.giq_option(6, 371, 152, VConComp20, 50)
    fallout.giq_option(6, 371, 153, VConComp21, 50)
    fallout.giq_option(6, 371, 154, VConComp20, 50)
    fallout.giq_option(7, 371, 155, VConComp19a, 50)
end

function VConComp19a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 12, -10)) then
        VConComp21()
    else
        VConComp20()
    end
end

function VConComp20()
    fallout.gsay_reply(371, 156)
    VConComp18a()
end

function VConComp21()
    fallout.gsay_reply(371, 157)
    fallout.giq_option(6, 371, 158, VConComp27, 50)
    fallout.giq_option(7, 371, 159, VConComp30, 50)
    fallout.giq_option(4, 371, 150, VConCompEnd, 50)
end

function VConComp22()
    fallout.gsay_reply(371, 160)
    fallout.giq_option(4, 371, 161, VConComp23, 50)
    fallout.giq_option(4, 371, 162, VConComp24, 50)
    fallout.giq_option(4, 371, 163, VConComp25, 50)
    fallout.giq_option(4, 371, 164, VConComp26, 50)
end

function VConComp23()
    fallout.gsay_reply(371, 165)
    fallout.giq_option(4, 371, 166, VConComp22, 50)
    fallout.giq_option(4, 371, 138, VConComp18, 50)
end

function VConComp24()
    fallout.gsay_reply(371, 167)
    fallout.giq_option(4, 371, 166, VConComp22, 50)
    fallout.giq_option(4, 371, 138, VConComp18, 50)
end

function VConComp25()
    fallout.gsay_reply(371, 168)
    fallout.giq_option(4, 371, 166, VConComp22, 50)
    fallout.giq_option(4, 371, 138, VConComp18, 50)
end

function VConComp26()
    fallout.gsay_reply(371, 169)
    fallout.giq_option(4, 371, 166, VConComp22, 50)
    fallout.giq_option(4, 371, 138, VConComp18, 50)
end

function VConComp27()
    fallout.gsay_reply(371, 170)
    fallout.giq_option(4, 371, 172, VConComp28, 50)
    fallout.giq_option(4, 371, 173, VConComp29, 50)
end

function VConComp28()
    fallout.gsay_reply(371, 171)
    fallout.giq_option(4, 371, 138, VConComp32, 50)
    fallout.giq_option(4, 371, 150, VConCompEnd, 50)
end

function VConComp29()
    fallout.gsay_reply(371, 146)
    VConComp18a()
end

function VConComp30()
    fallout.gsay_reply(371, 174)
    fallout.giq_option(4, 371, 172, VConComp31, 50)
    fallout.giq_option(4, 371, 173, VConComp29, 50)
end

function VConComp31()
    fallout.gsay_reply(371, 175)
    fallout.giq_option(4, 371, 138, VConComp32, 50)
    fallout.giq_option(4, 371, 150, VConCompEnd, 50)
end

function VConComp32()
    fallout.gsay_reply(371, 176)
    fallout.giq_option(4, 371, 103, VConComp02, 50)
    fallout.giq_option(4, 371, 104, VConComp11, 50)
    fallout.giq_option(4, 371, 105, VConComp05, 50)
end

function VConCompEnd()
end

function Update_Invasion()
    local v0 = 0
    local v1 = 0
    local v2 = 0
    local v3 = 0
    local v4 = 0
    v0 = fallout.global_var(150) - ((fallout.global_var(150) - (fallout.game_time() // (10 * 60 * 60 * 24))) // 2)
    v1 = fallout.global_var(151) - ((fallout.global_var(151) - (fallout.game_time() // (10 * 60 * 60 * 24))) // 2)
    v2 = fallout.global_var(152) - ((fallout.global_var(152) - (fallout.game_time() // (10 * 60 * 60 * 24))) // 2)
    v3 = fallout.global_var(153) - ((fallout.global_var(153) - (fallout.game_time() // (10 * 60 * 60 * 24))) // 2)
    v4 = fallout.global_var(154) - ((fallout.global_var(154) - (fallout.game_time() // (10 * 60 * 60 * 24))) // 2)
    fallout.set_global_var(150, v0)
    fallout.set_global_var(151, v1)
    fallout.set_global_var(152, v2)
    fallout.set_global_var(153, v3)
    fallout.set_global_var(154, v4)
end

local exports = {}
exports.start = start
exports.damage_p_proc = damage_p_proc
exports.description_p_proc = description_p_proc
exports.look_at_p_proc = look_at_p_proc
exports.talk_p_proc = talk_p_proc
exports.use_p_proc = use_p_proc
exports.use_obj_on_p_proc = use_obj_on_p_proc
exports.use_skill_on_p_proc = use_skill_on_p_proc
return exports
