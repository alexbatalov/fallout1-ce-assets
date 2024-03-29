local fallout = require("fallout")
local misc = require("lib.misc")
local reaction = require("lib.reaction")
local reputation = require("lib.reputation")

local start
local pickup_p_proc
local talk_p_proc
local critter_p_proc
local damage_p_proc
local destroy_p_proc
local timed_event_p_proc
local look_at_p_proc
local alya00
local alya01
local alya02
local alya03
local alya04
local alya05
local alya06
local alya07
local alya08
local alya09
local alya10
local alyaend
local combat

local hostile = false
local initialized = false

function start()
    if not initialized then
        local self_obj = fallout.self_obj()
        misc.set_team(self_obj, 6)
        misc.set_ai(self_obj, 21)
        initialized = true
    end

    local script_action = fallout.script_action()
    if script_action == 11 then
        talk_p_proc()
    elseif script_action == 22 then
        timed_event_p_proc()
    elseif script_action == 4 then
        pickup_p_proc()
    elseif script_action == 12 then
        critter_p_proc()
    elseif script_action == 21 then
        look_at_p_proc()
    elseif script_action == 14 then
        damage_p_proc()
    elseif script_action == 18 then
        destroy_p_proc()
    end
end

function pickup_p_proc()
    HOSTILE = true
end

function talk_p_proc()
    if fallout.global_var(116) == 1 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(136, fallout.random(102, 106)), 8)
    else
        fallout.set_local_var(3, 1)
        reaction.get_reaction()
        fallout.start_gdialog(143, fallout.self_obj(), 4, -1, -1)
        fallout.gsay_start()
        if fallout.local_var(4) == 5 then
            alya10()
        else
            fallout.set_local_var(4, fallout.local_var(4) + 1)
            alya00()
        end
        fallout.gsay_end()
        fallout.end_dialogue()
    end
end

function critter_p_proc()
    local dude_obj = fallout.dude_obj()
    local self_obj = fallout.self_obj()
    local distance_self_to_dude = fallout.tile_distance_objs(self_obj, dude_obj)
    if fallout.global_var(26) == 2 then
        fallout.set_global_var(254, 1)
    elseif fallout.global_var(116) ~= 0 then
            fallout.set_global_var(254, 0)
            if distance_self_to_dude < 3 then
                local self_tile = fallout.tile_num(self_obj)
                local v0 = fallout.tile_num_in_direction(self_tile, fallout.random(0, 5), 3)
                if fallout.tile_distance(self_tile, v0) > 2 then
                    if fallout.random(0, 9) == 0 then
                        fallout.float_msg(self_obj, fallout.message_str(136, fallout.random(102, 106)), 8)
                    end
                    fallout.animate_move_obj_to_tile(self_obj, v0, 0)
                end
            end
        else
            if fallout.global_var(213) ~= 0 then
                fallout.set_global_var(254, 1)
            end
            if fallout.obj_can_see_obj(self_obj, dude_obj) then
                if fallout.global_var(214) ~= 0 then
                    fallout.set_global_var(254, 1)
                end
            end
            if fallout.map_var(2) == 1 then
                fallout.set_global_var(254, 1)
            end
    end
    if fallout.global_var(254) and fallout.obj_can_see_obj(self_obj, dude_obj) then
        hostile = true
    end
    if distance_self_to_dude > 12 then
        hostile = false
    end
    if hostile then
        hostile = false
        fallout.attack(dude_obj, 0, 1, 0, 0, 30000, 0, 0)
    end
end

function damage_p_proc()
    if fallout.global_var(116) == 0 then
        fallout.set_global_var(254, 1)
    end
end

function destroy_p_proc()
    reputation.inc_evil_critter()
    fallout.set_global_var(254, 1)
    fallout.set_global_var(611, 0)
    fallout.set_global_var(115, fallout.global_var(115) - 1)
end

function timed_event_p_proc()
    if fallout.tile_distance_objs(fallout.self_obj(), fallout.dude_obj()) < 8 then
        combat()
    end
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(143, 100))
end

function alya00()
    fallout.gsay_reply(143, 101)
    if fallout.global_var(103) == 1 and fallout.global_var(218) == 1 then
        fallout.giq_option(4, 143, 102, alya01, 50)
    end
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        fallout.giq_option(4, 143, 103, alya02, 50)
    end
    fallout.giq_option(4, 143, 104, alya03, 50)
    fallout.giq_option(4, 143, 105, alyaend, 50)
    fallout.giq_option(-3, 143, 106, alya05, 50)
end

function alya01()
    fallout.gsay_message(143, 107, 50)
end

function alya02()
    fallout.gsay_message(143, 108, 50)
    combat()
end

function alya03()
    fallout.gsay_reply(143, 109)
    fallout.giq_option(4, 143, 110, alya04, 50)
    fallout.giq_option(4, 143, 111, alya09, 50)
    fallout.giq_option(4, 143, 112, alyaend, 50)
end

function alya04()
    fallout.gsay_reply(143, 113)
    fallout.giq_option(4, 143, 114, alya06, 50)
    fallout.giq_option(4, 143, 115, alya08, 50)
    fallout.giq_option(4, 143, 116, alyaend, 50)
end

function alya05()
    fallout.gsay_message(143, 117, 50)
end

function alya06()
    fallout.gsay_reply(143, 118)
    fallout.giq_option(4, 143, 119, alya07, 50)
    fallout.giq_option(4, 143, 120, combat, 50)
    fallout.giq_option(4, 143, 121, alyaend, 50)
end

function alya07()
    fallout.gsay_message(143, 122, 50)
    combat()
end

function alya08()
    fallout.gsay_message(143, 123, 50)
    fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(15), 1)
end

function alya09()
    fallout.gsay_message(143, 124, 50)
end

function alya10()
    fallout.gsay_message(143, 125, 50)
end

function alyaend()
end

function combat()
    if fallout.global_var(116) == 1 then
        misc.set_team(fallout.self_obj(), 87)
    end
    hostile = true
end

local exports = {}
exports.start = start
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.critter_p_proc = critter_p_proc
exports.damage_p_proc = damage_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.timed_event_p_proc = timed_event_p_proc
exports.look_at_p_proc = look_at_p_proc
return exports
