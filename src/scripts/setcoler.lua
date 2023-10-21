local fallout = require("fallout")

local start
local trap_stuff
local see_stuff
local find_trap
local find_iq
local disarm_trap
local disarm_mech
local failure
local explode
local close_cooler
local open_cooler

local damage = 0
local test = 0
local use_skill = 0

function start()
    if (fallout.script_action() == 3) or (fallout.script_action() == 21) then
        see_stuff()
    else
        if fallout.script_action() == 8 then
            trap_stuff()
        else
            if fallout.script_action() == 6 then
                if fallout.local_var(1) == 0 then
                    find_iq()
                else
                    if fallout.local_var(2) ~= 0 then
                        close_cooler()
                    else
                        open_cooler()
                    end
                end
            else
                if fallout.script_action() == 4 then
                    if fallout.local_var(2) == 0 then
                        fallout.script_overrides()
                    end
                end
            end
        end
    end
end

function trap_stuff()
    fallout.script_overrides()
    use_skill = fallout.action_being_used()
    if fallout.local_var(0) ~= 0 then
        if fallout.local_var(1) == 0 then
            if use_skill == 11 then
                disarm_trap()
            else
                if use_skill == 13 then
                    disarm_mech()
                else
                    fallout.display_msg(fallout.message_str(92, 100))
                end
            end
        end
    else
        find_trap()
    end
end

function see_stuff()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(92, 109))
end

function find_trap()
    if fallout.has_skill(fallout.dude_obj(), 11) then
        test = fallout.roll_vs_skill(fallout.dude_obj(), 11, -10)
        if fallout.is_success(test) then
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
        test = fallout.do_check(fallout.dude_obj(), 4, 0)
        if fallout.is_success(test) then
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
    test = fallout.roll_vs_skill(fallout.dude_obj(), 11, 10)
    if fallout.is_success(test) then
        fallout.display_msg(fallout.message_str(92, 103))
        fallout.set_local_var(1, 1)
    else
        if fallout.is_critical(test) then
            fallout.display_msg(fallout.message_str(92, 105))
            explode()
        else
            fallout.display_msg(fallout.message_str(92, 104))
        end
    end
end

function disarm_mech()
    fallout.script_overrides()
    test = fallout.roll_vs_skill(fallout.dude_obj(), 13, 30)
    if fallout.is_success(test) then
        fallout.display_msg(fallout.message_str(92, 103))
        fallout.set_local_var(1, 1)
    else
        if fallout.is_critical(test) then
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
    fallout.explosion(fallout.tile_num(fallout.self_obj()), fallout.elevation(fallout.self_obj()), 0)
    damage = fallout.random(1, 6) + fallout.random(1, 6) + fallout.random(1, 6)
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
return exports
