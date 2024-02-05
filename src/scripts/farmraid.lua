local fallout = require("fallout")
local misc = require("lib.misc")
local time = require("lib.time")

local start
local talk_p_proc
local critter_p_proc
local destroy_p_proc

local initialized = false
local PsstTime = 0

function start()
    if not initialized then
        local self_obj = fallout.self_obj()
        if fallout.obj_is_carrying_obj_pid(self_obj, 41) == 0 then
            fallout.item_caps_adjust(self_obj, fallout.random(1, 10))
        end
        misc.set_team(self_obj, 6)
        fallout.critter_add_trait(self_obj, 1, 5, 17)
        if fallout.local_var(4) == 0 then
            fallout.set_global_var(269, fallout.global_var(269) + 1)
            fallout.set_local_var(4, 1)
        end
        initialized = true
    end
end

function talk_p_proc()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(935, fallout.random(300, 303)), 0)
end

function critter_p_proc()
    local dude_obj = fallout.dude_obj()
    local self_obj = fallout.self_obj()
    if fallout.obj_can_see_obj(self_obj, dude_obj) then
        fallout.attack(dude_obj, 0, 1, 0, 0, 30000, 0, 0)
    end
    if time.game_time_in_seconds() - PsstTime >= 30 and fallout.tile_distance_objs(self_obj, dude_obj) <= 4 then
        fallout.float_msg(self_obj, fallout.message_str(935, fallout.random(300, 303)), 0)
        PsstTime = time.game_time_in_seconds()
    end
end

function destroy_p_proc()
    fallout.set_global_var(269, fallout.global_var(269) - 1)
    if fallout.global_var(269) == 0 then
        fallout.set_global_var(307, 2)
    end
end

local exports = {}
exports.start = start
exports.talk_p_proc = talk_p_proc
exports.critter_p_proc = critter_p_proc
exports.destroy_p_proc = destroy_p_proc
return exports
