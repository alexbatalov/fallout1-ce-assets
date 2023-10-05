local fallout = require("fallout")

local start
local do_dialogue

local in_combat = 0
local rndx = 0
local rndy = 0
local new_obj = 0
local new_obj_picked = 0
local my_tile = 0
local scared = 0

function start()
    local v0 = 0
    local v1 = 0
    local v2 = 0
    local v3 = 0
    local v4 = 0
    if fallout.script_action() == 11 then
        do_dialogue()
    end
end

function do_dialogue()
    fallout.start_gdialog(7, fallout.self_obj(), 4, -1, -1)
    rndx = fallout.random(0, 6)
    if rndx == 0 then
        fallout.sayMessage(0, fallout.message_str(7, 102))
    end
    if rndx == 1 then
        fallout.sayMessage(0, fallout.message_str(7, 103))
    end
    if rndx == 2 then
        fallout.sayMessage(0, fallout.message_str(7, 104))
    end
    if rndx == 3 then
        fallout.sayMessage(0, fallout.message_str(7, 105))
    end
    if rndx == 4 then
        fallout.sayMessage(0, fallout.message_str(7, 106))
    end
    if rndx == 5 then
        fallout.sayMessage(0, fallout.message_str(7, 107))
    end
    if rndx == 6 then
        fallout.sayMessage(0, fallout.message_str(7, 108))
    end
    fallout.end_dialogue()
end

local exports = {}
exports.start = start
return exports
