local fallout = require("fallout")

local start
local do_dialogue

local HOSTILE = 0
local only_once = 1

function start()
    if only_once then
        only_once = 0
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 34)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 46)
    else
        if fallout.script_action() == 14 then
            if fallout.global_var(245) == 0 then
                fallout.set_global_var(245, 1)
            end
        else
            if fallout.script_action() == 11 then
                do_dialogue()
            else
                if fallout.script_action() == 4 then
                    HOSTILE = 1
                end
            end
        end
    end
    if fallout.script_action() == 12 then
        if HOSTILE then
            HOSTILE = 0
            fallout.attack_complex(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
        end
    else
        if (fallout.script_action() == 21) or (fallout.script_action() == 3) then
            fallout.script_overrides()
        else
            if fallout.script_action() == 18 then
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
    end
end

function do_dialogue()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(673, 143), 2)
end

local exports = {}
exports.start = start
return exports
