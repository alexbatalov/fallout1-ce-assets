local fallout = require("fallout")
local misc = require("lib.misc")
local reputation = require("lib.reputation")

local start
local critter_p_proc
local damage_p_proc
local destroy_p_proc
local pickup_p_proc
local talk_p_proc
local timed_event_p_proc
local GenSupr00
local GenSupr03
local GenSupr03a
local GenSupr03b
local GenSupr04
local GenSupr05
local GenSupr06
local GenSupr07
local GenSupr08
local GenSuprAlert
local GenSuprxx

local initialized = false
local hostile = false

function start()
    if not initialized then
        local self_obj = fallout.self_obj()
        misc.set_team(self_obj, 34)
        misc.set_ai(self_obj, 48)
        initialized = true
    end

    local script_action = fallout.script_action()
    if script_action == 12 then
        critter_p_proc()
    elseif script_action == 14 then
        damage_p_proc()
    elseif script_action == 18 then
        destroy_p_proc()
    elseif script_action == 4 then
        pickup_p_proc()
    elseif script_action == 11 then
        talk_p_proc()
    elseif script_action == 22 then
        timed_event_p_proc()
    end
end

function critter_p_proc()
    local self_obj = fallout.self_obj()
    local dude_obj = fallout.dude_obj()
    if fallout.obj_can_see_obj(self_obj, dude_obj) then
        if hostile then
            hostile = false
            fallout.attack(dude_obj, 0, 1, 0, 0, 30000, 0, 0)
        else
            if fallout.global_var(146) ~= 0 then
                hostile = true
            else
                if fallout.external_var("ignoring_dude") == 0 then
                    if fallout.tile_distance_objs(self_obj, dude_obj) < 12 then
                        fallout.dialogue_system_enter()
                    end
                end
            end
        end
    end
    if fallout.global_var(273) >= 1 and fallout.global_var(273) <= 3 then
        fallout.set_external_var("valid_target", self_obj)
    end
end

function damage_p_proc()
    fallout.set_map_var(13, 1)
end

function destroy_p_proc()
    reputation.inc_evil_critter()
    fallout.set_map_var(12, 3)
end

function pickup_p_proc()
    hostile = true
end

function talk_p_proc()
    if fallout.global_var(54) ~= 0 then
        GenSupr08()
    else
        if misc.is_armed(fallout.dude_obj()) and not hostile then
            if fallout.random(0, 5) == 5 then
                GenSupr00()
            else
                hostile = true
            end
        else
            fallout.start_gdialog(433, fallout.self_obj(), 4, -1, -1)
            fallout.gsay_start()
            GenSupr03()
            fallout.gsay_end()
            fallout.end_dialogue()
        end
    end
end

function timed_event_p_proc()
    hostile = true
end

function GenSupr00()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(433, fallout.random(101, 103)), 2)
    hostile = true
end

function GenSupr03()
    fallout.gsay_reply(433, fallout.random(104, 106))
    fallout.giq_option(-3, 433, 107, GenSupr04, 51)
    fallout.giq_option(4, 433, 108, GenSupr04, 51)
    fallout.giq_option(5, 433, 109, GenSupr05, 50)
    fallout.giq_option(6, 433, 110, GenSupr03a, 50)
    if misc.is_wearing_coc_robe(fallout.dude_obj()) then
        fallout.giq_option(6, 433, 111, GenSupr03b, 50)
    end
end

function GenSupr03a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        GenSupr07()
    else
        GenSupr06()
    end
end

function GenSupr03b()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 25)) then
        GenSupr07()
    else
        GenSupr06()
    end
end

function GenSupr04()
    hostile = true
    fallout.gsay_message(433, fallout.random(112, 114), 51)
end

function GenSupr05()
    fallout.gsay_reply(433, 115)
    fallout.giq_option(5, 433, 116, GenSuprxx, 50)
    fallout.giq_option(5, 433, 117, GenSuprAlert, 51)
end

function GenSupr06()
    hostile = true
    fallout.gsay_message(433, fallout.random(118, 120), 51)
end

function GenSupr07()
    fallout.set_external_var("ignoring_dude", 1)
    fallout.gsay_message(433, fallout.random(121, 123), 50)
end

function GenSupr08()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(433, fallout.random(124, 127)), 2)
    hostile = true
end

function GenSuprAlert()
    fallout.set_global_var(146, 1)
    fallout.use_obj(fallout.external_var("radio_computer"))
    fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(5), 1)
end

function GenSuprxx()
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.damage_p_proc = damage_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.timed_event_p_proc = timed_event_p_proc
return exports
