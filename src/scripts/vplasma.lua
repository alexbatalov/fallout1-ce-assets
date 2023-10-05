local fallout = require("fallout")

local start
local description_p_proc
local spatial_p_proc
local use_skill_on_p_proc

local fired = 0

function start()
    if fallout.script_action() == 3 then
        description_p_proc()
    else
        if fallout.script_action() == 2 then
            spatial_p_proc()
        else
            if fallout.script_action() == 8 then
                use_skill_on_p_proc()
            end
        end
    end
end

function description_p_proc()
    local v0 = 0
    fallout.script_overrides()
    if not(fallout.local_var(0)) then
        if fallout.is_success(fallout.do_check(fallout.dude_obj(), 1, fallout.has_trait(0, fallout.dude_obj(), 0) - 3)) then
            v0 = fallout.message_str(612, 101)
            if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 11, 0)) then
                v0 = v0 + fallout.message_str(612, 102)
            end
            fallout.set_local_var(0, 1)
        else
            v0 = 0
        end
    else
        v0 = fallout.message_str(612, 101)
    end
    if v0 ~= 0 then
        fallout.display_msg(v0)
    end
end

function spatial_p_proc()
    if fired then
        if fallout.tile_num(fallout.source_obj()) ~= fallout.tile_num(fallout.self_obj()) then
            fired = 0
        end
    else
        if fallout.map_var(7) == 1 then
            if fallout.map_var(11) == 0 then
                fallout.display_msg(fallout.message_str(612, 100))
                fallout.critter_dmg(fallout.source_obj(), fallout.random(10, 20), 3)
                fired = 1
            end
        end
    end
end

function use_skill_on_p_proc()
    if fallout.action_being_used() == 11 then
        if fallout.local_var(0) == 1 then
            fallout.script_overrides()
            if fallout.is_success(fallout.roll_vs_skill(fallout.source_obj(), 11, 0)) then
                fallout.display_msg(fallout.message_str(612, 103))
                fallout.set_map_var(11, 1)
                fallout.move_to(fallout.self_obj(), 7000, 0)
                fallout.set_external_var("removal_ptr", fallout.self_obj())
            else
                fallout.display_msg(fallout.message_str(612, 104))
            end
        end
    end
end

local exports = {}
exports.start = start
exports.description_p_proc = description_p_proc
exports.spatial_p_proc = spatial_p_proc
exports.use_skill_on_p_proc = use_skill_on_p_proc
return exports
