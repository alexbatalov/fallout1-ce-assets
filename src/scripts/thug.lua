local fallout = require("fallout")
local reputation = require("lib.reputation")

local start
local critter_p_proc
local pickup_p_proc
local talk_p_proc
local destroy_p_proc

local initialized = false
local hostile = 0
local my_script_mode = 0

function start()
    if not initialized then
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 29)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 11)
        if fallout.cur_map_index() ~= 29 then
            fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
            my_script_mode = 1
        else
            if fallout.global_var(123) == 3 then
                fallout.move_to(fallout.self_obj(), 7000, 0)
                fallout.set_obj_visibility(fallout.self_obj(), 1)
            end
        end
        initialized = true
    else
        if not(my_script_mode) then
            if fallout.script_action() == 18 then
                destroy_p_proc()
            else
                if fallout.script_action() == 12 then
                    critter_p_proc()
                else
                    if fallout.script_action() == 4 then
                        pickup_p_proc()
                    else
                        if fallout.script_action() == 11 then
                            talk_p_proc()
                        end
                    end
                end
            end
        else
            if fallout.script_action() == 18 then
                destroy_p_proc()
            end
        end
    end
end

function critter_p_proc()
    if hostile then
        hostile = 0
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    end
end

function pickup_p_proc()
    hostile = 1
end

function talk_p_proc()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(383, 100), 0)
end

function destroy_p_proc()
    reputation.inc_evil_critter()
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.destroy_p_proc = destroy_p_proc
return exports
