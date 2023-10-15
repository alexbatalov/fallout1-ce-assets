local fallout = require("fallout")

local start
local description_p_proc
local map_enter_p_proc
local use_p_proc

local initialized = false

function start()
    if fallout.script_action() == 3 then
        description_p_proc()
    else
        if fallout.script_action() == 15 then
            map_enter_p_proc()
        else
            if fallout.script_action() == 6 then
                use_p_proc()
            end
        end
    end
end

function description_p_proc()
    fallout.display_msg(fallout.message_str(343, 100))
end

function map_enter_p_proc()
    fallout.set_external_var("vault_door_ptr", fallout.self_obj())
    if fallout.obj_is_open(fallout.self_obj()) then
        fallout.use_obj(fallout.self_obj())
    end
end

function use_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.script_overrides()
        fallout.display_msg(fallout.message_str(343, 100))
    end
end

local exports = {}
exports.start = start
exports.description_p_proc = description_p_proc
exports.map_enter_p_proc = map_enter_p_proc
exports.use_p_proc = use_p_proc
return exports
