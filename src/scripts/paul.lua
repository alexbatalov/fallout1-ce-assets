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
local Paul01
local Paul02
local Paul03
local Paul04
local Paul05
local Paul06
local Paul07
local Paul08
local Paul09
local Paul10
local Paul11
local Paul12
local Paul13
local Paul14
local Paul15
local PaulEnd

local hostile = false
local initialized = false

function start()
    if not initialized then
        local self_obj = fallout.self_obj()
        fallout.critter_add_trait(self_obj, 1, 6, 44)
        fallout.critter_add_trait(self_obj, 1, 5, 64)
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

function combat()
    hostile = true
end

function critter_p_proc()
    if hostile then
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
    reaction.get_reaction()
    fallout.start_gdialog(865, fallout.self_obj(), 4, -1, -1)
    fallout.gsay_start()
    if fallout.local_var(4) == 0 then
        fallout.set_local_var(4, 1)
        Paul01()
    else
        Paul14()
    end
    fallout.gsay_end()
    fallout.end_dialogue()
end

function destroy_p_proc()
    reputation.inc_good_critter()
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(865, 100))
end

function Paul01()
    fallout.gsay_reply(865, 101)
    fallout.giq_option(4, 865, 102, Paul02, 50)
    fallout.giq_option(4, 865, 103, Paul04, 50)
    if fallout.map_var(0) == 1 then
        fallout.giq_option(4, 865, 104, Paul07, 50)
    end
    if fallout.global_var(30) ~= 1 then
        fallout.giq_option(4, 865, 105, Paul09, 50)
    end
    if fallout.global_var(304) == 1 then
        fallout.giq_option(4, 865, 106, Paul12, 50)
    end
    fallout.giq_option(4, 865, 108, PaulEnd, 50)
    fallout.giq_option(-3, 865, 107, Paul15, 50)
end

function Paul02()
    fallout.gsay_reply(865, 109)
    fallout.giq_option(4, 865, 110, Paul03, 50)
    if fallout.map_var(0) == 1 then
        fallout.giq_option(4, 865, 111, Paul07, 50)
    end
end

function Paul03()
    fallout.gsay_reply(865, 112)
    fallout.giq_option(4, 865, 113, Paul04, 50)
    fallout.giq_option(4, 865, 114, PaulEnd, 50)
end

function Paul04()
    fallout.gsay_reply(865, 115)
    fallout.giq_option(4, 865, 116, Paul05, 50)
    fallout.giq_option(4, 865, 117, PaulEnd, 50)
end

function Paul05()
    fallout.gsay_reply(865, 118)
    fallout.giq_option(4, 865, 119, Paul06, 50)
    fallout.giq_option(4, 865, 120, PaulEnd, 50)
end

function Paul06()
    fallout.gsay_reply(865, 121)
    fallout.giq_option(4, 865, 122, Paul04, 50)
    if fallout.global_var(30) ~= 1 then
        fallout.giq_option(4, 865, 123, Paul09, 50)
    end
    if fallout.global_var(304) == 1 then
        fallout.giq_option(4, 865, 124, Paul12, 50)
    end
    if fallout.map_var(0) == 1 then
        fallout.giq_option(4, 865, 125, Paul07, 50)
    end
    fallout.giq_option(4, 865, 126, PaulEnd, 50)
end

function Paul07()
    fallout.gsay_reply(865, 127)
    fallout.giq_option(4, 865, 128, Paul08, 50)
    fallout.giq_option(4, 865, 129, Paul11, 50)
end

function Paul08()
    fallout.gsay_reply(865, 130)
    fallout.giq_option(4, 865, 131, Paul05, 50)
    fallout.giq_option(4, 865, 132, PaulEnd, 50)
    fallout.giq_option(4, 865, 133, Paul06, 50)
end

function Paul09()
    fallout.gsay_reply(865, 134)
    fallout.giq_option(4, 865, 135, Paul10, 50)
end

function Paul10()
    fallout.gsay_reply(865, 136)
    fallout.giq_option(4, 865, 138, Paul06, 50)
    fallout.giq_option(4, 865, 137, PaulEnd, 50)
end

function Paul11()
    fallout.gsay_reply(865, 139)
    fallout.giq_option(4, 865, 140, Paul08, 50)
end

function Paul12()
    fallout.gsay_reply(865, 141)
    fallout.giq_option(4, 865, 142, Paul13, 50)
    fallout.giq_option(4, 865, 143, PaulEnd, 50)
end

function Paul13()
    fallout.gsay_reply(865, 144)
    fallout.giq_option(4, 865, 146, Paul06, 50)
    fallout.giq_option(4, 865, 145, PaulEnd, 50)
end

function Paul14()
    fallout.gsay_reply(865,
        fallout.message_str(865, 147) ..
        fallout.proto_data(fallout.obj_pid(fallout.dude_obj()), 1) .. fallout.message_str(865, 148))
    fallout.giq_option(4, 865, 149, Paul02, 50)
    fallout.giq_option(4, 865, 150, Paul04, 50)
    if fallout.map_var(0) == 1 then
        fallout.giq_option(4, 865, 151, Paul07, 50)
    end
    if fallout.global_var(30) ~= 1 then
        fallout.giq_option(4, 865, 152, Paul09, 50)
    end
    if fallout.global_var(304) == 1 then
        fallout.giq_option(4, 865, 153, Paul12, 50)
    end
    fallout.giq_option(4, 865, 155, PaulEnd, 50)
    fallout.giq_option(-3, 865, 154, Paul15, 50)
end

function Paul15()
    fallout.gsay_message(865, 156, 50)
end

function PaulEnd()
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
return exports
