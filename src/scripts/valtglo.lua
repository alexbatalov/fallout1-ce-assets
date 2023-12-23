local fallout = require("fallout")
local reputation = require("lib.reputation")

local start
local critter_p_proc
local pickup_p_proc
local talk_p_proc
local combat_p_proc
local destroy_p_proc
local look_at_p_proc

local hostile = false
local initialized = false

function start()
    if not initialized then
        local self_obj = fallout.self_obj()
        fallout.critter_add_trait(self_obj, 1, 6, 30)
        fallout.critter_add_trait(self_obj, 1, 5, 41)
        initialized = true
    end

    local script_action = fallout.script_action()
    if script_action == 21 then
        look_at_p_proc()
    elseif script_action == 4 then
        pickup_p_proc()
    elseif script_action == 11 then
        talk_p_proc()
    elseif script_action == 13 then
        combat_p_proc()
    elseif script_action == 12 then
        critter_p_proc()
    elseif script_action == 18 then
        destroy_p_proc()
    end
end

function critter_p_proc()
    if hostile then
        hostile = false
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    end
end

function pickup_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        hostile = true
    end
end

function talk_p_proc()
    if fallout.global_var(30) ~= 0 and fallout.global_var(31) ~= 2 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(792, 102), 2)
    else
        fallout.display_msg(fallout.message_str(792, 101))
    end
end

function combat_p_proc()
    if fallout.fixed_param() == 2 then
        local rads = fallout.random(1, 6) - 5
        if rads < 0 then
            rads = 0
        end
        if rads > 0 then
            fallout.radiation_inc(fallout.target_obj(), rads)
        end
    end
end

function destroy_p_proc()
    reputation.inc_evil_critter()
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(792, 100))
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.combat_p_proc = combat_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
return exports
