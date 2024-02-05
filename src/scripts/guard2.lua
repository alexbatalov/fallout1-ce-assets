local fallout = require("fallout")
local misc = require("lib.misc")
local reputation = require("lib.reputation")

local start
local pickup_p_proc
local talk_p_proc
local critter_p_proc
local damage_p_proc
local destroy_p_proc
local look_at_p_proc

local initialized = false
local hostile = false
local oktoyell = true
local active = false

function start()
    if not initialized then
        local self_obj = fallout.self_obj()
        misc.set_team(self_obj, 30)
        misc.set_ai(self_obj, 78)
        if fallout.global_var(227) == 1 then
            active = true
            fallout.set_obj_visibility(self_obj, false)
        else
            fallout.set_obj_visibility(self_obj, true)
        end
        initialized = true
    end
    if active then
        local script_action = fallout.script_action()
        if script_action == 11 then
            talk_p_proc()
        elseif script_action == 14 then
            damage_p_proc()
        elseif script_action == 12 then
            critter_p_proc()
        elseif script_action == 4 then
            pickup_p_proc()
        elseif script_action == 21 then
            look_at_p_proc()
        elseif script_action == 18 then
            destroy_p_proc()
        end
    end
end

function pickup_p_proc()
    hostile = true
end

function talk_p_proc()
    if fallout.global_var(31) == 2 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(535, 102), 8)
    else
        fallout.float_msg(fallout.self_obj(), fallout.message_str(535, 101), 8)
    end
end

function critter_p_proc()
    local self_obj = fallout.self_obj()
    local dude_obj = fallout.dude_obj()
    if fallout.global_var(249) ~= 0 and fallout.obj_can_see_obj(self_obj, dude_obj) then
        hostile = true
    end
    if hostile then
        hostile = false
        fallout.set_global_var(227, 0)
        fallout.set_global_var(249, 1)
        fallout.attack(dude_obj, 0, 1, 0, 0, 30000, 0, 0)
    else
        if fallout.global_var(31) ~= 2 then
            local distance_self_to_dude = fallout.tile_distance_objs(self_obj, dude_obj)
            if distance_self_to_dude > 7 then
                hostile = true
            elseif distance_self_to_dude > 4 and oktoyell then
                oktoyell = false
                fallout.float_msg(self_obj, fallout.message_str(535, 103), 8)
            elseif distance_self_to_dude < 5 then
                oktoyell = true
            end
        end
    end
end

function damage_p_proc()
    hostile = true
end

function destroy_p_proc()
    fallout.set_global_var(607, 3)
    fallout.set_global_var(227, 0)
    fallout.set_global_var(249, 1)
    reputation.inc_evil_critter()
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(535, 100))
end

local exports = {}
exports.start = start
return exports
