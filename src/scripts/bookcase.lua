local fallout = require("fallout")

local start
local description_p_proc
local use_p_proc
local pickup_p_proc
local use_skill_on_p_proc
local secret

local use_skill = 0
local Door_Test = 0

function start()
    if fallout.script_action() == 3 then
        description_p_proc()
    else
        if fallout.script_action() == 8 then
            use_skill_on_p_proc()
        else
            if fallout.script_action() == 6 then
                use_p_proc()
            else
                if fallout.script_action() == 4 then
                    pickup_p_proc()
                end
            end
        end
    end
end

function description_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(810, 200))
end

function use_p_proc()
    fallout.script_overrides()
    if (fallout.local_var(0) == 1) or (Door_Test == 1) then
        fallout.display_msg(fallout.message_str(810, 104))
        fallout.use_obj(fallout.external_var("J_Door_Ptr"))
    else
        fallout.display_msg(fallout.message_str(810, 101))
    end
end

function pickup_p_proc()
    fallout.script_overrides()
end

function use_skill_on_p_proc()
    use_skill = fallout.action_being_used()
    if (fallout.local_var(0) == 0) and (Door_Test == 0) then
        if use_skill == 9 then
            fallout.script_overrides()
            if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 9, 0)) then
                fallout.set_local_var(0, 1)
                Door_Test = 1
                fallout.display_msg(fallout.message_str(810, 102))
            else
                fallout.display_msg(fallout.message_str(810, 105))
            end
        else
            if use_skill == 11 then
                fallout.script_overrides()
                if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 11, 0)) then
                    fallout.set_local_var(0, 1)
                    Door_Test = 1
                    fallout.display_msg(fallout.message_str(810, 102))
                else
                    fallout.display_msg(fallout.message_str(810, 105))
                end
            else
                fallout.display_msg(fallout.message_str(810, 103))
            end
        end
    else
        fallout.display_msg(fallout.message_str(810, 103))
    end
end

function secret()
    fallout.set_local_var(0, 1)
    fallout.display_msg(fallout.message_str(810, 102))
end

local exports = {}
exports.start = start
exports.description_p_proc = description_p_proc
exports.use_p_proc = use_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.use_skill_on_p_proc = use_skill_on_p_proc
return exports
