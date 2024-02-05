local fallout = require("fallout")
local misc = require("lib.misc")

local start
local talk_p_proc
local critter_p_proc
local map_enter_p_proc

local initialized = false
local Hex_Number = 0

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
    elseif script_action == 15 then
        map_enter_p_proc()
    end
end

function talk_p_proc()
    if fallout.local_var(3) == 0 then
        if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
            fallout.float_msg(fallout.self_obj(), fallout.message_str(819, fallout.random(100, 105)), 9)
        else
            fallout.float_msg(fallout.self_obj(), fallout.message_str(819, fallout.random(106, 111)), 9)
        end
    end
end

function critter_p_proc()
    local dude_obj = fallout.dude_obj()
    local dude_tile_num = fallout.tile_num(dude_obj)
    local self_obj = fallout.self_obj()
    local self_tile_num = fallout.tile_num(self_obj)
    local distance_dude_to_self = fallout.tile_distance_objs(fallout.dude_obj(), self_obj)
    if fallout.global_var(223) == 1 then
        if fallout.local_var(4) == 0 then
            if Hex_Number == 0 then
                local rnd = fallout.random(1, 6)
                if rnd == 1 then
                    Hex_Number = 22098
                elseif rnd == 2 then
                    Hex_Number = 20700
                elseif rnd == 3 then
                    Hex_Number = 20506
                elseif rnd == 4 then
                    Hex_Number = 20902
                elseif rnd == 5 then
                    Hex_Number = 21708
                else
                    Hex_Number = 20900
                end
            end
            if self_tile_num ~= Hex_Number then
                fallout.animate_move_obj_to_tile(self_obj, Hex_Number, 0)
            else
                fallout.set_local_var(4, 1)
            end
        else
            if distance_dude_to_self > 10 and distance_dude_to_self < 15 then
                fallout.animate_move_obj_to_tile(self_obj,
                    fallout.tile_num_in_direction(dude_tile_num, fallout.random(0, 5),
                        fallout.random(3, 6)), 0)
            elseif distance_dude_to_self >= 15 then
                fallout.animate_move_obj_to_tile(self_obj,
                    fallout.tile_num_in_direction(dude_tile_num, fallout.random(0, 5),
                        fallout.random(3, 6)), 1)
            else
                if fallout.random(1, 100) == 1 then
                    fallout.animate_move_obj_to_tile(self_obj,
                        fallout.tile_num_in_direction(self_tile_num, fallout.random(0, 5),
                            fallout.random(3, 6)), 0)
                end
            end
        end
        if fallout.local_var(4) == 1 then
            if fallout.cur_map_index() == 17 or fallout.cur_map_index() == 18 then
                if fallout.local_var(0) == 0 then
                    fallout.float_msg(self_obj, fallout.message_str(819, 112), 9)
                    fallout.set_local_var(0, 1)
                    fallout.party_add(self_obj)
                end
            elseif fallout.cur_map_index() == 33 then
                if fallout.local_var(1) == 0 then
                    fallout.set_local_var(1, 1)
                    fallout.float_msg(self_obj, fallout.message_str(819, 113), 9)
                end
            elseif fallout.cur_map_index() == 34 then
                if fallout.local_var(2) == 0 then
                    fallout.set_local_var(2, 1)
                    fallout.float_msg(self_obj, fallout.message_str(819, 114), 9)
                end
            else
                if fallout.local_var(3) == 0 then
                    fallout.set_local_var(3, 1)
                    fallout.float_msg(self_obj, fallout.message_str(819, 115), 9)
                    fallout.party_remove(self_obj)
                    fallout.animate_move_obj_to_tile(self_obj, 26000, 0)
                    fallout.set_global_var(223, 10)
                end
            end
        end
    elseif fallout.global_var(223) == 2 then
        if fallout.local_var(4) == 0 then
            fallout.set_obj_visibility(self_obj, 0)
            if Hex_Number == 0 then
                local rnd = fallout.random(1, 6)
                if rnd == 1 then
                    Hex_Number = 21534
                elseif rnd == 2 then
                    Hex_Number = 22136
                elseif rnd == 3 then
                    Hex_Number = 20932
                elseif rnd == 4 then
                    Hex_Number = 22938
                elseif rnd == 5 then
                    Hex_Number = 21931
                else
                    Hex_Number = 22733
                end
            end
            if self_tile_num ~= Hex_Number then
                fallout.animate_move_obj_to_tile(self_obj, Hex_Number, 0)
            else
                fallout.set_local_var(4, 1)
            end
        else
            if distance_dude_to_self > 8 and distance_dude_to_self < 12 then
                fallout.animate_move_obj_to_tile(self_obj,
                    fallout.tile_num_in_direction(dude_tile_num, fallout.random(0, 5),
                        fallout.random(3, 6)), 0)
            elseif distance_dude_to_self >= 12 then
                fallout.animate_move_obj_to_tile(self_obj,
                    fallout.tile_num_in_direction(dude_tile_num, fallout.random(0, 5),
                        fallout.random(3, 6)), 1)
            else
                if fallout.random(1, 100) == 1 then
                    fallout.animate_move_obj_to_tile(self_obj,
                        fallout.tile_num_in_direction(self_tile_num, fallout.random(0, 5),
                            fallout.random(3, 6)), 0)
                end
            end
        end
    end
end

function map_enter_p_proc()
    if fallout.global_var(223) == 2 and fallout.cur_map_index() ~= 30 then
        fallout.set_global_var(223, 10)
    end
    if fallout.global_var(223) ~= 1 and fallout.global_var(223) ~= 2 then
        fallout.set_obj_visibility(fallout.self_obj(), true)
    end
end

local exports = {}
exports.start = start
exports.talk_p_proc = talk_p_proc
exports.critter_p_proc = critter_p_proc
exports.map_enter_p_proc = map_enter_p_proc
return exports
