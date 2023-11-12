local fallout = require("fallout")

local start
local spatial_p_proc

function start()
    if fallout.script_action() == 2 then
        spatial_p_proc()
    end
end

function spatial_p_proc()
    if fallout.global_var(139) ~= 0 and fallout.global_var(140) ~= 0 then
        if fallout.local_var(0) == 0 then
            fallout.set_local_var(0, 1)
            local damage = fallout.random(1, 6) - 3
            fallout.float_msg(fallout.dude_obj(), fallout.message_str(335, 100), 0)
            if damage < 2 then
                fallout.display_msg(fallout.message_str(335, 101))
                fallout.critter_dmg(fallout.dude_obj(), 1, 0)
            else
                fallout.display_msg(fallout.message_str(335, 102) .. damage .. fallout.message_str(335, 103))
                fallout.critter_dmg(fallout.dude_obj(), damage, 0)
            end
        end
    end
end

local exports = {}
exports.start = start
exports.spatial_p_proc = spatial_p_proc
return exports
