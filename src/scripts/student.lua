local fallout = require("fallout")

local hostile = 0

local start
local destroy_p_proc
local critter_p_proc

local initialized = 0
local my_knife = 0
local home_face = 2
local temp = 0

function start()
    if not(initialized) then
        if fallout.local_var(3) == 0 then
            fallout.set_local_var(3, fallout.tile_num(fallout.self_obj()))
        end
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 44)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 62)
        my_knife = fallout.obj_carrying_pid_obj(fallout.self_obj(), 4)
        if fallout.local_var(0) ~= 0 then
            if fallout.map_var(4) == fallout.local_var(0) then
                fallout.set_external_var("Student_ptr", fallout.self_obj())
                fallout.set_map_var(0, 1)
            end
        else
            temp = fallout.map_var(5) + 1
            fallout.set_map_var(5, temp)
            fallout.set_local_var(0, temp)
            fallout.set_external_var("Student_ptr", fallout.self_obj())
            fallout.set_map_var(0, 1)
        end
        initialized = 1
    else
        if fallout.script_action() == 18 then
            destroy_p_proc()
        else
            if fallout.script_action() == 12 then
                if fallout.global_var(250) then
                    hostile = 1
                end
                if fallout.tile_distance_objs(fallout.self_obj(), fallout.dude_obj()) > 12 then
                    hostile = 0
                end
                if hostile then
                    fallout.set_global_var(250, 1)
                    hostile = 0
                    fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
                else
                    if fallout.global_var(250) == 0 then
                        critter_p_proc()
                    end
                end
            end
        end
    end
end

function destroy_p_proc()
    fallout.set_global_var(250, 1)
    fallout.rm_timer_event(fallout.self_obj())
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

function critter_p_proc()
    if fallout.local_var(1) == 1 then
        if fallout.tile_num(fallout.self_obj()) ~= fallout.map_var(1) then
            fallout.animate_move_obj_to_tile(fallout.self_obj(), fallout.map_var(1), 0)
        else
            fallout.set_local_var(1, 0)
            fallout.set_map_var(0, 1)
            fallout.anim(fallout.self_obj(), 1000, 1)
        end
    else
        if fallout.local_var(2) == 1 then
            if fallout.tile_num(fallout.self_obj()) ~= fallout.local_var(3) then
                fallout.animate_move_obj_to_tile(fallout.self_obj(), fallout.local_var(3), 0)
            else
                fallout.set_local_var(2, 0)
                fallout.anim(fallout.self_obj(), 1000, home_face)
            end
        else
            if fallout.map_var(2) == fallout.local_var(0) then
                fallout.set_map_var(2, 0)
                fallout.set_external_var("Student_ptr", fallout.self_obj())
                fallout.set_map_var(3, fallout.map_var(4))
                fallout.set_map_var(4, fallout.local_var(0))
                fallout.set_local_var(1, 1)
            else
                if fallout.map_var(3) == fallout.local_var(0) then
                    fallout.set_map_var(3, 0)
                    fallout.set_local_var(2, 1)
                end
            end
        end
    end
end

local exports = {}
exports.start = start
exports.destroy_p_proc = destroy_p_proc
exports.critter_p_proc = critter_p_proc
return exports
