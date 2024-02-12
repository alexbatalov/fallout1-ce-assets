local fallout = require("fallout")
local misc = require("lib.misc")

local start
local critter_p_proc
local combat_p_proc
local destroy_p_proc

local Herebefore = 0
local initialized = false

function start()
    if not initialized then
        local self_obj = fallout.self_obj()
        misc.set_ai(self_obj, 8)
        if fallout.cur_map_index() == 26 or fallout.cur_map_index() == 25 then
            misc.set_team(self_obj, 2)
        else
            misc.set_team(self_obj, 21)
        end
        initialized = true
    end

    local script_action = fallout.script_action()
    if script_action == 12 then
        critter_p_proc()
    elseif script_action == 18 then
        destroy_p_proc()
    elseif script_action == 13 then
        combat_p_proc()
    end
end

function critter_p_proc()
    local self_obj = fallout.self_obj()
    local dude_obj = fallout.dude_obj()
    if fallout.global_var(5) == 1 and fallout.tile_distance_objs(self_obj, dude_obj) > 5 and Herebefore == 1 then
        local rotation = fallout.random(0, 5)
        local tile_num = fallout.tile_num_in_direction(fallout.tile_num(dude_obj), rotation, 1)
        fallout.animate_move_obj_to_tile(self_obj, tile_num, 0)
    else
        if fallout.random(1, 20) == 1 then
            local rotation = fallout.random(0, 5)
            local tile_num = fallout.tile_num_in_direction(fallout.tile_num(self_obj), rotation, 1)
            fallout.animate_move_obj_to_tile(self_obj, tile_num, 0)
        end
    end
    if fallout.global_var(4) == 0 then
        if fallout.obj_can_see_obj(self_obj, dude_obj) and fallout.global_var(5) == 0 then
            if fallout.obj_pid(fallout.critter_inven_obj(dude_obj, 0)) == 74 then
                fallout.set_global_var(5, 1)
                Herebefore = 1
                fallout.display_msg(fallout.message_str(242, 102))
            end
        end
    end
end

function combat_p_proc()
    fallout.set_global_var(5, 1)
end

function destroy_p_proc()
    fallout.set_global_var(4, fallout.global_var(4) + 1)
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.combat_p_proc = combat_p_proc
exports.destroy_p_proc = destroy_p_proc
return exports
