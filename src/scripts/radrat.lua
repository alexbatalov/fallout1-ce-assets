local fallout = require("fallout")
local reputation = require("lib.reputation")

local start

local rndx = 0
local initialized = false

function start()
    if not initialized then
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 9)
        initialized = true
    end
    if fallout.script_action() == 13 then
        if fallout.fixed_param() == 2 then
            rndx = fallout.random(1, 6) - 5
            if rndx < 0 then
                rndx = 0
            end
            if rndx > 0 then
                fallout.radiation_inc(fallout.target_obj(), rndx)
            end
        end
    else
        if fallout.script_action() == 12 then
            if fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) ~= 0 then
                if fallout.has_trait(0, fallout.dude_obj(), 44) == 0 then
                    fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
                end
            end
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
