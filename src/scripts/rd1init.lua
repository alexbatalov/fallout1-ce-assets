local fallout = require("fallout")
local misc = require("lib.misc")
local reputation = require("lib.reputation")

local start
local critter_p_proc
local pickup_p_proc
local talk_p_proc
local destroy_p_proc
local look_at_p_proc
local goto00
local goto01
local goto02
local goto03
local goto04
local goto05
local goto06
local goto07
local gotoend
local dialog_end
local do_dialog

local hostile = false
local initialized = false

function start()
    if not initialized then
        local self_obj = fallout.self_obj()
        misc.set_team(self_obj, 44)
        fallout.critter_add_trait(self_obj, 1, 5, 62)
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
    end
end

function pickup_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        hostile = true
    end
end

function talk_p_proc()
    if fallout.local_var(4) > 0 then
        goto07()
    else
        fallout.start_gdialog(691, fallout.self_obj(), 4, -1, -1)
        fallout.gsay_start()
        do_dialog()
        fallout.gsay_end()
        fallout.end_dialogue()
    end
end

function destroy_p_proc()
    fallout.set_global_var(250, 1)
    fallout.rm_timer_event(fallout.self_obj())
    reputation.inc_good_critter()
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(691, 100))
end

function goto00()
    fallout.gsay_reply(691,
        fallout.message_str(691, 103) ..
        fallout.proto_data(fallout.obj_pid(fallout.dude_obj()), 1) .. fallout.message_str(691, 104))
    fallout.giq_option(4, 691, 105, goto03, 50)
    fallout.giq_option(4, 691, 106, goto01, 50)
    fallout.giq_option(4, 691, 107, goto02, 50)
    fallout.giq_option(-3, 691, 108, goto04, 50)
end

function goto01()
    fallout.gsay_reply(691, 109)
    fallout.giq_option(4, 691, 110, goto06, 50)
    fallout.giq_option(4, 691, 111, goto05, 50)
end

function goto02()
    fallout.gsay_reply(691, 112)
    fallout.giq_option(4, 691, 110, goto06, 50)
    fallout.giq_option(4, 691, 111, goto05, 50)
end

function goto03()
    fallout.gsay_reply(691, 113)
    fallout.giq_option(4, 691, 114, goto04, 50)
end

function goto04()
    fallout.gsay_message(691, 115, 50)
    dialog_end()
end

function goto05()
    fallout.gsay_message(691, 116, 50)
    dialog_end()
end

function goto06()
    fallout.gsay_message(691, 117, 50)
    dialog_end()
end

function goto07()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(691, fallout.random(118, 125)), 2)
end

function gotoend()
end

function dialog_end()
end

function do_dialog()
    fallout.set_local_var(4, 1)
    goto00()
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
return exports
