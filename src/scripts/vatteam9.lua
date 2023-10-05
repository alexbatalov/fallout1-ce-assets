local fallout = require("fallout")

local start
local critter_p_proc
local description_p_proc
local destroy_p_proc
local pickup_p_proc

local hostile = 0
local initialized = 0

function start()
    if not(initialized) then
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 34)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 48)
        initialized = 1
    end
    if fallout.script_action() == 12 then
        critter_p_proc()
    else
        if fallout.script_action() == 3 then
            description_p_proc()
        else
            if fallout.script_action() == 18 then
                destroy_p_proc()
            else
                if fallout.script_action() == 4 then
                    pickup_p_proc()
                end
            end
        end
    end
end

function critter_p_proc()
    if fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) then
        if fallout.global_var(146) then
            hostile = 1
        else
            if not(fallout.obj_pid(fallout.critter_inven_obj(fallout.dude_obj(), 0)) == 113) then
                hostile = 1
            end
        end
    end
end

function description_p_proc()
    fallout.display_msg(fallout.message_str(370, 100))
end

function destroy_p_proc()
    fallout.set_external_var("Team9_Count", fallout.external_var("Team9_Count") - 1)
    if fallout.source_obj() == fallout.dude_obj() then
        if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1)) then
            fallout.set_global_var(156, 1)
            fallout.set_global_var(157, 0)
        end
        if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(160) > (3 * fallout.global_var(159))) or (fallout.global_var(157) == 1)) then
            fallout.set_global_var(157, 1)
            fallout.set_global_var(156, 0)
        end
        fallout.set_global_var(160, fallout.global_var(160) + 1)
        if (fallout.global_var(160) % 6) == 0 then
            fallout.set_global_var(155, fallout.global_var(155) + 1)
        end
    end
end

function pickup_p_proc()
    hostile = 1
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.description_p_proc = description_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.pickup_p_proc = pickup_p_proc
return exports
