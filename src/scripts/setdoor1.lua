local fallout = require("fallout")

local start
local do_stuff
local do_skill
local see_stuff
local doorend

local lockpicks = 0
local testa = 0

function start()
    local v0 = 0
    if fallout.script_action() == 21 then
        fallout.script_overrides()
        see_stuff()
    end
    if fallout.script_action() == 6 then
        fallout.script_overrides()
        do_stuff()
    end
    if fallout.script_action() == 7 then
        lockpicks = fallout.obj_being_used_with()
        fallout.script_overrides()
        do_skill()
    end
end

function do_stuff()
    fallout.display_msg(fallout.message_str(94, 107))
end

function do_skill()
    if fallout.has_skill(fallout.dude_obj(), 9) then
        testa = fallout.roll_vs_skill(fallout.dude_obj(), 9, -10)
        if fallout.is_success(testa) then
            fallout.display_msg(fallout.message_str(94, 100))
            fallout.set_local_var(0, 1)
        else
            fallout.display_msg(fallout.message_str(94, 101))
            if fallout.is_critical(testa) then
                fallout.display_msg(fallout.message_str(94, 102))
                fallout.rm_obj_from_inven(fallout.dude_obj(), lockpicks)
            end
        end
    else
        fallout.display_msg(fallout.message_str(94, 103))
    end
end

function see_stuff()
    if fallout.local_var(0) == 0 then
        fallout.display_msg(fallout.message_str(94, 104))
    else
        if fallout.local_var(2) == 1 then
            fallout.display_msg(fallout.message_str(94, 105))
        else
            fallout.display_msg(fallout.message_str(94, 106))
        end
    end
end

function doorend()
end

local exports = {}
exports.start = start
return exports
