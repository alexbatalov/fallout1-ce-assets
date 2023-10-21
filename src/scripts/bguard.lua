local fallout = require("fallout")

local start
local pickup_p_proc
local talk_p_proc
local critter_p_proc
local look_at_p_proc

local hostile = false

function start()
    local script_action = fallout.script_action()
    if script_action == 11 then
        talk_p_proc()
    elseif script_action == 12 then
        critter_p_proc()
    elseif script_action == 4 then
        pickup_p_proc()
    elseif script_action == 21 or script_action == 3 then
        look_at_p_proc()
    end
end

function pickup_p_proc()
    hostile = true
end

function talk_p_proc()
    local msg = fallout.message_str(4, 101 + fallout.random(0, 6))
    fallout.float_msg(fallout.self_obj(), msg, 0)
end

function critter_p_proc()
    if hostile then
        hostile = false
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    end
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(4, 100))
end

local exports = {}
exports.start = start
exports.talk_p_proc = talk_p_proc
exports.critter_p_proc = critter_p_proc
exports.look_at_p_proc = look_at_p_proc
return exports
