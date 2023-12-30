local fallout = require("fallout")

local start
local pickup_p_proc
local use_p_proc
local use_skill_on_p_proc
local look_at_p_proc
local find_trap
local find_iq
local disarm_trap
local disarm_mech
local failure
local explode
local close_cooler
local open_cooler

function start()
    local script_action = fallout.script_action()
    if script_action == 3 or script_action == 21 then
        look_at_p_proc()
    elseif script_action == 8 then
        use_skill_on_p_proc()
    elseif script_action == 6 then
        use_p_proc()
    elseif script_action == 4 then
        pickup_p_proc()
    end
end

function pickup_p_proc()
    if fallout.local_var(2) == 0 then
        fallout.script_overrides()
    end
end

function use_p_proc()
    if fallout.local_var(1) == 0 then
        find_iq()
    else
        if fallout.local_var(2) ~= 0 then
            close_cooler()
        else
            open_cooler()
        end
    end
end

function use_skill_on_p_proc()
    fallout.script_overrides()
    local skill = fallout.action_being_used()
    if fallout.local_var(0) ~= 0 then
        if fallout.local_var(1) == 0 then
            if skill == 11 then
                disarm_trap()
            elseif skill == 13 then
                disarm_mech()
            else
                fallout.display_msg(fallout.message_str(92, 100))
            end
        end
    else
        find_trap()
    end
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(92, 109))
end

function find_trap()
    if fallout.has_skill(fallout.dude_obj(), 11) then
        local roll = fallout.roll_vs_skill(fallout.dude_obj(), 11, -10)
        if fallout.is_success(roll) then
            fallout.display_msg(fallout.message_str(92, 101))
            fallout.set_local_var(0, 1)
        else
            fallout.display_msg(fallout.message_str(92, 102))
            explode()
        end
    end
end

function find_iq()
    fallout.script_overrides()
    if fallout.local_var(0) ~= 0 then
        failure()
    else
        local roll = fallout.do_check(fallout.dude_obj(), 4, 0)
        if fallout.is_success(roll) then
            fallout.display_msg(fallout.message_str(92, 101))
            fallout.set_local_var(0, 1)
        else
            fallout.display_msg(fallout.message_str(92, 102))
            explode()
        end
    end
end

function disarm_trap()
    fallout.script_overrides()
    local roll = fallout.roll_vs_skill(fallout.dude_obj(), 11, 10)
    if fallout.is_success(roll) then
        fallout.display_msg(fallout.message_str(92, 103))
        fallout.set_local_var(1, 1)
    else
        if fallout.is_critical(roll) then
            fallout.display_msg(fallout.message_str(92, 105))
            explode()
        else
            fallout.display_msg(fallout.message_str(92, 104))
        end
    end
end

function disarm_mech()
    fallout.script_overrides()
    local roll = fallout.roll_vs_skill(fallout.dude_obj(), 13, 30)
    if fallout.is_success(roll) then
        fallout.display_msg(fallout.message_str(92, 103))
        fallout.set_local_var(1, 1)
    else
        if fallout.is_critical(roll) then
            fallout.display_msg(fallout.message_str(92, 105))
            explode()
        else
            fallout.display_msg(fallout.message_str(92, 104))
        end
    end
end

function failure()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(92, 106))
    explode()
end

function explode()
    local self_obj = fallout.self_obj()
    fallout.explosion(fallout.tile_num(self_obj), fallout.elevation(self_obj), 0)
    local damage = fallout.random(1, 6) + fallout.random(1, 6) + fallout.random(1, 6)
    fallout.critter_dmg(fallout.dude_obj(), damage, 0)
    fallout.set_local_var(1, 1)
    fallout.set_local_var(0, 1)
end

function close_cooler()
    fallout.script_overrides()
    fallout.animate_stand_reverse_obj(fallout.self_obj())
    fallout.set_local_var(2, 0)
end

function open_cooler()
    fallout.script_overrides()
    fallout.animate_stand_obj(fallout.self_obj())
    fallout.set_local_var(2, 1)
end

local exports = {}
exports.start = start
exports.pickup_p_proc = pickup_p_proc
exports.use_p_proc = use_p_proc
exports.use_skill_on_p_proc = use_skill_on_p_proc
exports.look_at_p_proc = look_at_p_proc
return exports
