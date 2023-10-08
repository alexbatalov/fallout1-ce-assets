local fallout = require("fallout")
local reputation = require("lib.reputation")

local start
local combat
local critter_p_proc
local pickup_p_proc
local talk_p_proc
local destroy_p_proc
local look_at_p_proc
local do_dialogue
local goto00
local goto00b
local goto01
local goto02
local goto03
local goto04
local goto05
local goto06

local hostile = 0
local only_once = 1
local rndx = 0

function start()
    if only_once then
        only_once = 0
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 44)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 64)
    end
    if fallout.script_action() == 21 then
        look_at_p_proc()
    else
        if fallout.script_action() == 4 then
            pickup_p_proc()
        else
            if fallout.script_action() == 12 then
                critter_p_proc()
            else
                if fallout.script_action() == 11 then
                    talk_p_proc()
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
    end
end

function pickup_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        hostile = 1
    end
end

function talk_p_proc()
    if fallout.local_var(0) then
        goto05()
    else
        if fallout.local_var(1) == 0 then
            do_dialogue()
        else
            goto06()
        end
    end
end

function destroy_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.set_global_var(250, 1)
    end
    fallout.rm_timer_event(fallout.self_obj())
    reputation.inc_good_critter()
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(770, 100))
end

function do_dialogue()
    fallout.start_gdialog(770, fallout.self_obj(), 4, -1, -1)
    fallout.gsay_start()
    goto00()
    fallout.gsay_end()
    fallout.end_dialogue()
end

function goto00()
    fallout.gsay_reply(770, 101)
    fallout.giq_option(4, 770, 102, goto02, 50)
    fallout.giq_option(4, 770, 103, goto00b, 50)
    fallout.giq_option(-3, 770, 104, goto01, 50)
end

function goto00b()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        goto03()
    else
        goto04()
    end
end

function goto01()
    fallout.gsay_message(770, 105, 50)
end

function goto02()
    fallout.set_local_var(1, 1)
    fallout.critter_mod_skill(fallout.dude_obj(), 2, 5)
    fallout.game_time_advance(fallout.game_ticks(1800))
    fallout.gsay_message(770, 106, 50)
end

function goto03()
    fallout.set_local_var(1, 1)
    fallout.critter_mod_skill(fallout.dude_obj(), 2, 5)
    fallout.game_time_advance(fallout.game_ticks(1800))
    fallout.gsay_message(770, 107, 50)
end

function goto04()
    fallout.set_local_var(0, 1)
    fallout.gsay_message(770, 108, 50)
end

function goto05()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(770, 109), 2)
end

function goto06()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(770, fallout.random(216, 223)), 2)
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
return exports
