local fallout = require("fallout")

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
            if fallout.source_obj() == fallout.dude_obj() then
                if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1)) then
                    fallout.set_global_var(156, 1)
                    fallout.set_global_var(157, 0)
                end
                if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(160) > (3 * fallout.global_var(159))) or (fallout.global_var(157) == 1)) then
                    fallout.set_global_var(157, 1)
                    fallout.set_global_var(156, 0)
                end
                fallout.set_global_var(159, fallout.global_var(159) + 1)
                if (fallout.global_var(159) % 2) == 0 then
                    fallout.set_global_var(155, fallout.global_var(155) - 1)
                end
            end
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
