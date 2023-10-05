local fallout = require("fallout")

local start

function start()
    if fallout.script_action() == 2 then
        if fallout.source_obj() == fallout.dude_obj() then
            if fallout.local_var(0) ~= 1 then
                if fallout.get_critter_stat(fallout.dude_obj(), 4) > 8 then
                    fallout.display_msg(fallout.message_str(60, 100))
                end
                fallout.set_local_var(0, 1)
            end
        end
    end
end

local exports = {}
exports.start = start
return exports
