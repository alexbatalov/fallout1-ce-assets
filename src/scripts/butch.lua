local fallout = require("fallout")
local reaction = require("lib.reaction")
local reputation = require("lib.reputation")

local start
local combat
local critter_p_proc
local pickup_p_proc
local talk_p_proc
local destroy_p_proc
local damage_p_proc
local look_at_p_proc
local Butch00a
local Butch00
local Butch01
local Butch02
local Butch03
local Butch04
local Butch05
local Butch06
local Butch08
local Butch09
local Butch10
local Butch11
local Butch12
local Butch12a
local Butch13
local Butch13a
local Butch14
local Butch15
local Butch16
local Butch17
local Butch18
local Butch19
local Butch19a
local Butch20
local Butch21
local Butch22
local Butch23
local Butch23a
local Butch24
local Butch25
local Butch26
local Butch27
local Butch27a
local Butch28
local Butch29
local Butch30
local Butch30a
local Butch31
local Butch32
local Butch33
local Butch34
local Butch35
local Butch35a
local Butch36
local Butch37
local Butch38
local Butch39
local Butch40
local Butch41
local Butch42
local Butch43
local Butch44
local Butch45
local Butch46
local Butch47
local Butch49
local Butch50
local Butch51
local Butch51a
local Butch52
local Butch53
local Butch53a
local Butch54
local Butch54a
local Butch55
local Butch56
local Butch57
local Butch58
local Butch59
local Butch60
local Butch61
local Butch62
local Butch63
local Butch64
local Butch65
local Butch66
local Butch67
local Butch68
local Butch69
local Butch70
local Butch71
local Butch72
local Butch73
local ButchX2
local ButchX3
local ButchEnd
local ButchEndAccept
local ButchEndTransport

local hostile = 0
local Only_Once = 1
local TossOut = 0

local exit_line = 0

function start()
    if Only_Once then
        Only_Once = 0
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 36)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 50)
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
end

function pickup_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        hostile = 1
    end
end

function talk_p_proc()
    reaction.get_reaction()
    if fallout.map_var(40) == 1 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(39, 328), 2)
    else
        if fallout.map_var(41) == 2 then
            fallout.float_msg(fallout.self_obj(), fallout.message_str(39, 325), 2)
        else
            if fallout.get_critter_stat(fallout.dude_obj(), 4) < 4 then
                fallout.float_msg(fallout.dude_obj(), fallout.message_str(39, 330), 3)
                fallout.float_msg(fallout.self_obj(), fallout.message_str(39, 331), 2)
            else
                if (fallout.local_var(4) == 0) and (fallout.map_var(34) == 1) then
                    fallout.set_local_var(4, 1)
                    fallout.start_gdialog(39, fallout.self_obj(), 4, 8, 3)
                    fallout.gsay_start()
                    Butch01()
                    fallout.gsay_end()
                    fallout.end_dialogue()
                else
                    if (fallout.local_var(4) == 0) and (fallout.map_var(34) == 0) then
                        fallout.float_msg(fallout.self_obj(), fallout.message_str(39, 324), 2)
                    else
                        if fallout.map_var(41) == 3 then
                            fallout.start_gdialog(39, fallout.self_obj(), 4, 8, 3)
                            fallout.gsay_start()
                            Butch73()
                            fallout.gsay_end()
                            fallout.end_dialogue()
                        else
                            if (fallout.local_var(5) == 1) or (fallout.map_var(41) == 4) then
                                fallout.start_gdialog(39, fallout.self_obj(), 4, 8, 3)
                                fallout.gsay_start()
                                Butch60()
                                fallout.gsay_end()
                                fallout.end_dialogue()
                            else
                                if fallout.map_var(56) == 1 then
                                    fallout.start_gdialog(39, fallout.self_obj(), 4, 8, 3)
                                    fallout.gsay_start()
                                    Butch59()
                                    fallout.gsay_end()
                                    fallout.end_dialogue()
                                else
                                    if fallout.global_var(226) == 5 then
                                        fallout.start_gdialog(39, fallout.self_obj(), 4, 8, 3)
                                        fallout.gsay_start()
                                        Butch37()
                                        fallout.gsay_end()
                                        fallout.end_dialogue()
                                    else
                                        fallout.start_gdialog(39, fallout.self_obj(), 4, 8, 3)
                                        fallout.gsay_start()
                                        Butch01()
                                        fallout.gsay_end()
                                        fallout.end_dialogue()
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    if TossOut == 1 then
        TossOut = 0
        ButchEndTransport()
    end
end

function destroy_p_proc()
    reputation.inc_good_critter()
end

function damage_p_proc()
    local v0 = 0
    v0 = fallout.obj_pid(fallout.source_obj())
    if fallout.party_member_obj(v0) ~= 0 then
        fallout.set_global_var(248, 1)
    end
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(39, 100))
end

function Butch00a()
    if fallout.local_var(1) >= 2 then
        Butch34()
    else
        Butch36()
    end
end

function Butch00()
    fallout.giq_option(4, 39, 101, Butch23, 50)
    fallout.giq_option(4, 39, 102, Butch10, 50)
    fallout.giq_option(4, 39, 103, Butch00a, 50)
    fallout.giq_option(4, 39, 104, Butch27, 50)
    fallout.giq_option(4, 39, 105, ButchEnd, 50)
end

function Butch01()
    fallout.gsay_reply(39, 106)
    fallout.giq_option(4, 39, 107, Butch02, 50)
    fallout.giq_option(4, 39, 108, ButchEnd, 50)
end

function Butch02()
    fallout.gsay_reply(39, 109)
    fallout.giq_option(4, 39, 110, Butch03, 50)
    fallout.giq_option(4, 39, 111, Butch08, 50)
    fallout.giq_option(4, 39, 112, Butch08, 50)
end

function Butch03()
    reaction.UpReactLevel()
    fallout.gsay_reply(39, 113)
    fallout.giq_option(4, 39, 114, Butch04, 50)
    fallout.giq_option(4, 39, 115, ButchEndAccept, 50)
end

function Butch04()
    fallout.gsay_reply(39, 116)
    fallout.giq_option(4, 39, 117, Butch05, 50)
    fallout.giq_option(4, 39, 118, Butch08, 50)
    fallout.giq_option(4, 39, 119, ButchEndAccept, 50)
end

function Butch05()
    fallout.gsay_reply(39, 120)
    fallout.giq_option(4, 39, 121, Butch06, 50)
    fallout.giq_option(4, 39, 122, ButchEndAccept, 50)
end

function Butch06()
    fallout.gsay_reply(39, fallout.message_str(39, 123) .. fallout.message_str(39, 124))
    fallout.giq_option(4, 39, 125, Butch08, 50)
    fallout.giq_option(4, 39, 127, Butch05, 50)
    fallout.giq_option(4, 39, 128, Butch21, 51)
    fallout.giq_option(4, 39, 129, Butch11, 50)
end

function Butch08()
    fallout.gsay_reply(39, 133)
    fallout.giq_option(4, 39, 134, Butch09, 50)
    fallout.giq_option(4, 39, 135, Butch19, 51)
end

function Butch09()
    fallout.gsay_reply(39, 136)
    fallout.giq_option(4, 39, 137, Butch12, 50)
    fallout.giq_option(4, 39, 138, Butch16, 50)
    fallout.giq_option(4, 39, 139, Butch18, 50)
end

function Butch10()
    fallout.gsay_reply(39, 140)
    fallout.giq_option(4, 39, 141, Butch12, 50)
end

function Butch11()
    fallout.gsay_message(39, 142, 50)
end

function Butch12()
    fallout.gsay_reply(39, 143)
    fallout.giq_option(4, 39, 144, Butch12a, 50)
    fallout.giq_option(4, 39, 145, ButchEndAccept, 50)
end

function Butch12a()
    Butch13()
end

function Butch13()
    fallout.set_map_var(8, 1)
    fallout.set_global_var(226, 1)
    fallout.gsay_reply(39, 146)
    fallout.giq_option(4, 39, 147, Butch14, 51)
    fallout.giq_option(4, 39, 148, Butch17, 50)
    fallout.giq_option(4, 39, 149, Butch13a, 50)
end

function Butch13a()
    fallout.set_map_var(33, 1)
    fallout.gsay_reply(39, 150)
    fallout.giq_option(4, 39, 151, Butch15, 51)
    fallout.giq_option(4, 39, 152, Butch16, 50)
    fallout.giq_option(4, 39, 153, Butch17, 50)
end

function Butch14()
    reaction.DownReactLevel()
    fallout.set_map_var(33, 1)
    fallout.gsay_reply(39, 154)
    fallout.giq_option(4, 39, 155, Butch15, 51)
    fallout.giq_option(4, 39, 156, Butch16, 50)
    fallout.giq_option(4, 39, 157, Butch17, 50)
end

function Butch15()
    fallout.set_map_var(40, 1)
    fallout.set_map_var(35, 1)
    fallout.set_map_var(10, 0)
    TossOut = 1
    fallout.gsay_message(39, 158, 50)
end

function Butch16()
    fallout.set_map_var(41, 1)
    fallout.set_global_var(106, 1)
    fallout.set_map_var(10, 1)
    fallout.gsay_message(39, 159, 50)
    ButchX3()
end

function Butch17()
    fallout.gsay_reply(39, 160)
    Butch00()
end

function Butch18()
    fallout.set_map_var(41, 2)
    fallout.set_global_var(106, 0)
    fallout.gsay_message(39, 161, 50)
end

function Butch19()
    fallout.gsay_reply(39, 162)
    fallout.giq_option(4, 39, 163, Butch15, 51)
    fallout.giq_option(4, 39, 164, Butch19a, 50)
end

function Butch19a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        Butch09()
    else
        Butch20()
    end
end

function Butch20()
    reaction.DownReactLevel()
    fallout.gsay_reply(39, 165)
    fallout.giq_option(4, 39, 166, Butch16, 50)
    fallout.giq_option(4, 39, 167, Butch18, 50)
end

function Butch21()
    reaction.DownReactLevel()
    fallout.gsay_reply(39, 168)
    fallout.giq_option(4, 39, 169, Butch15, 51)
    fallout.giq_option(4, 39, 170, Butch08, 50)
end

function Butch22()
    fallout.gsay_message(39, 171, 50)
end

function Butch23()
    fallout.gsay_reply(39, 172)
    fallout.giq_option(4, 39, 173, Butch23a, 50)
    fallout.giq_option(4, 39, 174, Butch23a, 50)
    fallout.giq_option(4, 39, 175, Butch17, 50)
end

function Butch23a()
    local v0 = 0
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        v0 = 0
    else
        v0 = 20
    end
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, v0)) then
        Butch24()
    else
        Butch26()
    end
end

function Butch24()
    fallout.gsay_reply(39, 176)
    fallout.giq_option(4, 39, 177, Butch25, 50)
    Butch00()
end

function Butch25()
    fallout.gsay_message(39, 179, 50)
    Butch00()
end

function Butch26()
    fallout.gsay_reply(39, 180)
    fallout.giq_option(4, 39, 181, Butch24, 50)
    Butch00()
end

function Butch27()
    fallout.gsay_reply(39, 183)
    fallout.giq_option(4, 39, 184, Butch28, 50)
    fallout.giq_option(4, 39, 185, Butch27a, 50)
end

function Butch27a()
    if fallout.local_var(1) >= 2 then
        Butch29()
    else
        Butch30()
    end
end

function Butch28()
    fallout.gsay_reply(39, 186)
    Butch00()
end

function Butch29()
    fallout.gsay_reply(39, 187)
    fallout.giq_option(4, 39, 188, Butch32, 50)
    Butch00()
end

function Butch30()
    fallout.gsay_reply(39, 190)
    fallout.giq_option(4, 39, 191, Butch30a, 51)
    Butch00()
end

function Butch30a()
    if fallout.local_var(1) >= 2 then
        reaction.DownReactLevel()
        Butch31()
    else
        Butch15()
    end
end

function Butch31()
    fallout.gsay_reply(39, 193)
    fallout.giq_option(4, 39, 194, Butch15, 51)
    fallout.giq_option(4, 39, 195, Butch17, 50)
end

function Butch32()
    fallout.gsay_reply(39, 196)
    Butch00()
end

function Butch33()
    fallout.gsay_reply(39, 199)
    Butch00()
end

function Butch34()
    if fallout.global_var(71) == 0 then
        fallout.set_global_var(71, 1)
    end
    if fallout.global_var(74) == 0 then
        fallout.set_global_var(74, 1)
    end
    if fallout.global_var(75) == 0 then
        fallout.set_global_var(75, 1)
    end
    fallout.gsay_reply(39, 201)
    fallout.giq_option(4, 39, 202, Butch35, 50)
    Butch00()
end

function Butch35()
    if fallout.global_var(72) == 0 then
        fallout.set_global_var(72, 1)
    end
    fallout.gsay_reply(39, 204)
    fallout.giq_option(4, 39, 205, Butch35a, 50)
end

function Butch35a()
    fallout.gsay_reply(39, 206)
    Butch00()
end

function Butch36()
    fallout.gsay_reply(39, 208)
    fallout.giq_option(4, 39, 209, Butch30a, 51)
    Butch00()
end

function Butch37()
    fallout.gsay_reply(39, 211)
    if (fallout.global_var(78) == 2) or (fallout.obj_is_carrying_obj_pid(fallout.dude_obj(), 196) >= 1) then
        fallout.giq_option(4, 39, 212, Butch38, 50)
    else
        if fallout.global_var(226) == 5 then
            fallout.giq_option(4, 39, 213, Butch53, 50)
        end
    end
    fallout.giq_option(4, 39, 214, ButchEnd, 50)
end

function Butch38()
    fallout.gsay_reply(39, 215)
    fallout.giq_option(4, 39, 216, Butch39, 50)
    fallout.giq_option(4, 39, 217, Butch51, 50)
end

function Butch39()
    fallout.set_map_var(42, 2)
    fallout.gsay_reply(39, 218)
    fallout.giq_option(4, 39, 219, Butch40, 50)
    fallout.giq_option(4, 39, 220, Butch46, 50)
end

function Butch40()
    fallout.gsay_reply(39, 221)
    fallout.giq_option(4, 39, 222, Butch41, 50)
    fallout.giq_option(4, 39, 223, Butch46, 50)
end

function Butch41()
    fallout.gsay_reply(39, 224)
    fallout.giq_option(4, 39, 225, Butch42, 50)
    if fallout.global_var(78) == 2 then
        fallout.giq_option(4, 39, 226, Butch34, 50)
    end
end

function Butch42()
    fallout.set_map_var(41, 3)
    fallout.set_global_var(106, 2)
    fallout.gsay_message(39, 227, 50)
    ButchX2()
end

function Butch43()
    fallout.gsay_reply(39, 228)
    fallout.giq_option(4, 39, 229, Butch44, 50)
    fallout.giq_option(4, 39, 230, Butch45, 50)
end

function Butch44()
    fallout.set_map_var(41, 3)
    fallout.set_global_var(106, 2)
    fallout.gsay_message(39, 231, 50)
    ButchX2()
end

function Butch45()
    fallout.set_map_var(41, 3)
    fallout.set_global_var(106, 2)
    fallout.gsay_message(39, 232, 50)
    ButchX2()
end

function Butch46()
    fallout.gsay_reply(39, 233)
    fallout.giq_option(4, 39, 234, Butch42, 50)
    fallout.giq_option(4, 39, 235, Butch47, 50)
end

function Butch47()
    fallout.set_map_var(41, 3)
    fallout.set_global_var(106, 2)
    fallout.gsay_message(39, 236, 50)
    ButchX2()
end

function Butch49()
    fallout.gsay_message(39, 241, 50)
    ButchX3()
end

function Butch50()
    fallout.gsay_reply(39, 242)
    fallout.giq_option(4, 39, 243, Butch39, 50)
    fallout.giq_option(4, 39, 244, Butch49, 50)
end

function Butch51()
    fallout.gsay_reply(39, 245)
    fallout.giq_option(4, 39, 246, Butch51a, 50)
    fallout.giq_option(4, 39, 247, Butch50, 50)
end

function Butch51a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        Butch52()
    else
        Butch49()
    end
end

function Butch52()
    fallout.set_map_var(41, 3)
    fallout.set_global_var(106, 2)
    fallout.set_map_var(42, 1)
    fallout.gsay_message(39, 248, 50)
    ButchX2()
end

function Butch53()
    fallout.gsay_reply(39, 249)
    fallout.giq_option(4, 39, 250, Butch54, 50)
    fallout.giq_option(4, 39, 251, Butch53a, 50)
end

function Butch53a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        Butch54a()
    else
        Butch58()
    end
end

function Butch54()
    fallout.gsay_reply(39, 252)
    fallout.giq_option(4, 39, 253, Butch54a, 50)
end

function Butch54a()
    fallout.gsay_reply(39, 254)
    fallout.giq_option(4, 39, 255, Butch55, 50)
    fallout.giq_option(4, 39, 256, Butch56, 50)
end

function Butch55()
    fallout.gsay_message(39, 257, 50)
    ButchX3()
end

function Butch56()
    fallout.gsay_reply(39, 258)
    fallout.giq_option(4, 39, 259, Butch55, 50)
    fallout.giq_option(4, 39, 260, Butch57, 50)
end

function Butch57()
    fallout.gsay_message(39, 261, 50)
    ButchX3()
end

function Butch58()
    fallout.gsay_message(39, 262, 50)
    ButchX3()
end

function Butch59()
    fallout.gsay_reply(39, 263)
    if (fallout.global_var(78) == 2) or (fallout.obj_is_carrying_obj_pid(fallout.dude_obj(), 196) >= 1) then
        fallout.giq_option(4, 39, 264, Butch40, 50)
    else
        if fallout.global_var(226) == 5 then
            fallout.giq_option(4, 39, 265, Butch54a, 50)
        end
    end
    fallout.giq_option(4, 39, 327, Butch67, 50)
    fallout.giq_option(4, 39, 329, Butch49, 50)
end

function Butch60()
    fallout.gsay_message(39, 266, 50)
    ButchX2()
end

function Butch61()
end

function Butch62()
end

function Butch63()
end

function Butch64()
end

function Butch65()
end

function Butch66()
end

function Butch67()
    fallout.gsay_message(39, 274, 50)
    ButchEnd()
end

function Butch68()
    fallout.gsay_message(39, 276, 50)
    ButchEnd()
end

function Butch69()
end

function Butch70()
end

function Butch71()
end

function Butch72()
end

function Butch73()
    fallout.gsay_reply(39, 160)
    fallout.giq_option(4, 39, 326, Butch68, 50)
end

function ButchX2()
    fallout.set_local_var(5, 1)
    fallout.set_map_var(56, 0)
end

function ButchX3()
    fallout.set_local_var(5, 0)
    fallout.set_map_var(56, 1)
end

function ButchEnd()
end

function ButchEndAccept()
    fallout.set_map_var(41, 1)
    fallout.set_global_var(106, 1)
    fallout.set_map_var(10, 1)
end

function ButchEndTransport()
    fallout.gfade_out(1000)
    fallout.move_to(fallout.dude_obj(), 18664, 0)
    fallout.gfade_in(1000)
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.damage_p_proc = damage_p_proc
exports.look_at_p_proc = look_at_p_proc
return exports
