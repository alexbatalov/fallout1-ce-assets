local fallout = require("fallout")

local start
local critter_p_proc
local destroy_p_proc
local use_skill_on_p_proc

local initialized = 0

function start()
    if not(initialized) and fallout.metarule(14, 0) then
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 0)
        fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(1), 1)
        fallout.move_to(fallout.self_obj(), fallout.tile_num_in_direction(fallout.tile_num(fallout.dude_obj()), (fallout.has_trait(1, fallout.dude_obj(), 10) + 3) % 6, 2), fallout.elevation(fallout.dude_obj()))
        initialized = 1
    else
        if fallout.script_action() == 12 then
            critter_p_proc()
        else
            if fallout.script_action() == 18 then
                destroy_p_proc()
            else
                if fallout.script_action() == 8 then
                    use_skill_on_p_proc()
                end
            end
        end
    end
end

function critter_p_proc()
    if fallout.global_var(5) == 1 then
        if fallout.tile_distance_objs(fallout.self_obj(), fallout.dude_obj()) > 4 then
            fallout.animate_move_obj_to_tile(fallout.self_obj(), fallout.tile_num_in_direction(fallout.tile_num(fallout.dude_obj()), fallout.random(0, 5), 1), 1)
        else
            fallout.animate_move_obj_to_tile(fallout.self_obj(), fallout.tile_num_in_direction(fallout.tile_num(fallout.dude_obj()), fallout.random(0, 5), 3), 0)
        end
    end
end

function destroy_p_proc()
    fallout.set_global_var(5, 0)
end

function use_skill_on_p_proc()
    if fallout.action_being_used() == 10 then
        fallout.script_overrides()
    end
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.use_skill_on_p_proc = use_skill_on_p_proc
return exports
