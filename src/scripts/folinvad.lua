local fallout = require("fallout")
local misc = require("lib.misc")

local start
local talk_p_proc
local Initialize_p_proc
local critter_p_proc
local map_enter_p_proc

local initialized = false
local Hex_Number = 0

local HEXES <const> = {
    19905,
    20308,
    20506,
    20906,
    20110,
    19503,
    19103,
    20904,
    21113,
    19910,
}

function start()
    if not initialized then
        local self_obj = fallout.self_obj()
        misc.set_team(self_obj, 0)
        misc.set_ai(self_obj, 65)
        initialized = true
    end

    local script_action = fallout.script_action()
    if script_action == 11 then
        talk_p_proc()
    elseif script_action == 12 then
        critter_p_proc()
    elseif script_action == map_enter_p_proc() then
        map_enter_p_proc()
    end
end

function talk_p_proc()
    if fallout.local_var(3) == 0 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(820, fallout.random(100, 107)), 9)
    end
end

function critter_p_proc()
    local self_obj = fallout.self_obj()
    if fallout.global_var(63) == 1 then
        if fallout.local_var(4) == 0 then
            if Hex_Number == 0 then
                Hex_Number = HEXES[fallout.random(1, #HEXES)]
            end
            if fallout.tile_num(self_obj) ~= Hex_Number then
                fallout.animate_move_obj_to_tile(self_obj, Hex_Number, 0)
            else
                fallout.set_local_var(4, 1)
            end
        else
            local dude_obj = fallout.dude_obj()
            local distance_dude_to_self = fallout.tile_distance_objs(dude_obj, self_obj)
            if distance_dude_to_self > 10 and distance_dude_to_self < 15 then
                fallout.animate_move_obj_to_tile(self_obj,
                    fallout.tile_num_in_direction(fallout.tile_num(fallout.dude_obj()), fallout.random(0, 5),
                        fallout.random(3, 6)), 0)
            elseif distance_dude_to_self >= 15 then
                fallout.animate_move_obj_to_tile(self_obj,
                    fallout.tile_num_in_direction(fallout.tile_num(fallout.dude_obj()), fallout.random(0, 5),
                        fallout.random(3, 6)), 1)
            elseif fallout.random(1, 100) == 1 then
                fallout.animate_move_obj_to_tile(self_obj,
                    fallout.tile_num_in_direction(fallout.tile_num(self_obj), fallout.random(0, 5),
                        fallout.random(3, 6)), 0)
            end
        end
        if fallout.local_var(4) == 1 then
            local cur_map_index = fallout.cur_map_index()
            if cur_map_index == 17 or cur_map_index == 18 then
                if fallout.local_var(0) == 0 then
                    fallout.set_local_var(0, 1)
                    fallout.party_add(self_obj)
                    fallout.float_msg(self_obj, fallout.message_str(820, 112), 9)
                end
            elseif cur_map_index == 33 then
                if fallout.local_var(1) == 0 then
                    if fallout.elevation(self_obj) == 1 then
                        fallout.set_local_var(1, 1)
                        fallout.float_msg(self_obj, fallout.message_str(820, 109), 9)
                    end
                end
            elseif cur_map_index == 34 then
                if fallout.local_var(2) == 0 then
                    fallout.set_local_var(2, 1)
                    fallout.float_msg(self_obj, fallout.message_str(820, 110), 9)
                end
            elseif fallout.local_var(3) == 0 then
                fallout.set_local_var(3, 1)
                fallout.float_msg(self_obj, fallout.message_str(820, 111), 9)
                fallout.party_remove(self_obj)
                fallout.animate_move_obj_to_tile(self_obj, 26000, 0)
                fallout.set_global_var(63, 5)
            end
        end
    else
        fallout.set_obj_visibility(self_obj, 1)
    end
end

function map_enter_p_proc()
    if fallout.global_var(63) ~= 1 then
        fallout.set_obj_visibility(fallout.self_obj(), 1)
    end
end

local exports = {}
exports.start = start
exports.talk_p_proc = talk_p_proc
exports.Initialize_p_proc = Initialize_p_proc
exports.critter_p_proc = critter_p_proc
exports.map_enter_p_proc = map_enter_p_proc
return exports
