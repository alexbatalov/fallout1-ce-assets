local fallout = require("fallout")
local reputation = require("lib.reputation")

local start
local critter_p_proc
local damage_p_proc
local destroy_p_proc
local look_at_p_proc
local talk_p_proc
local guard0
local guard1
local guard2
local guard3
local guard4
local guard5
local guard6
local guard7
local guard8
local guard9
local guard10
local guard11
local guard12
local guard13
local guard14
local guard15
local guard16
local guard16a
local guard17
local guard18
local guard19
local guard20
local guard21
local guard22
local guard23
local combat
local guardend

local hostile = 0
local initialized = false

function start()
    if not initialized then
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 46)
        if fallout.local_var(0) == 0 then
            if fallout.get_critter_stat(fallout.self_obj(), 34) == 1 then
                fallout.set_local_var(0, fallout.random(100, 104))
            else
                fallout.set_local_var(0, fallout.random(105, 109))
            end
        end
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
            if fallout.script_action() == 14 then
                damage_p_proc()
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
end

function critter_p_proc()
    if fallout.map_var(1) == 1 then
        fallout.animate_move_obj_to_tile(fallout.self_obj(), fallout.tile_num_in_direction(fallout.tile_num(fallout.dude_obj()), fallout.random(0, 6), fallout.random(3, 7)), 0)
    else
        if (fallout.map_var(1) == 2) and fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) then
            hostile = 1
        end
    end
    if fallout.global_var(129) == 2 then
        fallout.set_external_var("removal_ptr", fallout.self_obj())
    end
    if hostile then
        hostile = 0
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    else
        if fallout.tile_distance_objs(fallout.self_obj(), fallout.dude_obj()) < 8 then
            if fallout.local_var(1) or fallout.global_var(256) then
                hostile = 1
            end
        end
    end
end

function damage_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.set_local_var(1, 1)
    end
end

function destroy_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.set_global_var(256, 1)
    end
    reputation.inc_good_critter()
end

function look_at_p_proc()
    fallout.display_msg(fallout.message_str(264, fallout.local_var(0)))
end

function talk_p_proc()
    fallout.script_overrides()
    if fallout.local_var(1) or fallout.global_var(256) then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(669, fallout.random(100, 105)), 0)
    else
        fallout.start_gdialog(264, fallout.self_obj(), 4, -1, -1)
        fallout.gsay_start()
        if fallout.global_var(133) == 1 then
            guard16()
        else
            if fallout.global_var(133) == 2 then
                guard22()
            else
                guard0()
            end
        end
        fallout.gsay_end()
        fallout.end_dialogue()
    end
end

function guard0()
    fallout.gsay_reply(264, 110)
    fallout.giq_option(-3, 264, 111, guard1, 50)
    fallout.giq_option(4, 264, fallout.message_str(264, 112) .. fallout.proto_data(fallout.obj_pid(fallout.dude_obj()), 1) .. fallout.message_str(264, 113), guard4, 50)
    fallout.giq_option(4, 264, fallout.message_str(264, 114) .. fallout.proto_data(fallout.obj_pid(fallout.dude_obj()), 1) .. fallout.message_str(264, 115), combat, 50)
    fallout.giq_option(6, 264, 116, guard11, 50)
end

function guard1()
    fallout.gsay_reply(264, 117)
    fallout.giq_option(-3, 264, fallout.message_str(264, 118) .. fallout.proto_data(fallout.obj_pid(fallout.dude_obj()), 1) .. fallout.message_str(264, 119), combat, 50)
    fallout.giq_option(-3, 264, fallout.message_str(264, 120) .. fallout.proto_data(fallout.obj_pid(fallout.dude_obj()), 1) .. fallout.message_str(264, 121), guard2, 50)
    fallout.giq_option(-3, 264, fallout.message_str(264, 122), guard3, 50)
    fallout.giq_option(-3, 264, fallout.message_str(264, 123) .. fallout.proto_data(fallout.obj_pid(fallout.dude_obj()), 1) .. fallout.message_str(264, 124), guard3, 50)
end

function guard2()
    fallout.gsay_message(264, 125, 50)
end

function guard3()
    fallout.gsay_message(264, 126, 50)
end

function guard4()
    fallout.gsay_reply(264, 127)
    fallout.giq_option(4, 264, 128, guard5, 50)
    fallout.giq_option(4, 264, 129, combat, 50)
    fallout.giq_option(4, 264, 130, guard6, 50)
    fallout.giq_option(4, 264, 131, guard10, 50)
end

function guard5()
    fallout.gsay_message(264, 132, 50)
end

function guard6()
    fallout.gsay_reply(264, 133)
    fallout.giq_option(4, 264, 134, guard5, 50)
    fallout.giq_option(4, 264, 135, guard7, 50)
    fallout.giq_option(4, 264, 136, guard9, 50)
    fallout.giq_option(4, 264, 137, guard8, 50)
end

function guard7()
    fallout.gsay_reply(264, 138)
    fallout.giq_option(4, 264, 139, guard5, 50)
    fallout.giq_option(4, 264, 140, guard8, 50)
end

function guard8()
    fallout.gsay_message(264, 141, 50)
end

function guard9()
    fallout.gsay_reply(264, 142)
    fallout.giq_option(4, 264, 143, guardend, 50)
end

function guard10()
    fallout.gsay_reply(264, 144)
    fallout.giq_option(4, 264, 145, guard5, 50)
    fallout.giq_option(4, 264, 146, guard8, 50)
    fallout.giq_option(4, 264, 147, guard6, 50)
end

function guard11()
    fallout.gsay_reply(264, 148)
    fallout.giq_option(6, 264, 149, guardend, 50)
    fallout.giq_option(6, 264, 150, guard12, 50)
    fallout.giq_option(6, 264, 151, guard15, 50)
end

function guard12()
    fallout.gsay_reply(264, 152)
    fallout.giq_option(6, 264, 153, guardend, 50)
    fallout.giq_option(6, 264, 154, guard13, 50)
    fallout.giq_option(6, 264, 155, guard14, 50)
end

function guard13()
    fallout.gsay_reply(264, 156)
    fallout.giq_option(6, 264, 157, guardend, 50)
    fallout.giq_option(6, 264, 158, combat, 50)
end

function guard14()
    fallout.gsay_message(264, 159, 50)
end

function guard15()
    fallout.gsay_reply(264, 160)
    fallout.giq_option(6, 264, 161, guardend, 50)
end

function guard16()
    fallout.gsay_reply(264, 162)
    fallout.giq_option(4, 264, 163, guard17, 50)
    fallout.giq_option(4, 264, 164, guard19, 50)
    fallout.giq_option(6, 264, 165, guard16a, 50)
end

function guard16a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, -10)) then
        guard20()
    else
        guard21()
    end
end

function guard17()
    fallout.gsay_reply(264, 166)
    fallout.giq_option(4, 264, 167, guard18, 50)
    fallout.giq_option(4, 264, 168, guardend, 50)
    fallout.giq_option(4, 264, 169, combat, 50)
end

function guard18()
    fallout.gsay_reply(264, 170)
    fallout.giq_option(4, 264, 171, guardend, 50)
end

function guard19()
    fallout.gsay_message(264, 172, 50)
    combat()
end

function guard20()
    fallout.gsay_message(264, 173, 50)
end

function guard21()
    fallout.gsay_message(264, 174, 50)
    combat()
end

function guard22()
    fallout.gsay_reply(264, 175)
    fallout.giq_option(4, 264, 176, guardend, 50)
    if fallout.global_var(132) == 0 then
        fallout.giq_option(4, 264, 177, guard23, 50)
    end
end

function guard23()
    local v0 = 0
    v0 = 4 * 3600
    fallout.set_global_var(132, 1)
    fallout.gsay_reply(264, 178)
    fallout.game_time_advance(fallout.game_ticks(v0))
    fallout.gfade_out(400)
    fallout.gfade_in(400)
    fallout.giq_option(4, 264, 179, guardend, 50)
end

function combat()
    hostile = 1
end

function guardend()
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.damage_p_proc = damage_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
exports.talk_p_proc = talk_p_proc
return exports
