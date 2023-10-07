local fallout = require("fallout")

local start

local once = 0
local Passed_Times = 0

function start()
    if fallout.script_action() == 2 then
        if fallout.global_var(146) == 1 then
            if fallout.is_success(fallout.roll_vs_skill(fallout.source_obj(), 11, 0)) and (once == 0) then
                fallout.give_exp_points(25)
                fallout.reg_anim_func(2, fallout.source_obj())
                if fallout.source_obj() ~= fallout.dude_obj() then
                    fallout.display_msg(fallout.proto_data(fallout.obj_pid(fallout.source_obj()), 1) .. fallout.message_str(509, 100))
                else
                    Passed_Times = Passed_Times + 1
                    if Passed_Times > 2 then
                        once = 1
                    end
                    fallout.display_msg(fallout.message_str(509, 101))
                end
            else
                if once == 0 then
                    once = 1
                    fallout.critter_dmg(fallout.source_obj(), fallout.random(15, 40), 3)
                end
            end
        end
    end
end

local exports = {}
exports.start = start
return exports
