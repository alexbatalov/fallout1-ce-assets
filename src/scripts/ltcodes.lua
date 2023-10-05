local fallout = require("fallout")

local start

function start()
    if (fallout.script_action() == 21) or (fallout.script_action() == 3) then
        fallout.script_overrides()
        fallout.display_msg(fallout.message_str(350, 103))
    else
        if fallout.script_action() == 6 then
            fallout.script_overrides()
            if fallout.local_var(0) == 1 then
                fallout.display_msg(fallout.message_str(350, 101))
            else
                fallout.set_local_var(0, 1)
                fallout.display_msg(fallout.message_str(350, 102))
                fallout.set_global_var(298, 1)
            end
        end
    end
end

local exports = {}
exports.start = start
return exports
