local fallout = require("fallout")
local misc = require("lib.misc")
local reputation = require("lib.reputation")

local hostile = false

local start
local destroy_p_proc
local critter_p_proc

local initialized = false

function start()
    if not initialized then
        local self_obj = fallout.self_obj()
        if fallout.local_var(3) == 0 then
            fallout.set_local_var(3, fallout.tile_num(self_obj))
        end
        misc.set_team(self_obj, 44)
        misc.set_ai(self_obj, 62)
        if fallout.local_var(0) ~= 0 then
            if fallout.map_var(4) == fallout.local_var(0) then
                fallout.set_external_var("Student_ptr", self_obj)
                fallout.set_map_var(0, 1)
            end
        else
            local temp = fallout.map_var(5) + 1
            fallout.set_map_var(5, temp)
            fallout.set_local_var(0, temp)
            fallout.set_external_var("Student_ptr", self_obj)
            fallout.set_map_var(0, 1)
        end
        initialized = true
    end

    local script_action = fallout.script_action()
    if script_action == 18 then
        destroy_p_proc()
    elseif script_action == 12 then
        critter_p_proc()
    end
end

function destroy_p_proc()
    fallout.set_global_var(250, 1)
    fallout.rm_timer_event(fallout.self_obj())
    reputation.inc_good_critter()
end

function critter_p_proc()
    local self_obj = fallout.self_obj()
    local dude_obj = fallout.dude_obj()
    if fallout.global_var(250) ~= 0 then
        hostile = true
    end
    if fallout.tile_distance_objs(self_obj, dude_obj) > 12 then
        hostile = false
    end
    if hostile then
        fallout.set_global_var(250, 1)
        hostile = false
        fallout.attack(dude_obj, 0, 1, 0, 0, 30000, 0, 0)
    else
        if fallout.global_var(250) == 0 then
            if fallout.local_var(1) == 1 then
                if fallout.tile_num(self_obj) ~= fallout.map_var(1) then
                    fallout.animate_move_obj_to_tile(self_obj, fallout.map_var(1), 0)
                else
                    fallout.set_local_var(1, 0)
                    fallout.set_map_var(0, 1)
                    fallout.anim(self_obj, 1000, 1)
                end
            elseif fallout.local_var(2) == 1 then
                if fallout.tile_num(self_obj) ~= fallout.local_var(3) then
                    fallout.animate_move_obj_to_tile(self_obj, fallout.local_var(3), 0)
                else
                    fallout.set_local_var(2, 0)
                    fallout.anim(self_obj, 1000, 2)
                end
            elseif fallout.map_var(2) == fallout.local_var(0) then
                fallout.set_map_var(2, 0)
                fallout.set_external_var("Student_ptr", self_obj)
                fallout.set_map_var(3, fallout.map_var(4))
                fallout.set_map_var(4, fallout.local_var(0))
                fallout.set_local_var(1, 1)
            elseif fallout.map_var(3) == fallout.local_var(0) then
                fallout.set_map_var(3, 0)
                fallout.set_local_var(2, 1)
            end
        end
    end
end

local exports = {}
exports.start = start
exports.destroy_p_proc = destroy_p_proc
exports.critter_p_proc = critter_p_proc
return exports
