local fallout = require("fallout")
local light = require("lib.light")

local start
local map_enter_p_proc
local map_update_p_proc

fallout.create_external_var("Tardis_ptr")

function start()
    if fallout.script_action() == 15 then
        map_enter_p_proc()
    else
        if fallout.script_action() == 23 then
            map_update_p_proc()
        end
    end
end

function map_enter_p_proc()
    light.lighting()
end

function map_update_p_proc()
    light.lighting()
end

local exports = {}
exports.start = start
exports.map_enter_p_proc = map_enter_p_proc
exports.map_update_p_proc = map_update_p_proc
return exports
