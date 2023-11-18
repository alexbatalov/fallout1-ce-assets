local fallout = require("fallout")
local behaviour = require("lib.behaviour")
local reputation = require("lib.reputation")

local start
local critter_p_proc
local damage_p_proc
local destroy_p_proc
local look_at_p_proc
local talk_p_proc
local float_line0
local float_line1
local float_line2

local initialized = false

function start()
    if not initialized then
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 46)
        if fallout.local_var(0) == 0 then
            if fallout.get_critter_stat(fallout.self_obj(), 34) == 0 then
                fallout.set_local_var(0, fallout.random(100, 104))
            else
                fallout.set_local_var(0, fallout.random(105, 109))
            end
        end
        if fallout.global_var(129) == 2 then
            if fallout.random(0, 1) then
                fallout.kill_critter(fallout.self_obj(), 59)
            else
                fallout.kill_critter(fallout.self_obj(), 57)
            end
        end
        initialized = true
    else
        if fallout.script_action() == 12 then
            critter_p_proc()
        else
            if fallout.script_action() == 14 then
                damage_p_proc()
            else
                if fallout.script_action() == 18 then
                    destroy_p_proc()
                else
                    if fallout.script_action() == 21 then
                        look_at_p_proc()
                    else
                        if fallout.script_action() == 11 then
                            talk_p_proc()
                        end
                    end
                end
            end
        end
    end
end

function critter_p_proc()
    if fallout.global_var(129) == 2 then
        fallout.set_external_var("removal_ptr", fallout.self_obj())
    end
    if fallout.local_var(1) or fallout.global_var(256) then
        if fallout.tile_distance_objs(fallout.dude_obj(), fallout.self_obj()) < 8 then
            behaviour.flee_dude(1)
        end
    end
end

function damage_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.set_local_var(1, 1)
    end
end

function destroy_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.set_global_var(256, 1)
    end
    reputation.inc_good_critter()
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(259, fallout.local_var(0)))
end

function talk_p_proc()
    fallout.script_overrides()
    if fallout.local_var(1) or fallout.global_var(256) then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(669, fallout.random(100, 105)), 0)
    else
        if fallout.global_var(133) == 1 then
            float_line1()
        else
            if fallout.global_var(132) == 1 then
                float_line2()
            else
                float_line0()
            end
        end
    end
end

function float_line0()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(259, fallout.random(110, 117)), 0)
end

function float_line1()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(259, fallout.random(118, 122)), 0)
end

function float_line2()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(259, fallout.random(123, 126)), 0)
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.damage_p_proc = damage_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
exports.talk_p_proc = talk_p_proc
return exports
