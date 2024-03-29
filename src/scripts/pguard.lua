local fallout = require("fallout")
local misc = require("lib.misc")
local reputation = require("lib.reputation")
local time = require("lib.time")

local start
local look_at_p_proc
local description_p_proc
local talk_p_proc
local critter_p_proc
local damage_p_proc
local destroy_p_proc
local pickup_p_proc

local initialized = false
local PsstTime = 0

local timed_event_p_proc

function start()
    if not initialized then
        local self_obj = fallout.self_obj()
        if fallout.obj_is_carrying_obj_pid(self_obj, 41) == 0 then
            fallout.item_caps_adjust(self_obj, fallout.random(1, 10))
        end
        misc.set_team(self_obj, 89)
        misc.set_ai(self_obj, 29)
        fallout.add_timer_event(self_obj, fallout.game_ticks(fallout.random(1, 3)), 1)
        if fallout.local_var(5) == 0 then
            fallout.set_map_var(1, fallout.map_var(1) + 1)
            fallout.set_local_var(5, 1)
        end
        initialized = true
    end
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(252, 100))
end

function description_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(252, 100))
end

function talk_p_proc()
    if fallout.global_var(251) == 1 or fallout.global_var(616) == 1 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(669, fallout.random(100, 105)), 2)
    else
        fallout.float_msg(fallout.self_obj(), fallout.message_str(252, fallout.random(134, 138)), 0)
    end
end

function critter_p_proc()
    local self_obj = fallout.self_obj()
    local dude_obj = fallout.dude_obj()
    if fallout.obj_can_see_obj(self_obj, dude_obj) then
        if fallout.global_var(251) == 1 or fallout.global_var(616) == 1 then
            fallout.attack(dude_obj, 0, 1, 0, 0, 30000, 0, 0)
        end
    end
    if time.game_time_in_seconds() - PsstTime >= 30
        and fallout.tile_distance_objs(self_obj, dude_obj) <= 4
        and fallout.global_var(251) == 0
        and fallout.global_var(616) == 0 then
        fallout.float_msg(self_obj, fallout.message_str(252, fallout.random(134, 138)), 0)
        PsstTime = time.game_time_in_seconds()
    end
end

function damage_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.set_global_var(616, 1)
    end
end

function destroy_p_proc()
    fallout.set_map_var(1, fallout.map_var(1) - 1)
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.set_global_var(616, 1)
        reputation.inc_evil_critter()
    end
    if fallout.map_var(1) == 0 then
        fallout.terminate_combat()
    end
end

function pickup_p_proc()
    fallout.set_global_var(616, 1)
end

function timed_event_p_proc()
    if fallout.global_var(612) == 9003 or fallout.global_var(613) == 9103 then
        if fallout.local_var(4) == 0 then
            fallout.set_local_var(4, 1)
            fallout.float_msg(fallout.self_obj(), fallout.message_str(252, 139), 2)
            fallout.attack(fallout.external_var("JonPtr"), 0, 1, 100, 250, 300, 0, 128)
        end
    else
        fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(fallout.random(1, 3)), 1)
    end
end

local exports = {}
exports.start = start
exports.look_at_p_proc = look_at_p_proc
exports.description_p_proc = description_p_proc
exports.talk_p_proc = talk_p_proc
exports.critter_p_proc = critter_p_proc
exports.damage_p_proc = damage_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.timed_event_p_proc = timed_event_p_proc
return exports
