local fallout = require("fallout")
local reputation = require("lib.reputation")

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
            fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
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
                reputation.inc_evil_critter()
            end
        end
    end
end

local exports = {}
exports.start = start
return exports
