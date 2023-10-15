local fallout = require("fallout")

local start

local initialized = false
local Hostile = 0
local oktoyell = 1

function start()
    if not initialized then
        initialized = true
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 30)
        if fallout.global_var(31) == 1 then
            fallout.set_obj_visibility(fallout.self_obj(), 0)
        else
            fallout.set_obj_visibility(fallout.self_obj(), 1)
        end
    end
    if fallout.script_action() == 11 then
        if fallout.global_var(31) == 2 then
            fallout.float_msg(fallout.self_obj(), fallout.message_str(535, 102), 8)
        else
            fallout.float_msg(fallout.self_obj(), fallout.message_str(535, 101), 8)
        end
    else
        if fallout.script_action() == 12 then
            if Hostile then
                Hostile = 0
                fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
            end
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
                        if fallout.source_obj() == fallout.dude_obj() then
                            fallout.set_global_var(160, fallout.global_var(160) + 1)
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
