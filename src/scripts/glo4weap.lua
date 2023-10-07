local fallout = require("fallout")

local start
local Traps
local Sciences
local Picklocks
local Using_Door

local Shocked = 0

function start()
    if fallout.global_var(142) == 2 then
        fallout.set_local_var(1, 1)
    end
    if (fallout.script_action() == 21) or (fallout.script_action() == 3) then
        fallout.script_overrides()
        fallout.display_msg(fallout.message_str(321, 100))
    else
        if fallout.script_action() == 6 then
            if fallout.global_var(142) ~= 2 then
                fallout.set_global_var(142, 1)
            end
            Using_Door()
        else
            if fallout.script_action() == 8 then
                if fallout.global_var(142) ~= 2 then
                    fallout.set_global_var(142, 1)
                end
                if fallout.action_being_used() == 9 then
                    Picklocks()
                else
                    if fallout.action_being_used() == 11 then
                        Traps()
                    else
                        if fallout.action_being_used() == 12 then
                            Sciences()
                        else
                            fallout.display_msg(fallout.message_str(321, 101))
                        end
                    end
                end
            else
                if fallout.script_action() == 7 then
                    if fallout.global_var(142) ~= 2 then
                        fallout.set_global_var(142, 1)
                    end
                    if fallout.obj_pid(fallout.obj_being_used_with()) == 96 then
                        if fallout.local_var(1) == 0 then
                            fallout.script_overrides()
                            Shocked = fallout.random(3, 7)
                            fallout.critter_dmg(fallout.dude_obj(), Shocked, 0)
                            fallout.display_msg(fallout.message_str(321, 102) .. Shocked .. fallout.message_str(321, 103))
                            fallout.set_local_var(0, fallout.local_var(0) + 1)
                        else
                            if fallout.local_var(2) == 0 then
                                fallout.script_overrides()
                                fallout.set_local_var(2, 1)
                                fallout.display_msg(fallout.message_str(321, 104))
                            end
                        end
                    else
                        fallout.display_msg(fallout.message_str(321, 105))
                    end
                end
            end
        end
    end
end

function Traps()
    if fallout.local_var(1) == 0 then
        if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 11, 0)) then
            fallout.set_local_var(1, 1)
            fallout.display_msg(fallout.message_str(321, 113))
        else
            fallout.set_local_var(0, 5)
            Shocked = fallout.random(2, fallout.local_var(0))
            fallout.critter_dmg(fallout.dude_obj(), Shocked, 0)
            fallout.display_msg(fallout.message_str(321, 114) .. Shocked .. fallout.message_str(321, 115))
            fallout.set_local_var(0, fallout.local_var(0) + 1)
        end
    else
        fallout.display_msg(fallout.message_str(321, 116))
    end
end

function Sciences()
    if fallout.local_var(1) == 0 then
        if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 12, 0)) then
            fallout.set_local_var(1, 1)
            fallout.display_msg(fallout.message_str(321, 117))
        else
            fallout.set_local_var(0, 5)
            Shocked = fallout.random(2, fallout.local_var(0))
            fallout.critter_dmg(fallout.dude_obj(), Shocked, 0)
            fallout.display_msg(fallout.message_str(321, 118) .. Shocked .. fallout.message_str(321, 119))
            fallout.set_local_var(0, fallout.local_var(0) + 1)
        end
    else
        fallout.display_msg(fallout.message_str(321, 120))
    end
end

function Picklocks()
    if fallout.local_var(1) == 0 then
        if fallout.local_var(0) > 2 then
            Shocked = fallout.random(2, fallout.local_var(0))
            fallout.critter_dmg(fallout.dude_obj(), Shocked, 0)
            fallout.display_msg(fallout.message_str(321, 121) .. Shocked .. fallout.message_str(321, 122))
            fallout.set_local_var(0, fallout.local_var(0) + 1)
        else
            fallout.set_local_var(0, fallout.local_var(0) + 1)
            fallout.display_msg(fallout.message_str(321, 123))
        end
    else
        if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 9, 0)) then
            fallout.set_local_var(2, 1)
            fallout.display_msg(fallout.message_str(321, 124))
        else
            fallout.display_msg(fallout.message_str(321, 125))
        end
    end
end

function Using_Door()
    if fallout.local_var(1) == 0 then
        fallout.script_overrides()
        if fallout.local_var(0) > 2 then
            Shocked = fallout.random(2, fallout.local_var(0))
            fallout.critter_dmg(fallout.dude_obj(), Shocked, 0)
            fallout.display_msg(fallout.message_str(321, 106) .. Shocked .. fallout.message_str(321, 107))
            fallout.set_local_var(0, fallout.local_var(0) + 1)
        else
            fallout.set_local_var(0, fallout.local_var(0) + 1)
            fallout.display_msg(fallout.message_str(321, 108))
        end
    else
        if fallout.local_var(2) == 0 then
            fallout.script_overrides()
            fallout.display_msg(fallout.message_str(321, 109))
            if fallout.is_success(fallout.do_check(fallout.dude_obj(), 1, 0)) then
                fallout.display_msg(fallout.message_str(321, 110))
            else
                if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 11, 0)) then
                    fallout.display_msg(fallout.message_str(321, 111))
                else
                    fallout.display_msg(fallout.message_str(321, 112))
                end
            end
        end
    end
end

local exports = {}
exports.start = start
return exports
