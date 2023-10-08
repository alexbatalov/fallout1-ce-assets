local fallout = require("fallout")
local reaction = require("lib.reaction")
local time = require("lib.time")

local start
local combat
local critter_p_proc
local pickup_p_proc
local talk_p_proc
local destroy_p_proc
local look_at_p_proc
local dialog_end
local madsci00
local madsci00a
local madsci00b
local madsci01
local madsci01a
local madsci02
local madsci02a
local madsci02b
local madsci03
local madsci03a
local madsci03b
local madsci04
local madsci04a
local madsci05
local madsci06
local madsci07
local madsci08
local madsci09
local madsci09a
local madsci09b
local madsci09c
local madsci10
local madsci10a
local madsci10b
local madsci11
local madsci12
local madsci12a
local madsci12b
local madsci12c
local madsci13
local madsci13a
local madsci13b
local madsci14
local madsci14a

local hostile = 0
local Only_Once = 1
local home_tile = 0
local sleep_tile = 0

local exit_line = 0

local madscinull

function start()
    if Only_Once then
        Only_Once = 0
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 34)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 69)
        home_tile = fallout.tile_num(fallout.self_obj())
        if home_tile == 22093 then
            sleep_tile = 21881
        else
            if home_tile == 22704 then
                sleep_tile = 22281
            else
                sleep_tile = 22083
            end
        end
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

function combat()
    hostile = 1
end

function critter_p_proc()
    if hostile then
        hostile = 0
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    else
        if time.is_day() then
            if fallout.local_var(6) then
                fallout.set_local_var(6, 0)
                fallout.animate_move_obj_to_tile(fallout.self_obj(), home_tile, 0)
            else
                if fallout.tile_num(fallout.self_obj()) ~= home_tile then
                    fallout.animate_move_obj_to_tile(fallout.self_obj(), home_tile, 0)
                end
            end
        else
            if fallout.local_var(6) then
                if fallout.tile_num(fallout.self_obj()) ~= sleep_tile then
                    fallout.animate_move_obj_to_tile(fallout.self_obj(), sleep_tile, 0)
                end
            else
                fallout.set_local_var(6, 1)
                fallout.animate_move_obj_to_tile(fallout.self_obj(), sleep_tile, 0)
            end
        end
    end
end

function pickup_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        hostile = 1
    end
end

function talk_p_proc()
    if fallout.tile_num(fallout.self_obj()) == sleep_tile then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(679, 303), 2)
    else
        reaction.get_reaction()
        fallout.start_gdialog(679, fallout.self_obj(), 4, -1, -1)
        fallout.gsay_start()
        if fallout.obj_pid(fallout.critter_inven_obj(fallout.dude_obj(), 0)) == 113 then
            if fallout.local_var(5) == 1 then
                madsci01()
            else
                madsci00()
            end
            fallout.set_local_var(5, 1)
        else
            if fallout.local_var(4) == 1 then
                madsci01()
            else
                madsci12()
            end
            fallout.set_local_var(4, 1)
        end
        fallout.gsay_end()
        fallout.end_dialogue()
    end
end

function destroy_p_proc()
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

function look_at_p_proc()
    fallout.script_overrides()
    if fallout.tile_num(fallout.self_obj()) == sleep_tile then
        fallout.display_msg(fallout.message_str(679, 300))
    else
        fallout.display_msg(fallout.message_str(679, 100))
    end
end

function dialog_end()
end

function madsci00()
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        fallout.gsay_reply(679, 101)
    else
        fallout.gsay_reply(679, 102)
    end
    fallout.giq_option(7, 679, 103, madsci00a, 50)
    fallout.giq_option(4, 679, 104, madsci04, 50)
    if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1)) then
        fallout.giq_option(4, 679, 105, madsci00b, 50)
    end
    fallout.giq_option(-3, 679, 106, madsci06, 50)
end

function madsci00a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        madsci02()
    else
        madsci09()
    end
end

function madsci00b()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, -10)) then
        madsci03()
    else
        madsci08()
    end
end

function madsci01()
    fallout.gsay_reply(679, 107)
    fallout.giq_option(4, 679, 108, madsci01a, 50)
    fallout.giq_option(4, 679, 109, madsci02, 50)
    if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1)) then
        fallout.giq_option(4, 679, 110, combat, 51)
    end
    fallout.giq_option(-3, 679, 111, madsci06, 50)
end

function madsci01a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, -10)) then
        madsci03()
    else
        madsci09()
    end
end

function madsci02()
    fallout.gsay_reply(679, 112)
    fallout.giq_option(7, 679, 113, madsci07, 50)
    fallout.giq_option(4, 679, 114, madsci02a, 50)
    fallout.giq_option(4, 679, 115, madsci02b, 50)
    fallout.giq_option(4, 679, 116, madsci14, 50)
end

function madsci02a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        madsci07()
    else
        madsci09()
    end
end

function madsci02b()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        madsci04()
    else
        madsci06()
    end
end

function madsci03()
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        fallout.gsay_reply(679, 117)
    else
        fallout.gsay_reply(679, 118)
    end
    fallout.giq_option(4, 679, 103, madsci03a, 50)
    fallout.giq_option(4, 679, 104, madsci04, 50)
    if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1)) then
        fallout.giq_option(4, 679, 119, madsci03b, 50)
    end
end

function madsci03a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        madsci02()
    else
        madsci06()
    end
end

function madsci03b()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, -10)) then
        madsci09()
    else
        madsci08()
    end
end

function madsci04()
    fallout.gsay_reply(679, 120)
    fallout.giq_option(4, 679, 121, madsci04a, 50)
    fallout.giq_option(4, 679, 122, madsci05, 50)
    if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1)) then
        fallout.giq_option(4, 679, 123, combat, 51)
    end
end

function madsci04a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        madsci09()
    else
        madsci08()
    end
end

function madsci05()
    fallout.gsay_reply(679, 124)
    fallout.giq_option(4, 679, 125, dialog_end, 50)
    fallout.giq_option(4, 679, 126, madsci09, 50)
    if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1)) then
        fallout.giq_option(4, 679, 127, combat, 51)
    end
end

function madsci06()
    fallout.gsay_message(679, 128, 50)
end

function madsci07()
    fallout.gsay_reply(679, 129)
    fallout.giq_option(4, 679, 130, madsci05, 50)
    fallout.giq_option(4, 679, 131, dialog_end, 50)
    if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1)) then
        fallout.giq_option(4, 679, 132, combat, 51)
    end
end

function madsci08()
    fallout.gsay_message(679, 133, 50)
end

function madsci09()
    fallout.gsay_reply(679, 134)
    fallout.giq_option(4, 679, 135, madsci09a, 50)
    fallout.giq_option(4, 679, 136, madsci09b, 51)
    fallout.giq_option(4, 679, 137, madsci09c, 51)
    if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1)) then
        fallout.giq_option(4, 679, 138, combat, 51)
    end
end

function madsci09a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, -5)) then
        madsci06()
    else
        madsci08()
    end
end

function madsci09b()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, -20)) then
        madsci10()
    else
        madsci11()
    end
end

function madsci09c()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, -10)) then
        madsci10()
    else
        madsci11()
    end
end

function madsci10()
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        fallout.gsay_reply(679, 117)
    else
        fallout.gsay_reply(679, 118)
    end
    fallout.giq_option(4, 679, 139, madsci10a, 50)
    fallout.giq_option(4, 679, 140, dialog_end, 50)
    if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1)) then
        fallout.giq_option(4, 679, 119, madsci10b, 50)
    end
end

function madsci10a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        madsci02()
    else
        madsci06()
    end
end

function madsci10b()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, -20)) then
        madsci06()
    else
        madsci08()
    end
end

function madsci11()
    fallout.gsay_message(679, 141, 51)
    combat()
end

function madsci12()
    fallout.gsay_reply(679, 142)
    fallout.giq_option(4, 679, 143, madsci12a, 50)
    fallout.giq_option(4, 679, 144, madsci12b, 51)
    fallout.giq_option(4, 679, 145, madsci12c, 50)
    fallout.giq_option(4, 679, 146, combat, 50)
end

function madsci12a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, -20)) then
        madsci03()
    else
        madsci09()
    end
end

function madsci12b()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, -25)) then
        madsci10()
    else
        madsci11()
    end
end

function madsci12c()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, -15)) then
        madsci13()
    else
        madsci08()
    end
end

function madsci13()
    fallout.gsay_reply(679, 147)
    fallout.giq_option(4, 679, 148, madsci02, 50)
    fallout.giq_option(4, 679, 144, madsci13a, 51)
    fallout.giq_option(4, 679, 149, madsci13b, 50)
end

function madsci13a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, -25)) then
        madsci10()
    else
        madsci11()
    end
end

function madsci13b()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, -20)) then
        madsci10()
    else
        madsci08()
    end
end

function madsci14()
    fallout.gsay_reply(679, 150)
    fallout.giq_option(4, 679, 151, madsci14a, 50)
    fallout.giq_option(4, 679, 122, madsci05, 50)
    if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1)) then
        fallout.giq_option(4, 679, 123, combat, 50)
    end
end

function madsci14a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        madsci09()
    else
        madsci08()
    end
end

function madscinull()
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
return exports
