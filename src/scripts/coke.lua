local fallout = require("fallout")
local factory = require("lib.factory")

return factory.create_use_scr(function()
    fallout.script_overrides()
    if fallout.local_var(0) == 0 then
        if fallout.is_success(fallout.do_check(fallout.dude_obj(), 6, 0)) then
            fallout.display_msg(fallout.message_str(22, 101))
            local caps = fallout.random(1, 6) + fallout.random(1, 6) + fallout.random(1, 6)
            fallout.item_caps_adjust(fallout.dude_obj(), caps)
        end
        fallout.set_local_var(0, 1)
    else
        fallout.display_msg(fallout.message_str(22, 100))
    end
end)
