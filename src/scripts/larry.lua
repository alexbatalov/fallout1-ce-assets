local fallout = require("fallout")
local misc = require("lib.misc")
local reputation = require("lib.reputation")
local time = require("lib.time")

local start
local pickup_p_proc
local talk_p_proc
local destroy_p_proc
local look_at_p_proc
local mutant00
local mutant01
local mutant02
local combat
local critter_p_proc

local hostile = false
local initialized = false

function start()
    if not initialized then
        local self_obj = fallout.self_obj()
        misc.set_team(self_obj, 34)
        fallout.critter_add_trait(self_obj, 1, 5, 79)
        fallout.set_local_var(1, 0)
        initialized = true
    end

    local script_action = fallout.script_action()
    if (script_action == 11) then
        talk_p_proc()
    elseif script_action == 21 then
        look_at_p_proc()
    elseif script_action == 4 then
        pickup_p_proc()
    elseif script_action == 12 then
        critter_p_proc()
    elseif script_action == 18 then
        destroy_p_proc()
    end
end

function pickup_p_proc()
    hostile = true
end

function talk_p_proc()
    if fallout.global_var(35) < 1 then
        if fallout.global_var(306) == 0 then
            mutant00()
        else
            fallout.display_msg(fallout.message_str(80, 108))
        end
    end
end

function destroy_p_proc()
    fallout.set_global_var(35, fallout.global_var(35) + 1)
    if fallout.global_var(35) > fallout.global_var(551) then
        fallout.set_global_var(155, fallout.global_var(155) + 3)
        fallout.set_global_var(29, 2)
        fallout.set_global_var(225, time.game_time_in_days())
    end
    reputation.inc_evil_critter()
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(80, 101))
end

function mutant00()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(80, 102), 3)
end

function mutant01()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(80, 103), 3)
    combat()
end

function mutant02()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(80, 107), 3)
    combat()
end

function combat()
    hostile = true
end

function critter_p_proc()
    local self_obj = fallout.self_obj()
    local dude_obj = fallout.dude_obj()
    if fallout.global_var(35) > 0 and fallout.obj_can_see_obj(self_obj, dude_obj) then
        hostile = true
    end
    if hostile then
        hostile = false
        fallout.attack(dude_obj, 0, 1, 0, 0, 30000, 0, 0)
    else
        local self_tile_num = fallout.tile_num(self_obj)
        if fallout.global_var(306) == 1 and self_tile_num ~= 15507 then
            fallout.animate_move_obj_to_tile(self_obj, 15507, 0)
        elseif fallout.global_var(306) == 1 and self_tile_num == 15507 then
            fallout.set_global_var(306, 2)
        elseif fallout.global_var(306) == 2 and self_tile_num ~= 12536 then
            fallout.animate_move_obj_to_tile(self_obj, 12536, 0)
        elseif fallout.global_var(306) == 2 and self_tile_num == 12536 then
            fallout.set_obj_visibility(self_obj, true)
        end
    end
end

local exports = {}
exports.start = start
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.critter_p_proc = critter_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
return exports
