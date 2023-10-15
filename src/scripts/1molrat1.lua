local fallout = require("fallout")
local reputation = require("lib.reputation")

local start

local count = 0
local initialized = false

function start()
    if not initialized then
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 8)
        initialized = true
    end
    if fallout.script_action() == 12 then
        if fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) ~= 0 then
            fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
        end
    else
        if fallout.script_action() == 18 then
            reputation.inc_evil_critter()
        end
    end
end

local exports = {}
exports.start = start
return exports
