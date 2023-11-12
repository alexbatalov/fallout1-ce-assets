local fallout = require("fallout")

local start
local pickup_p_proc
local talk_p_proc
local critter_p_proc
local destroy_p_proc
local look_at_p_proc

local initialized = false
local hostile = false
local oktoyell = true

function start()
    if not initialized then
        local self_obj = fallout.self_obj()
        fallout.critter_add_trait(self_obj, 1, 6, 30)
        if fallout.global_var(31) == 1 then
            fallout.set_obj_visibility(self_obj, false)
        else
            fallout.set_obj_visibility(self_obj, true)
        end
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

function pickup_p_proc()
    hostile = true
end

function talk_p_proc()
    if fallout.global_var(31) == 2 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(535, 102), 8)
    else
        fallout.float_msg(fallout.self_obj(), fallout.message_str(535, 101), 8)
    end
end

function critter_p_proc()
    local dude_obj = fallout.dude_obj()
    if hostile then
        hostile = false
        fallout.attack(dude_obj, 0, 1, 0, 0, 30000, 0, 0)
    end
    if fallout.global_var(31) ~= 2 then
        local self_obj = fallout.self_obj()
        local distance_self_to_dude = fallout.tile_distance_objs(self_obj, dude_obj)
        if distance_self_to_dude > 7 then
            hostile = true
        elseif distance_self_to_dude > 4 and oktoyell then
            oktoyell = false
            fallout.float_msg(self_obj, fallout.message_str(535, 103), 8)
        elseif distance_self_to_dude < 5 then
            oktoyell = true
        end
    end
end

function destroy_p_proc()
    fallout.set_global_var(607, 3)
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.set_global_var(160, fallout.global_var(160) + 1)
    end
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(535, 100))
end

local exports = {}
exports.start = start
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.critter_p_proc = critter_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
return exports
