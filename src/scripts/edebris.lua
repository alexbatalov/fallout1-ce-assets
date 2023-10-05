local fallout = require("fallout")

local start

function start()
    if fallout.script_action() == 2 then
        if fallout.source_obj() == fallout.dude_obj() then
            if fallout.map_var(2) == 0 then
                fallout.set_map_var(2, 1)
                fallout.set_map_var(4, fallout.map_var(4) + 1)
                if fallout.map_var(4) > 3 then
                    fallout.display_msg(fallout.message_str(824, 104))
                else
                    fallout.display_msg(fallout.message_str(824, 102))
                end
            end
        end
    end
end

local exports = {}
exports.start = start
return exports
