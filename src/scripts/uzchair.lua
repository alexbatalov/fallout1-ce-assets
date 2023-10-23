local fallout = require("fallout")
local factory = require("lib.factory")

return factory.create_use_scr(function()
    if fallout.local_var(0) == 0 then
        fallout.script_overrides()
        fallout.display_msg(fallout.message_str(464, 100))
        local item_obj = fallout.create_object_sid(82, 0, 0, -1)
        fallout.add_obj_to_inven(fallout.dude_obj(), item_obj)
        fallout.set_local_var(0, 1)
    end
end)
