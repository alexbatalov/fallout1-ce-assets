local fallout = require("fallout")

local start

local Only_once = 1
local Hostile = 0
local oktoyell = 1
local active = 0

function start()
    if Only_once then
        Only_once = 0
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 30)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 78)
        if fallout.global_var(227) == 1 then
            active = 1
            fallout.set_obj_visibility(fallout.self_obj(), 0)
        else
            fallout.set_obj_visibility(fallout.self_obj(), 1)
        end
    end
    if active then
        if fallout.script_action() == 11 then
            if fallout.global_var(31) == 2 then
                fallout.float_msg(fallout.self_obj(), fallout.message_str(535, 102), 8)
            else
                fallout.float_msg(fallout.self_obj(), fallout.message_str(535, 101), 8)
            end
        else
            if fallout.script_action() == 14 then
                Hostile = 1
            else
                if fallout.script_action() == 12 then
                    if fallout.global_var(249) and fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) then
                        Hostile = 1
                    end
                    if Hostile then
                        Hostile = 0
                        fallout.set_global_var(227, 0)
                        fallout.set_global_var(249, 1)
                        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
                    else
                        if fallout.global_var(31) ~= 2 then
                            if fallout.tile_distance_objs(fallout.self_obj(), fallout.dude_obj()) > 7 then
                                Hostile = 1
                            else
                                if (fallout.tile_distance_objs(fallout.self_obj(), fallout.dude_obj()) > 4) and oktoyell then
                                    oktoyell = 0
                                    fallout.float_msg(fallout.self_obj(), fallout.message_str(535, 103), 8)
                                else
                                    if fallout.tile_distance_objs(fallout.self_obj(), fallout.dude_obj()) < 5 then
                                        oktoyell = 1
                                    end
                                end
                            end
                        end
                    end
                else
                    if fallout.script_action() == 4 then
                        Hostile = 1
                    else
                        if fallout.script_action() == 21 then
                            fallout.script_overrides()
                            fallout.display_msg(fallout.message_str(535, 100))
                        else
                            if fallout.script_action() == 18 then
                                fallout.set_global_var(607, 3)
                                fallout.set_global_var(227, 0)
                                fallout.set_global_var(249, 1)
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
    end
end

local exports = {}
exports.start = start
return exports
