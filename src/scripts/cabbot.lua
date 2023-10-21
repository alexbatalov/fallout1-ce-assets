local fallout = require("fallout")
local reaction = require("lib.reaction")
local reputation = require("lib.reputation")

local start
local do_dialogue
local cabbot01
local cabbot02
local cabbot04
local cabbot05
local cabbot05a
local cabbot06
local cabbot07
local cabbot09
local cabbot10
local cabbot12
local cabbot16
local cabbot17
local cabbot18
local cabbot19
local cabbot20
local cabbot21
local cabbot21_1
local cabbot22
local cabbot23
local cabbot24
local cabbot25
local cabbot27
local cabbot28
local cabbot31
local cabbot32
local cabbot33
local cabbot34
local cabbot35
local cabbot36
local cabbot37
local cabbot38
local cabbot39
local cabbot40
local cabbot41
local cabbot42
local cabbot43
local cabbot44
local cabbot45
local cabbot46
local cabbot47
local cabbot48
local cabbot06a
local cabbot07a
local cabbot16a
local cabbot19a
local cabbot23a
local cabbot33a
local cabbotx
local cabbotx1
local cabbotx3
local cabbotx6
local cabbotx7
local cabbotx8
local cabbot35a
local cabbot49
local cabbot50
local cabbot51
local cabbot52
local cabbot53
local cabbot54
local cabbot55
local cabbot56
local cabbot57
local cabbot58
local cabbot59
local cabbot60
local cabbot61
local cabbot62
local cabbot63
local cabbot64
local cabbot65
local cabbot66
local cabbot67
local cabbot68
local cabbot69
local cabbotend
local cabbotopen
local combat
local damage_p_proc
local critter_p_proc
local pickup_p_proc
local talk_p_proc
local destroy_p_proc
local look_at_p_proc
local time_p_proc

local VATS = 0
local MALE = 0
local SEXY = 0
local HOSTILE = 0
local ILLEGAL = 0
local initialized = false
local awardex = 0
local temp = 0

local exit_line = 0

function start()
    if not initialized then
        initialized = true
        fallout.set_external_var("Cabbot_Ptr", fallout.self_obj())
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 44)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 64)
    end
    if fallout.script_action() == 21 then
        look_at_p_proc()
    else
        if fallout.script_action() == 14 then
            damage_p_proc()
        else
            if fallout.script_action() == 4 then
                pickup_p_proc()
            else
                if fallout.script_action() == 22 then
                    time_p_proc()
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
    end
end

function do_dialogue()
    reaction.get_reaction()
    fallout.start_gdialog(40, fallout.self_obj(), 4, 16, 5)
    fallout.gsay_start()
    if fallout.local_var(4) == 1 then
        if fallout.global_var(108) == 1 then
            cabbot24()
        else
            if fallout.global_var(108) == 2 then
                cabbot36()
            else
                if fallout.global_var(117 == 1) then
                    cabbot33()
                else
                    if fallout.local_var(0) >= 50 then
                        cabbot19()
                    else
                        cabbot21()
                    end
                end
            end
        end
    else
        cabbot01()
    end
    fallout.gsay_end()
    fallout.end_dialogue()
    if awardex then
        awardex = 0
        fallout.display_msg(fallout.message_str(40, 232))
        fallout.set_global_var(155, fallout.global_var(155) + 1)
        fallout.give_exp_points(2000)
    end
end

function cabbot01()
    fallout.set_local_var(4, 1)
    fallout.gsay_reply(40, 101)
    fallout.giq_option(4, 40, 103, cabbot17, 50)
    fallout.giq_option(4, 40, 105, cabbot04, 50)
    fallout.giq_option(4, 40, 106, cabbot12, 50)
    fallout.giq_option(4, 40, 107, cabbot10, 50)
    fallout.giq_option(4, 40, 102, cabbot02, 50)
    fallout.giq_option(-3, 40, 104, cabbot46, 50)
end

function cabbot02()
    fallout.gsay_reply(40, 108)
    fallout.giq_option(5, 40, 109, cabbot17, 50)
    fallout.giq_option(4, 40, 110, cabbot16, 50)
    fallout.giq_option(5, 40, 111, cabbot04, 50)
    fallout.giq_option(4, 40, 112, cabbot12, 50)
    fallout.giq_option(4, 40, 113, cabbot10, 50)
end

function cabbot04()
    fallout.gsay_message(40, 114, 50)
    fallout.set_local_var(6, 1)
    fallout.gfade_out(600)
    fallout.game_time_advance(fallout.game_ticks(600))
    fallout.gfade_in(600)
    cabbot05()
end

function cabbot05()
    fallout.gsay_reply(40, 115)
    fallout.giq_option(4, 40, 116, cabbot06, 50)
    fallout.giq_option(4, 40, 117, cabbot10, 50)
    fallout.giq_option(6, 40, 118, cabbot05a, 50)
end

function cabbot05a()
    fallout.gsay_reply(40, 119)
    fallout.giq_option(4, 40, 120, cabbot06, 50)
    fallout.giq_option(6, 40, 121, cabbot17, 50)
    fallout.giq_option(4, 40, 122, cabbot10, 50)
end

function cabbot06()
    fallout.gsay_reply(40, 123)
    if not(fallout.global_var(76)) then
        fallout.set_global_var(76, 1)
    end
    fallout.giq_option(7, 40, 124, cabbot07, 50)
    fallout.giq_option(4, 40, 125, cabbot09, 50)
    fallout.giq_option(4, 40, 126, cabbot06a, 51)
end

function cabbot07()
    fallout.gsay_reply(40, 127)
    fallout.giq_option(4, 40, 128, cabbot09, 50)
    fallout.giq_option(4, 40, 129, cabbot07a, 51)
end

function cabbot09()
    fallout.gsay_message(40, 130, 49)
    fallout.set_global_var(108, 1)
    reaction.UpReactLevel()
    cabbotx()
end

function cabbot10()
    fallout.gsay_message(40, 131, 50)
end

function cabbot12()
    fallout.gsay_reply(40, 132)
    fallout.giq_option(5, 40, 133, cabbot04, 50)
    fallout.giq_option(4, 40, 134, cabbot10, 50)
    fallout.giq_option(5, 40, 135, cabbot17, 50)
end

function cabbot16()
    fallout.gsay_reply(40, 136)
    fallout.giq_option(5, 40, 137, cabbot17, 50)
    fallout.giq_option(5, 40, 138, cabbot04, 50)
    fallout.giq_option(4, 40, 139, cabbot16a, 51)
    fallout.giq_option(4, 40, 140, cabbot10, 50)
end

function cabbot17()
    fallout.gsay_message(40, 141, 51)
    cabbotx()
end

function cabbot18()
    fallout.gsay_message(40, 142, 51)
    cabbotx()
end

function cabbot19()
    if fallout.local_var(1) >= 3 then
        fallout.gsay_reply(40, 143)
    else
        fallout.gsay_reply(40, 144)
    end
    fallout.giq_option(5, 40, 145, cabbot05, 50)
    fallout.giq_option(5, 40, 146, cabbot17, 50)
    fallout.giq_option(4, 40, 147, cabbot19a, 51)
    fallout.giq_option(-3, 40, 104, cabbot46, 50)
end

function cabbot20()
    fallout.gsay_message(40, 148, 50)
    cabbotx()
end

function cabbot21()
    fallout.gsay_reply(40, 149)
    fallout.giq_option(5, 40, 150, cabbot21_1, 50)
    fallout.giq_option(4, 40, 151, cabbotx, 50)
end

function cabbot21_1()
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
            cabbot23()
        else
            cabbot22()
        end
    else
        cabbot23()
    end
end

function cabbot22()
    fallout.gsay_message(40, 152, 50)
    cabbotx()
end

function cabbot23()
    if fallout.local_var(1) < 2 then
        fallout.set_local_var(1, 2)
        reaction.LevelToReact()
    end
    fallout.gsay_reply(40, 153)
    fallout.giq_option(5, 40, 154, cabbot05, 50)
    fallout.giq_option(5, 40, 155, cabbot17, 50)
    fallout.giq_option(4, 40, 156, cabbot23a, 51)
end

function cabbot24()
    fallout.gsay_reply(40, 157)
    fallout.giq_option(4, 40, 158, cabbot25, 50)
    fallout.giq_option(4, 40, 159, cabbot32, 50)
end

function cabbot25()
    fallout.gsay_reply(40, 160)
    fallout.giq_option(4, 40, 161, cabbotx3, 50)
    fallout.giq_option(4, 40, 162, cabbot32, 50)
end

function cabbot27()
    fallout.gsay_reply(40, 163)
    fallout.giq_option(4, 40, 164, cabbotopen, 50)
end

function cabbot28()
    fallout.gsay_reply(40, 165)
    fallout.giq_option(4, 40, 166, cabbot31, 50)
end

function cabbot31()
    fallout.gsay_message(40, 168, 50)
    cabbotx()
end

function cabbot32()
    fallout.gsay_message(40, 169, 50)
    cabbotx()
end

function cabbot33()
    if fallout.local_var(1) >= 3 then
        fallout.gsay_reply(40, 170)
    else
        if fallout.local_var(1) <= 1 then
            fallout.gsay_reply(40, 171)
        else
            fallout.gsay_reply(40, 172)
        end
    end
    fallout.giq_option(4, 40, 173, cabbot34, 50)
    fallout.giq_option(4, 40, 174, cabbot33a, 51)
end

function cabbot34()
    if fallout.local_var(1) >= 3 then
        fallout.gsay_message(40, 175, 49)
    else
        if fallout.local_var(1) <= 1 then
            fallout.gsay_message(40, 176, 51)
        else
            fallout.gsay_message(40, 177, 50)
        end
    end
    cabbotx6()
end

function cabbot35()
    fallout.giq_option(5, 40, 178, cabbot38, 50)
    fallout.giq_option(5, 40, 179, cabbot42, 50)
    fallout.giq_option(4, 40, 180, cabbot37, 50)
end

function cabbot36()
    if fallout.local_var(1) >= 3 then
        fallout.gsay_reply(40, 182)
    else
        if fallout.local_var(1) <= 1 then
            fallout.gsay_reply(40, 183)
        else
            fallout.gsay_reply(40, 184)
        end
    end
    fallout.giq_option(5, 40, 185, cabbot35a, 50)
    fallout.giq_option(4, 40, 186, cabbot37, 50)
end

function cabbot37()
    fallout.gsay_message(40, 187, 50)
    cabbotx7()
end

function cabbot38()
    fallout.gsay_reply(40, 188)
    fallout.giq_option(5, 40, 189, cabbot39, 50)
    fallout.giq_option(5, 40, 190, cabbot40, 50)
end

function cabbot39()
    fallout.gsay_reply(40, 191)
    fallout.giq_option(5, 40, 192, cabbot35a, 50)
    fallout.giq_option(4, 40, 193, cabbot37, 50)
end

function cabbot40()
    fallout.gsay_reply(40, 194)
    fallout.giq_option(6, 40, 195, cabbot41, 50)
    fallout.giq_option(5, 40, 196, cabbot35a, 50)
    fallout.giq_option(4, 40, 197, cabbot37, 50)
end

function cabbot41()
    fallout.gsay_reply(40, 198)
    fallout.giq_option(4, 40, 199, cabbot35a, 50)
    fallout.giq_option(4, 40, 200, cabbot37, 50)
end

function cabbot42()
    fallout.gsay_reply(40, 201)
    fallout.giq_option(4, 40, 202, cabbot39, 50)
    fallout.giq_option(5, 40, 203, cabbot35a, 50)
    fallout.giq_option(4, 40, 204, cabbot37, 50)
end

function cabbot43()
    reaction.DownReactLevel()
    ILLEGAL = 1
    fallout.float_msg(fallout.self_obj(), fallout.message_str(40, 205), 2)
end

function cabbot44()
    reaction.DownReactLevel()
    ILLEGAL = 1
    fallout.float_msg(fallout.self_obj(), fallout.message_str(40, 206), 2)
    cabbotx8()
end

function cabbot45()
    reaction.DownReactLevel()
    ILLEGAL = 1
    fallout.float_msg(fallout.self_obj(), fallout.message_str(40, 207), 2)
end

function cabbot46()
    fallout.gsay_message(40, 208, 50)
    cabbotx()
end

function cabbot47()
    fallout.gsay_message(40, 209, 50)
end

function cabbot48()
    fallout.gsay_message(40, 210, 50)
end

function cabbot06a()
    reaction.DownReactLevel()
    cabbot10()
end

function cabbot07a()
    reaction.DownReactLevel()
    reaction.LevelToReact()
    cabbot10()
end

function cabbot16a()
    reaction.BottomReact()
    cabbot18()
end

function cabbot19a()
    reaction.DownReactLevel()
    reaction.LevelToReact()
    cabbot20()
end

function cabbot23a()
    reaction.DownReactLevel()
    cabbot20()
end

function cabbot33a()
    reaction.DownReactLevel()
    cabbot34()
end

function cabbotx()
end

function cabbotx1()
    cabbot05()
end

function cabbotx3()
    local v0 = 0
    if fallout.obj_is_carrying_obj_pid(fallout.dude_obj(), 164) then
        awardex = 1
        v0 = fallout.obj_carrying_pid_obj(fallout.dude_obj(), 164)
        fallout.set_global_var(108, 2)
        reaction.TopReact()
        fallout.rm_obj_from_inven(fallout.dude_obj(), v0)
        cabbot27()
    else
        cabbot31()
    end
end

function cabbotx6()
end

function cabbotx7()
end

function cabbotx8()
end

function cabbot35a()
    fallout.gsay_message(40, 181, 50)
    cabbot35()
end

function cabbot49()
    fallout.gsay_message(40, 211, 50)
end

function cabbot50()
    fallout.gsay_message(40, 212, 50)
end

function cabbot51()
    fallout.gsay_message(40, 213, 50)
end

function cabbot52()
    fallout.gsay_message(40, 214, 50)
end

function cabbot53()
    fallout.gsay_message(40, 215, 50)
end

function cabbot54()
    fallout.gsay_message(40, 216, 50)
end

function cabbot55()
    fallout.gsay_message(40, 217, 50)
end

function cabbot56()
    fallout.gsay_message(40, 218, 50)
end

function cabbot57()
    fallout.gsay_message(40, 219, 50)
end

function cabbot58()
    fallout.gsay_message(40, 220, 50)
end

function cabbot59()
    fallout.gsay_message(40, 221, 50)
end

function cabbot60()
    fallout.gsay_message(40, 222, 50)
end

function cabbot61()
    fallout.gsay_message(40, 223, 50)
end

function cabbot62()
    fallout.gsay_message(40, 224, 50)
end

function cabbot63()
    fallout.gsay_message(40, 225, 50)
end

function cabbot64()
    fallout.gsay_message(40, 226, 50)
end

function cabbot65()
    fallout.gsay_message(40, 227, 50)
end

function cabbot66()
    fallout.gsay_message(40, 228, 50)
end

function cabbot67()
    fallout.gsay_message(40, 229, 50)
end

function cabbot68()
    fallout.gsay_message(40, 230, 50)
end

function cabbot69()
    fallout.gsay_message(40, 231, 50)
end

function cabbotend()
end

function cabbotopen()
end

function combat()
    HOSTILE = 1
end

function damage_p_proc()
    fallout.set_global_var(250, 1)
end

function critter_p_proc()
    if fallout.global_var(250) ~= 0 then
        HOSTILE = 1
    end
    if fallout.tile_distance_objs(fallout.self_obj(), fallout.dude_obj()) > 12 then
        HOSTILE = 0
    end
    if HOSTILE then
        fallout.set_global_var(250, 1)
        HOSTILE = 0
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    else
        if fallout.local_var(5) == 0 then
            if fallout.global_var(108) == 2 then
                fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(1), 1)
            end
        else
            if fallout.local_var(5) == 1 then
                if fallout.tile_num(fallout.self_obj()) == 20906 then
                    fallout.set_local_var(5, 2)
                else
                    fallout.animate_move_obj_to_tile(fallout.self_obj(), 20906, 0)
                end
            end
        end
    end
end

function pickup_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        HOSTILE = 1
    end
end

function talk_p_proc()
    if fallout.global_var(108) == 5 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(40, 233), 2)
    else
        do_dialogue()
    end
end

function destroy_p_proc()
    fallout.set_global_var(250, 1)
    fallout.rm_timer_event(fallout.self_obj())
    reputation.inc_good_critter()
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(40, 100))
end

function time_p_proc()
    fallout.set_local_var(5, 1)
    fallout.use_obj(fallout.external_var("Door_ptr"))
end

local exports = {}
exports.start = start
exports.damage_p_proc = damage_p_proc
exports.critter_p_proc = critter_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
exports.time_p_proc = time_p_proc
return exports
