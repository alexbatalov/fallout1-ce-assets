local fallout = require("fallout")
local reaction = require("lib.reaction")
local reputation = require("lib.reputation")

local start
local combat
local critter_p_proc
local pickup_p_proc
local talk_p_proc
local destroy_p_proc
local look_at_p_proc
local PlayerQuestions
local Decker01
local Decker02
local Decker03
local Decker04
local Decker05
local Decker06
local Decker07
local Decker08
local Decker09
local Decker10
local Decker11
local Decker12
local Decker13
local Decker14
local Decker15
local Decker16
local Decker17
local Decker18
local Decker19
local Decker25
local Decker26
local Decker27
local Decker28
local Decker29
local Decker30
local Decker31
local Decker32
local Decker33
local Decker34
local Decker35
local Decker36
local DeckerEndAcceptJob1
local DeckerEndDeclineJob1
local DeckerEndAcceptJob2
local DeckerEndDeclineJob2
local DeckerEndInsult
local DeckerEndNormal
local DeckerTransport

local hostile = 0
local initialized = false
local travel = 0

local exit_line = 0

function start()
    if not initialized then
        initialized = true
        fallout.set_external_var("Decker_Ptr", fallout.self_obj())
        if fallout.map_var(50) == 1 then
            fallout.set_obj_visibility(fallout.self_obj(), 1)
        end
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 38)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 87)
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
    if travel == 1 then
        travel = 0
        DeckerTransport()
    else
        if fallout.tile_distance_objs(fallout.self_obj(), fallout.dude_obj()) <= 10 then
            fallout.dialogue_system_enter()
        end
    end
end

function pickup_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        hostile = 1
    end
end

function talk_p_proc()
    fallout.set_global_var(219, 1)
    reaction.get_reaction()
    if (fallout.map_var(49) == 1) or (fallout.map_var(45) ~= 1) then
        if fallout.map_var(52) == 0 then
            fallout.float_msg(fallout.self_obj(), fallout.message_str(42, 230), 2)
            combat()
        else
            fallout.float_msg(fallout.self_obj(), fallout.message_str(42, 231), 2)
            combat()
        end
    else
        fallout.set_map_var(45, 0)
        if fallout.local_var(4) == 0 then
            fallout.set_local_var(4, 1)
            fallout.start_gdialog(42, fallout.self_obj(), 4, 7, 3)
            fallout.gsay_start()
            Decker01()
            fallout.gsay_end()
            fallout.end_dialogue()
        else
            if fallout.global_var(112) == 2 then
                fallout.start_gdialog(42, fallout.self_obj(), 4, 7, 3)
                fallout.gsay_start()
                Decker15()
                fallout.gsay_end()
                fallout.end_dialogue()
            else
                if fallout.global_var(111) == 2 then
                    fallout.start_gdialog(42, fallout.self_obj(), 4, 7, 3)
                    fallout.gsay_start()
                    Decker26()
                    fallout.gsay_end()
                    fallout.end_dialogue()
                end
            end
        end
    end
end

function destroy_p_proc()
    reputation.inc_evil_critter()
    fallout.set_map_var(50, 1)
    fallout.set_global_var(203, 1)
    if (fallout.map_var(49) == 1) and (fallout.map_var(50) == 1) then
        fallout.set_global_var(202, 1)
        fallout.set_map_var(11, 1)
        fallout.set_map_var(44, 1)
    end
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(42, 100))
end

function PlayerQuestions()
    fallout.giq_option(4, 42, 144, Decker17, 50)
    fallout.giq_option(4, 42, 145, Decker25, 50)
    fallout.giq_option(4, 42, 146, DeckerEndNormal, 50)
end

function Decker01()
    fallout.gsay_reply(42, 103)
    fallout.giq_option(4, 42, fallout.message_str(42, 104) .. fallout.proto_data(fallout.obj_pid(fallout.dude_obj()), 1) .. fallout.message_str(42, 105), Decker02, 50)
    fallout.giq_option(4, 42, 106, Decker13, 51)
end

function Decker02()
    fallout.gsay_reply(42, 107)
    fallout.giq_option(4, 42, 108, Decker03, 50)
    fallout.giq_option(4, 42, 109, Decker14, 50)
end

function Decker03()
    fallout.gsay_reply(42, 110)
    fallout.giq_option(4, 42, 111, Decker04, 50)
end

function Decker04()
    fallout.gsay_reply(42, 112)
    fallout.giq_option(4, 42, 113, Decker05, 50)
    fallout.giq_option(4, 42, 114, Decker11, 50)
    fallout.giq_option(4, 42, 115, Decker10, 51)
end

function Decker05()
    fallout.gsay_reply(42, 116)
    fallout.giq_option(4, 42, 117, Decker06, 50)
    fallout.giq_option(4, 42, 118, Decker10, 50)
    fallout.giq_option(4, 42, 119, Decker06, 50)
end

function Decker06()
    fallout.gsay_reply(42, 120)
    fallout.giq_option(4, 42, 121, Decker07, 50)
end

function Decker07()
    fallout.gsay_reply(42, 122)
    fallout.giq_option(4, 42, 123, Decker08, 50)
    fallout.giq_option(4, 42, 124, Decker09, 50)
    fallout.giq_option(4, 42, 125, Decker10, 50)
end

function Decker08()
    fallout.gsay_message(42, 126, 50)
    DeckerEndAcceptJob1()
end

function Decker09()
    fallout.gsay_reply(42, 127)
    fallout.giq_option(4, 42, 128, Decker08, 50)
    fallout.giq_option(4, 42, 129, Decker10, 50)
end

function Decker10()
    fallout.gsay_message(42, 130, 50)
    DeckerEndDeclineJob1()
end

function Decker11()
    fallout.gsay_reply(42, 131)
    fallout.giq_option(4, 42, 132, Decker10, 50)
    fallout.giq_option(4, 42, 133, Decker12, 50)
end

function Decker12()
    fallout.gsay_message(42, 134, 50)
    DeckerEndAcceptJob1()
end

function Decker13()
    fallout.gsay_reply(42, 135)
    fallout.giq_option(4, 42, fallout.message_str(42, 136) .. fallout.proto_data(fallout.obj_pid(fallout.dude_obj()), 1) .. fallout.message_str(42, 137), Decker02, 50)
    fallout.giq_option(4, 42, 138, Decker14, 50)
end

function Decker14()
    fallout.gsay_message(42, 139, 51)
    DeckerEndInsult()
end

function Decker15()
    fallout.gsay_reply(42, 140)
    fallout.giq_option(4, 42, 141, Decker16, 50)
    fallout.giq_option(4, 42, 142, DeckerEndNormal, 50)
end

function Decker16()
    fallout.gsay_reply(42, 143)
    PlayerQuestions()
end

function Decker17()
    fallout.gsay_reply(42, 148)
    fallout.giq_option(4, 42, 149, Decker18, 50)
    fallout.giq_option(4, 42, 150, Decker16, 50)
end

function Decker18()
    fallout.gsay_reply(42, 151)
    fallout.giq_option(4, 42, 152, Decker19, 50)
    fallout.giq_option(4, 42, 153, Decker16, 50)
end

function Decker19()
    fallout.gsay_reply(42, 154)
    fallout.giq_option(4, 42, 155, Decker16, 50)
end

function Decker25()
    fallout.gsay_reply(42, 167)
    PlayerQuestions()
end

function Decker26()
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        fallout.gsay_reply(42, 232)
    else
        fallout.gsay_reply(42, 233)
    end
    fallout.giq_option(4, 42, 169, Decker27, 50)
    fallout.giq_option(4, 42, 170, Decker35, 51)
end

function Decker27()
    fallout.gsay_reply(42, 171)
    fallout.giq_option(4, 42, 172, Decker28, 50)
    fallout.giq_option(4, 42, 173, Decker35, 51)
end

function Decker28()
    fallout.gsay_reply(42, 174)
    fallout.giq_option(4, 42, 175, Decker29, 50)
end

function Decker29()
    fallout.gsay_reply(42, 176)
    fallout.giq_option(4, 42, 177, Decker30, 50)
    fallout.giq_option(4, 42, 178, Decker32, 51)
end

function Decker30()
    reaction.UpReact()
    fallout.gsay_reply(42, 179)
    fallout.giq_option(4, 42, 180, Decker31, 50)
end

function Decker31()
    fallout.gsay_message(42, 181, 50)
    DeckerEndAcceptJob2()
end

function Decker32()
    fallout.gsay_reply(42, 182)
    fallout.giq_option(4, 42, 183, Decker33, 50)
    fallout.giq_option(4, 42, 184, Decker34, 50)
end

function Decker33()
    fallout.gsay_reply(42, 185)
    fallout.giq_option(4, 42, 186, Decker31, 50)
end

function Decker34()
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        fallout.gsay_message(42, 234, 51)
    else
        fallout.gsay_message(42, 235, 51)
    end
    DeckerEndDeclineJob2()
end

function Decker35()
    fallout.gsay_reply(42, 188)
    fallout.giq_option(4, 42, 189, Decker36, 50)
    fallout.giq_option(4, 42, 190, Decker28, 50)
end

function Decker36()
    fallout.gsay_message(42, 191, 51)
    DeckerEndDeclineJob2()
end

function DeckerEndAcceptJob1()
    fallout.set_map_var(46, 2)
    fallout.set_global_var(111, 1)
    travel = 1
end

function DeckerEndDeclineJob1()
    fallout.set_map_var(46, 1)
    fallout.set_map_var(11, 1)
    fallout.set_global_var(111, 0)
    travel = 1
end

function DeckerEndAcceptJob2()
    fallout.set_map_var(47, 3)
    fallout.set_global_var(112, 1)
    travel = 1
end

function DeckerEndDeclineJob2()
    fallout.set_map_var(47, 2)
    fallout.set_map_var(11, 1)
    fallout.set_global_var(112, 0)
    travel = 1
end

function DeckerEndInsult()
    fallout.set_map_var(46, 1)
    fallout.set_map_var(11, 1)
    fallout.set_map_var(44, 1)
    travel = 1
end

function DeckerEndNormal()
    travel = 1
end

function DeckerTransport()
    fallout.gfade_out(1000)
    fallout.move_to(fallout.external_var("Kane_Ptr"), 24336, 0)
    fallout.move_to(fallout.dude_obj(), 23736, 0)
    fallout.anim(fallout.external_var("Kane_Ptr"), 1000, fallout.rotation_to_tile(fallout.tile_num(fallout.external_var("Kane_Ptr")), fallout.tile_num(fallout.dude_obj())))
    fallout.anim(fallout.dude_obj(), 1000, fallout.rotation_to_tile(fallout.tile_num(fallout.dude_obj()), fallout.tile_num(fallout.external_var("Kane_Ptr"))))
    fallout.gfade_in(1000)
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
return exports
