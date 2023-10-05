local fallout = require("fallout")

local start
local do_dialogue

local Hostile = 0
local initialized = 0
local rndx = 0

function start()
    if not(initialized) then
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 30)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 41)
        initialized = 1
    end
    if fallout.script_action() == 11 then
        if fallout.global_var(249) then
            fallout.attack_complex(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
        else
            do_dialogue()
        end
    else
        if (fallout.script_action() == 21) or (fallout.script_action() == 3) then
            fallout.script_overrides()
            fallout.display_msg(fallout.message_str(230, 100))
        else
            if fallout.script_action() == 4 then
                Hostile = 1
            else
                if fallout.script_action() == 12 then
                    if fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) and fallout.global_var(249) then
                        Hostile = 1
                    end
                    if Hostile then
                        Hostile = 0
                        fallout.attack_complex(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
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
        end
    end
end

function do_dialogue()
    rndx = fallout.random(1, 3)
    if rndx == 1 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(230, 101), 3)
    end
    if rndx == 2 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(230, 102), 3)
    end
    if rndx == 3 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(230, 103), 3)
    end
end

local exports = {}
exports.start = start
return exports
