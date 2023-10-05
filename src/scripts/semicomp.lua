local fallout = require("fallout")

local start
local search
local skills

local use_skill = 0

function start()
    if fallout.local_var(0) == 0 then
        fallout.set_local_var(0, fallout.random(1, 9))
    end
    if fallout.script_action() == 21 then
        fallout.script_overrides()
        search()
    else
        if fallout.script_action() == 8 then
            use_skill = fallout.action_being_used()
            fallout.script_overrides()
            skills()
        end
    end
end

function search()
    if fallout.tile_distance_objs(fallout.self_obj(), fallout.dude_obj()) > 3 then
        fallout.display_msg(fallout.message_str(418, 100))
    else
        if fallout.local_var(0) == 1 then
            fallout.display_msg(fallout.message_str(418, 102))
        else
            if fallout.local_var(0) == 2 then
                fallout.display_msg(fallout.message_str(418, 103))
            else
                if fallout.local_var(0) == 3 then
                    fallout.display_msg(fallout.message_str(418, 104))
                else
                    if fallout.local_var(0) == 4 then
                        fallout.display_msg(fallout.message_str(418, 105))
                    else
                        if fallout.local_var(0) == 5 then
                            fallout.display_msg(fallout.message_str(418, 106))
                        else
                            if fallout.local_var(0) == 6 then
                                fallout.display_msg(fallout.message_str(418, 107))
                            else
                                if fallout.local_var(0) == 7 then
                                    fallout.display_msg(fallout.message_str(418, 108))
                                else
                                    if fallout.local_var(0) == 8 then
                                        fallout.display_msg(fallout.message_str(418, 109))
                                    else
                                        if fallout.local_var(0) == 9 then
                                            fallout.display_msg(fallout.message_str(418, 111))
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
end

function skills()
    if (use_skill == 13) or (use_skill == 12) then
        fallout.display_msg(fallout.message_str(418, 101))
    else
        fallout.display_msg(fallout.message_str(418, 102))
    end
end

local exports = {}
exports.start = start
return exports
