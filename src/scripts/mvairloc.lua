local fallout = require("fallout")

local start
local use_stuff
local pick_lock

local unlocked = 0

function start()
    if fallout.script_action() == 15 then
        fallout.set_external_var("MVAirlock_ptr", fallout.self_obj())
    else
        if (fallout.script_action() == 21) or (fallout.script_action() == 3) then
            fallout.script_overrides()
            fallout.display_msg(fallout.message_str(427, 100))
        else
            if fallout.script_action() == 6 then
                use_stuff()
            else
                if fallout.script_action() == 8 then
                    if fallout.obj_pid(fallout.obj_being_used_with()) == 77 then
                        pick_lock()
                    end
                end
            end
        end
    end
end

function use_stuff()
    if not(unlocked) then
        fallout.script_overrides()
        fallout.display_msg(fallout.message_str(427, 101))
    end
end

function pick_lock()
    fallout.script_overrides()
    if unlocked then
        fallout.display_msg(fallout.message_str(427, 102))
    else
        if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 9, -30)) then
            fallout.display_msg(fallout.message_str(427, 103))
            unlocked = 1
        else
            fallout.display_msg(fallout.message_str(427, 104))
        end
    end
end

local exports = {}
exports.start = start
return exports
