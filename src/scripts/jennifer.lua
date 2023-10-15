local fallout = require("fallout")
local reaction = require("lib.reaction")
local reputation = require("lib.reputation")

local start
local pre_dialogue
local do_dialogue
local weapon_check
local Jennifer00
local Jennifer01
local Jennifer01a
local Jennifer01b
local Jennifer02
local Jennifer05
local Jennifer07
local Jennifer08
local Jennifer11
local Jennifer13
local Jennifer14
local Jennifer15
local Jennifer16
local Jennifer17
local Jennifer18
local Jennifer19
local Jennifer20
local Jennifer21
local Jennifer22
local Jennifer23
local Jennifer25
local Jennifer26
local Jennifer27
local Jennifer28
local Jennifer29
local Jennifer30
local Jennifer31
local JenniferCharm
local JenniferEnd
local JenniferRandom1
local JenniferRandom2
local JenniferRandom3
local JenniferBackground1
local combat
local critter_p_proc
local pickup_p_proc
local talk_p_proc
local destroy_p_proc
local look_at_p_proc

local known = 0
local armed = 0
local warned = 0
local first_time = 1
local last_seen = 0
local flag1 = 0
local flag2 = 0
local line2flag = 0
local line5flag = 0
local line14flag = 0
local hostile = 0
local initialized = false

local exit_line = 0

function start()
    if not initialized then
        initialized = true
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 44)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 65)
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

function pre_dialogue()
    reaction.get_reaction()
    if not(first_time) then
        if fallout.local_var(0) < 2 then
            JenniferRandom3()
        else
            JenniferRandom2()
        end
    else
        first_time = 0
        do_dialogue()
    end
end

function do_dialogue()
    fallout.start_gdialog(-1, fallout.self_obj(), 4, -1, -1)
    fallout.gsay_start()
    Jennifer01()
    fallout.gsay_end()
    fallout.end_dialogue()
end

function weapon_check()
    if (fallout.obj_item_subtype(fallout.critter_inven_obj(fallout.dude_obj(), 1)) == 3) or (fallout.obj_item_subtype(fallout.critter_inven_obj(fallout.dude_obj(), 2)) == 3) then
        armed = 1
    else
        armed = 0
    end
end

function Jennifer00()
    warned = 1
    fallout.float_msg(fallout.self_obj(), fallout.message_str(462, 102), 0)
    fallout.float_msg(fallout.self_obj(), fallout.message_str(462, 103), 0)
end

function Jennifer01()
    fallout.gsay_reply(462, 104)
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 1 then
        fallout.giq_option(5, 462, 105, Jennifer14, 50)
    else
        fallout.giq_option(5, 462, 106, JenniferCharm, 50)
        fallout.giq_option(-3, 462, 107, Jennifer11, 50)
    end
    fallout.giq_option(5, 462, 108, Jennifer01a, 49)
    fallout.giq_option(4, 462, 109, Jennifer01b, 51)
    fallout.giq_option(4, 462, 110, Jennifer02, 50)
    fallout.giq_option(-3, 462, 111, Jennifer13, 50)
end

function Jennifer01a()
    reaction.UpReact()
    Jennifer02()
end

function Jennifer01b()
    reaction.BigDownReact()
    Jennifer20()
end

function Jennifer02()
    line2flag = 1
    fallout.gsay_message(462, 112, 50)
    fallout.gsay_reply(462, 113)
    fallout.giq_option(5, 462, 114, UpReact, 50)
    if not(line5flag) then
        fallout.giq_option(4, 462, 115, Jennifer05, 50)
    end
    exit_line = reaction.Goodbyes()
    fallout.giq_option(4, 0, exit_line, JenniferEnd, 50)
end

function Jennifer05()
    line5flag = 1
    fallout.gsay_message(462, 116, 50)
    Jennifer07()
end

function Jennifer07()
    fallout.gsay_reply(462, 117)
    fallout.giq_option(4, 462, 118, UpReact, 49)
    fallout.giq_option(4, 462, 119, Jennifer08, 50)
    fallout.giq_option(4, 462, 120, DownReact, 51)
end

function Jennifer08()
    fallout.gsay_reply(462, 121)
    fallout.giq_option(5, 462, 122, UpReact, 50)
    fallout.giq_option(6, 462, 123, Jennifer29, 50)
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 1 then
        if not(line14flag) then
            fallout.giq_option(5, 462, 124, Jennifer14, 50)
        end
    else
        if not(flag1) and not(flag2) and (fallout.get_critter_stat(fallout.dude_obj(), 34) == 0) then
            fallout.giq_option(5, 462, 125, JenniferCharm, 50)
        end
    end
    fallout.giq_option(4, 462, 126, JenniferEnd, 50)
end

function Jennifer11()
    fallout.gsay_reply(462, 127)
    fallout.giq_option(-3, 462, 128, Jennifer13, 50)
end

function Jennifer13()
    fallout.gsay_message(462, 129, 50)
end

function Jennifer14()
    line14flag = 1
    reaction.TopReact()
    fallout.gsay_message(462, 130, 50)
    fallout.gsay_reply(462, 131)
    fallout.giq_option(8, 462, 132, Jennifer16, 50)
    fallout.giq_option(4, 462, 133, Jennifer15, 50)
    fallout.giq_option(4, 462, 134, Jennifer17, 50)
end

function Jennifer15()
    fallout.gsay_reply(462, 135)
    fallout.giq_option(4, 462, 136, Jennifer17, 50)
    fallout.giq_option(4, 462, 137, Jennifer17, 50)
end

function Jennifer16()
    fallout.gsay_reply(462, 138)
    fallout.giq_option(8, 462, 139, Jennifer18, 50)
    fallout.giq_option(4, 462, 140, Jennifer17, 50)
end

function Jennifer17()
    fallout.gsay_reply(462, 141)
    if not(line2flag) then
        fallout.giq_option(4, 462, 142, Jennifer02, 50)
    end
    if not(line5flag) then
        fallout.giq_option(4, 462, 143, Jennifer05, 50)
    end
    fallout.giq_option(4, 462, 144, JenniferEnd, 50)
end

function Jennifer18()
    fallout.gsay_message(462, 145, 50)
    fallout.gsay_reply(462, 146)
    fallout.giq_option(4, 462, 147, Jennifer19, 50)
    exit_line = reaction.Goodbyes()
    fallout.giq_option(4, 0, exit_line, JenniferEnd, 50)
end

function Jennifer19()
    fallout.gsay_message(462, 148, 50)
    fallout.gsay_reply(462, 149)
    exit_line = reaction.Goodbyes()
    fallout.giq_option(4, 0, exit_line, JenniferEnd, 50)
end

function Jennifer20()
    fallout.gsay_reply(462, 150)
    fallout.giq_option(5, 462, 151, BottomReact, 51)
    fallout.giq_option(4, 462, 152, UpReact, 49)
    fallout.giq_option(4, 462, 153, DownReact, 51)
end

function Jennifer21()
    fallout.gsay_reply(462, 154)
    fallout.giq_option(4, 462, 155, Jennifer22, 50)
    fallout.giq_option(4, 462, 156, JenniferEnd, 50)
end

function Jennifer22()
    fallout.gsay_message(462, 157, 50)
end

function Jennifer23()
    reaction.TopReact()
    flag1 = 1
    flag2 = 0
    last_seen = fallout.game_time()
    fallout.gsay_message(462, 163, 49)
    fallout.gsay_reply(462, 164)
    if line2flag == 0 then
        fallout.giq_option(4, 462, 165, Jennifer02, 50)
    end
    if line5flag == 0 then
        fallout.giq_option(4, 462, 166, Jennifer05, 50)
    end
    fallout.giq_option(4, 462, 167, JenniferEnd, 50)
    fallout.giq_option(4, 462, 168, JenniferEnd, 50)
end

function Jennifer25()
    flag1 = 0
    flag2 = 1
    fallout.gsay_message(462, 163, 50)
    fallout.gsay_reply(462, 164)
    if not(line2flag) then
        fallout.giq_option(4, 462, 165, Jennifer02, 50)
    end
    if not(line5flag) then
        fallout.giq_option(4, 462, 166, Jennifer05, 50)
    end
    fallout.giq_option(4, 462, 167, JenniferEnd, 50)
    fallout.giq_option(4, 462, 168, JenniferEnd, 50)
end

function Jennifer26()
    fallout.gsay_reply(462, 169)
    fallout.giq_option(4, 462, 170, reaction.BigDownReact, 51)
    fallout.giq_option(4, 462, 171, Jennifer27, 50)
    fallout.giq_option(4, 462, 172, JenniferEnd, 50)
end

function Jennifer27()
    fallout.gsay_reply(462, 173)
    if not(line2flag) then
        fallout.giq_option(4, 462, 174, Jennifer02, 50)
    end
    if not(line5flag) then
        fallout.giq_option(4, 462, 175, Jennifer05, 50)
    end
    fallout.giq_option(4, 462, 176, JenniferEnd, 50)
end

function Jennifer28()
    fallout.gsay_reply(462, 177)
    fallout.giq_option(4, 462, 178, Jennifer27, 50)
    fallout.giq_option(4, 462, 179, Jennifer27, 51)
    fallout.giq_option(4, 462, 180, JenniferEnd, 50)
end

function Jennifer29()
    fallout.gsay_reply(462, 181)
    fallout.giq_option(4, 462, 182, Jennifer30, 50)
    fallout.giq_option(4, 462, 183, BottomReact, 51)
end

function Jennifer30()
    fallout.gsay_message(462, 184, 50)
    fallout.gsay_message(462, 185, 50)
    fallout.gsay_reply(462, 186)
    fallout.giq_option(7, 462, 187, Jennifer31, 50)
    fallout.giq_option(4, 462, 188, UpReact, 49)
    fallout.giq_option(4, 462, 189, DownReact, 51)
    if not(line2flag) then
        fallout.giq_option(4, 462, 190, Jennifer02, 50)
    end
end

function Jennifer31()
    fallout.gsay_reply(462, 191)
    fallout.giq_option(4, 462, 192, JenniferEnd, 50)
    fallout.giq_option(4, 462, 193, DownReact, 51)
    if not(line2flag) then
        fallout.giq_option(4, 462, 194, Jennifer02, 50)
    end
end

function JenniferCharm()
    local v0 = 0
    v0 = fallout.do_check(fallout.dude_obj(), 3, 0)
    if fallout.is_success(v0) then
        if fallout.is_critical(v0) then
            reaction.BigUpReact()
            flag1 = 1
            Jennifer23()
        else
            Jennifer25()
        end
    else
        if fallout.is_critical(v0) then
            Jennifer28()
        else
            Jennifer26()
        end
    end
end

function JenniferEnd()
end

function JenniferRandom1()
    local v0 = 0
    local v1 = 0
    if not(v0) then
        v0 = fallout.random(1, 10)
    end
    if (fallout.game_time_hour() > 800) and (fallout.game_time_hour() < 1700) then
        if v0 > 10 then
            v0 = 1
        end
        v1 = fallout.message_str(462, 195)
        if v0 == 2 then
            v1 = fallout.message_str(462, 196)
        else
            if v0 == 3 then
                v1 = fallout.message_str(462, 197)
            else
                if v0 == 4 then
                    v1 = fallout.message_str(462, 198)
                else
                    if v0 == 5 then
                        v1 = fallout.message_str(462, 199)
                    else
                        if v0 == 6 then
                            v1 = fallout.message_str(462, 200)
                        else
                            if v0 == 7 then
                                v1 = fallout.message_str(462, 201)
                            else
                                if (last_seen - fallout.game_time()) > 86400 then
                                    if v0 == 8 then
                                        v1 = fallout.message_str(462, 202)
                                    end
                                    if v0 == 9 then
                                        v1 = fallout.message_str(462, 203)
                                    end
                                    if v0 == 10 then
                                        v1 = fallout.message_str(462, 204)
                                    end
                                else
                                    v0 = 1
                                end
                            end
                        end
                    end
                end
            end
        end
    else
        if v0 > 6 then
            v0 = 1
        end
        v1 = fallout.message_str(462, 205)
        if v0 == 2 then
            v1 = fallout.message_str(462, 206)
        else
            if v0 == 3 then
                v1 = fallout.message_str(462, 207)
            else
                if v0 == 4 then
                    v1 = fallout.message_str(462, 208)
                else
                    if v0 == 5 then
                        v1 = fallout.message_str(462, 209)
                    else
                        if v0 == 6 then
                            v1 = fallout.message_str(462, 210)
                        end
                    end
                end
            end
        end
    end
    v0 = v0 + 1
    last_seen = fallout.game_time()
    fallout.float_msg(fallout.self_obj(), v1, 0)
end

function JenniferRandom2()
    local v0 = 0
    local v1 = 0
    if not(v0) then
        v0 = fallout.random(1, 5)
    end
    if v0 > 5 then
        v0 = 1
    end
    v1 = fallout.message_str(462, 211)
    if v0 == 2 then
        v1 = fallout.message_str(462, 212) .. fallout.proto_data(fallout.obj_pid(fallout.dude_obj()), 1) .. fallout.message_str(462, 213)
    else
        if v0 == 3 then
            v1 = fallout.message_str(462, 214)
        else
            if v0 == 4 then
                v1 = fallout.message_str(462, 215) .. fallout.proto_data(fallout.obj_pid(fallout.dude_obj()), 1) .. fallout.message_str(462, 216)
            else
                if v0 == 5 then
                    v1 = fallout.message_str(462, 217)
                end
            end
        end
    end
    v0 = v0 + 1
    fallout.float_msg(fallout.self_obj(), v1, 0)
end

function JenniferRandom3()
    local v0 = 0
    local v1 = 0
    if not(v0) then
        v0 = fallout.random(1, 8)
    end
    if v0 > 8 then
        v0 = 1
    end
    v1 = fallout.message_str(462, 218)
    if v0 == 2 then
        v1 = fallout.message_str(462, 219)
    else
        if v0 == 3 then
            v1 = fallout.message_str(462, 220)
        else
            if v0 == 4 then
                v1 = fallout.message_str(462, 221)
            else
                if v0 == 5 then
                    v1 = fallout.message_str(462, 222)
                else
                    if v0 == 6 then
                        v1 = fallout.message_str(462, 223)
                    else
                        if v0 == 7 then
                            v1 = fallout.message_str(462, 224)
                        else
                            if v0 == 8 then
                                v1 = fallout.message_str(462, 225)
                            end
                        end
                    end
                end
            end
        end
    end
    v0 = v0 + 1
    fallout.float_msg(fallout.self_obj(), v1, 0)
end

function JenniferBackground1()
    local v0 = 0
    local v1 = 0
    if not(v0) then
        v0 = fallout.random(1, 11)
    end
    if (fallout.game_time_hour() > 800) and (fallout.game_time_hour() < 1700) then
        if v0 > 11 then
            v0 = 1
        end
        if v0 == 1 then
            v1 = fallout.message_str(462, 226)
        else
            if v0 == 2 then
                v1 = fallout.message_str(462, 227)
            else
                if v0 == 3 then
                    v1 = fallout.proto_data(fallout.obj_pid(fallout.dude_obj()), 1) .. fallout.message_str(462, 228)
                else
                    if v0 == 4 then
                        v1 = fallout.message_str(462, 229)
                    else
                        if v0 == 5 then
                            v1 = fallout.message_str(462, 230)
                        else
                            if v0 == 6 then
                                v1 = fallout.message_str(462, 231)
                            else
                                if v0 == 7 then
                                    v1 = fallout.message_str(462, 232)
                                else
                                    if v0 == 8 then
                                        v1 = fallout.message_str(462, 233)
                                    else
                                        if v0 == 9 then
                                            v1 = fallout.message_str(462, 234)
                                        else
                                            if v0 == 10 then
                                                v1 = fallout.message_str(462, 235)
                                            else
                                                if v0 == 11 then
                                                    v1 = fallout.message_str(462, 236)
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    else
        if v0 == 1 then
            v1 = fallout.message_str(462, 237)
        else
            if v0 == 2 then
                v1 = fallout.message_str(462, 238)
            else
                if v0 == 3 then
                    v1 = fallout.message_str(462, 239)
                else
                    if v0 == 4 then
                        v1 = fallout.message_str(462, 240)
                    else
                        if v0 == 5 then
                            v1 = fallout.message_str(462, 241)
                        end
                    end
                end
            end
        end
    end
    v0 = v0 + 1
    fallout.float_msg(fallout.self_obj(), v1, 0)
    last_seen = fallout.game_time()
end

function combat()
    hostile = 1
end

function critter_p_proc()
    if fallout.global_var(250) then
        hostile = 1
    end
    if fallout.tile_distance_objs(fallout.self_obj(), fallout.dude_obj()) > 12 then
        hostile = 0
    end
    if hostile then
        fallout.set_global_var(250, 1)
        hostile = 0
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    else
        if warned == 0 then
            if fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) then
                if armed == 0 then
                    weapon_check()
                end
                if armed then
                    Jennifer00()
                end
            end
        end
    end
end

function pickup_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        hostile = 1
    end
end

function talk_p_proc()
    pre_dialogue()
end

function destroy_p_proc()
    fallout.set_global_var(250, 1)
    fallout.rm_timer_event(fallout.self_obj())
    reputation.inc_good_critter()
end

function look_at_p_proc()
    fallout.script_overrides()
    if known then
        fallout.display_msg(fallout.message_str(462, 100))
    else
        fallout.display_msg(fallout.message_str(462, 101))
    end
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
return exports
