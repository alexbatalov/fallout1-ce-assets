local fallout = require("fallout")
local reputation = require("lib.reputation")

local start

local Hostile = 0
local initialized = false

function start()
    if not initialized then
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 30)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 42)
        initialized = true
    end
    if fallout.script_action() == 11 then
        fallout.display_msg(fallout.message_str(95, 100))
    else
        if fallout.script_action() == 4 then
            Hostile = 1
        else
            if fallout.script_action() == 12 then
                if Hostile then
                    Hostile = 0
                    fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
                end
            else
                if fallout.script_action() == 18 then
                    reputation.inc_evil_critter()
                end
            end
        end
    end
end

local exports = {}
exports.start = start
return exports
