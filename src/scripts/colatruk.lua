local fallout = require("fallout")
local light = require("lib.light")

local start
local add_caps

function start()
    if fallout.script_action() == 15 then
        light.lighting()
        add_caps()
        if fallout.metarule(14, 0) then
            fallout.override_map_start(130, 107, 0, 0)
            fallout.display_msg(fallout.message_str(112, 315))
        end
    else
        if fallout.script_action() == 23 then
            light.lighting()
        end
    end
end

function add_caps()
    local v0 = 0
    local v1 = 0
    local v2 = 0
    v0 = fallout.create_object_sid(180, 19919, 0, -1)
    v1 = fallout.create_object_sid(41, 0, 0, -1)
    if fallout.get_critter_stat(fallout.dude_obj(), 6) == 1 then
        v2 = 1
    else
        if fallout.get_critter_stat(fallout.dude_obj(), 6) == 2 then
            v2 = 32
        else
            if fallout.get_critter_stat(fallout.dude_obj(), 6) == 3 then
                v2 = 105
            else
                if fallout.get_critter_stat(fallout.dude_obj(), 6) == 4 then
                    v2 = 298
                else
                    if fallout.get_critter_stat(fallout.dude_obj(), 6) == 5 then
                        v2 = 730
                    else
                        if fallout.get_critter_stat(fallout.dude_obj(), 6) == 6 then
                            v2 = 1645
                        else
                            if fallout.get_critter_stat(fallout.dude_obj(), 6) == 7 then
                                v2 = 2976
                            else
                                if fallout.get_critter_stat(fallout.dude_obj(), 6) == 8 then
                                    v2 = 5709
                                else
                                    if fallout.get_critter_stat(fallout.dude_obj(), 6) == 9 then
                                        v2 = 8443
                                    else
                                        if fallout.get_critter_stat(fallout.dude_obj(), 6) == 10 then
                                            v2 = 10765
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
    v2 = v2 * (fallout.has_trait(0, fallout.dude_obj(), 20) + 1)
    fallout.add_mult_objs_to_inven(v0, v1, v2)
end

local exports = {}
exports.start = start
return exports
