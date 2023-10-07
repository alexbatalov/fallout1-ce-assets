local fallout = require("fallout")

local start
local do_dialogue

local rndx = 0
local hostile = 0

function start()
    if fallout.script_action() == 11 then
        do_dialogue()
    else
        if fallout.script_action() == 12 then
            if hostile then
                hostile = 0
                fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
            end
        else
            if fallout.script_action() == 4 then
                hostile = 1
            else
                if (fallout.script_action() == 21) or (fallout.script_action() == 3) then
                    fallout.script_overrides()
                    fallout.display_msg(fallout.message_str(4, 100))
                end
            end
        end
    end
end

function do_dialogue()
    local v0 = 0
    rndx = fallout.random(0, 6)
    if rndx == 0 then
        v0 = fallout.message_str(4, 101)
    end
    if rndx == 1 then
        v0 = fallout.message_str(4, 102)
    end
    if rndx == 2 then
        v0 = fallout.message_str(4, 103)
    end
    if rndx == 3 then
        v0 = fallout.message_str(4, 104)
    end
    if rndx == 4 then
        v0 = fallout.message_str(4, 105)
    end
    if rndx == 5 then
        v0 = fallout.message_str(4, 106)
    end
    if rndx == 6 then
        v0 = fallout.message_str(4, 107)
    end
    fallout.float_msg(fallout.self_obj(), v0, 0)
end

local exports = {}
exports.start = start
return exports
