local fallout = require("fallout")
local behaviour = require("lib.behaviour")

local start
local critter_p_proc
local destroy_p_proc
local look_at_p_proc
local talk_p_proc
local Scout0
local Scout1
local Scout2
local Scout3
local Scout4
local Scout5
local Scout6
local Scout7
local Scout8
local Scout9
local Scout10
local Scout11
local Scout12
local Scout13
local Scout14
local Scout15
local Scout16
local Scout16a
local Scout17
local Scout18
local Scout19
local Scout20
local Scout21
local Scout22
local Scout23
local combat
local ScoutEnd

local hostile = 0
local initialized = false

local damage_p_proc

function start()
    if not initialized then
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 46)
        if fallout.global_var(129) == 2 then
            if fallout.random(0, 1) then
                fallout.kill_critter(fallout.self_obj(), 59)
            else
                fallout.kill_critter(fallout.self_obj(), 57)
            end
        end
        initialized = true
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
    if fallout.global_var(129) == 2 then
        fallout.set_external_var("removal_ptr", fallout.self_obj())
    end
    if hostile then
        hostile = 0
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    else
        if fallout.local_var(1) or fallout.global_var(256) then
            if fallout.tile_distance_objs(fallout.self_obj(), fallout.dude_obj()) < 8 then
                behaviour.flee_dude(1)
            end
        end
    end
end

function destroy_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.set_global_var(256, 1)
    end
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.set_global_var(159, fallout.global_var(159) + 1)
        if (fallout.global_var(159) % 7) == 0 then
            fallout.set_global_var(155, fallout.global_var(155) - 1)
        end
    end
end

function look_at_p_proc()
    if fallout.local_var(0) == 0 then
        if fallout.get_critter_stat(fallout.self_obj(), 34) == 0 then
            fallout.set_local_var(0, fallout.random(100, 104))
        else
            fallout.set_local_var(0, fallout.random(105, 109))
        end
    end
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(263, fallout.local_var(0)))
end

function talk_p_proc()
    fallout.script_overrides()
    if fallout.local_var(1) or fallout.global_var(256) then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(669, fallout.random(100, 105)), 0)
    else
        fallout.start_gdialog(263, fallout.self_obj(), 4, -1, -1)
        fallout.gsay_start()
        if fallout.global_var(133) == 1 then
            Scout16()
        else
            if fallout.global_var(133) == 2 then
                Scout22()
            else
                Scout0()
            end
        end
        fallout.gsay_end()
        fallout.end_dialogue()
    end
end

function Scout0()
    fallout.gsay_reply(263, 110)
    fallout.giq_option(-3, 263, 111, Scout1, 50)
    fallout.giq_option(4, 263, fallout.message_str(263, 112) .. fallout.proto_data(fallout.obj_pid(fallout.dude_obj()), 1) .. fallout.message_str(263, 113), Scout4, 50)
    fallout.giq_option(4, 263, fallout.message_str(263, 114) .. fallout.proto_data(fallout.obj_pid(fallout.dude_obj()), 1) .. fallout.message_str(263, 115), combat, 50)
    fallout.giq_option(6, 263, 116, Scout11, 50)
end

function Scout1()
    fallout.gsay_reply(263, 117)
    fallout.giq_option(-3, 263, fallout.message_str(263, 118) .. fallout.proto_data(fallout.obj_pid(fallout.dude_obj()), 1) .. fallout.message_str(263, 119), combat, 50)
    fallout.giq_option(-3, 263, fallout.message_str(263, 120) .. fallout.proto_data(fallout.obj_pid(fallout.dude_obj()), 1) .. fallout.message_str(263, 121), Scout2, 50)
    fallout.giq_option(-3, 263, fallout.message_str(263, 122), Scout3, 50)
    fallout.giq_option(-3, 263, fallout.message_str(263, 123) .. fallout.proto_data(fallout.obj_pid(fallout.dude_obj()), 1) .. fallout.message_str(263, 124), Scout3, 50)
end

function Scout2()
    fallout.gsay_message(263, 125, 50)
end

function Scout3()
    fallout.gsay_message(263, 126, 50)
end

function Scout4()
    fallout.gsay_reply(263, 127)
    fallout.giq_option(4, 263, 128, Scout5, 50)
    fallout.giq_option(4, 263, 129, combat, 50)
    fallout.giq_option(4, 263, 130, Scout6, 50)
    fallout.giq_option(4, 263, 131, Scout10, 50)
end

function Scout5()
    fallout.gsay_message(263, 132, 50)
end

function Scout6()
    fallout.gsay_reply(263, 133)
    fallout.giq_option(4, 263, 134, Scout5, 50)
    fallout.giq_option(4, 263, 135, Scout7, 50)
    fallout.giq_option(4, 263, 136, Scout9, 50)
    fallout.giq_option(4, 263, 137, Scout8, 50)
end

function Scout7()
    fallout.gsay_reply(263, 138)
    fallout.giq_option(4, 263, 139, Scout5, 50)
    fallout.giq_option(4, 263, 140, Scout8, 50)
end

function Scout8()
    fallout.gsay_message(263, 141, 50)
end

function Scout9()
    fallout.gsay_reply(263, 142)
    fallout.giq_option(4, 263, 143, ScoutEnd, 50)
end

function Scout10()
    fallout.gsay_reply(263, 144)
    fallout.giq_option(4, 263, 145, Scout5, 50)
    fallout.giq_option(4, 263, 146, Scout8, 50)
    fallout.giq_option(4, 263, 147, Scout6, 50)
end

function Scout11()
    fallout.gsay_reply(263, 148)
    fallout.giq_option(6, 263, 149, ScoutEnd, 50)
    fallout.giq_option(6, 263, 150, Scout12, 50)
    fallout.giq_option(6, 263, 151, Scout15, 50)
end

function Scout12()
    fallout.gsay_reply(263, 152)
    fallout.giq_option(6, 263, 153, ScoutEnd, 50)
    fallout.giq_option(6, 263, 154, Scout13, 50)
    fallout.giq_option(6, 263, 155, Scout14, 50)
end

function Scout13()
    fallout.gsay_reply(263, 156)
    fallout.giq_option(6, 263, 157, ScoutEnd, 50)
    fallout.giq_option(6, 263, 158, combat, 50)
end

function Scout14()
    fallout.gsay_message(263, 159, 50)
end

function Scout15()
    fallout.gsay_reply(263, 160)
    fallout.giq_option(6, 263, 161, ScoutEnd, 50)
end

function Scout16()
    fallout.gsay_reply(263, 162)
    fallout.giq_option(4, 263, 163, Scout17, 50)
    fallout.giq_option(4, 263, 164, Scout19, 50)
    fallout.giq_option(6, 263, 165, Scout16a, 50)
end

function Scout16a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, -10)) then
        Scout20()
    else
        Scout21()
    end
end

function Scout17()
    fallout.gsay_reply(263, 166)
    fallout.giq_option(4, 263, 167, Scout18, 50)
    fallout.giq_option(4, 263, 168, ScoutEnd, 50)
    fallout.giq_option(4, 263, 169, combat, 50)
end

function Scout18()
    fallout.gsay_reply(263, 170)
    fallout.giq_option(4, 263, 171, ScoutEnd, 50)
end

function Scout19()
    fallout.gsay_message(263, 172, 50)
    combat()
end

function Scout20()
    fallout.gsay_message(263, 173, 50)
end

function Scout21()
    fallout.gsay_message(263, 174, 50)
    combat()
end

function Scout22()
    fallout.gsay_reply(263, 175)
    fallout.giq_option(4, 263, 176, ScoutEnd, 50)
    if fallout.global_var(132) == 0 then
        fallout.giq_option(4, 263, 177, Scout23, 50)
    end
end

function Scout23()
    local v0 = 0
    v0 = 4 * 3600
    fallout.set_global_var(132, 1)
    fallout.gsay_reply(263, 178)
    fallout.game_time_advance(fallout.game_ticks(v0))
    fallout.gfade_out(400)
    fallout.gfade_in(400)
    fallout.giq_option(4, 263, 179, ScoutEnd, 50)
end

function combat()
    hostile = 1
end

function ScoutEnd()
end

function damage_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.set_local_var(1, 1)
    end
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
exports.talk_p_proc = talk_p_proc
exports.damage_p_proc = damage_p_proc
return exports
