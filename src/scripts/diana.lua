local fallout = require("fallout")
local reaction = require("lib.reaction")
local reputation = require("lib.reputation")

local start
local pickup_p_proc
local talk_p_proc
local critter_p_proc
local damage_p_proc
local destroy_p_proc
local look_at_p_proc
local do_dialogue
local Diana00
local Diana01
local Diana02
local Diana03
local Diana04
local Diana05
local Diana10
local Diana11
local Diana12
local Dianaend

local hostile = false
local initialized = false

function start()
    if not initialized then
        local self_obj = fallout.self_obj()
        fallout.critter_add_trait(self_obj, 1, 6, 6)
        fallout.critter_add_trait(self_obj, 1, 5, 21)
        initialized = true
    end

    local script_action = fallout.script_action()
    if script_action == 11 then
        talk_p_proc()
    elseif script_action == 21 then
        look_at_p_proc()
    elseif script_action == 4 then
        pickup_p_proc()
    elseif script_action == 12 then
        critter_p_proc()
    elseif script_action == 14 then
        damage_p_proc()
    elseif script_action == 18 then
        destroy_p_proc()
    end
end

function pickup_p_proc()
    hostile = true
end

function destroy_p_proc()
    reputation.inc_evil_critter()
    fallout.set_global_var(254, 1)
    fallout.set_global_var(611, 0)
    fallout.set_global_var(115, fallout.global_var(115) - 1)
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(142, 100))
end

function do_dialogue()
    fallout.set_local_var(3, 1)
    reaction.get_reaction()
    fallout.start_gdialog(142, fallout.self_obj(), 4, -1, -1)
    fallout.gsay_start()
    if fallout.local_var(4) ~= 0 then
        Diana10()
    else
        if fallout.global_var(611) == 1 then
            Diana11()
        else
            fallout.set_local_var(4, 1)
            Diana00()
        end
    end
    fallout.gsay_end()
    fallout.end_dialogue()
end

function Diana00()
    fallout.gsay_reply(142, 101)
    if (fallout.global_var(103) == 1) and (fallout.global_var(218) == 1) then
        fallout.giq_option(4, 142, 102, Diana01, 50)
    end
    fallout.giq_option(4, 142, 103, Dianaend, 50)
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        fallout.giq_option(4, 142, 104, Diana02, 50)
    end
    fallout.giq_option(4, 142, 105, Diana04, 50)
    if fallout.local_var(5) == 0 then
        fallout.giq_option(7, 142, 106, Diana05, 50)
    end
    fallout.giq_option(-3, 142, 107, Diana10, 50)
end

function Diana01()
    fallout.gsay_reply(142, 108)
    fallout.giq_option(4, 142, 109, Dianaend, 50)
    fallout.giq_option(4, 142, 110, Diana03, 50)
end

function Diana02()
    fallout.gsay_message(142, 111, 50)
end

function Diana03()
    fallout.gsay_message(142, 112, 50)
end

function Diana04()
    fallout.gsay_reply(142, 113)
    fallout.giq_option(4, 142, 114, Diana03, 50)
    if fallout.local_var(5) == 0 then
        fallout.giq_option(7, 142, 115, Diana05, 50)
    end
end

function Diana05()
    fallout.gsay_reply(142, 116)
    fallout.set_local_var(5, 1)
    fallout.giq_option(4, 142, 117, Diana01, 50)
    fallout.giq_option(4, 142, 118, Diana03, 50)
end

function Diana10()
    fallout.gsay_message(142, 119, 50)
end

function Diana11()
    fallout.gsay_reply(142, 120)
    fallout.giq_option(4, 142, 104, Diana10, 50)
    fallout.giq_option(4, 142, 118, Diana12, 50)
    fallout.giq_option(-3, 142, 107, Diana10, 50)
end

function Diana12()
    fallout.gsay_message(142, 121, 50)
end

function Dianaend()
end

function talk_p_proc()
    if fallout.global_var(116) == 1 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(136, fallout.random(102, 106)), 8)
    else
        do_dialogue()
    end
end

function critter_p_proc()
    local dude_obj = fallout.dude_obj()
    local self_obj = fallout.self_obj()
    if fallout.global_var(26) == 2 then
        fallout.set_global_var(254, 1)
    else
        if fallout.global_var(116) ~= 0 then
            fallout.set_global_var(254, 0)
            if fallout.tile_distance_objs(self_obj, dude_obj) < 3 then
                local self_tile_num = fallout.tile_num(self_obj)
                local dest_tile_num = fallout.tile_num_in_direction(self_tile_num, fallout.random(0, 5), 3)
                if fallout.tile_distance(self_tile_num, dest_tile_num) > 2 then
                    if fallout.random(0, 9) == 0 then
                        fallout.float_msg(self_obj, fallout.message_str(136, fallout.random(102, 106)), 8)
                    end
                    fallout.animate_move_obj_to_tile(self_obj, dest_tile_num, 0)
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
    end
    if fallout.global_var(254) and fallout.obj_can_see_obj(self_obj, dude_obj) then
        hostile = true
    end
    if fallout.tile_distance_objs(self_obj, dude_obj) > 12 then
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

local exports = {}
exports.start = start
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.critter_p_proc = critter_p_proc
exports.damage_p_proc = damage_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
return exports
