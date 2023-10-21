local fallout = require("fallout")

local start
local Initialize_Fridge
local Looting_Fridge
local Open_Fridge
local pick_lock
local map_update_p_proc

local last_user = 0

function start()
    if fallout.script_action() == 15 then
        Initialize_Fridge()
    else
        if fallout.script_action() == 23 then
            map_update_p_proc()
        else
            if fallout.script_action() == 4 then
                Looting_Fridge()
            else
                if fallout.script_action() == 6 then
                    Open_Fridge()
                else
                    if fallout.script_action() == 22 then
                        fallout.float_msg(fallout.external_var("Garret_ptr"), fallout.message_str(420, 105), 0)
                    else
                        if fallout.script_action() == 7 then
                            if fallout.obj_pid(fallout.obj_being_used_with()) == 84 then
                                pick_lock()
                            end
                        else
                            if fallout.script_action() == 8 then
                                if fallout.action_being_used() == 9 then
                                    pick_lock()
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

function Initialize_Fridge()
    fallout.set_external_var("Fridge_ptr", fallout.self_obj())
end

function Looting_Fridge()
    if fallout.source_obj() ~= fallout.external_var("Garret_ptr") then
        if fallout.local_var(0) == 0 then
            fallout.script_overrides()
        else
            if fallout.local_var(1) == 0 then
                fallout.script_overrides()
            end
        end
    end
end

function Open_Fridge()
    last_user = fallout.source_obj()
    if fallout.source_obj() == fallout.external_var("Garret_ptr") then
        if fallout.local_var(1) == 0 then
            fallout.set_local_var(0, 1)
            fallout.set_local_var(1, 1)
        else
            if last_user == fallout.external_var("Garret_ptr") then
                fallout.set_local_var(1, 0)
                fallout.set_local_var(0, 0)
            else
                fallout.script_overrides()
                fallout.float_msg(fallout.external_var("Garret_ptr"), fallout.message_str(420, 104), 0)
            end
        end
    else
        if fallout.local_var(0) == 0 then
            fallout.script_overrides()
            fallout.display_msg(fallout.message_str(420, 100))
        else
            if fallout.local_var(1) ~= 0 then
                fallout.set_local_var(1, 0)
            else
                fallout.set_local_var(1, 1)
            end
        end
    end
end

function pick_lock()
    fallout.script_overrides()
    if fallout.local_var(0) ~= 0 then
        fallout.display_msg(fallout.message_str(420, 101))
    else
        if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 9, 0)) then
            fallout.display_msg(fallout.message_str(420, 102))
            fallout.set_local_var(0, 1)
            fallout.display_msg(fallout.message_str(766, 103) .. "25" .. fallout.message_str(766, 104))
            fallout.give_exp_points(25)
        else
            fallout.display_msg(fallout.message_str(420, 103))
        end
    end
end

function map_update_p_proc()
    fallout.set_external_var("Fridge_ptr", fallout.self_obj())
end

local exports = {}
exports.start = start
exports.map_update_p_proc = map_update_p_proc
return exports
