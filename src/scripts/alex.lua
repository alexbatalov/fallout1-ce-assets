local fallout = require("fallout")
local behaviour = require("lib.behaviour")
local misc = require("lib.misc")
local reputation = require("lib.reputation")

local start
local critter_p_proc
local destroy_p_proc
local look_at_p_proc
local talk_p_proc
local Alex01
local Alex02
local Alex03
local Alex04
local Alex05
local Alex06
local Alex07

local night_person = false
local wake_time = 0
local sleep_time = 0
local home_tile = 0
local sleep_tile = 0
local hostile = false
local initialized = false

function start()
    if not initialized then
        local self_obj = fallout.self_obj()
        misc.set_team(self_obj, 49)
        sleep_tile = 14275
        home_tile = 11300
        wake_time = 2030
        sleep_time = 730
        night_person = true
        if fallout.obj_is_carrying_obj_pid(self_obj, 41) == 0 then
            fallout.item_caps_adjust(self_obj, fallout.random(0, 20))
        end
        initialized = true
    end

    local script_action = fallout.script_action()
    if script_action == 12 then
        critter_p_proc()
    elseif script_action == 18 then
        destroy_p_proc()
    elseif script_action == 21 then
        look_at_p_proc()
    elseif script_action == 11 then
        talk_p_proc()
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
            if fallout.local_var(0) == 0 then
                if fallout.tile_distance_objs(self_obj, dude_obj) < 12 then
                    fallout.dialogue_system_enter()
                end
            end
            local dude_tile_num = fallout.tile_num(dude_obj)
            if fallout.tile_distance(dude_tile_num, 10700) > fallout.tile_distance(dude_tile_num, 11900) then
                if fallout.global_var(128) < 2 then
                    hostile = true
                end
            end
        end
    else
        behaviour.sleeping(1, night_person, wake_time, sleep_time, home_tile, sleep_tile)
    end
end

function destroy_p_proc()
    reputation.inc_good_critter()
end

function look_at_p_proc()
    if fallout.local_var(0) ~= 0 then
        fallout.script_overrides()
        fallout.display_msg(fallout.message_str(670, 100))
    end
end

function talk_p_proc()
    if fallout.global_var(128) == 2 then
        fallout.float_msg(fallout.self_obj(),
            fallout.message_str(670, 101) .. fallout.proto_data(fallout.obj_pid(fallout.dude_obj()), 1), 0)
    else
        if fallout.local_var(0) ~= 0 then
            Alex01()
        else
            fallout.start_gdialog(670, fallout.self_obj(), 4, -1, -1)
            fallout.gsay_start()
            Alex02()
            fallout.gsay_end()
            fallout.end_dialogue()
        end
    end
end

function Alex01()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(670, 102), 0)
end

function Alex02()
    fallout.set_local_var(0, 1)
    fallout.gsay_reply(670, 103)
    fallout.giq_option(4, 670, 104, Alex03, 50)
    fallout.giq_option(4, 670, 105, Alex05, 51)
    fallout.giq_option(4, 670, 106, Alex06, 50)
    fallout.giq_option(-3, 670, 114, Alex06, 50)
end

function Alex03()
    fallout.gsay_reply(670, 107)
    fallout.giq_option(4, 670, 108, Alex04, 50)
    fallout.giq_option(4, 670, 106, Alex06, 50)
end

function Alex04()
    fallout.gsay_message(670, 109, 50)
end

function Alex05()
    fallout.gsay_reply(670, 110)
    fallout.giq_option(4, 670, 106, Alex06, 50)
    fallout.giq_option(4, 670, 111, Alex07, 50)
end

function Alex06()
    fallout.gsay_message(670, 112, 50)
end

function Alex07()
    hostile = true
    fallout.gsay_message(670, 113, 51)
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
exports.talk_p_proc = talk_p_proc
return exports
