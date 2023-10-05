local fallout = require("fallout")

local start
local destroy_p_proc
local look_at_p_proc
local talk_p_proc

local initialized = 1

function start()
    if not(initialized) then
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 20)
        if fallout.local_var(0) == 0 then
            fallout.set_local_var(0, fallout.random(100, 109))
        end
        initialized = 1
    else
        if fallout.script_action() == 18 then
            destroy_p_proc()
        else
            if fallout.script_action() == 21 then
                look_at_p_proc()
            else
                if fallout.script_action() == 11 then
                    talk_p_proc()
                end
            end
        end
    end
end

function destroy_p_proc()
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

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(261, fallout.local_var(0)))
end

function talk_p_proc()
    fallout.script_overrides()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(261, fallout.random(110, 120)), 0)
end

local exports = {}
exports.start = start
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
exports.talk_p_proc = talk_p_proc
return exports
