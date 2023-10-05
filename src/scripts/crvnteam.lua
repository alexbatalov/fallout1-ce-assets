local fallout = require("fallout")

local start
local critter_p_proc
local destroy_p_proc
local initialize_p_proc

local Only_Once = 0

function start()
    if Only_Once == 0 then
        initialize_p_proc()
    else
        if fallout.script_action() == 12 then
            critter_p_proc()
        else
            if fallout.script_action() == 18 then
                destroy_p_proc()
            end
        end
    end
end

function critter_p_proc()
end

function destroy_p_proc()
    if fallout.obj_pid(fallout.self_obj()) == 16777420 then
        fallout.set_global_var(216, fallout.global_var(216) - 1)
    else
        fallout.set_global_var(215, 0)
    end
    if fallout.source_obj() == fallout.dude_obj() then
        if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1)) then
            fallout.set_global_var(156, 1)
            fallout.set_global_var(157, 0)
        end
        if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(160) > (3 * fallout.global_var(159))) or (fallout.global_var(157) == 1)) then
            fallout.set_global_var(157, 1)
            fallout.set_global_var(156, 0)
        end
        fallout.set_global_var(159, fallout.global_var(159) + 1)
        if (fallout.global_var(159) % 2) == 0 then
            fallout.set_global_var(155, fallout.global_var(155) - 1)
        end
    end
end

function initialize_p_proc()
    Only_Once = 1
    fallout.critter_add_trait(fallout.self_obj(), 1, 6, 0)
    fallout.critter_add_trait(fallout.self_obj(), 1, 5, 1)
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.initialize_p_proc = initialize_p_proc
return exports
