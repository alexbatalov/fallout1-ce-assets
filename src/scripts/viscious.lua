local fallout = require("fallout")

local start
local do_dialogue
local moveme
local goto00
local goto00a
local goto01
local goto02
local goto03
local goto03a
local goto04
local goto05
local goto06
local goto07
local goto07a
local goto08
local gotoend
local gotocbt
local gotoret

local HOSTILE = 0
local only_once = 1
local DISGUISED = 0
local ARMED = 0
local moving = 1
local my_hex = 0
local home_tile = 0
local smoke_tile = 0
local indlog = 0

function start()
    if fallout.local_var(4) == 0 then
        fallout.set_local_var(4, 1)
        fallout.set_local_var(5, 1)
        fallout.set_local_var(6, 0)
        fallout.set_local_var(7, 22091)
    end
    if only_once then
        only_once = 0
        home_tile = 23488
        smoke_tile = 21299
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 34)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 49)
        if fallout.local_var(0) == 1 then
            fallout.set_obj_visibility(fallout.self_obj(), 1)
            moving = 0
        end
    else
        if fallout.local_var(0) ~= 1 then
            if fallout.script_action() == 14 then
                if fallout.global_var(245) == 0 then
                    fallout.set_global_var(245, 1)
                end
            else
                if fallout.script_action() == 11 then
                    do_dialogue()
                else
                    if fallout.script_action() == 22 then
                        if fallout.fixed_param() == 1 then
                            moving = 1
                        end
                    else
                        if fallout.script_action() == 4 then
                            HOSTILE = 1
                        end
                    end
                end
            end
            if fallout.script_action() == 12 then
                if HOSTILE then
                    HOSTILE = 0
                    fallout.attack_complex(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
                else
                    if moving then
                        moveme()
                    end
                end
            else
                if fallout.script_action() == 21 then
                    fallout.script_overrides()
                    if fallout.local_var(3) then
                        fallout.display_msg(fallout.message_str(811, 302))
                    else
                        fallout.display_msg(fallout.message_str(811, 200))
                    end
                else
                    if fallout.script_action() == 18 then
                        fallout.set_local_var(0, 1)
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
    fallout.start_gdialog(811, fallout.self_obj(), 4, -1, -1)
    fallout.gsay_start()
    indlog = 1
    ARMED = 0
    DISGUISED = 0
    if (fallout.obj_item_subtype(fallout.critter_inven_obj(fallout.dude_obj(), 1)) == 3) or (fallout.obj_item_subtype(fallout.critter_inven_obj(fallout.dude_obj(), 2)) == 3) then
        ARMED = 1
    end
    if fallout.obj_pid(fallout.critter_inven_obj(fallout.dude_obj(), 0)) == 113 then
        if fallout.metarule(16, 0) > 1 then
            DISGUISED = 0
        else
            DISGUISED = 1
        end
    end
    if (DISGUISED == 0) or (ARMED == 1) then
        goto01()
    else
        if fallout.local_var(2) == 1 then
            goto08()
        else
            fallout.set_local_var(2, 1)
            goto00()
        end
    end
    indlog = 0
    fallout.gsay_end()
    fallout.end_dialogue()
end

function moveme()
    my_hex = fallout.tile_num(fallout.self_obj())
    if my_hex == fallout.local_var(7) then
        fallout.set_local_var(3, 0)
        if fallout.local_var(5) then
            fallout.set_local_var(6, fallout.local_var(6) + 1)
        else
            fallout.set_local_var(6, fallout.local_var(6) - 1)
        end
        if fallout.local_var(6) > 2 then
            fallout.set_local_var(3, 1)
            moving = 0
            fallout.set_local_var(6, 1)
            fallout.set_local_var(5, 0)
            fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(180), 1)
        else
            if fallout.local_var(6) < 0 then
                moving = 0
                fallout.set_local_var(6, 1)
                fallout.set_local_var(5, 1)
                fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(600), 1)
            end
        end
        if fallout.local_var(6) == 0 then
            fallout.set_local_var(7, home_tile)
        else
            if fallout.local_var(6) == 1 then
                fallout.set_local_var(7, 22091)
            else
                if fallout.local_var(6) == 2 then
                    fallout.set_local_var(7, smoke_tile)
                end
            end
        end
    else
        fallout.animate_move_obj_to_tile(fallout.self_obj(), fallout.local_var(7), 0)
    end
    if fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) then
        ARMED = 0
        DISGUISED = 0
        if (fallout.obj_item_subtype(fallout.critter_inven_obj(fallout.dude_obj(), 1)) == 3) or (fallout.obj_item_subtype(fallout.critter_inven_obj(fallout.dude_obj(), 2)) == 3) then
            ARMED = 1
        end
        if fallout.obj_pid(fallout.critter_inven_obj(fallout.dude_obj(), 0)) == 113 then
            if fallout.metarule(16, 0) > 1 then
                DISGUISED = 0
            else
                DISGUISED = 1
            end
        end
        if (DISGUISED == 0) or (ARMED == 1) then
            if fallout.tile_distance_objs(fallout.self_obj(), fallout.dude_obj()) < 6 then
                if fallout.local_var(1) < 1 then
                    fallout.set_local_var(1, 1)
                    fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(15), 2)
                    fallout.dialogue_system_enter()
                end
            end
        end
    end
end

function goto00()
    fallout.gsay_reply(811, 202)
    fallout.giq_option(-3, 811, 203, goto01, 51)
    fallout.giq_option(4, 811, 204, goto02, 51)
    fallout.giq_option(7, 811, 205, goto00a, 50)
    fallout.giq_option(4, 811, 206, gotocbt, 51)
end

function goto00a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        goto04()
    else
        goto03()
    end
end

function goto01()
    if indlog then
        fallout.gsay_message(811, 207, 51)
    else
        fallout.float_msg(fallout.self_obj(), fallout.message_str(811, 207), 2)
    end
    gotocbt()
end

function goto02()
    fallout.gsay_message(811, 208, 51)
    gotocbt()
end

function goto03()
    fallout.gsay_reply(811, 209)
    fallout.giq_option(4, 811, 210, gotocbt, 51)
    fallout.giq_option(7, 811, 211, goto03a, 50)
end

function goto03a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, -20)) then
        goto04()
    else
        goto02()
    end
end

function goto04()
    fallout.gsay_reply(811, 212)
    fallout.giq_option(7, 811, 213, gotoend, 50)
    fallout.giq_option(7, 811, 214, goto05, 50)
end

function goto05()
    fallout.gsay_reply(811, 215)
    fallout.giq_option(7, 811, 216, goto06, 50)
    fallout.giq_option(8, 811, 217, goto07, 51)
end

function goto06()
    fallout.gsay_message(811, 218, 50)
end

function goto07()
    fallout.gsay_reply(811, 219)
    fallout.giq_option(4, 811, 220, goto07a, 50)
    fallout.giq_option(4, 811, 221, gotocbt, 51)
end

function goto07a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        goto06()
    else
        goto01()
    end
end

function goto08()
    if indlog then
        fallout.gsay_message(811, 222, 50)
    else
        fallout.float_msg(fallout.self_obj(), fallout.message_str(811, 222), 2)
    end
end

function gotoend()
end

function gotocbt()
    HOSTILE = 1
end

function gotoret()
end

local exports = {}
exports.start = start
return exports
