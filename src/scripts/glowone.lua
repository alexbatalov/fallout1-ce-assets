local fallout = require("fallout")
local reputation = require("lib.reputation")

local start
local do_dialogue

local Hostile = 0
local initialized = false
local rndx = 0

function start()
    local v0 = 0
    if not initialized then
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 31)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 93)
        initialized = true
    end
    if fallout.script_action() == 11 then
        fallout.script_overrides()
        do_dialogue()
    else
        if (fallout.script_action() == 21) or (fallout.script_action() == 3) then
            fallout.script_overrides()
            fallout.display_msg(fallout.message_str(76, 100))
        else
            if fallout.script_action() == 4 then
                Hostile = 1
            else
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
                        if Hostile then
                            Hostile = 0
                            fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
                        end
                    else
                        if fallout.script_action() == 18 then
                            reputation.inc_good_critter()
                        end
                    end
                end
            end
        end
    end
end

function do_dialogue()
    rndx = fallout.random(1, 4)
    if rndx == 1 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(76, 101), 2)
    end
    if rndx == 2 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(76, 102), 2)
    end
    if rndx == 3 then
        fallout.display_msg(fallout.message_str(76, 103))
    end
    if rndx == 4 then
        fallout.display_msg(fallout.message_str(76, 104))
    end
end

local exports = {}
exports.start = start
return exports
