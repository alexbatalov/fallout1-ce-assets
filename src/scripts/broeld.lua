local fallout = require("fallout")

local start
local critter_p_proc
local talk_p_proc
local pickup_p_proc
local look_at_p_proc
local destroy_p_proc

local hostile = false
local initialized = false

function start()
    if not initialized then
        local self_obj = fallout.self_obj()
        fallout.critter_add_trait(self_obj, 1, 6, 44)
        fallout.critter_add_trait(self_obj, 1, 5, 80)
        initialized = true
    end

    local script_action = fallout.script_action()
    if script_action == 11 then
        talk_p_proc()
    elseif script_action == 12 then
        critter_p_proc()
    elseif script_action == 4 then
        pickup_p_proc()
    elseif script_action == 21 then
        look_at_p_proc()
    elseif script_action == 18 then
        destroy_p_proc()
    end
end

function critter_p_proc()
    if fallout.global_var(250) ~= 0 then
        hostile = true
    end
    if fallout.tile_distance_objs(fallout.self_obj(), fallout.dude_obj()) > 12 then
        hostile = false
    end
    if hostile then
        fallout.set_global_var(250, 1)
        hostile = false
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    end
end

function talk_p_proc()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(944, fallout.random(101, 105)), 2)
end

function pickup_p_proc()
    hostile = true
end

function look_at_p_proc()
    fallout.display_msg(fallout.message_str(944, 100))
end

function destroy_p_proc()
    fallout.set_global_var(250, 1)
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.talk_p_proc = talk_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.look_at_p_proc = look_at_p_proc
exports.destroy_p_proc = destroy_p_proc
return exports
