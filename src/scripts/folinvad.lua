local fallout = require("fallout")

local start
local talk_p_proc
local Initialize_p_proc
local critter_p_proc
local map_enter_p_proc

local initialized = false
local Hex_Number = 0

function start()
    if not initialized then
        Initialize_p_proc()
    else
        if fallout.script_action() == 11 then
            talk_p_proc()
        else
            if fallout.script_action() == 12 then
                critter_p_proc()
            else
                if fallout.script_action() == map_enter_p_proc() then
                    map_enter_p_proc()
                end
            end
        end
    end
end

function talk_p_proc()
    if fallout.local_var(3) == 0 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(820, fallout.random(100, 107)), 9)
    end
end

function Initialize_p_proc()
    fallout.critter_add_trait(fallout.self_obj(), 1, 6, 0)
    fallout.critter_add_trait(fallout.self_obj(), 1, 5, 65)
    initialized = true
end

function critter_p_proc()
    local v0 = 0
    if fallout.global_var(63) == 1 then
        if fallout.local_var(4) == 0 then
            if Hex_Number == 0 then
                v0 = fallout.random(1, 10)
                if v0 == 1 then
                    Hex_Number = 19905
                else
                    if v0 == 2 then
                        Hex_Number = 20308
                    else
                        if v0 == 3 then
                            Hex_Number = 20506
                        else
                            if v0 == 4 then
                                Hex_Number = 20906
                            else
                                if v0 == 5 then
                                    Hex_Number = 20110
                                else
                                    if v0 == 6 then
                                        Hex_Number = 19503
                                    else
                                        if v0 == 7 then
                                            Hex_Number = 19103
                                        else
                                            if v0 == 8 then
                                                Hex_Number = 20904
                                            else
                                                if v0 == 9 then
                                                    Hex_Number = 21113
                                                else
                                                    Hex_Number = 19910
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
            if fallout.tile_num(fallout.self_obj()) ~= Hex_Number then
                fallout.animate_move_obj_to_tile(fallout.self_obj(), Hex_Number, 0)
            else
                if fallout.tile_num(fallout.self_obj()) == Hex_Number then
                    fallout.set_local_var(4, 1)
                end
            end
        else
            if (fallout.tile_distance_objs(fallout.dude_obj(), fallout.self_obj()) > 10) and (fallout.tile_distance_objs(fallout.dude_obj(), fallout.self_obj()) < 15) then
                fallout.animate_move_obj_to_tile(fallout.self_obj(), fallout.tile_num_in_direction(fallout.tile_num(fallout.dude_obj()), fallout.random(0, 5), fallout.random(3, 6)), 0)
            else
                if fallout.tile_distance_objs(fallout.dude_obj(), fallout.self_obj()) >= 15 then
                    fallout.animate_move_obj_to_tile(fallout.self_obj(), fallout.tile_num_in_direction(fallout.tile_num(fallout.dude_obj()), fallout.random(0, 5), fallout.random(3, 6)), 1)
                else
                    if fallout.random(1, 100) == 1 then
                        fallout.animate_move_obj_to_tile(fallout.self_obj(), fallout.tile_num_in_direction(fallout.tile_num(fallout.self_obj()), fallout.random(0, 5), fallout.random(3, 6)), 0)
                    end
                end
            end
        end
        if fallout.local_var(4) == 1 then
            if (fallout.cur_map_index() == 17) or (fallout.cur_map_index() == 18) then
                if fallout.local_var(0) == 0 then
                    fallout.set_local_var(0, 1)
                    fallout.party_add(fallout.self_obj())
                    fallout.float_msg(fallout.self_obj(), fallout.message_str(820, 112), 9)
                end
            else
                if fallout.cur_map_index() == 33 then
                    if fallout.local_var(1) == 0 then
                        if fallout.elevation(fallout.self_obj()) == 1 then
                            fallout.set_local_var(1, 1)
                            fallout.float_msg(fallout.self_obj(), fallout.message_str(820, 109), 9)
                        end
                    end
                else
                    if fallout.cur_map_index() == 34 then
                        if fallout.local_var(2) == 0 then
                            fallout.set_local_var(2, 1)
                            fallout.float_msg(fallout.self_obj(), fallout.message_str(820, 110), 9)
                        end
                    else
                        if fallout.local_var(3) == 0 then
                            fallout.set_local_var(3, 1)
                            fallout.float_msg(fallout.self_obj(), fallout.message_str(820, 111), 9)
                            fallout.party_remove(fallout.self_obj())
                            fallout.animate_move_obj_to_tile(fallout.self_obj(), 26000, 0)
                            fallout.set_global_var(63, 5)
                        end
                    end
                end
            end
        end
    else
        fallout.set_obj_visibility(fallout.self_obj(), 1)
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
