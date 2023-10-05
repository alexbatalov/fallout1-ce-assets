local fallout = require("fallout")

local start
local do_dialogue

local rndx = 0

function start()
    local v0 = 0
    if fallout.script_action() == 11 then
        do_dialogue()
        detach()
    else
        if fallout.script_action() == 12 then
            detach()
        else
            if fallout.script_action() == 13 then
                detach()
            end
        end
    end
end

function do_dialogue()
    rndx = fallout.random(1, 3)
    fallout.start_gdialog(-1, fallout.self_obj(), 4, -1, -1)
    fallout.sayStart()
    if rndx == 1 then
        fallout.sayMessage(0, "Go away.")
    end
    if rndx == 2 then
        fallout.sayMessage(0, "I don't like your kind.")
    end
    if rndx == 3 then
        fallout.sayMessage(0, "If you have a problem with Set, you have a problem with me.")
    end
    fallout.sayEnd()
    fallout.end_dialogue()
end

local exports = {}
exports.start = start
return exports
