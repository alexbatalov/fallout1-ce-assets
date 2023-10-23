local fallout = require("fallout")
local light = require("lib.light")

local start
local map_enter_p_proc
local map_update_p_proc

local CAPS <const> = {
    1,
    32,
    105,
    298,
    730,
    1645,
    2976,
    5709,
    8443,
    10765,
}

function start()
    local script_action = fallout.script_action()
    if script_action == 15 then
        map_enter_p_proc()
    elseif script_action == 23 then
        map_update_p_proc()
    end
end

function map_enter_p_proc()
    light.lighting()

    local crate_obj = fallout.create_object_sid(180, 19919, 0, -1)
    local caps_obj = fallout.create_object_sid(41, 0, 0, -1)
    local luck = fallout.get_critter_stat(fallout.dude_obj(), 6)
    local qty = CAPS[luck] * (fallout.has_trait(0, fallout.dude_obj(), 20) + 1)
    fallout.add_mult_objs_to_inven(crate_obj, caps_obj, qty)

    if fallout.metarule(14, 0) ~= 0 then
        fallout.override_map_start(130, 107, 0, 0)
        fallout.display_msg(fallout.message_str(112, 315))
    end
end

function map_update_p_proc()
    light.lighting()
end

local exports = {}
exports.start = start
exports.map_enter_p_proc = map_enter_p_proc
exports.map_update_p_proc = map_update_p_proc
return exports
