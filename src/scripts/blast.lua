local fallout = require("fallout")

local start
local use_obj_on_p_proc

function start()
    if fallout.script_action() == 7 then
        use_obj_on_p_proc()
    end
end

function use_obj_on_p_proc()
    if fallout.obj_pid(fallout.obj_being_used_with()) == 85 then
        fallout.script_overrides()
        local roll = fallout.roll_vs_skill(fallout.dude_obj(), 11, 0)
        if fallout.is_success(roll) then
            fallout.display_msg(fallout.message_str(463, 100))
            fallout.give_exp_points(1)
            fallout.display_msg(fallout.message_str(463, 103))
        else
            if fallout.is_critical(roll) then
                fallout.display_msg(fallout.message_str(463, 101))
                fallout.critter_dmg(fallout.dude_obj(), fallout.random(10, 40), 0)
            else
                fallout.display_msg(fallout.message_str(463, 102))
            end
        end
    end
end

local exports = {}
exports.start = start
exports.use_obj_on_p_proc = use_obj_on_p_proc
return exports
