local fallout = require("fallout")
local reputation = require("lib.reputation")

local start
local critter_p_proc
local destroy_p_proc
local look_at_p_proc
local pickup_p_proc
local talk_p_proc

local hostile = false
local initialized = false

function start()
    if not initialized then
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 56)
        if fallout.local_var(0) == 0 then
            fallout.set_local_var(0, fallout.random(100, 109))
        end
        initialized = true
    end

    local script_action = fallout.script_action()
    if script_action == 12 then
        critter_p_proc()
    elseif script_action == 18 then
        destroy_p_proc()
    elseif script_action == 21 then
        look_at_p_proc()
    elseif script_action == 4 then
        pickup_p_proc()
    elseif script_action == 11 then
        talk_p_proc()
    end
end

function critter_p_proc()
    if hostile then
        hostile = false
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    end
end

function destroy_p_proc()
    reputation.inc_evil_critter()
end

function look_at_p_proc()
    fallout.display_msg(fallout.message_str(260, fallout.local_var(0)))
end

function pickup_p_proc()
    hostile = true
end

function talk_p_proc()
    fallout.script_overrides()
    local rnd = fallout.random(110, 118)
    fallout.float_msg(fallout.self_obj(), fallout.message_str(260, rnd), 0)
    -- FIXME: Will never be true, probably should be 103/108?
    if rnd == 3 or rnd == 8 then
        hostile = true
    end
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
return exports
