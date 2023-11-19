local fallout = require("fallout")

local start
local description_p_proc
local map_enter_p_proc
local use_p_proc

function start()
    local script_action = fallout.script_action()
    if script_action == 3 then
        description_p_proc()
    elseif script_action == 15 then
        map_enter_p_proc()
    elseif script_action == 6 then
        use_p_proc()
    end
end

function description_p_proc()
    fallout.display_msg(fallout.message_str(343, 100))
end

function map_enter_p_proc()
    local self_obj = fallout.self_obj()
    fallout.set_external_var("vault_door_ptr", self_obj)
    if fallout.obj_is_open(self_obj) then
        fallout.use_obj(self_obj)
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
