local fallout = require("fallout")
local factory = require("lib.factory")

return factory.create_use_scr(function()
    fallout.script_overrides()

    local dude_obj = fallout.dude_obj()
    if fallout.source_obj() == dude_obj then
        fallout.reg_anim_func(2, dude_obj)
        fallout.move_to(dude_obj, 22499, 1)
    end
end)
