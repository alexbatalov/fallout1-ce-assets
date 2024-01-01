local fallout = require("fallout")

local start
local critter_p_proc
local use_skill_on_p_proc
local combat_p_proc

function start()
    local script_action = fallout.script_action()
    if script_action == 8 then
        use_skill_on_p_proc()
    elseif script_action == 12 then
        critter_p_proc()
    elseif script_action == 13 then
        combat_p_proc()
    end
end

function critter_p_proc()
    local self_obj = fallout.self_obj()
    local dude_obj = fallout.dude_obj()
    if fallout.obj_can_see_obj(self_obj, dude_obj) and fallout.global_var(224) == 2 and fallout.global_var(140) == 0 then
        fallout.attack(dude_obj, 0, 1, 0, 0, 30000, 0, 0)
    else
        if fallout.global_var(224) ~= 2 then
            fallout.anim(self_obj, 48, 0)
        end
    end
end

function use_skill_on_p_proc()
    if fallout.action_being_used() == 12 then
        fallout.script_overrides()
        if fallout.global_var(224) == 2 and fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 12, -10)) then
            fallout.display_msg(fallout.message_str(766, 173))
            if fallout.local_var(0) == 0 then
                fallout.give_exp_points(100)
            end
        else
            fallout.display_msg(fallout.message_str(766, 174))
        end
    end
end

function combat_p_proc()
    if fallout.fixed_param() == 4 then
        if fallout.global_var(224) ~= 2 or fallout.global_var(140) ~= 0 then
            fallout.script_overrides()
            fallout.anim(fallout.self_obj(), 48, 0)
        end
    end
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.use_skill_on_p_proc = use_skill_on_p_proc
exports.combat_p_proc = combat_p_proc
return exports
