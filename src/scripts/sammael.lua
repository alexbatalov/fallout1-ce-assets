local fallout = require("fallout")
local reputation = require("lib.reputation")

local start
local critter_p_proc
local damage_p_proc
local destroy_p_proc
local look_at_p_proc
local pickup_p_proc
local talk_p_proc
local Sammael01
local Sammael02
local Sammael03
local Sammael04
local Sammael05
local Sammael06
local Sammael07
local Sammael08
local Sammael09
local Sammael10
local Sammael11
local Sammael12
local Sammael13
local Sammael14
local Sammael15

local hostile = 0
local initialized = false

function start()
    if not initialized then
        if (fallout.global_var(613) == 9103) or (fallout.global_var(613) == 9102) then
            fallout.critter_add_trait(fallout.self_obj(), 1, 6, 0)
        else
            fallout.critter_add_trait(fallout.self_obj(), 1, 6, 49)
        end
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 29)
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
                    if fallout.script_action() == 4 then
                        pickup_p_proc()
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
    if hostile then
        hostile = 0
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    else
        if fallout.tile_distance_objs(fallout.dude_obj(), fallout.self_obj()) > fallout.get_critter_stat(fallout.dude_obj(), 1) then
            fallout.set_obj_visibility(fallout.self_obj(), 1)
        else
            fallout.set_obj_visibility(fallout.self_obj(), 0)
        end
    end
end

function damage_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.set_global_var(251, 1)
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 49)
    end
end

function destroy_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.set_global_var(251, 1)
        reputation.inc_good_critter()
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 49)
    end
end

function look_at_p_proc()
    fallout.script_overrides()
    if fallout.local_var(4) then
        fallout.display_msg(fallout.message_str(254, 100))
    else
        fallout.display_msg(fallout.message_str(254, 101))
    end
end

function pickup_p_proc()
    fallout.set_global_var(251, 1)
end

function talk_p_proc()
    fallout.start_gdialog(254, fallout.self_obj(), 4, -1, -1)
    fallout.gsay_start()
    if fallout.local_var(4) then
        Sammael14()
    else
        Sammael01()
    end
    fallout.gsay_end()
    fallout.end_dialogue()
end

function Sammael01()
    fallout.gsay_reply(254, 102)
    fallout.giq_option(4, 254, fallout.message_str(254, 103) .. fallout.proto_data(fallout.obj_pid(fallout.dude_obj()), 1) .. fallout.message_str(254, 104), Sammael02, 50)
    fallout.giq_option(4, 254, 105, Sammael03, 50)
    fallout.giq_option(-3, 254, 106, Sammael15, 50)
end

function Sammael02()
    fallout.set_local_var(4, 1)
    fallout.gsay_reply(254, 107)
    fallout.giq_option(4, 254, 108, Sammael04, 50)
    fallout.giq_option(4, 254, 109, Sammael05, 50)
end

function Sammael03()
    fallout.gsay_message(254, 110, 50)
end

function Sammael04()
    fallout.gsay_reply(254, 111)
    fallout.giq_option(4, 254, 112, Sammael06, 50)
    fallout.giq_option(4, 254, 113, Sammael07, 50)
    fallout.giq_option(6, 254, 114, Sammael08, 50)
    fallout.giq_option(0, 254, 115, Sammael05, 50)
end

function Sammael05()
    fallout.gsay_message(254, 116, 50)
end

function Sammael06()
    fallout.gsay_reply(254, 117)
    fallout.giq_option(4, 254, 118, Sammael07, 50)
    fallout.giq_option(6, 254, 119, Sammael08, 50)
    fallout.giq_option(4, 254, 120, Sammael05, 50)
end

function Sammael07()
    fallout.gsay_message(254, 121, 50)
end

function Sammael08()
    fallout.gsay_reply(254, 122)
    fallout.giq_option(4, 254, 123, Sammael09, 50)
    fallout.giq_option(4, 254, 124, Sammael10, 50)
    fallout.giq_option(4, 254, 125, Sammael11, 50)
    fallout.giq_option(4, 254, 126, Sammael12, 50)
    fallout.giq_option(4, 254, 127, Sammael13, 50)
    fallout.giq_option(4, 254, 128, Sammael05, 50)
end

function Sammael09()
    fallout.gsay_message(254, 129, 50)
    Sammael08()
end

function Sammael10()
    fallout.gsay_message(254, 130, 50)
    fallout.gsay_message(254, 131, 50)
    Sammael08()
end

function Sammael11()
    fallout.gsay_message(254, 132, 50)
    Sammael08()
end

function Sammael12()
    fallout.gsay_message(254, 133, 50)
    Sammael08()
end

function Sammael13()
    fallout.gsay_message(254, 134, 50)
    fallout.gsay_message(254, 135, 50)
    Sammael08()
end

function Sammael14()
    fallout.gsay_reply(254, 136)
    fallout.giq_option(4, 254, 137, Sammael04, 50)
    fallout.giq_option(4, 254, 138, Sammael05, 50)
end

function Sammael15()
    fallout.gsay_message(254, 139, 50)
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.damage_p_proc = damage_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
return exports
