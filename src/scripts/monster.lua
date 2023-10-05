local fallout = require("fallout")

local start

local HOSTILE = 0
local DISGUISED = 0
local only_once = 1

function start()
    if only_once then
        only_once = 0
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 34)
        fallout.anim(fallout.self_obj(), 1000, fallout.rotation_to_tile(fallout.tile_num(fallout.self_obj()), 28113))
    else
        if fallout.script_action() == 4 then
            HOSTILE = 1
        end
    end
    if fallout.script_action() == 12 then
        if HOSTILE then
            HOSTILE = 0
            fallout.attack_complex(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
        end
        if fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) then
            DISGUISED = 0
            if fallout.obj_pid(fallout.critter_inven_obj(fallout.dude_obj(), 0)) == 113 then
                if fallout.metarule(16, 0) > 1 then
                    DISGUISED = 0
                else
                    DISGUISED = 1
                end
            end
            if DISGUISED == 0 then
                HOSTILE = 1
            end
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

local exports = {}
exports.start = start
return exports
