local fallout = require("fallout")
local misc = require("lib.misc")
local reaction = require("lib.reaction")
local reputation = require("lib.reputation")

local start
local tolya00
local tolya01
local tolya02
local tolya03
local tolya04
local tolya05
local tolya06
local tolya07
local tolya08
local tolya09
local tolya10
local tolyaend
local pickup_p_proc
local talk_p_proc
local critter_p_proc
local combat
local damage_p_proc
local destroy_p_proc
local look_at_p_proc

local hostile = false
local initialized = false

function start()
    if not initialized then
        local self_obj = fallout.self_obj()
        misc.set_team(self_obj, 6)
        misc.set_ai(self_obj, 20)
        initialized = true
    end

    local script_action = fallout.script_action()
    if script_action == 21 then
        look_at_p_proc()
    elseif script_action == 11 then
        talk_p_proc()
    elseif script_action == 12 then
        critter_p_proc()
    elseif script_action == 4 then
        pickup_p_proc()
    elseif script_action == 14 then
        damage_p_proc()
    elseif script_action == 18 then
        destroy_p_proc()
    end
end

function tolya00()
    fallout.gsay_reply(140, 101)
    fallout.giq_option(4, 140,
        fallout.message_str(140, 102) ..
        fallout.proto_data(fallout.obj_pid(fallout.dude_obj()), 1) .. fallout.message_str(140, 103), tolya01, 50)
    fallout.giq_option(5, 140, 104, tolya02, 50)
    fallout.giq_option(-3, 140, 105, tolya03, 50)
end

function tolya01()
    fallout.gsay_reply(140, 106)
    fallout.giq_option(4, 140, 107, tolya04, 50)
    fallout.giq_option(4, 140, 108, tolyaend, 50)
    fallout.giq_option(4, 140, 109, tolya05, 50)
end

function tolya02()
    fallout.gsay_reply(140, 110)
    fallout.giq_option(4, 140,
        fallout.message_str(140, 111) ..
        fallout.proto_data(fallout.obj_pid(fallout.dude_obj()), 1) .. fallout.message_str(140, 112), tolya07, 50)
    fallout.giq_option(4, 140, 113, combat, 50)
end

function tolya03()
    fallout.gsay_message(140, 114, 50)
end

function tolya04()
    fallout.gsay_reply(140, 115)
    fallout.giq_option(4, 140, 116, tolya06, 50)
    fallout.giq_option(4, 140, 117, tolyaend, 50)
end

function tolya05()
    fallout.gsay_reply(140, 118)
    fallout.giq_option(4, 140, 119, tolya08, 50)
    fallout.giq_option(4, 140, 120, tolya09, 50)
end

function tolya06()
    fallout.gsay_message(140, 121, 50)
    combat()
end

function tolya07()
    fallout.gsay_message(140, 122, 50)
end

function tolya08()
    fallout.set_local_var(6, 1)
    if fallout.local_var(5) == 0 then
        fallout.gsay_reply(140, 123)
        fallout.giq_option(4, 140, 124, tolya09, 50)
    else
        fallout.gsay_message(140, 123, 50)
        tolyaend()
    end
end

function tolya09()
    fallout.set_local_var(5, 1)
    if fallout.local_var(6) == 0 then
        fallout.gsay_reply(140, 125)
        fallout.giq_option(4, 140, 126, tolya08, 50)
    else
        fallout.gsay_message(140, 125, 50)
        tolyaend()
    end
end

function tolya10()
    fallout.gsay_message(140, 127, 50)
end

function tolyaend()
end

function pickup_p_proc()
    hostile = true
end

function talk_p_proc()
    if fallout.global_var(116) == 1 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(136, fallout.random(102, 106)), 8)
    else
        fallout.set_local_var(3, 1)
        reaction.get_reaction()
        fallout.start_gdialog(140, fallout.self_obj(), 4, -1, -1)
        fallout.gsay_start()
        if fallout.local_var(4) == 5 then
            tolya10()
        else
            fallout.set_local_var(4, fallout.local_var(4) + 1)
            tolya00()
        end
        fallout.gsay_end()
        fallout.end_dialogue()
    end
end

function critter_p_proc()
    local self_obj = fallout.self_obj()
    local dude_obj = fallout.dude_obj()
    local self_can_see_dude = fallout.obj_can_see_obj(self_obj, dude_obj)
    local distance_self_to_dude = fallout.tile_distance_objs(self_obj, dude_obj)
    if fallout.global_var(26) == 2 then
        fallout.set_global_var(254, 1)
    else
        if fallout.global_var(116) ~= 0 then
            fallout.set_global_var(254, 0)
            if distance_self_to_dude < 3 then
                local tile_num = fallout.tile_num_in_direction(fallout.tile_num(self_obj), fallout.random(0, 5), 3)
                if fallout.tile_distance(fallout.tile_num(self_obj), tile_num) > 2 then
                    if fallout.random(0, 9) == 0 then
                        fallout.float_msg(self_obj, fallout.message_str(136, fallout.random(102, 106)), 8)
                    end
                    fallout.animate_move_obj_to_tile(self_obj, tile_num, 0)
                end
            end
        else
            if fallout.global_var(213) ~= 0 then
                fallout.set_global_var(254, 1)
            end
            if self_can_see_dude then
                if fallout.global_var(214) ~= 0 then
                    fallout.set_global_var(254, 1)
                end
            end
            if fallout.map_var(2) == 1 then
                fallout.set_global_var(254, 1)
            end
        end
    end
    if fallout.global_var(254) ~= 0 and self_can_see_dude then
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

function combat()
    if fallout.global_var(116) == 1 then
        misc.set_team(fallout.self_obj(), 87)
    end
    hostile = true
end

function destroy_p_proc()
    reputation.inc_evil_critter()
    fallout.set_global_var(254, 1)
    fallout.set_global_var(611, 0)
    fallout.set_global_var(115, fallout.global_var(115) - 1)
end

function damage_p_proc()
    if fallout.global_var(116) == 0 then
        fallout.set_global_var(254, 1)
    end
end

function look_at_p_proc()
    fallout.display_msg(fallout.message_str(140, 100))
    fallout.script_overrides()
end

local exports = {}
exports.start = start
exports.talk_p_proc = talk_p_proc
exports.critter_p_proc = critter_p_proc
exports.damage_p_proc = damage_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
return exports
