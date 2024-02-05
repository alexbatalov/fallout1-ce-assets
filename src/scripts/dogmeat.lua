local fallout = require("fallout")
local misc = require("lib.misc")

local start
local critter_p_proc
local destroy_p_proc
local use_skill_on_p_proc

local initialized = false

function start()
    if not initialized and misc.map_first_run() then
        local dude_obj = fallout.dude_obj()
        local self_obj = fallout.self_obj()
        misc.set_team(self_obj, 0)
        fallout.add_timer_event(self_obj, fallout.game_ticks(1), 1) -- FIXME: What for?
        fallout.move_to(self_obj,
            fallout.tile_num_in_direction(fallout.tile_num(dude_obj), (fallout.has_trait(1, dude_obj, 10) + 3) % 6, 2),
            fallout.elevation(dude_obj))
        initialized = true
    end

    local script_action = fallout.script_action()
    if script_action == 12 then
        critter_p_proc()
    elseif script_action == 18 then
        destroy_p_proc()
    elseif script_action == 8 then
        use_skill_on_p_proc()
    end
end

function critter_p_proc()
    if fallout.global_var(5) == 1 then
        local dude_obj = fallout.dude_obj()
        local self_obj = fallout.self_obj()
        if fallout.tile_distance_objs(self_obj, dude_obj) > 4 then
            fallout.animate_move_obj_to_tile(self_obj,
                fallout.tile_num_in_direction(fallout.tile_num(dude_obj), fallout.random(0, 5), 1), 1)
        else
            fallout.animate_move_obj_to_tile(self_obj,
                fallout.tile_num_in_direction(fallout.tile_num(dude_obj), fallout.random(0, 5), 3), 0)
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
