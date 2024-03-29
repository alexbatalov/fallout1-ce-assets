local fallout = require("fallout")

local start
local spatial_p_proc

local Passed_Times = 0

function start()
    if fallout.script_action() == 2 then
        spatial_p_proc()
    end
end

function spatial_p_proc()
    if fallout.global_var(146) == 1 then
        local source_obj = fallout.source_obj()
        if fallout.is_success(fallout.roll_vs_skill(source_obj, 11, 0)) and fallout.local_var(0) == 0 then
            fallout.give_exp_points(25)
            fallout.reg_anim_func(2, source_obj)
            if source_obj ~= fallout.dude_obj() then
                fallout.display_msg(fallout.proto_data(fallout.obj_pid(source_obj), 1) .. fallout.message_str(509, 100))
            else
                Passed_Times = Passed_Times + 1
                if Passed_Times > 2 then
                    fallout.set_local_var(0, 1)
                end
                fallout.display_msg(fallout.message_str(509, 101))
            end
        else
            if fallout.local_var(0) == 0 then
                fallout.set_local_var(0, 1)
                fallout.critter_dmg(source_obj, fallout.random(15, 40), 4)
            end
        end
    end
end

local exports = {}
exports.start = start
exports.spatial_p_proc = spatial_p_proc
return exports
