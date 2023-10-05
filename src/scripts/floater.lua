local fallout = require("fallout")

local start
local destroy_p_proc
local critter_p_proc

local start_init = 0
local hostile = 0

function start()
    local v0 = 0
    if not(start_init) and fallout.metarule(14, 0) then
        v0 = fallout.obj_pid(fallout.self_obj())
        if v0 == 16777261 then
            fallout.critter_add_trait(fallout.self_obj(), 1, 5, 73)
            fallout.critter_add_trait(fallout.self_obj(), 1, 6, 43)
        else
            if v0 == 16777259 then
                fallout.critter_add_trait(fallout.self_obj(), 1, 5, 72)
                fallout.critter_add_trait(fallout.self_obj(), 1, 6, 43)
            end
        end
        start_init = 1
    else
        if fallout.script_action() == 18 then
            destroy_p_proc()
        else
            if fallout.script_action() == 12 then
                critter_p_proc()
            end
        end
    end
end

function destroy_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
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
end

function critter_p_proc()
    if not(hostile) then
        fallout.attack_complex(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
        hostile = 1
    end
end

local exports = {}
exports.start = start
exports.destroy_p_proc = destroy_p_proc
exports.critter_p_proc = critter_p_proc
return exports
