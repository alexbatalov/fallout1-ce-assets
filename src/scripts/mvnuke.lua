local fallout = require("fallout")

--
-- Some unreferenced imported varables found.
-- Because of it it is impossible to specify
-- the real names of global variables.
--

local g0 = 0

local start
local skills
local reset

-- ?import? variable KEY_USED
-- ?import? variable SKILL_USED
-- ?import? variable MASTER_HAS_ACTIVATED
-- ?import? variable BOMB_ARMED
-- ?import? variable use_skill

function start()
    if fallout.script_action() == 21 then
        fallout.script_overrides()
        fallout.display_msg(fallout.message_str(449, 100))
    else
        if fallout.script_action() == 8 then
            fallout.set_map_var(5, 1)
            g0 = fallout.action_being_used()
            fallout.script_overrides()
            skills()
        end
    end
end

function skills()
    if g0 == 12 then
        fallout.display_msg(fallout.message_str(449, 108))
    else
        if g0 == 13 then
            fallout.display_msg(fallout.message_str(449, 109))
        else
            if g0 == 9 then
                fallout.display_msg(fallout.message_str(449, 110))
            else
                if g0 == 11 then
                    fallout.display_msg(fallout.message_str(449, 111))
                else
                    fallout.display_msg(fallout.message_str(449, 105))
                end
            end
        end
    end
end

function reset()
    fallout.display_msg(fallout.message_str(449, 103))
    fallout.set_global_var(55, 0)
    fallout.set_global_var(18, 0)
end

local exports = {}
exports.start = start
return exports
