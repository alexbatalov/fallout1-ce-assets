local fallout = require("fallout")
local reputation = require("lib.reputation")

local start
local critter_p_proc
local pickup_p_proc
local talk_p_proc
local destroy_p_proc

local initialized = false
local hostile = false
local my_script_mode = false

function start()
    if not initialized then
        local self_obj = fallout.self_obj()
        fallout.critter_add_trait(self_obj, 1, 6, 29)
        fallout.critter_add_trait(self_obj, 1, 5, 11)
        if fallout.cur_map_index() ~= 29 then
            fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
            my_script_mode = true
        else
            if fallout.global_var(123) == 3 then
                fallout.move_to(self_obj, 7000, 0)
                fallout.set_obj_visibility(self_obj, true)
            end
        end
        initialized = true
    end

    local script_action = fallout.script_action()
    if not my_script_mode then
        if script_action == 18 then
            destroy_p_proc()
        elseif script_action == 12 then
            critter_p_proc()
        elseif script_action == 4 then
            pickup_p_proc()
        elseif script_action == 11 then
            talk_p_proc()
        end
    else
        if script_action == 18 then
            destroy_p_proc()
        end
    end
end

function critter_p_proc()
    if hostile then
        hostile = false
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    end
end

function pickup_p_proc()
    hostile = true
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
