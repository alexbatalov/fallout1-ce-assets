local fallout = require("fallout")

local start

function start()
    local v0 = 0
    local v1 = 0
    local v2 = 0
    local v3 = 0
    v0 = fallout.get_critter_stat(fallout.dude_obj(), 0)
    v1 = fallout.get_critter_stat(fallout.dude_obj(), 5)
    v2 = fallout.get_critter_stat(fallout.dude_obj(), 6)
    v3 = v0 + v1 + v2
    if (fallout.script_action() == 21) and (fallout.script_action() == 3) then
        fallout.script_overrides()
        fallout.display_msg(fallout.message_str(298, 100))
    else
        if fallout.script_action() == 6 then
            if (v0 < 8) and (v3 < 18) then
                fallout.script_overrides()
                fallout.display_msg(fallout.message_str(298, 101))
            end
        end
    end
end

local exports = {}
exports.start = start
return exports
