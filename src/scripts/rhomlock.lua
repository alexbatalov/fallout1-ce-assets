local fallout = require("fallout")
local misc = require("lib.misc")

local start
local use_p_proc
local pickup_p_proc
local use_skill_on_p_proc
local timed_event_p_proc

local initialized = false
local Test = 0

function start()
    if not initialized then
        fallout.set_external_var("locker_ptr", fallout.self_obj())
        initialized = true
    end

    local script_action = fallout.script_action()
    if script_action == 22 then
        timed_event_p_proc()
    elseif script_action == 6 then
        use_p_proc()
    elseif script_action == 4 then
        pickup_p_proc()
    elseif script_action == 8 then
        use_skill_on_p_proc()
    end
end

function use_p_proc()
    local source_obj = fallout.source_obj()
    local dude_obj = fallout.dude_obj()
    if source_obj == dude_obj then
        local bonus = -35
        local failure = true
        if misc.party_member_count() > 1 then
            fallout.set_map_var(19, 2)
        else
            if source_obj == dude_obj then
                if fallout.using_skill(dude_obj, 8) then
                    local roll = fallout.roll_vs_skill(dude_obj, 8, bonus)
                    if fallout.is_success(roll) then
                        failure = false
                    else
                        failure = true
                    end
                    if fallout.has_skill(dude_obj, 8) < 40 then
                        failure = true
                    end
                end
            end
            if failure then
                fallout.display_msg(fallout.message_str(56, 204))
                fallout.set_map_var(19, 2)
            else
                fallout.display_msg(fallout.message_str(56, 205))
            end
        end
        fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(1), 1)
    end
end

function pickup_p_proc()
    use_p_proc()
end

function use_skill_on_p_proc()
    if fallout.action_being_used() == 9 then
        fallout.display_msg(fallout.message_str(56, 208))
    end
end

function timed_event_p_proc()
    if not fallout.combat_is_initialized() then
        fallout.obj_close(fallout.self_obj())
    end
end

local exports = {}
exports.start = start
exports.use_p_proc = use_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.use_skill_on_p_proc = use_skill_on_p_proc
exports.timed_event_p_proc = timed_event_p_proc
return exports
