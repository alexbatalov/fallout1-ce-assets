local fallout = require("fallout")
local reputation = require("lib.reputation")

local start
local do_dialogue

local Hostile = 0
local initialized = 0

function start()
    if not(initialized) then
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 30)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 78)
        initialized = 1
    end
    if fallout.script_action() == 22 then
        Hostile = 1
    else
        if fallout.script_action() == 11 then
            if fallout.local_var(0) == 0 then
                fallout.set_local_var(0, 1)
                do_dialogue()
            end
        else
            if (fallout.script_action() == 21) or (fallout.script_action() == 3) then
                fallout.script_overrides()
                fallout.display_msg(fallout.message_str(231, 100))
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
    end
end

function do_dialogue()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(231, 101), 0)
    fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(5), 1)
end

local exports = {}
exports.start = start
return exports
