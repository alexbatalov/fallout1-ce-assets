local fallout = require("fallout")

local start
local description_p_proc
local spatial_p_proc
local use_skill_on_p_proc

local initialized = false

function start()
    if not initialized then
        initialized = true
    else
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
end

function description_p_proc()
    local v0 = 0
    v0 = fallout.message_str(611, 100)
    if not(fallout.local_var(0)) then
        if not(fallout.is_success(fallout.do_check(fallout.dude_obj(), 1, fallout.has_trait(0, fallout.dude_obj(), 0)))) then
            v0 = fallout.message_str(611, 101)
        else
            fallout.set_local_var(0, 1)
        end
    end
    fallout.display_msg(v0)
end

function spatial_p_proc()
    if fallout.map_var(7) == 0 then
        if not(fallout.is_success(fallout.do_check(fallout.dude_obj(), 6, 0))) then
            fallout.set_global_var(146, 1)
            fallout.set_map_var(7, 1)
            fallout.display_msg(fallout.message_str(611, 102))
            fallout.move_to(fallout.self_obj(), 7000, 0)
            fallout.set_external_var("removal_ptr", fallout.self_obj())
        end
    else
        fallout.display_msg(fallout.message_str(611, 103))
    end
end

function use_skill_on_p_proc()
    if fallout.action_being_used() == 11 then
        if fallout.local_var(0) ~= 0 then
            fallout.script_overrides()
            if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 11, 0)) then
                fallout.display_msg(fallout.message_str(611, 104))
                fallout.move_to(fallout.self_obj(), 7000, 0)
                fallout.set_external_var("removal_ptr", fallout.self_obj())
                fallout.set_map_var(12, 1)
            else
                fallout.display_msg(fallout.message_str(611, 105))
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
