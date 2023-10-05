local fallout = require("fallout")

local start
local use_top
local use_middle
local use_bottom

function start()
    if fallout.script_action() == 6 then
        fallout.move_to(fallout.dude_obj(), 16307, 1)
    end
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.anim(fallout.source_obj(), 0, 0)
    end
end

function use_top()
    fallout.script_overrides()
    if fallout.obj_pid(fallout.self_obj()) == 33554576 then
        if fallout.external_var("Use_Manhole_Top") then
            fallout.set_external_var("Use_Manhole_Top", 0)
            fallout.animate_stand_obj(fallout.self_obj())
        else
            fallout.set_external_var("Use_Manhole_Top", 1)
            fallout.add_timer_event(fallout.self_obj(), 7, 1)
            fallout.animate_stand_reverse_obj(fallout.self_obj())
        end
    else
        if fallout.external_var("Use_Manhole_Top") then
            fallout.add_timer_event(fallout.self_obj(), 7, 1)
        else
            fallout.set_external_var("Use_Manhole_Top", 1)
            fallout.animate_stand_reverse_obj(fallout.external_var("Manhole_Pointer_Top"))
            fallout.add_timer_event(fallout.self_obj(), 7, 1)
        end
    end
end

function use_middle()
    fallout.script_overrides()
    if fallout.obj_pid(fallout.self_obj()) == 33554576 then
        if fallout.external_var("Use_Manhole_Middle") then
            fallout.set_external_var("Use_Manhole_Middle", 0)
            fallout.animate_stand_obj(fallout.self_obj())
        else
            fallout.set_external_var("Use_Manhole_Middle", 1)
            fallout.add_timer_event(fallout.self_obj(), 7, 1)
            fallout.animate_stand_reverse_obj(fallout.self_obj())
        end
    else
        if fallout.external_var("Use_Manhole_Middle") then
            fallout.add_timer_event(fallout.self_obj(), 7, 1)
        else
            fallout.set_external_var("Use_Manhole_Middle", 1)
            fallout.animate_stand_reverse_obj(fallout.external_var("Manhole_Pointer_Middle"))
            fallout.add_timer_event(fallout.self_obj(), 7, 1)
        end
    end
end

function use_bottom()
    fallout.script_overrides()
    if fallout.obj_pid(fallout.self_obj()) == 33554576 then
        if fallout.external_var("Use_Manhole_Bottom") then
            fallout.set_external_var("Use_Manhole_Bottom", 0)
            fallout.animate_stand_obj(fallout.self_obj())
        else
            fallout.set_external_var("Use_Manhole_Bottom", 1)
            fallout.add_timer_event(fallout.self_obj(), 7, 1)
            fallout.animate_stand_reverse_obj(fallout.self_obj())
        end
    else
        if fallout.external_var("Use_Manhole_Bottom") then
            fallout.add_timer_event(fallout.self_obj(), 7, 1)
        else
            fallout.set_external_var("Use_Manhole_Bottom", 1)
            fallout.animate_stand_reverse_obj(fallout.external_var("Manhole_Pointer_Bottom"))
            fallout.add_timer_event(fallout.self_obj(), 7, 1)
        end
    end
end

local exports = {}
exports.start = start
return exports
