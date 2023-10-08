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
local Pick = 0
local only_once = 1
local message = 0

local exit_line = 0

function start()
    if only_once then
        only_once = 0
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 44)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 64)
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

function combat()
    hostile = 1
end

function critter_p_proc()
    if fallout.global_var(250) then
        hostile = 1
    end
    if fallout.tile_distance_objs(fallout.self_obj(), fallout.dude_obj()) > 12 then
        hostile = 0
    end
    if hostile then
        fallout.set_global_var(250, 1)
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
    Pick = fallout.random(1, 9)
    if Pick == 1 then
        message = fallout.message_str(618, 101)
    else
        if Pick == 2 then
            message = fallout.message_str(618, 102)
        else
            if Pick == 3 then
                message = fallout.message_str(618, 103)
            else
                if Pick == 4 then
                    message = fallout.message_str(618, 104)
                else
                    if Pick == 5 then
                        message = fallout.message_str(618, 105)
                    else
                        if Pick == 6 then
                            message = fallout.message_str(618, 106)
                        else
                            if Pick == 7 then
                                message = fallout.message_str(618, 107)
                            else
                                if Pick == 8 then
                                    message = fallout.message_str(618, 108)
                                else
                                    if Pick == 9 then
                                        message = fallout.message_str(618, 110) .. fallout.proto_data(fallout.obj_pid(fallout.dude_obj()), 1) .. fallout.message_str(618, 111)
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    fallout.float_msg(fallout.self_obj(), message, 0)
end

function destroy_p_proc()
    fallout.set_global_var(250, 1)
    fallout.rm_timer_event(fallout.self_obj())
    reputation.inc_good_critter()
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(618, 100))
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
return exports
