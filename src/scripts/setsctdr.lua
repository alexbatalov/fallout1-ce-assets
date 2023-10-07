local fallout = require("fallout")

local start
local trap_stuff
local find_trap
local find_iq
local disarm_trap
local disarm_mech
local failure
local explode
local use_door

local damage = 0
local test = 0
local temp = 0
local use_skill = 0

function start()
    if fallout.script_action() == 6 then
        if fallout.source_obj() == fallout.dude_obj() then
            if fallout.local_var(2) then
                use_door()
            end
            if fallout.local_var(3) == 0 then
                fallout.set_local_var(3, 1)
                temp = 100
                fallout.give_exp_points(temp)
                fallout.display_msg(fallout.message_str(96, 200) .. temp .. fallout.message_str(96, 201))
            else
                if fallout.local_var(1) then
                    use_door()
                else
                    if fallout.local_var(0) then
                        failure()
                    else
                        find_iq()
                    end
                end
            end
        else
            use_door()
        end
    else
        if fallout.script_action() == 8 then
            trap_stuff()
        end
    end
end

function trap_stuff()
    use_skill = fallout.action_being_used()
    if fallout.local_var(1) == 0 then
        if fallout.local_var(0) then
            if use_skill == 11 then
                disarm_trap()
            else
                if use_skill == 13 then
                    disarm_mech()
                end
            end
        end
    else
        find_trap()
    end
end

function find_trap()
    fallout.script_overrides()
    test = fallout.roll_vs_skill(fallout.dude_obj(), 11, -20)
    if fallout.is_success(test) then
        fallout.display_msg(fallout.message_str(96, 100))
        fallout.set_local_var(0, 1)
    else
        fallout.display_msg(fallout.message_str(96, 104))
        explode()
    end
end

function find_iq()
    fallout.script_overrides()
    test = fallout.do_check(fallout.dude_obj(), 4, 2)
    if fallout.is_success(test) then
        fallout.display_msg(fallout.message_str(96, 100))
        fallout.set_local_var(0, 1)
    else
        fallout.display_msg(fallout.message_str(96, 104))
        explode()
    end
end

function disarm_trap()
    fallout.script_overrides()
    test = fallout.roll_vs_skill(fallout.dude_obj(), 11, 0)
    if fallout.is_success(test) then
        fallout.display_msg(fallout.message_str(96, 102))
        fallout.set_local_var(1, 1)
    else
        if fallout.is_critical(test) then
            fallout.display_msg(fallout.message_str(96, 104))
            explode()
        else
            fallout.display_msg(fallout.message_str(96, 103))
        end
    end
end

function disarm_mech()
    fallout.script_overrides()
    test = fallout.roll_vs_skill(fallout.dude_obj(), 13, 20)
    if fallout.is_success(test) then
        fallout.display_msg(fallout.message_str(96, 102))
        fallout.set_local_var(1, 1)
    else
        if fallout.is_critical(test) then
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
    fallout.explosion(fallout.tile_num(fallout.self_obj()), fallout.elevation(fallout.self_obj()), 0)
    damage = fallout.random(1, 6) + fallout.random(1, 6) + fallout.random(1, 6) + fallout.random(1, 6) + fallout.random(1, 6) + fallout.random(1, 6)
    fallout.critter_dmg(fallout.dude_obj(), damage, 0)
end

function use_door()
    if fallout.local_var(2) then
        fallout.set_local_var(2, 0)
    else
        fallout.set_local_var(2, 1)
    end
end

local exports = {}
exports.start = start
return exports
