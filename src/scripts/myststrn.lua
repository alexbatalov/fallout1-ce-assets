local fallout = require("fallout")
local misc = require("lib.misc")

local start
local destroy_p_proc
local talk_p_proc

local initialized = false

function start()
    if not initialized and misc.map_first_run() then
        local self_obj = fallout.self_obj()
        misc.set_team(self_obj, 0)
        misc.set_ai(self_obj, 92)
        local item_obj = fallout.create_object_sid(fallout.global_var(288), 0, 0, -1)
        fallout.add_obj_to_inven(self_obj, item_obj)
        fallout.float_msg(self_obj, fallout.message_str(766, 182 + fallout.random(0, 1)), 0)
        initialized = true
    end

    local script_action = fallout.script_action()
    if script_action == 18 then
        destroy_p_proc()
    elseif script_action == 11 then
        talk_p_proc()
    end
end

function destroy_p_proc()
    fallout.set_global_var(601, 1)
end

function talk_p_proc()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(766, 184 + fallout.random(0, 1)), 0)
end

local exports = {}
exports.start = start
exports.destroy_p_proc = destroy_p_proc
exports.talk_p_proc = talk_p_proc
return exports
