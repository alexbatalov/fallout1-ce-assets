local fallout = require("fallout")
local reputation = require("lib.reputation")

local start
local talk_p_proc
local destroy_p_proc
local look_at_p_proc
local guard00

function start()
    local script_action = fallout.script_action()
    if script_action == 11 then
        talk_p_proc()
    else
        if script_action == 18 then
            destroy_p_proc()
        else
            if script_action == 21 or script_action == 3 then
                look_at_p_proc()
            end
        end
    end
end

function talk_p_proc()
    guard00()
end

function destroy_p_proc()
    reputation.inc_good_critter()
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(38, 100))
end

function guard00()
    local rnd
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        rnd = fallout.random(1, 2)
    else
        rnd = fallout.random(1, 3)
    end
    if rnd == 1 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(38, 103), 0)
    elseif rnd == 2 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(38, 104), 0)
    elseif rnd == 3 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(38, 105), 0)
    end
end

local exports = {}
exports.start = start
exports.talk_p_proc = talk_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
return exports
