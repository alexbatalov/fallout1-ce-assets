local fallout = require("fallout")

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
local sleeping

local night_person = 0
local wake_time = 0
local sleep_time = 0
local home_tile = 0
local sleep_tile = 0
local hostile = 0
local initialized = 0

function start()
    if not(initialized) then
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 49)
        sleep_tile = 14275
        home_tile = 11300
        wake_time = 2030
        sleep_time = 730
        night_person = 1
        if fallout.obj_is_carrying_obj_pid(fallout.self_obj(), 41) == 0 then
            fallout.item_caps_adjust(fallout.self_obj(), fallout.random(0, 20))
        end
        initialized = 1
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
    if fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) then
        if hostile then
            hostile = 0
            fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
        else
            if fallout.local_var(0) == 0 then
                if fallout.tile_distance_objs(fallout.self_obj(), fallout.dude_obj()) < 12 then
                    fallout.dialogue_system_enter()
                end
            end
            if fallout.tile_distance(fallout.tile_num(fallout.dude_obj()), 10700) > fallout.tile_distance(fallout.tile_num(fallout.dude_obj()), 11900) then
                if fallout.global_var(128) < 2 then
                    hostile = 1
                end
            end
        end
    else
        sleeping()
    end
end

function destroy_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1)) then
            fallout.set_global_var(156, 1)
            fallout.set_global_var(157, 0)
        end
        if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(160) > (3 * fallout.global_var(159))) or (fallout.global_var(157) == 1)) then
            fallout.set_global_var(157, 1)
            fallout.set_global_var(156, 0)
        end
        fallout.set_global_var(159, fallout.global_var(159) + 1)
        if (fallout.global_var(159) % 2) == 0 then
            fallout.set_global_var(155, fallout.global_var(155) - 1)
        end
    end
end

function look_at_p_proc()
    if fallout.local_var(0) then
        fallout.script_overrides()
        fallout.display_msg(fallout.message_str(670, 100))
    end
end

function talk_p_proc()
    if fallout.global_var(128) == 2 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(670, 101) .. fallout.proto_data(fallout.obj_pid(fallout.dude_obj()), 1), 0)
    else
        if fallout.local_var(0) then
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
    hostile = 1
    fallout.gsay_message(670, 113, 51)
end

function sleeping()
    if fallout.local_var(1) == 1 then
        if not(night_person) and (fallout.game_time_hour() >= wake_time) and (fallout.game_time_hour() < sleep_time) or (night_person and ((fallout.game_time_hour() >= wake_time) or (fallout.game_time_hour() < sleep_time))) then
            if ((fallout.game_time_hour() - wake_time) < 10) and ((fallout.game_time_hour() - wake_time) > 0) then
                if fallout.tile_num(fallout.self_obj()) ~= home_tile then
                    fallout.animate_move_obj_to_tile(fallout.self_obj(), home_tile, 0)
                else
                    fallout.set_local_var(1, 0)
                end
            else
                fallout.move_to(fallout.self_obj(), home_tile, fallout.elevation(fallout.self_obj()))
                if fallout.tile_num(fallout.self_obj()) == home_tile then
                    fallout.set_local_var(1, 0)
                end
            end
        end
    else
        if night_person and (fallout.game_time_hour() >= sleep_time) and (fallout.game_time_hour() < wake_time) or (not(night_person) and ((fallout.game_time_hour() >= sleep_time) or (fallout.game_time_hour() < wake_time))) then
            if ((fallout.game_time_hour() - sleep_time) < 10) and ((fallout.game_time_hour() - sleep_time) > 0) then
                if fallout.tile_num(fallout.self_obj()) ~= sleep_tile then
                    fallout.animate_move_obj_to_tile(fallout.self_obj(), fallout.self_obj(), 0)
                else
                    fallout.set_local_var(1, 1)
                end
            else
                if fallout.tile_num(fallout.self_obj()) ~= sleep_tile then
                    fallout.move_to(fallout.self_obj(), sleep_tile, fallout.elevation(fallout.self_obj()))
                else
                    fallout.set_local_var(1, 1)
                end
            end
        end
    end
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
exports.talk_p_proc = talk_p_proc
return exports
