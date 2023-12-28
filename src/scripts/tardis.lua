local fallout = require("fallout")

local start
local map_enter_p_proc
local spatial_p_proc
local use_p_proc

function start()
    local script_action = fallout.script_action()
    if script_action == 15 then
        map_enter_p_proc()
    elseif script_action == 2 then
        spatial_p_proc()
    elseif script_action == 6 then
        use_p_proc()
    end
end

function map_enter_p_proc()
    local self_obj = fallout.self_obj()
    if fallout.obj_pid(self_obj) == 33555090 then
        fallout.set_external_var("Tardis_ptr", self_obj)
    end
    if fallout.metarule(14, 0) ~= 0 then
        fallout.override_map_start(113, 107, 0, 0)
        fallout.display_msg(fallout.message_str(112, 317))
    end
end

function spatial_p_proc()
    fallout.reg_anim_func(2, fallout.dude_obj())
    fallout.play_sfx("STARDIS1")
    fallout.use_obj(fallout.external_var("Tardis_ptr"))
    fallout.destroy_object(fallout.self_obj())
end

function use_p_proc()
    if fallout.source_obj() ~= fallout.dude_obj() then
        fallout.animate_stand_obj(fallout.self_obj())
    end
end

local exports = {}
exports.start = start
exports.map_enter_p_proc = map_enter_p_proc
exports.spatial_p_proc = spatial_p_proc
exports.use_p_proc = use_p_proc
return exports
