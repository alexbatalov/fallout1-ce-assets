local fallout = require("fallout")
local reputation = require("lib.reputation")

local start

local Only_once = 1
local hostile = 0

function start()
    if Only_once then
        Only_once = 0
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 0)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 4)
        if fallout.global_var(124) == 3 then
            fallout.set_obj_visibility(fallout.self_obj(), 1)
        end
    end
    if fallout.script_action() == 11 then
        if fallout.global_var(43) == 2 then
            fallout.float_msg(fallout.self_obj(), fallout.message_str(197, 102), 8)
        else
            fallout.float_msg(fallout.self_obj(), fallout.message_str(197, 101), 8)
        end
    else
        if fallout.script_action() == 12 then
            if hostile then
                hostile = 0
                fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
            end
            if fallout.tile_distance_objs(fallout.self_obj(), fallout.dude_obj()) > 3 then
                fallout.animate_move_obj_to_tile(fallout.self_obj(), fallout.tile_num_in_direction(fallout.tile_num(fallout.dude_obj()), fallout.random(0, 5), 1), 0)
            end
        else
            if fallout.script_action() == 4 then
                hostile = 1
            else
                if fallout.script_action() == 21 then
                    fallout.script_overrides()
                    fallout.display_msg(fallout.message_str(197, 100))
                else
                    if fallout.script_action() == 18 then
                        fallout.set_global_var(124, 3)
                        reputation.inc_good_critter()
                    end
                end
            end
        end
    end
end

local exports = {}
exports.start = start
return exports
