local fallout = require("fallout")

local start

local HEREBEFORE = 0

function start()
    if fallout.script_action() == 2 then
        if fallout.source_obj() == fallout.dude_obj() then
            if not(HEREBEFORE) then
                HEREBEFORE = 1
                fallout.display_msg(fallout.message_str(91, 100))
            end
        end
    end
end

local exports = {}
exports.start = start
return exports
