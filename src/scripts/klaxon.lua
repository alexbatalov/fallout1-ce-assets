local fallout = require("fallout")

local start
local map_update_p_proc

function start()
    if fallout.script_action() == 23 then
        map_update_p_proc()
    end
end

function map_update_p_proc()
    local v0 = 0
    if fallout.global_var(146) and (fallout.local_var(0) == 0) then
        fallout.set_local_var(0, 1)
        if fallout.obj_pid(fallout.self_obj()) == 33555260 then
            v0 = fallout.create_object_sid(33555340, fallout.tile_num(fallout.self_obj()), fallout.elevation(fallout.self_obj()), -1)
        else
            v0 = fallout.create_object_sid(33555339, fallout.tile_num(fallout.self_obj()), fallout.elevation(fallout.self_obj()), -1)
        end
    end
end

local exports = {}
exports.start = start
exports.map_update_p_proc = map_update_p_proc
return exports
