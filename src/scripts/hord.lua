local fallout = require("fallout")
local reputation = require("lib.reputation")

local start

local initialized = false

function start()
    if not initialized then
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 55)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 66)
        initialized = true
        fallout.move_to(fallout.self_obj(), 0, 0)
    end
    if fallout.local_var(0) == 0 then
        if fallout.map_var(4) ~= 0 then
            fallout.set_map_var(4, 0)
            fallout.set_local_var(0, 1)
            fallout.critter_attempt_placement(fallout.self_obj(), 18859, 0)
            fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
        end
    else
        if fallout.script_action() == 21 then
            fallout.script_overrides()
        else
            if fallout.script_action() == 18 then
                reputation.inc_evil_critter()
            end
        end
    end
end

local exports = {}
exports.start = start
return exports
