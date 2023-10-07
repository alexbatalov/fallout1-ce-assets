local fallout = require("fallout")

local start
local do_dialogue
local jeremend
local jeremcbt
local jeremret

local HOSTILE = 0
local only_once = 1
local Weapons = 0
local DISGUISED = 0
local moving = 1
local my_hex = 0
local home_tile = 0

function start()
    if fallout.local_var(0) == 0 then
        fallout.set_local_var(0, 1)
        fallout.set_local_var(1, 0)
        fallout.set_local_var(2, 4)
        fallout.set_local_var(3, 16912)
    end
    if only_once then
        only_once = 0
        home_tile = 16912
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 34)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 69)
        if fallout.global_var(233) == 1 then
            fallout.set_obj_visibility(fallout.self_obj(), 1)
            moving = 0
        else
            if fallout.global_var(232) == 0 then
                fallout.set_obj_visibility(fallout.self_obj(), 1)
                moving = 0
                fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(300), 1)
            end
        end
    else
        if fallout.global_var(233) ~= 1 then
            if fallout.script_action() == 11 then
                do_dialogue()
            else
                if fallout.script_action() == 22 then
                    if fallout.fixed_param() == 1 then
                        moving = 1
                        fallout.set_global_var(232, 1)
                        fallout.move_to(fallout.self_obj(), home_tile, 0)
                        fallout.set_local_var(1, 0)
                        fallout.set_local_var(2, 4)
                        fallout.set_local_var(3, 16912)
                        fallout.set_obj_visibility(fallout.self_obj(), 0)
                    else
                        if fallout.fixed_param() == 2 then
                            moving = 1
                        end
                    end
                else
                    if fallout.script_action() == 4 then
                        HOSTILE = 1
                    end
                end
            end
            if fallout.script_action() == 12 then
                if HOSTILE then
                    HOSTILE = 0
                    fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
                end
                if moving then
                    my_hex = fallout.tile_num(fallout.self_obj())
                    if my_hex == fallout.local_var(3) then
                        if fallout.local_var(1) then
                            fallout.set_local_var(2, fallout.local_var(2) + 1)
                        else
                            fallout.set_local_var(2, fallout.local_var(2) - 1)
                        end
                        if fallout.local_var(2) > 4 then
                            moving = 0
                            fallout.set_local_var(1, 0)
                            fallout.set_local_var(2, 4)
                            fallout.set_obj_visibility(fallout.self_obj(), 1)
                            fallout.set_global_var(232, 0)
                            fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(300), 1)
                        else
                            if fallout.local_var(2) < 0 then
                                moving = 0
                                fallout.set_local_var(1, 1)
                                fallout.set_local_var(2, 0)
                                fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(300), 2)
                            end
                        end
                        if fallout.local_var(2) == 0 then
                            fallout.set_local_var(3, 23689)
                        else
                            if fallout.local_var(2) == 1 then
                                fallout.set_local_var(3, 22900)
                            else
                                if fallout.local_var(2) == 2 then
                                    fallout.set_local_var(3, 22312)
                                else
                                    if fallout.local_var(2) == 3 then
                                        fallout.set_local_var(3, 19512)
                                    else
                                        if fallout.local_var(2) == 4 then
                                            fallout.set_local_var(3, 16912)
                                        end
                                    end
                                end
                            end
                        end
                    else
                        fallout.animate_move_obj_to_tile(fallout.self_obj(), fallout.local_var(3), 0)
                    end
                    if fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) then
                        DISGUISED = 0
                        if fallout.obj_pid(fallout.critter_inven_obj(fallout.dude_obj(), 0)) == 113 then
                            if fallout.metarule(16, 0) > 1 then
                                DISGUISED = 0
                            else
                                DISGUISED = 1
                            end
                        end
                        if DISGUISED == 0 then
                            fallout.dialogue_system_enter()
                        end
                    end
                end
            else
                if fallout.script_action() == 21 then
                    fallout.script_overrides()
                    fallout.display_msg(fallout.message_str(672, 100))
                else
                    if fallout.script_action() == 18 then
                        fallout.set_global_var(233, 1)
                        if fallout.source_obj() == fallout.dude_obj() then
                            if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1)) then
                                fallout.set_global_var(156, 1)
                                fallout.set_global_var(157, 0)
                            end
                            if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(160) > (3 * fallout.global_var(159))) or (fallout.global_var(157) == 1)) then
                                fallout.set_global_var(157, 1)
                                fallout.set_global_var(156, 0)
                            end
                            fallout.set_global_var(160, fallout.global_var(160) + 1)
                            if (fallout.global_var(160) % 6) == 0 then
                                fallout.set_global_var(155, fallout.global_var(155) + 1)
                            end
                        end
                    end
                end
            end
        end
    end
end

function do_dialogue()
    if fallout.obj_pid(fallout.critter_inven_obj(fallout.dude_obj(), 0)) == 113 then
        if fallout.metarule(16, 0) > 1 then
            DISGUISED = 0
        else
            DISGUISED = 1
        end
    end
    if fallout.global_var(231) == 1 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(672, 187), 2)
    else
        fallout.float_msg(fallout.self_obj(), fallout.message_str(672, 120), 2)
    end
    jeremcbt()
end

function jeremend()
end

function jeremcbt()
    HOSTILE = 1
end

function jeremret()
end

local exports = {}
exports.start = start
return exports
