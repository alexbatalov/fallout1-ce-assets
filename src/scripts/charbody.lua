local fallout = require("fallout")

local start

local rndx = 0

function start()
    if (fallout.script_action() == 21) or (fallout.script_action() == 3) then
        fallout.script_overrides()
        rndx = fallout.random(1, 4)
        if rndx == 1 then
            fallout.display_msg(fallout.message_str(292, 100))
        else
            if rndx == 2 then
                fallout.display_msg(fallout.message_str(292, 101))
            else
                if rndx == 3 then
                    fallout.display_msg(fallout.message_str(292, 102))
                else
                    if rndx == 4 then
                        fallout.display_msg(fallout.message_str(292, 103))
                    end
                end
            end
        end
    else
        if fallout.script_action() == 6 then
            fallout.display_msg(fallout.message_str(292, 104))
            fallout.script_overrides()
        end
    end
end

local exports = {}
exports.start = start
return exports
