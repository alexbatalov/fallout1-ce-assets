local fallout = require("fallout")
local reputation = require("lib.reputation")

local start
local combat
local critter_p_proc
local pickup_p_proc
local talk_p_proc
local destroy_p_proc
local look_at_p_proc

local hostile = 0
local only_once = 1
local rndx = 0

function start()
    if only_once then
        only_once = 0
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 32)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 78)
    end
    if fallout.script_action() == 21 then
        look_at_p_proc()
    else
        if fallout.script_action() == 4 then
            pickup_p_proc()
        else
            if fallout.script_action() == 11 then
                talk_p_proc()
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
                        critter_p_proc()
                    else
                        if fallout.script_action() == 18 then
                            destroy_p_proc()
                        end
                    end
                end
            end
        end
    end
end

function combat()
    hostile = 1
end

function critter_p_proc()
    if (fallout.global_var(30) ~= 0) and (fallout.global_var(31) ~= 2) then
        if fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) and (fallout.tile_distance_objs(fallout.self_obj(), fallout.dude_obj()) < 9) then
            fallout.float_msg(fallout.self_obj(), fallout.message_str(791, 102), 2)
            hostile = 1
        end
    end
    if hostile then
        hostile = 0
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    end
end

function pickup_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        hostile = 1
    end
end

function talk_p_proc()
    if fallout.global_var(30) ~= 0 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(791, 102), 2)
    else
        fallout.float_msg(fallout.self_obj(), fallout.message_str(791, 101), 2)
    end
end

function destroy_p_proc()
    reputation.inc_evil_critter()
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(791, 100))
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
return exports
