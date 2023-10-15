local fallout = require("fallout")
local reputation = require("lib.reputation")

local start
local do_dialogue

local Hostile = 0
local initialized = false
local rndx = 0

function start()
    if not initialized then
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 30)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 41)
        initialized = true
    end
    if fallout.script_action() == 11 then
        if fallout.global_var(249) then
            fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
        else
            do_dialogue()
        end
    else
        if (fallout.script_action() == 21) or (fallout.script_action() == 3) then
            fallout.script_overrides()
            fallout.display_msg(fallout.message_str(230, 100))
        else
            if fallout.script_action() == 4 then
                Hostile = 1
            else
                if fallout.script_action() == 12 then
                    if fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) and fallout.global_var(249) then
                        Hostile = 1
                    end
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

function do_dialogue()
    rndx = fallout.random(1, 3)
    if rndx == 1 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(230, 101), 3)
    end
    if rndx == 2 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(230, 102), 3)
    end
    if rndx == 3 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(230, 103), 3)
    end
end

local exports = {}
exports.start = start
return exports
