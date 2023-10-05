local fallout = require("fallout")

local start

function start()
    if fallout.script_action() == 2 then
        if fallout.source_obj() == fallout.dude_obj() then
            fallout.script_overrides()
            fallout.display_msg("You are now entering the world map.")
            fallout.world_map()
        end
    end
end

local exports = {}
exports.start = start
return exports
