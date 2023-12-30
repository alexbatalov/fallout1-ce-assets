local fallout = require("fallout")

local start
local spatial_p_proc
local timed_event_p_proc

function start()
    local script_action = fallout.script_action()
    if script_action == 2 then
        spatial_p_proc()
    elseif script_action == 22 then
        timed_event_p_proc()
    end
end

function spatial_p_proc()
    local source_obj = fallout.source_obj()
    local dude_obj = fallout.dude_obj()

    if fallout.local_var(0) == 0 and source_obj == dude_obj then
        fallout.display_msg(fallout.message_str(304, 100))
        fallout.set_local_var(0, 1)
    end
    if fallout.local_var(1) == 0 and source_obj == dude_obj and fallout.global_var(139) ~= 0 and fallout.global_var(140) ~= 0 then
        fallout.display_msg(fallout.message_str(304, 101))
        fallout.set_local_var(1, 1)
        fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(7), 1)
    end
end

function timed_event_p_proc()
    local source_obj = fallout.source_obj()
    local dude_obj = fallout.dude_obj()
    local damage = fallout.random(1, 6) + 2
    local roll = fallout.do_check(source_obj, 5, 0)
    if fallout.is_success(roll) then
        if fallout.is_critical(roll) then
            if source_obj == dude_obj then
                fallout.display_msg(fallout.message_str(304, 102))
            end
        else
            if source_obj == dude_obj then
                fallout.display_msg(fallout.message_str(304, 103))
            end
            fallout.critter_dmg(source_obj, damage, 0)
            fallout.display_msg(fallout.message_str(304, 104) .. damage .. fallout.message_str(304, 105))
        end
    else
        if fallout.is_critical(roll) then
            if source_obj == dude_obj then
                fallout.display_msg(fallout.message_str(304, 106))
            end
            fallout.critter_dmg(source_obj, damage, 0)
            fallout.display_msg(fallout.message_str(304, 107) .. damage .. fallout.message_str(304, 108))
        else
            if source_obj == dude_obj then
                fallout.display_msg(fallout.message_str(304, 109))
            end
            fallout.critter_dmg(fallout.source_obj(), damage, 0)
            fallout.display_msg(fallout.message_str(304, 110) .. damage .. fallout.message_str(304, 111))
        end
    end
    fallout.set_local_var(1, 0)
end

local exports = {}
exports.start = start
exports.spatial_p_proc = spatial_p_proc
exports.timed_event_p_proc = timed_event_p_proc
return exports
