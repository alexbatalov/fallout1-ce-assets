local fallout = require("fallout")

local start

local only_once = 1

function start()
    if only_once then
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 55)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 66)
        only_once = 0
        fallout.move_to(fallout.self_obj(), 0, 0)
    end
    if fallout.local_var(0) == 0 then
        if fallout.map_var(4) then
            fallout.set_map_var(4, 0)
            fallout.set_local_var(0, 1)
            fallout.critter_attempt_placement(fallout.self_obj(), 18859, 0)
            fallout.attack_complex(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
        end
    else
        if fallout.script_action() == 21 then
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

local exports = {}
exports.start = start
return exports
