local fallout = require("fallout")
local reputation = require("lib.reputation")

local start
local critter_p_proc
local destroy_p_proc
local map_enter_p_proc
local talk_p_proc
local timed_event_p_proc

local home_tile = 7000
local hostile = 0
local sfx_name = 0

function start()
    if fallout.script_action() == 12 then
        critter_p_proc()
    else
        if fallout.script_action() == 18 then
            destroy_p_proc()
        else
            if fallout.script_action() == 11 then
                talk_p_proc()
            else
                if fallout.script_action() == 22 then
                    timed_event_p_proc()
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
        if fallout.external_var("Saul_loses") then
            if (fallout.obj_pid(fallout.external_var("challenger_ptr")) == 16777227) or (fallout.obj_pid(fallout.external_var("challenger_ptr")) == 16777226) then
                if fallout.external_var("shot_challenger") == 0 then
                    fallout.set_external_var("Saul_loses", 0)
                    fallout.anim(fallout.self_obj(), 1000, 5)
                    fallout.float_msg(fallout.self_obj(), fallout.message_str(835, fallout.random(100, 103)), 0)
                    fallout.reg_anim_func(2, fallout.self_obj())
                    fallout.reg_anim_func(1, 1)
                    fallout.reg_anim_animate(fallout.self_obj(), 43, -1)
                    fallout.reg_anim_animate(fallout.self_obj(), 45, -1)
                    sfx_name = fallout.sfx_build_weapon_name(1, fallout.obj_carrying_pid_obj(fallout.self_obj(), 8), 2, fallout.external_var("challenger_ptr"))
                    fallout.reg_anim_play_sfx(fallout.dude_obj(), sfx_name, -1)
                    fallout.reg_anim_animate(fallout.external_var("challenger_ptr"), 14, 4)
                    fallout.reg_anim_animate(fallout.self_obj(), 43, -1)
                    fallout.reg_anim_animate(fallout.self_obj(), 45, -1)
                    sfx_name = fallout.sfx_build_weapon_name(1, fallout.obj_carrying_pid_obj(fallout.self_obj(), 8), 2, fallout.external_var("challenger_ptr"))
                    fallout.reg_anim_play_sfx(fallout.dude_obj(), sfx_name, -1)
                    fallout.reg_anim_animate(fallout.external_var("challenger_ptr"), 34, 4)
                    fallout.reg_anim_animate(fallout.self_obj(), 44, -1)
                    fallout.reg_anim_func(3, 0)
                    fallout.rm_timer_event(fallout.self_obj())
                    fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(5), 1)
                end
            else
                fallout.set_external_var("shot_challenger", 1)
            end
        else
            if fallout.external_var("Saul_wins") then
                fallout.set_external_var("shot_challenger", 1)
            end
        end
    end
end

function destroy_p_proc()
    reputation.inc_evil_critter()
end

function map_enter_p_proc()
    if fallout.global_var(15) == 1 then
        fallout.kill_critter(fallout.self_obj(), 49)
    end
    if fallout.local_var(0) == 0 then
        fallout.set_local_var(0, fallout.tile_num(fallout.self_obj()))
    end
    home_tile = fallout.local_var(0)
    fallout.critter_add_trait(fallout.self_obj(), 1, 6, 25)
    if fallout.item_caps_total(fallout.self_obj()) == 0 then
        fallout.item_caps_adjust(fallout.self_obj(), fallout.random(10, 25))
    end
end

function talk_p_proc()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(835, fallout.random(106, 107)), 0)
end

function timed_event_p_proc()
    fallout.set_external_var("Saul_loses", 1)
    fallout.set_external_var("shot_challenger", 1)
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.map_enter_p_proc = map_enter_p_proc
exports.talk_p_proc = talk_p_proc
exports.timed_event_p_proc = timed_event_p_proc
return exports
