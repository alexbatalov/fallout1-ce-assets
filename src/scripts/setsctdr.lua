local fallout = require("fallout")

local start
local use_p_proc
local use_skill_on_p_proc
local find_trap
local find_iq
local disarm_trap
local disarm_mech
local failure
local explode
local use_door

function start()
    local script_action = fallout.script_action()
    if script_action == 6 then
        use_p_proc()
    elseif script_action == 8 then
        use_skill_on_p_proc()
    end
end

function use_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        if fallout.local_var(2) ~= 0 then
            use_door()
        end
        if fallout.local_var(3) == 0 then
            fallout.set_local_var(3, 1)
            local xp = 100
            fallout.give_exp_points(xp)
            fallout.display_msg(fallout.message_str(96, 200) .. xp .. fallout.message_str(96, 201))
        else
            if fallout.local_var(1) ~= 0 then
                use_door()
            elseif fallout.local_var(0) ~= 0 then
                failure()
            else
                find_iq()
            end
        end
    else
        use_door()
    end
end

function use_skill_on_p_proc()
    local skill = fallout.action_being_used()
    if fallout.local_var(1) == 0 then
        if fallout.local_var(0) ~= 0 then
            if skill == 11 then
                disarm_trap()
            elseif skill == 13 then
                disarm_mech()
            end
        end
    else
        find_trap()
    end
end

function find_trap()
    fallout.script_overrides()
    local roll = fallout.roll_vs_skill(fallout.dude_obj(), 11, -20)
    if fallout.is_success(roll) then
        fallout.display_msg(fallout.message_str(96, 100))
        fallout.set_local_var(0, 1)
    else
        fallout.display_msg(fallout.message_str(96, 104))
        explode()
    end
end

function find_iq()
    fallout.script_overrides()
    local roll = fallout.do_check(fallout.dude_obj(), 4, 2)
    if fallout.is_success(roll) then
        fallout.display_msg(fallout.message_str(96, 100))
        fallout.set_local_var(0, 1)
    else
        fallout.display_msg(fallout.message_str(96, 104))
        explode()
    end
end

function disarm_trap()
    fallout.script_overrides()
    local roll = fallout.roll_vs_skill(fallout.dude_obj(), 11, 0)
    if fallout.is_success(roll) then
        fallout.display_msg(fallout.message_str(96, 102))
        fallout.set_local_var(1, 1)
    else
        if fallout.is_critical(roll) then
            fallout.display_msg(fallout.message_str(96, 104))
            explode()
        else
            fallout.display_msg(fallout.message_str(96, 103))
        end
    end
end

function disarm_mech()
    fallout.script_overrides()
    local roll = fallout.roll_vs_skill(fallout.dude_obj(), 13, 20)
    if fallout.is_success(roll) then
        fallout.display_msg(fallout.message_str(96, 102))
        fallout.set_local_var(1, 1)
    else
        if fallout.is_critical(roll) then
            fallout.display_msg(fallout.message_str(96, 104))
            explode()
        else
            fallout.display_msg(fallout.message_str(96, 103))
        end
    end
end

function failure()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(96, 105))
    explode()
end

function explode()
    fallout.set_local_var(1, 1)
    local self_obj = fallout.self_obj()
    fallout.explosion(fallout.tile_num(self_obj), fallout.elevation(self_obj), 0)
    local damage = fallout.random(1, 6) + fallout.random(1, 6) + fallout.random(1, 6) + fallout.random(1, 6) +
        fallout.random(1, 6) + fallout.random(1, 6)
    fallout.critter_dmg(fallout.dude_obj(), damage, 0)
end

function use_door()
    if fallout.local_var(2) ~= 0 then
        fallout.set_local_var(2, 0)
    else
        fallout.set_local_var(2, 1)
    end
end

local exports = {}
exports.start = start
exports.use_p_proc = use_p_proc
exports.use_skill_on_p_proc = use_skill_on_p_proc
return exports
