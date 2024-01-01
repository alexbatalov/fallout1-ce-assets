local fallout = require("fallout")
local reaction = require("lib.reaction")
local reputation = require("lib.reputation")
local time = require("lib.time")

local start
local combat
local critter_p_proc
local pickup_p_proc
local talk_p_proc
local destroy_p_proc
local look_at_p_proc
local damage_p_proc
local combat_p_proc
local Wife01
local Wife02
local Wife03
local Wife04

local hostile = false
local initialized = false
local visible = true

function start()
    if not initialized then
        local self_obj = fallout.self_obj()
        if fallout.global_var(111) == 5 then
            fallout.set_obj_visibility(self_obj, false)
            visible = false
        end
        fallout.critter_add_trait(self_obj, 1, 6, 42)
        fallout.critter_add_trait(self_obj, 1, 5, 5)
        initialized = true
    end

    local script_action = fallout.script_action()
    if script_action == 21 then
        look_at_p_proc()
    elseif script_action == 4 then
        pickup_p_proc()
    elseif script_action == 11 then
        talk_p_proc()
    elseif script_action == 12 then
        critter_p_proc()
    elseif script_action == 18 then
        destroy_p_proc()
    elseif script_action == 14 then
        damage_p_proc()
    elseif script_action == 13 then
        combat_p_proc()
    end
end

function combat()
    hostile = true
end

function critter_p_proc()
    if not visible then
        fallout.script_overrides()
    else
        local self_obj = fallout.self_obj()
        local dude_obj = fallout.dude_obj()
        if hostile then
            hostile = false
            fallout.attack(dude_obj, 0, 1, 0, 0, 30000, 0, 0)
        end
        if fallout.map_var(5) == 1 then
            if fallout.obj_can_hear_obj(self_obj, dude_obj) or fallout.obj_can_see_obj(self_obj, dude_obj) then
                combat()
            end
        else
            if time.is_morning() or time.is_day() then
                if fallout.tile_num(self_obj) ~= 22114 then
                    fallout.animate_move_obj_to_tile(self_obj, 22114, 0)
                end
            else
                if fallout.tile_num(self_obj) ~= 25108 then
                    fallout.animate_move_obj_to_tile(self_obj, 25108, 0)
                end
            end
        end
    end
end

function pickup_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        hostile = true
    end
end

function talk_p_proc()
    reaction.get_reaction()
    if time.is_night() then
        Wife03()
    elseif fallout.global_var(248) == 1 then
        Wife04()
    elseif fallout.local_var(4) == 0 then
        fallout.set_local_var(4, 1)
        Wife01()
    else
        Wife02()
    end
end

function destroy_p_proc()
    reputation.inc_good_critter()
    fallout.set_map_var(0, fallout.map_var(0) + 1)
    if fallout.map_var(0) > 1 then
        fallout.set_global_var(111, 2)
    end
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(584, 100))
end

function damage_p_proc()
    fallout.set_map_var(5, 1)
    fallout.set_global_var(111, 5)
end

function combat_p_proc()
    fallout.critter_set_flee_state(fallout.self_obj(), true)
end

function Wife01()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(584, 101), 2)
end

function Wife02()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(584, 102), 2)
end

function Wife03()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(584, fallout.random(103, 105)), 2)
end

function Wife04()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(584, 106), 2)
    combat()
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
exports.damage_p_proc = damage_p_proc
exports.combat_p_proc = combat_p_proc
return exports
