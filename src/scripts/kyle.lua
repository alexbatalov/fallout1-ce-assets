local fallout = require("fallout")

local start
local do_dialogue
local goto01
local goto02
local goto03
local goto04
local goto05
local goto06
local goto07
local goto08
local goto09
local goto10
local goto11
local goto12
local goto13
local goto14
local goto15
local goto16
local goto17
local goto18
local goto19
local goto20
local goto21
local goto22
local goto23
local goto24
local goto24a
local goto25
local goto26
local goto27
local goto75
local gotoend
local gotopart
local combat
local critter_p_proc
local pickup_p_proc
local talk_p_proc
local destroy_p_proc
local look_at_p_proc
local smalltalk
local pre_dialogue

local known = 0
local only_once = 1
local hostile = 0
local radx = 0
local ccount = 0
local loot = 0
local stuff = 0

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
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 44)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 64)
    end
    if fallout.script_action() == 21 then
        look_at_p_proc()
    else
        if fallout.script_action() == 4 then
            pickup_p_proc()
        else
            if fallout.script_action() == 11 then
                talk_p_proc()
            else
                if fallout.script_action() == 12 then
                    critter_p_proc()
                else
                    if fallout.script_action() == 18 then
                        destroy_p_proc()
                    end
                end
            end
        end
    end
end

function do_dialogue()
    fallout.display_msg("in do_dialogue")
    get_reaction()
    fallout.start_gdialog(845, fallout.self_obj(), 4, -1, -1)
    fallout.gsay_start()
    if fallout.local_var(4) == 0 then
        fallout.set_local_var(4, 1)
        goto01()
    else
        if fallout.global_var(304) == 2 then
            goto26()
        else
            if fallout.global_var(304) == 3 then
                goto26()
            else
                if fallout.obj_carrying_pid_obj(fallout.dude_obj(), 229) then
                    goto23()
                else
                    if fallout.global_var(304) then
                        goto17()
                    else
                        goto27()
                    end
                end
            end
        end
    end
    fallout.gsay_end()
    fallout.end_dialogue()
end

function goto01()
    fallout.gsay_reply(845, 102)
    fallout.giq_option(-3, 845, 103, goto02, 50)
    fallout.giq_option(4, 845, 103, goto02, 50)
    fallout.giq_option(4, 845, 104, goto13, 50)
end

function goto02()
    fallout.gsay_reply(845, 105)
    fallout.giq_option(4, 845, 106, goto04, 50)
    fallout.giq_option(4, 845, 107, goto03, 50)
    fallout.giq_option(4, 845, 108, goto14, 50)
    fallout.giq_option(-3, 845, 103, gotoend, 50)
end

function goto03()
    fallout.gsay_reply(845, 109)
    fallout.giq_option(4, 845, 110, goto04, 50)
    fallout.giq_option(4, 845, 111, goto06, 50)
    fallout.giq_option(4, 845, 112, goto09, 51)
end

function goto04()
    fallout.gsay_reply(845, 113)
    if fallout.global_var(30) ~= 1 then
        fallout.giq_option(4, 845, 114, goto12, 50)
    end
    fallout.giq_option(4, 845, 115, goto05, 50)
    fallout.giq_option(4, 845, 116, gotoend, 50)
end

function goto05()
    fallout.gsay_reply(845, 117)
    fallout.giq_option(4, 845, 118, goto06, 50)
    if fallout.global_var(30) ~= 1 then
        fallout.giq_option(4, 845, 114, goto12, 50)
    end
end

function goto06()
    fallout.gsay_reply(845, 119)
    fallout.giq_option(4, 845, 120, goto07, 50)
    fallout.giq_option(4, 845, 121, gotoend, 50)
end

function goto07()
    fallout.gsay_reply(845, 122)
    fallout.giq_option(4, 845, 123, goto08, 50)
    fallout.giq_option(4, 845, 124, goto10, 50)
end

function goto08()
    fallout.gsay_reply(845, 125)
    fallout.giq_option(4, 845, 124, goto10, 50)
    fallout.giq_option(4, 845, 126, goto09, 51)
end

function goto09()
    BottomReact()
    fallout.gsay_message(845, 127, 51)
end

function goto10()
    fallout.gsay_reply(845, 128)
    fallout.giq_option(4, 845, 129, goto11, 50)
    fallout.giq_option(4, 845, 130, gotopart, 50)
end

function goto11()
    fallout.gsay_reply(845, 131)
    fallout.giq_option(4, 845, 132, gotopart, 50)
end

function goto12()
    fallout.gsay_reply(845, 133)
    fallout.giq_option(4, 845, 134, gotoend, 50)
    fallout.giq_option(4, 845, 135, goto09, 51)
    fallout.giq_option(4, 845, 136, goto06, 50)
end

function goto13()
    fallout.gsay_reply(845, 137)
    fallout.giq_option(4, 845, 138, goto02, 50)
    fallout.giq_option(4, 845, 139, goto04, 51)
    fallout.giq_option(4, 845, 140, gotoend, 50)
end

function goto14()
    fallout.gsay_reply(845, 141)
    fallout.giq_option(4, 845, 142, goto15, 50)
end

function goto15()
    fallout.gsay_reply(845, 143)
    fallout.giq_option(4, 845, fallout.message_str(845, 144) .. fallout.proto_data(fallout.obj_pid(fallout.dude_obj()), 1) .. fallout.message_str(845, 145), goto13, 50)
    fallout.giq_option(4, 845, 146, goto16, 50)
end

function goto16()
    fallout.gsay_reply(845, 147)
    fallout.giq_option(4, 845, 148, goto06, 50)
end

function goto17()
    fallout.gsay_reply(845, 149)
    fallout.giq_option(4, 845, 150, goto18, 50)
    fallout.giq_option(4, 845, 151, gotoend, 50)
    fallout.giq_option(4, 845, 152, gotoend, 50)
    fallout.giq_option(-3, 845, 103, gotoend, 50)
end

function goto18()
    fallout.gsay_reply(845, 153)
    fallout.giq_option(4, 845, 154, goto09, 51)
    fallout.giq_option(4, 845, 155, goto19, 50)
    fallout.giq_option(4, 845, 156, goto11, 50)
    fallout.giq_option(4, 845, 157, gotoend, 50)
end

function goto19()
    fallout.gsay_reply(845, 158)
    fallout.giq_option(4, 845, 159, gotoend, 50)
    fallout.giq_option(4, 845, 160, goto11, 50)
end

function goto20()
end

function goto21()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(845, 161), 2)
end

function goto22()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(845, 162), 2)
end

function goto23()
    loot = 0
    fallout.gsay_reply(845, 163)
    loot = fallout.obj_carrying_pid_obj(fallout.dude_obj(), 229)
    if loot then
        fallout.giq_option(4, 845, 164, goto24, 50)
    end
    fallout.giq_option(4, 845, 165, goto25, 50)
    fallout.giq_option(-3, 845, 103, gotoend, 50)
end

function goto24()
    fallout.rm_obj_from_inven(fallout.dude_obj(), loot)
    fallout.gsay_reply(845, 166)
    fallout.giq_option(4, 845, 300, goto24a, 50)
end

function goto24a()
    fallout.gfade_out(600)
    fallout.gfade_in(600)
    stuff = fallout.create_object_sid(76, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), stuff)
    fallout.set_global_var(304, 2)
    fallout.gsay_message(845, 167, 50)
end

function goto25()
    fallout.gsay_message(845, 168, 50)
end

function goto26()
    fallout.gsay_reply(845, 169)
    fallout.giq_option(4, 845, 170, gotoend, 50)
    fallout.giq_option(-3, 845, 103, gotoend, 50)
end

function goto27()
    fallout.gsay_reply(845, 171)
    fallout.giq_option(4, 845, 106, goto04, 50)
    fallout.giq_option(4, 845, 104, goto13, 50)
    fallout.giq_option(-3, 845, 103, gotoend, 50)
end

function goto75()
end

function gotoend()
end

function gotopart()
    fallout.set_global_var(304, 1)
end

function combat()
    hostile = 1
end

function critter_p_proc()
    if fallout.global_var(250) then
        hostile = 1
    end
    if fallout.tile_distance_objs(fallout.self_obj(), fallout.dude_obj()) > 12 then
        hostile = 0
    end
    if hostile then
        fallout.set_global_var(250, 1)
        hostile = 0
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    end
end

function pickup_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        hostile = 1
    end
end

function talk_p_proc()
    fallout.debug_msg("global_var(PART_RUN) == " .. fallout.global_var(304))
    if fallout.global_var(304) == 4 then
        smalltalk()
    else
        if (fallout.local_var(4) == 1) and (fallout.local_var(1) < 2) then
            goto22()
        else
            get_reaction()
            fallout.start_gdialog(845, fallout.self_obj(), 4, -1, -1)
            fallout.gsay_start()
            if fallout.local_var(4) == 0 then
                fallout.set_local_var(4, 1)
                goto01()
            else
                if fallout.global_var(304) == 2 then
                    goto26()
                else
                    if fallout.global_var(304) == 3 then
                        goto26()
                    else
                        if fallout.obj_carrying_pid_obj(fallout.dude_obj(), 229) then
                            goto23()
                        else
                            if fallout.global_var(304) then
                                goto17()
                            else
                                goto27()
                            end
                        end
                    end
                end
            end
            fallout.gsay_end()
            fallout.end_dialogue()
        end
    end
end

function destroy_p_proc()
    fallout.set_global_var(250, 1)
    if fallout.source_obj() == fallout.dude_obj() then
        if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1)) then
            fallout.set_global_var(156, 1)
            fallout.set_global_var(157, 0)
        end
        if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(160) > (3 * fallout.global_var(159))) or (fallout.global_var(157) == 1)) then
            fallout.set_global_var(157, 1)
            fallout.set_global_var(156, 0)
        end
        fallout.set_global_var(159, fallout.global_var(159) + 1)
        if (fallout.global_var(159) % 2) == 0 then
            fallout.set_global_var(155, fallout.global_var(155) - 1)
        end
    end
end

function look_at_p_proc()
    fallout.script_overrides()
    if known then
        fallout.display_msg(fallout.message_str(845, 100))
    else
        fallout.display_msg(fallout.message_str(845, 101))
    end
end

function smalltalk()
    ccount = ccount + 1
    if ccount < 6 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(723, 200 + fallout.random(0, 2)), 2)
    else
        if ccount < 9 then
            fallout.float_msg(fallout.self_obj(), fallout.message_str(723, 203 + fallout.random(0, 4)), 2)
        else
            if ccount < 12 then
                fallout.float_msg(fallout.self_obj(), fallout.message_str(723, 209 + fallout.random(0, 3)), 2)
            else
                fallout.display_msg(fallout.message_str(723, 213))
            end
        end
    end
end

function pre_dialogue()
    fallout.display_msg("in pre_dialogue")
    if fallout.global_var(304) == 4 then
        smalltalk()
    else
        if (fallout.local_var(4) == 1) and (fallout.local_var(1) < 2) then
            goto22()
        else
            do_dialogue()
        end
    end
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
exports.critter_p_proc = critter_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
return exports
