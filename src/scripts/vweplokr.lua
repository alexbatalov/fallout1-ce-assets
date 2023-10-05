local fallout = require("fallout")

local start
local map_enter_p_proc

function start()
    if fallout.script_action() == 15 then
        map_enter_p_proc()
    end
end

function map_enter_p_proc()
    fallout.set_external_var("VWeapLocker_ptr", fallout.self_obj())
end

local exports = {}
exports.start = start
exports.map_enter_p_proc = map_enter_p_proc
return exports
