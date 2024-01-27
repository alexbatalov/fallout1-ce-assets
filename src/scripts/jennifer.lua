local fallout = require("fallout")
local misc = require("lib.misc")
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

local known = false
local armed = false
local warned = false
local first_time = true
local last_seen = 0
local flag1 = false
local flag2 = false
local line2flag = false
local line5flag = false
local line14flag = false
local hostile = false
local initialized = false

local exit_line = 0

function start()
    if not initialized then
        local self_obj = fallout.self_obj()
        fallout.critter_add_trait(self_obj, 1, 6, 44)
        fallout.critter_add_trait(self_obj, 1, 5, 65)
        initialized = true
    end

    local script_action = fallout.script_action()
    if script_action == 21 then
        look_at_p_proc()
    elseif script_action == 4 then
        pickup_p_proc()
    elseif script_action == 11 then
        talk_p_proc()
    elseif script_action == 12 then
        critter_p_proc()
    elseif script_action == 18 then
        destroy_p_proc()
    end
end

function pre_dialogue()
    reaction.get_reaction()
    if not first_time then
        if fallout.local_var(0) < 2 then
            JenniferRandom3()
        else
            JenniferRandom2()
        end
    else
        first_time = false
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
    if misc.is_armed(fallout.dude_obj()) then
        armed = true
    else
        armed = false
    end
end

function Jennifer00()
    warned = true
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
    line2flag = true
    fallout.gsay_message(462, 112, 50)
    fallout.gsay_reply(462, 113)
    fallout.giq_option(5, 462, 114, reaction.UpReact, 50)
    if not (line5flag) then
        fallout.giq_option(4, 462, 115, Jennifer05, 50)
    end
    fallout.giq_option(4, 0, reaction.Goodbyes(), JenniferEnd, 50)
end

function Jennifer05()
    line5flag = true
    fallout.gsay_message(462, 116, 50)
    Jennifer07()
end

function Jennifer07()
    fallout.gsay_reply(462, 117)
    fallout.giq_option(4, 462, 118, reaction.UpReact, 49)
    fallout.giq_option(4, 462, 119, Jennifer08, 50)
    fallout.giq_option(4, 462, 120, reaction.DownReact, 51)
end

function Jennifer08()
    fallout.gsay_reply(462, 121)
    fallout.giq_option(5, 462, 122, reaction.UpReact, 50)
    fallout.giq_option(6, 462, 123, Jennifer29, 50)
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 1 then
        if not line14flag then
            fallout.giq_option(5, 462, 124, Jennifer14, 50)
        end
    else
        if not flag1 and not flag2 and fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
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
    line14flag = true
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
    if not line2flag then
        fallout.giq_option(4, 462, 142, Jennifer02, 50)
    end
    if not line5flag then
        fallout.giq_option(4, 462, 143, Jennifer05, 50)
    end
    fallout.giq_option(4, 462, 144, JenniferEnd, 50)
end

function Jennifer18()
    fallout.gsay_message(462, 145, 50)
    fallout.gsay_reply(462, 146)
    fallout.giq_option(4, 462, 147, Jennifer19, 50)
    fallout.giq_option(4, 0, reaction.Goodbyes(), JenniferEnd, 50)
end

function Jennifer19()
    fallout.gsay_message(462, 148, 50)
    fallout.gsay_reply(462, 149)
    fallout.giq_option(4, 0, reaction.Goodbyes(), JenniferEnd, 50)
end

function Jennifer20()
    fallout.gsay_reply(462, 150)
    fallout.giq_option(5, 462, 151, reaction.BottomReact, 51)
    fallout.giq_option(4, 462, 152, reaction.UpReact, 49)
    fallout.giq_option(4, 462, 153, reaction.DownReact, 51)
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
    flag1 = true
    flag2 = false
    last_seen = fallout.game_time()
    fallout.gsay_message(462, 163, 49)
    fallout.gsay_reply(462, 164)
    if not line2flag then
        fallout.giq_option(4, 462, 165, Jennifer02, 50)
    end
    if not line5flag then
        fallout.giq_option(4, 462, 166, Jennifer05, 50)
    end
    fallout.giq_option(4, 462, 167, JenniferEnd, 50)
    fallout.giq_option(4, 462, 168, JenniferEnd, 50)
end

function Jennifer25()
    flag1 = false
    flag2 = true
    fallout.gsay_message(462, 163, 50)
    fallout.gsay_reply(462, 164)
    if not line2flag then
        fallout.giq_option(4, 462, 165, Jennifer02, 50)
    end
    if not line5flag then
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
    if not line2flag then
        fallout.giq_option(4, 462, 174, Jennifer02, 50)
    end
    if not line5flag then
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
    fallout.giq_option(4, 462, 183, reaction.BottomReact, 51)
end

function Jennifer30()
    fallout.gsay_message(462, 184, 50)
    fallout.gsay_message(462, 185, 50)
    fallout.gsay_reply(462, 186)
    fallout.giq_option(7, 462, 187, Jennifer31, 50)
    fallout.giq_option(4, 462, 188, reaction.UpReact, 49)
    fallout.giq_option(4, 462, 189, reaction.DownReact, 51)
    if not line2flag then
        fallout.giq_option(4, 462, 190, Jennifer02, 50)
    end
end

function Jennifer31()
    fallout.gsay_reply(462, 191)
    fallout.giq_option(4, 462, 192, JenniferEnd, 50)
    fallout.giq_option(4, 462, 193, reaction.DownReact, 51)
    if not line2flag then
        fallout.giq_option(4, 462, 194, Jennifer02, 50)
    end
end

function JenniferCharm()
    local roll = fallout.do_check(fallout.dude_obj(), 3, 0)
    if fallout.is_success(roll) then
        if fallout.is_critical(roll) then
            reaction.BigUpReact()
            flag1 = true
            Jennifer23()
        else
            Jennifer25()
        end
    else
        if fallout.is_critical(roll) then
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
    local msg
    if v0 == 0 then
        v0 = fallout.random(1, 10)
    end
    if fallout.game_time_hour() > 800 and fallout.game_time_hour() < 1700 then
        if v0 > 10 then
            v0 = 1
        end
        msg = fallout.message_str(462, 195)
        if v0 == 2 then
            msg = fallout.message_str(462, 196)
        elseif v0 == 3 then
            msg = fallout.message_str(462, 197)
        elseif v0 == 4 then
            msg = fallout.message_str(462, 198)
        elseif v0 == 5 then
            msg = fallout.message_str(462, 199)
        elseif v0 == 6 then
            msg = fallout.message_str(462, 200)
        elseif v0 == 7 then
            msg = fallout.message_str(462, 201)
        else
            if last_seen - fallout.game_time() > 86400 then
                if v0 == 8 then
                    msg = fallout.message_str(462, 202)
                end
                if v0 == 9 then
                    msg = fallout.message_str(462, 203)
                end
                if v0 == 10 then
                    msg = fallout.message_str(462, 204)
                end
            else
                v0 = 1
            end
        end
    else
        if v0 > 6 then
            v0 = 1
        end
        msg = fallout.message_str(462, 205)
        if v0 == 2 then
            msg = fallout.message_str(462, 206)
        elseif v0 == 3 then
            msg = fallout.message_str(462, 207)
        elseif v0 == 4 then
            msg = fallout.message_str(462, 208)
        elseif v0 == 5 then
            msg = fallout.message_str(462, 209)
        elseif v0 == 6 then
            msg = fallout.message_str(462, 210)
        end
    end
    v0 = v0 + 1
    last_seen = fallout.game_time()
    fallout.float_msg(fallout.self_obj(), msg, 0)
end

function JenniferRandom2()
    local v0 = 0
    if v0 == 0 then
        v0 = fallout.random(1, 5)
    end
    if v0 > 5 then
        v0 = 1
    end
    local msg = fallout.message_str(462, 211)
    if v0 == 2 then
        msg = fallout.message_str(462, 212) ..
            fallout.proto_data(fallout.obj_pid(fallout.dude_obj()), 1) .. fallout.message_str(462, 213)
    elseif v0 == 3 then
        msg = fallout.message_str(462, 214)
    elseif v0 == 4 then
        msg = fallout.message_str(462, 215) ..
            fallout.proto_data(fallout.obj_pid(fallout.dude_obj()), 1) .. fallout.message_str(462, 216)
    elseif v0 == 5 then
        msg = fallout.message_str(462, 217)
    end
    v0 = v0 + 1
    fallout.float_msg(fallout.self_obj(), msg, 0)
end

function JenniferRandom3()
    local v0 = 0
    if v0 == 0 then
        v0 = fallout.random(1, 8)
    end
    if v0 > 8 then
        v0 = 1
    end
    local msg = fallout.message_str(462, 218)
    if v0 == 2 then
        msg = fallout.message_str(462, 219)
    elseif v0 == 3 then
        msg = fallout.message_str(462, 220)
    elseif v0 == 4 then
        msg = fallout.message_str(462, 221)
    elseif v0 == 5 then
        msg = fallout.message_str(462, 222)
    elseif v0 == 6 then
        msg = fallout.message_str(462, 223)
    elseif v0 == 7 then
        msg = fallout.message_str(462, 224)
    elseif v0 == 8 then
        msg = fallout.message_str(462, 225)
    end
    v0 = v0 + 1
    fallout.float_msg(fallout.self_obj(), msg, 0)
end

function JenniferBackground1()
    local v0 = 0
    local msg
    if v0 == 0 then
        v0 = fallout.random(1, 11)
    end
    if fallout.game_time_hour() > 800 and fallout.game_time_hour() < 1700 then
        if v0 > 11 then
            v0 = 1
        end
        if v0 == 1 then
            msg = fallout.message_str(462, 226)
        elseif v0 == 2 then
            msg = fallout.message_str(462, 227)
        elseif v0 == 3 then
            msg = fallout.proto_data(fallout.obj_pid(fallout.dude_obj()), 1) .. fallout.message_str(462, 228)
        elseif v0 == 4 then
            msg = fallout.message_str(462, 229)
        elseif v0 == 5 then
            msg = fallout.message_str(462, 230)
        elseif v0 == 6 then
            msg = fallout.message_str(462, 231)
        elseif v0 == 7 then
            msg = fallout.message_str(462, 232)
        elseif v0 == 8 then
            msg = fallout.message_str(462, 233)
        elseif v0 == 9 then
            msg = fallout.message_str(462, 234)
        elseif v0 == 10 then
            msg = fallout.message_str(462, 235)
        elseif v0 == 11 then
            msg = fallout.message_str(462, 236)
        end
    else
        if v0 == 1 then
            msg = fallout.message_str(462, 237)
        elseif v0 == 2 then
            msg = fallout.message_str(462, 238)
        elseif v0 == 3 then
            msg = fallout.message_str(462, 239)
        elseif v0 == 4 then
            msg = fallout.message_str(462, 240)
        elseif v0 == 5 then
            msg = fallout.message_str(462, 241)
        end
    end
    v0 = v0 + 1
    fallout.float_msg(fallout.self_obj(), msg, 0)
    last_seen = fallout.game_time()
end

function combat()
    hostile = true
end

function critter_p_proc()
    if fallout.global_var(250) ~= 0 then
        hostile = true
    end
    if fallout.tile_distance_objs(fallout.self_obj(), fallout.dude_obj()) > 12 then
        hostile = false
    end
    if hostile then
        fallout.set_global_var(250, 1)
        hostile = false
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    else
        if not warned then
            if fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) then
                if not armed then
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
        hostile = true
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
        -- FIXME: Jennifer never tells her name.
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
