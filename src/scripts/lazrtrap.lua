local fallout = require("fallout")

local start

local Damage = 0

function start()
    if fallout.script_action() == 2 then
        if fallout.global_var(139) and fallout.global_var(140) then
            if fallout.local_var(0) == 0 then
                fallout.set_local_var(0, 1)
                Damage = fallout.random(1, 6)
                fallout.float_msg(fallout.dude_obj(), fallout.message_str(336, 100), 0)
                if Damage == 1 then
                    fallout.display_msg(fallout.message_str(336, 101))
                    fallout.critter_dmg(fallout.dude_obj(), 1, 0)
                else
                    fallout.display_msg(fallout.message_str(336, 102) + Damage + fallout.message_str(336, 103))
                    fallout.critter_dmg(fallout.dude_obj(), Damage, 0)
                end
            end
        end
    end
end

local exports = {}
exports.start = start
return exports
