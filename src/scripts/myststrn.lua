local fallout = require("fallout")

local start
local destroy_p_proc
local talk_p_proc

local initialized = false
local Item = 0

function start()
    if not initialized and fallout.metarule(14, 0) then
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 0)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 92)
        Item = fallout.create_object_sid(fallout.global_var(288), 0, 0, -1)
        fallout.add_obj_to_inven(fallout.self_obj(), Item)
        fallout.float_msg(fallout.self_obj(), fallout.message_str(766, 182 + fallout.random(0, 1)), 0)
        initialized = true
    else
        if fallout.script_action() == 18 then
            destroy_p_proc()
        else
            if fallout.script_action() == 11 then
                talk_p_proc()
            end
        end
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
