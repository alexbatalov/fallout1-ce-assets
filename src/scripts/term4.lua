local fallout = require("fallout")

local start
local map_update_p_proc
local map_enter_p_proc
local look_at_p_proc

function start()
    if fallout.script_action() == 15 then
        map_enter_p_proc()
    else
        if fallout.script_action() == 23 then
            map_update_p_proc()
        else
            if fallout.script_action() == 21 then
                look_at_p_proc()
            else
                if fallout.script_action() == 6 then
                    if fallout.source_obj() ~= fallout.external_var("Vree_ptr") then
                        fallout.display_msg(fallout.message_str(725, 101))
                    else
                        fallout.float_msg(fallout.self_obj(), fallout.message_str(58, fallout.random(300, 308)), 8)
                    end
                end
            end
        end
    end
end

function map_update_p_proc()
    fallout.set_external_var("term4_ptr", fallout.self_obj())
end

function map_enter_p_proc()
    fallout.set_external_var("term4_ptr", fallout.self_obj())
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(725, 100))
end

local exports = {}
exports.start = start
exports.map_update_p_proc = map_update_p_proc
exports.map_enter_p_proc = map_enter_p_proc
exports.look_at_p_proc = look_at_p_proc
return exports
