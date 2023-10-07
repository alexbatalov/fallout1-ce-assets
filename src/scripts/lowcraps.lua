local fallout = require("fallout")

local start
local point_run

local point = 0

function start()
    if (fallout.script_action() == 21) or (fallout.script_action() == 3) then
        fallout.script_overrides()
        fallout.display_msg(fallout.message_str(0, 100))
    else
        if fallout.script_action() == 6 then
            point_run()
        else
            if fallout.script_action() == 11 then
                fallout.script_overrides()
                point_run()
            end
        end
    end
end

function point_run()
    local v0 = 0
    local v1 = 0
    local v2 = 0
    local v3 = 0
    local v4 = 0
    local v5 = 0
    v5 = fallout.random(1, 20) - fallout.random(5, 15)
    v4 = fallout.roll_vs_skill(fallout.dude_obj(), 16, v5)
    v0 = fallout.random(1, 6) + fallout.random(1, 6)
    if fallout.is_critical(v4) then
        if fallout.is_success(v4) then
            fallout.display_msg(fallout.message_str(0, 101))
        else
            fallout.display_msg(fallout.message_str(0, 102))
        end
    else
        if (v0 == 7) or (v0 == 11) then
            fallout.display_msg(fallout.message_str(0, 103) .. v0 .. fallout.message_str(0, 104))
        else
            if (v0 == 2) or (v0 == 3) or (v0 == 12) then
                fallout.display_msg(fallout.message_str(0, 105) .. v0 .. fallout.message_str(0, 106))
            else
                while not(v3) do
                    if v2 then
                        if (v0 == 7) or (v0 == 11) then
                            v3 = 1
                            fallout.display_msg(fallout.message_str(0, 107) .. v0 .. fallout.message_str(0, 108))
                        else
                            if v0 == v1 then
                                v3 = 1
                                fallout.display_msg(fallout.message_str(0, 109))
                            else
                                v0 = fallout.random(1, 6) + fallout.random(1, 6)
                            end
                        end
                    else
                        v2 = 1
                        v1 = v0
                        fallout.display_msg(fallout.message_str(0, 110) .. v0 .. fallout.message_str(0, 111))
                    end
                end
            end
        end
    end
end

local exports = {}
exports.start = start
return exports
