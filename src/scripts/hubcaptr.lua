local fallout = require("fallout")
local misc = require("lib.misc")
local reaction = require("lib.reaction")
local reputation = require("lib.reputation")

local start
local combat
local critter_p_proc
local pickup_p_proc
local talk_p_proc
local destroy_p_proc
local look_at_p_proc

local hostile = false
local initialized = false

function start()
    if not initialized then
        local self_obj = fallout.self_obj()
        misc.set_team(self_obj, 38)
        misc.set_ai(self_obj, 85)
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
    end
end

function combat()
    hostile = true
end

function critter_p_proc()
    local self_obj = fallout.self_obj()
    local dude_obj = fallout.dude_obj()
    if hostile then
        hostile = false
        fallout.attack(dude_obj, 0, 1, 0, 0, 30000, 0, 0)
    end
    if fallout.obj_can_see_obj(self_obj, dude_obj) then
        hostile = true
        local num = fallout.random(105, 108)
        if num == 108 then
            if fallout.get_critter_stat(dude_obj, 34) ~= 0 then
                num = 109
            end
        end
        fallout.float_msg(self_obj, fallout.message_str(652, num), 8)
    end
end

function pickup_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        hostile = true
    end
end

function talk_p_proc()
    reaction.get_reaction()
    fallout.set_local_var(4, fallout.local_var(4) + 1)
    if fallout.local_var(4) < 4 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(652, 100 + fallout.local_var(4)), 8)
    else
        fallout.float_msg(fallout.self_obj(), fallout.message_str(652, 104), 8)
        combat()
    end
end

function destroy_p_proc()
    fallout.set_map_var(0, fallout.map_var(0) + 1)
    reputation.inc_evil_critter()
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(652, 100))
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
return exports
