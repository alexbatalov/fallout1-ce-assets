local fallout = require("fallout")

local start

local count = 0
local init_teams = 0

function start()
    if not(init_teams) then
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 8)
        init_teams = 1
    end
    if fallout.script_action() == 12 then
        if fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) ~= 0 then
            fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
        end
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

local exports = {}
exports.start = start
return exports
