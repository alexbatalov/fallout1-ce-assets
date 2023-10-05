local fallout = require("fallout")

local start
local appear

function start()
    if fallout.script_action() ~= 6 then
        if fallout.global_var(13) == 1 then
            appear()
        else
            fallout.script_overrides()
            fallout.set_obj_visibility(fallout.self_obj(), 1)
        end
    end
end

function appear()
    fallout.set_obj_visibility(fallout.self_obj(), 0)
end

local exports = {}
exports.start = start
return exports
