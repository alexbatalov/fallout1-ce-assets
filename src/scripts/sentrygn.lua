local fallout = require("fallout")

local start

function start()
    local v0 = 0
    local v1 = 0
    if fallout.script_action() == 2 then
        if (fallout.local_var(0) == 0) and (fallout.obj_type(fallout.source_obj()) == fallout.dude_obj()) then
            fallout.display_msg(fallout.message_str(304, 100))
            fallout.set_local_var(0, 1)
        end
        if (fallout.local_var(1) == 0) and (fallout.obj_type(fallout.source_obj()) == fallout.dude_obj()) and fallout.global_var(139) and fallout.global_var(140) then
            fallout.display_msg(fallout.message_str(304, 101))
            fallout.set_local_var(1, 1)
            fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(7), 1)
        end
    else
        if fallout.script_action() == 22 then
            v0 = fallout.random(1, 6) + 2
            v1 = fallout.do_check(fallout.source_obj(), 5, 0)
            if fallout.is_success(v1) then
                if fallout.is_critical(v1) then
                    if fallout.obj_type(fallout.source_obj()) == fallout.dude_obj() then
                        fallout.display_msg(fallout.message_str(304, 102))
                    end
                else
                    if fallout.obj_type(fallout.source_obj()) == fallout.dude_obj() then
                        fallout.display_msg(fallout.message_str(304, 103))
                    end
                    fallout.critter_dmg(fallout.source_obj(), v0, 0)
                    fallout.display_msg(fallout.message_str(304, 104) + v0 + fallout.message_str(304, 105))
                end
            else
                if fallout.is_critical(v1) then
                    if fallout.obj_type(fallout.source_obj()) == fallout.dude_obj() then
                        fallout.display_msg(fallout.message_str(304, 106))
                    end
                    fallout.critter_dmg(fallout.source_obj(), v0, 0)
                    fallout.display_msg(fallout.message_str(304, 107) + v0 + fallout.message_str(304, 108))
                else
                    if fallout.obj_type(fallout.source_obj()) == fallout.dude_obj() then
                        fallout.display_msg(fallout.message_str(304, 109))
                    end
                    fallout.critter_dmg(fallout.source_obj(), v0, 0)
                    fallout.display_msg(fallout.message_str(304, 110) + v0 + fallout.message_str(304, 111))
                end
            end
            fallout.set_local_var(1, 0)
        end
    end
end

local exports = {}
exports.start = start
return exports
