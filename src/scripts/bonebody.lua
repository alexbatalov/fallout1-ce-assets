local fallout = require("fallout")

local start

local rndx = 0

function start()
    if (fallout.script_action() == 21) or (fallout.script_action() == 3) then
        fallout.script_overrides()
        rndx = fallout.random(1, 3)
        if rndx == 1 then
            fallout.display_msg(fallout.message_str(293, 100))
        else
            if rndx == 2 then
                fallout.display_msg(fallout.message_str(293, 101))
            else
                if rndx == 3 then
                    fallout.display_msg(fallout.message_str(293, 102))
                end
            end
        end
    end
end

local exports = {}
exports.start = start
return exports
