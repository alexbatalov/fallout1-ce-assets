local fallout = require("fallout")

local start
local do_dialogue
local dialog
local airgrd00
local airgrd01
local airgrd02
local airgrd03
local airgrd03a
local airgrd04
local airgrd04a
local airgrd04b
local airgrd05
local airgrd06
local airgrd07
local airgrd08
local airgrd09
local airgrd10
local airgrd11
local airgrd12
local airgrd13
local airgrd14
local airgrd15
local bluff_end
local dialog_end
local airgrdtim
local combat

local HOSTILE = 0
local only_once = 1
local Weapons = 0
local DISGUISED = 0
local again = 0
local first = 0
local rndx = 0
local jumpcode = 0
local indialog = 0
local temp = 0

local get_reaction
local ReactToLevel
local LevelToReact
local UpReact
local DownReact
local BottomReact
local TopReact
local BigUpReact
local BigDownReact
local UpReactLevel
local DownReactLevel
local Goodbyes

local exit_line = 0

function start()
    if only_once then
        only_once = 0
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 34)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 46)
    else
        if fallout.script_action() == 14 then
            if fallout.global_var(245) == 0 then
                fallout.set_global_var(245, 1)
            end
        else
            if fallout.script_action() == 11 then
                do_dialogue()
            else
                if fallout.script_action() == 4 then
                    HOSTILE = 1
                else
                    if fallout.script_action() == 22 then
                        if (fallout.obj_item_subtype(fallout.critter_inven_obj(fallout.dude_obj(), 1)) == 3) or (fallout.obj_item_subtype(fallout.critter_inven_obj(fallout.dude_obj(), 2)) == 3) then
                            combat()
                        end
                    else
                        if fallout.script_action() == 12 then
                            if HOSTILE then
                                HOSTILE = 0
                                fallout.attack_complex(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
                            end
                            if fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) and (fallout.tile_distance_objs(fallout.self_obj(), fallout.dude_obj()) < 6) then
                                if (fallout.obj_item_subtype(fallout.critter_inven_obj(fallout.dude_obj(), 1)) == 3) or (fallout.obj_item_subtype(fallout.critter_inven_obj(fallout.dude_obj(), 2)) == 3) then
                                    if Weapons == 0 then
                                        Weapons = 1
                                        again = 1
                                        fallout.dialogue_system_enter()
                                    end
                                end
                                DISGUISED = 0
                                if fallout.obj_pid(fallout.critter_inven_obj(fallout.dude_obj(), 0)) == 113 then
                                    if fallout.metarule(16, 0) > 1 then
                                        DISGUISED = 0
                                    else
                                        DISGUISED = 1
                                    end
                                end
                                if DISGUISED == 0 then
                                    again = 1
                                    fallout.dialogue_system_enter()
                                end
                                if again == 0 then
                                    again = 1
                                    fallout.dialogue_system_enter()
                                end
                            end
                        else
                            if (fallout.script_action() == 21) or (fallout.script_action() == 3) then
                                fallout.script_overrides()
                            else
                                if fallout.script_action() == 18 then
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
    if (fallout.map_var(1) == 1) and (fallout.global_var(231) == 1) then
        airgrd00()
    else
        if DISGUISED then
            if Weapons then
                jumpcode = 1
                dialog()
            else
                if first == 0 then
                    first = 1
                    jumpcode = 2
                    dialog()
                else
                    if first == 1 then
                        airgrd08()
                    end
                end
            end
        else
            if Weapons then
                airgrd15()
            else
                jumpcode = 3
                dialog()
            end
        end
    end
end

function dialog()
    fallout.set_local_var(3, 1)
    get_reaction()
    fallout.start_gdialog(673, fallout.self_obj(), 4, -1, -1)
    fallout.gsay_start()
    indialog = 1
    if jumpcode < 2 then
        airgrd01()
    else
        if jumpcode == 2 then
            airgrd03()
        else
            if jumpcode > 2 then
                airgrd09()
            end
        end
    end
    indialog = 0
    fallout.gsay_end()
    fallout.end_dialogue()
end

function airgrd00()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(673, fallout.random(102, 104)), 2)
end

function airgrd01()
    fallout.gsay_reply(673, 105)
    fallout.giq_option(-3, 673, 106, airgrd02, 51)
    fallout.giq_option(4, 673, 107, airgrdtim, 50)
    fallout.giq_option(4, 673, 108, airgrd02, 51)
    fallout.giq_option(4, 673, 109, airgrdtim, 50)
end

function airgrd02()
    fallout.gsay_message(673, 110, 51)
    combat()
end

function airgrd03()
    fallout.gsay_reply(673, 111)
    fallout.giq_option(-3, 673, 112, airgrd02, 51)
    fallout.giq_option(4, 673, 113, airgrd04, 50)
    fallout.giq_option(4, 673, 114, airgrd03a, 50)
    fallout.giq_option(4, 673, 115, airgrd02, 51)
end

function airgrd03a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        airgrd06()
    else
        airgrd08()
    end
end

function airgrd04()
    fallout.gsay_reply(673, 116)
    fallout.giq_option(4, 673, 117, airgrd04a, 50)
    fallout.giq_option(6, 673, 118, airgrd04b, 50)
end

function airgrd04a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, -30)) then
        airgrd06()
    else
        airgrd05()
    end
end

function airgrd04b()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, -15)) then
        airgrd06()
    else
        airgrd05()
    end
end

function airgrd05()
    fallout.gsay_message(673, 119, 51)
    combat()
end

function airgrd06()
    fallout.gsay_reply(673, 120)
    fallout.giq_option(4, 673, 121, bluff_end, 50)
    fallout.giq_option(4, 673, 122, airgrd07, 51)
    fallout.giq_option(4, 673, 123, bluff_end, 50)
end

function airgrd07()
    fallout.gsay_message(673, 124, 51)
    combat()
end

function airgrd08()
    if indialog == 1 then
        fallout.gsay_message(673, fallout.random(125, 127), 50)
    else
        fallout.float_msg(fallout.self_obj(), fallout.message_str(673, fallout.random(125, 127)), 2)
    end
    bluff_end()
end

function airgrd09()
    fallout.gsay_reply(673, 128)
    fallout.giq_option(-3, 673, 129, airgrd10, 51)
    fallout.giq_option(4, 673, 130, airgrd10, 51)
    fallout.giq_option(4, 673, 131, airgrd11, 51)
    fallout.giq_option(4, 673, 132, airgrd02, 51)
end

function airgrd10()
    fallout.gsay_message(673, 133, 51)
    combat()
end

function airgrd11()
    fallout.gsay_reply(673, 134)
    fallout.giq_option(4, 673, 135, airgrd02, 51)
    fallout.giq_option(4, 673, 136, airgrd12, 51)
end

function airgrd12()
    fallout.gsay_reply(673, 137)
    fallout.giq_option(4, 673, 138, airgrd13, 51)
    fallout.giq_option(6, 673, 139, airgrd14, 51)
end

function airgrd13()
    fallout.gsay_message(673, 140, 51)
    combat()
end

function airgrd14()
    fallout.gsay_message(673, 141, 51)
    combat()
end

function airgrd15()
    fallout.gsay_message(673, 142, 51)
    combat()
end

function bluff_end()
    if fallout.local_var(4) == 0 then
        fallout.set_local_var(4, 1)
        temp = 750
        fallout.display_msg(fallout.message_str(673, 200) + temp + fallout.message_str(673, 201))
        fallout.give_exp_points(temp)
    end
end

function dialog_end()
end

function airgrdtim()
    fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(10), 1)
end

function combat()
    HOSTILE = 1
end

function get_reaction()
    if fallout.local_var(2) == 0 then
        fallout.set_local_var(0, 50)
        fallout.set_local_var(1, 2)
        fallout.set_local_var(2, 1)
        fallout.set_local_var(0, fallout.local_var(0) + (5 * fallout.get_critter_stat(fallout.dude_obj(), 3)) - 25)
        fallout.set_local_var(0, fallout.local_var(0) + (10 * fallout.has_trait(0, fallout.dude_obj(), 10)))
        if fallout.has_trait(0, fallout.dude_obj(), 39) then
            if fallout.global_var(155) > 0 then
                fallout.set_local_var(0, fallout.local_var(0) + fallout.global_var(155))
            else
                fallout.set_local_var(0, fallout.local_var(0) - fallout.global_var(155))
            end
        else
            if fallout.local_var(3) == 1 then
                fallout.set_local_var(0, fallout.local_var(0) - fallout.global_var(155))
            else
                fallout.set_local_var(0, fallout.local_var(0) + fallout.global_var(155))
            end
        end
        if fallout.global_var(158) > 2 then
            fallout.set_local_var(0, fallout.local_var(0) - 30)
        end
        if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(160) > (3 * fallout.global_var(159))) or (fallout.global_var(157) == 1)) then
            fallout.set_local_var(0, fallout.local_var(0) + 20)
        end
        if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1)) then
            fallout.set_local_var(0, fallout.local_var(0) - 20)
        end
        ReactToLevel()
    end
end

function ReactToLevel()
    if fallout.local_var(0) <= 25 then
        fallout.set_local_var(1, 1)
    else
        if fallout.local_var(0) <= 75 then
            fallout.set_local_var(1, 2)
        else
            fallout.set_local_var(1, 3)
        end
    end
end

function LevelToReact()
    if fallout.local_var(1) == 1 then
        fallout.set_local_var(0, fallout.random(1, 25))
    else
        if fallout.local_var(1) == 2 then
            fallout.set_local_var(0, fallout.random(26, 75))
        else
            fallout.set_local_var(0, fallout.random(76, 100))
        end
    end
end

function UpReact()
    fallout.set_local_var(0, fallout.local_var(0) + 10)
    ReactToLevel()
end

function DownReact()
    fallout.set_local_var(0, fallout.local_var(0) - 10)
    ReactToLevel()
end

function BottomReact()
    fallout.set_local_var(1, 1)
    fallout.set_local_var(0, 1)
end

function TopReact()
    fallout.set_local_var(0, 100)
    fallout.set_local_var(1, 3)
end

function BigUpReact()
    fallout.set_local_var(0, fallout.local_var(0) + 25)
    ReactToLevel()
end

function BigDownReact()
    fallout.set_local_var(0, fallout.local_var(0) - 25)
    ReactToLevel()
end

function UpReactLevel()
    fallout.set_local_var(1, fallout.local_var(1) + 1)
    if fallout.local_var(1) > 3 then
        fallout.set_local_var(1, 3)
    end
    LevelToReact()
end

function DownReactLevel()
    fallout.set_local_var(1, fallout.local_var(1) - 1)
    if fallout.local_var(1) < 1 then
        fallout.set_local_var(1, 1)
    end
    LevelToReact()
end

function Goodbyes()
    exit_line = fallout.message_str(634, fallout.random(100, 105))
end

local exports = {}
exports.start = start
return exports
