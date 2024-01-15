local fallout = require("fallout")
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

function start()
    if not initialized then
        local self_obj = fallout.self_obj()
        if fallout.obj_is_carrying_obj_pid(self_obj, 41) == 0 then
            fallout.item_caps_adjust(self_obj, fallout.random(10, 100))
        end
        if fallout.global_var(613) == 9103 or fallout.global_var(613) == 9102 then
            fallout.critter_add_trait(self_obj, 1, 6, 0)
            local v0 = fallout.global_var(267)
            if v0 == 0 then
                fallout.set_external_var("InBladePtr1", self_obj)
            elseif v0 == 1 then
                fallout.set_external_var("InBladePtr2", self_obj)
            elseif v0 == 2 then
                fallout.set_external_var("InBladePtr3", self_obj)
            elseif v0 == 3 then
                fallout.set_external_var("InBladePtr4", self_obj)
            elseif v0 == 4 then
                fallout.set_external_var("InBladePtr5", self_obj)
            elseif v0 == 5 then
                fallout.set_external_var("InBladePtr6", self_obj)
            elseif v0 == 6 then
                fallout.set_external_var("InBladePtr7", self_obj)
            elseif v0 == 7 then
                fallout.set_external_var("InBladePtr8", self_obj)
                fallout.set_global_var(266, 1)
            end
            v0 = v0 + 1
            fallout.set_global_var(267, v0)
        else
            fallout.critter_add_trait(self_obj, 1, 6, 47)
        end
        initialized = true
    end
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(279, 100))
end

function description_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(279, 100))
end

function talk_p_proc()
    if fallout.global_var(253) == 1 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(669, fallout.random(100, 105)), 2)
    elseif fallout.global_var(613) == 2 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(279, fallout.random(101, 115)), 0)
    end
end

function critter_p_proc()
    local self_obj = fallout.self_obj()
    local dude_obj = fallout.dude_obj()
    if time.game_time_in_seconds() - PsstTime >= 30 and fallout.tile_distance_objs(self_obj, dude_obj) <= 4 and fallout.global_var(253) == 0 then
        if fallout.global_var(613) == 2 then
            fallout.float_msg(self_obj, fallout.message_str(279, fallout.random(101, 115)), 0)
        end
        PsstTime = time.game_time_in_seconds()
    end
    if fallout.obj_can_see_obj(self_obj, dude_obj) then
        if fallout.global_var(253) == 1 then
            fallout.attack(dude_obj, 0, 1, 0, 0, 30000, 0, 0)
        end
    end
end

function damage_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.set_global_var(253, 1)
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 47)
    end
end

function destroy_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.set_global_var(253, 1)
        reputation.inc_good_critter()
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 47)
    end
end

function pickup_p_proc()
    fallout.set_global_var(253, 1)
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
return exports
