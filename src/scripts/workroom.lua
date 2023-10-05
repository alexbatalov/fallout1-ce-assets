local fallout = require("fallout")

local start
local initialize
local look_at_p_proc
local explode

local new_tile = 0

function start()
    if fallout.script_action() == 15 then
        initialize()
    else
        if fallout.script_action() == 22 then
            explode()
        else
            if fallout.script_action() == 6 then
                explode()
            end
        end
    end
end

function initialize()
    fallout.set_external_var("table_ptr", fallout.self_obj())
end

function look_at_p_proc()
end

function explode()
    new_tile = fallout.tile_num_in_direction(fallout.tile_num(fallout.self_obj()), 1, 1)
    fallout.explosion(new_tile, fallout.elevation(fallout.self_obj()), 0)
    fallout.float_msg(fallout.self_obj(), fallout.message_str(736, fallout.random(108, 115)), 8)
end

local exports = {}
exports.start = start
exports.look_at_p_proc = look_at_p_proc
return exports
