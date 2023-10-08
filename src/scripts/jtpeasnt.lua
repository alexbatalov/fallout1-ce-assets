local fallout = require("fallout")
local reputation = require("lib.reputation")

local start
local do_dialogue
local guard00
local first
local notfirst

function start()
    local v0 = 0
    if fallout.script_action() == 11 then
        do_dialogue()
    else
        if fallout.script_action() == 18 then
            reputation.inc_good_critter()
        else
            if (fallout.script_action() == 21) or (fallout.script_action() == 3) then
                fallout.script_overrides()
                fallout.display_msg(fallout.message_str(38, 100))
            end
        end
    end
end

function do_dialogue()
    guard00()
end

function guard00()
    local v0 = 0
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        v0 = fallout.random(1, 2)
    else
        v0 = fallout.random(1, 3)
    end
    if v0 == 1 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(38, 103), 0)
    else
        if v0 == 2 then
            fallout.float_msg(fallout.self_obj(), fallout.message_str(38, 104), 0)
        else
            if v0 == 3 then
                fallout.float_msg(fallout.self_obj(), fallout.message_str(38, 105), 0)
            end
        end
    end
end

function first()
end

function notfirst()
end

local exports = {}
exports.start = start
return exports
