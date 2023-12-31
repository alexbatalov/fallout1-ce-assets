local fallout = require("fallout")
local reputation = require("lib.reputation")

local start
local spies
local guilt
local talk_p_proc

local Hostile = 0
local initialized = false

function start()
    if not initialized then
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 31)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 41)
        initialized = true
    end
    if fallout.script_action() == 11 then
        talk_p_proc()
    else
        if (fallout.script_action() == 21) or (fallout.script_action() == 3) then
            fallout.script_overrides()
            fallout.display_msg(fallout.message_str(109, 100))
        else
            if fallout.script_action() == 4 then
                Hostile = 1
            else
                if fallout.script_action() == 12 then
                    if Hostile then
                        Hostile = 0
                        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
                    else
                        if fallout.local_var(0) == 0 then
                            if (fallout.global_var(30) == 1) and (fallout.global_var(31) ~= 2) then
                                if fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) and (fallout.tile_distance_objs(fallout.self_obj(), fallout.dude_obj()) < 5) then
                                    fallout.set_local_var(0, 1)
                                    guilt()
                                end
                            end
                        end
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

function spies()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(109, 101), 0)
end

function guilt()
    if fallout.random(0, 1) then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(109, 200), 0)
    else
        fallout.float_msg(fallout.self_obj(), fallout.message_str(109, 201), 0)
    end
end

function talk_p_proc()
    if (fallout.global_var(30) == 1) and (fallout.global_var(31) ~= 2) then
        guilt()
    else
        spies()
    end
end

local exports = {}
exports.start = start
exports.talk_p_proc = talk_p_proc
return exports
