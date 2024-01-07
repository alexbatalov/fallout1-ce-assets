local fallout = require("fallout")

local start
local use_p_proc
local cover00
local cover01

function start()
    local script_action = fallout.script_action()
    if script_action == 6 then
        use_p_proc()
    end
end

function use_p_proc()
    fallout.script_overrides()
    if fallout.map_var(fallout.local_var(0)) == 1 then
        cover00()
    else
        cover01()
    end
end

function cover00()
    fallout.set_map_var(fallout.local_var(0), 0)
    fallout.display_msg(fallout.message_str(18, 100))
end

function cover01()
    local bonus = 3 - fallout.local_var(0)
    local roll = fallout.do_check(fallout.dude_obj(), 0, bonus)
    if fallout.is_success(roll) then
        fallout.set_local_var(0, 0)
        fallout.set_map_var(fallout.local_var(0), 1)
        fallout.display_msg(fallout.message_str(18, 101))
    else
        fallout.set_local_var(0, fallout.local_var(0) + 1)
        if fallout.is_critical(roll) then
            fallout.display_msg(fallout.message_str(18, 102))
            local damage = fallout.random(1, 6) - 4
            if damage < 1 then
                damage = 1
            end
            fallout.critter_dmg(fallout.dude_obj(), damage, 0)
        else
            fallout.display_msg(fallout.message_str(18, 103))
        end
    end
end

local exports = {}
exports.start = start
exports.use_p_proc = use_p_proc
return exports
