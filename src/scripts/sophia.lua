local fallout = require("fallout")
local reaction = require("lib.reaction")
local reputation = require("lib.reputation")

local start
local combat
local critter_p_proc
local pickup_p_proc
local talk_p_proc
local destroy_p_proc
local look_at_p_proc
local goto00
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
local goto16b
local goto17
local goto18
local goto19
local goto20
local goto20b
local goto21
local anger
local gotoend
local gotostory

local hostile = 0
local item = 0
local Pick = 0
local initialized = false
local message = 0

local exit_line = 0

function start()
    if not initialized then
        initialized = true
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 44)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 63)
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
    reaction.get_reaction()
    fallout.start_gdialog(319, fallout.self_obj(), 4, -1, -1)
    fallout.gsay_start()
    if fallout.local_var(4) then
        if fallout.local_var(1) < 2 then
            goto20()
        else
            goto16()
        end
    else
        fallout.set_local_var(4, 1)
        if fallout.map_var(0) == 1 then
            goto14()
        else
            goto00()
        end
    end
    fallout.gsay_end()
    fallout.end_dialogue()
end

function destroy_p_proc()
    fallout.set_global_var(250, 1)
    fallout.rm_timer_event(fallout.self_obj())
    reputation.inc_good_critter()
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(319, 100))
end

function goto00()
    fallout.gsay_reply(319, 301)
    fallout.giq_option(-3, 319, 302, goto01, 50)
    fallout.giq_option(4, 319, 303, goto02, 50)
    fallout.giq_option(4, 319, 304, goto03, 50)
    fallout.giq_option(4, 319, 305, goto02, 50)
    fallout.giq_option(4, 319, 306, anger, 51)
end

function goto01()
    fallout.gsay_message(319, 307, 51)
end

function goto02()
    fallout.gsay_reply(319, 308)
    if fallout.global_var(30) ~= 1 then
        fallout.giq_option(4, 319, 309, goto04, 50)
    end
    fallout.giq_option(4, 319, 310, goto05, 50)
    fallout.giq_option(4, 319, 311, goto06, 50)
    fallout.giq_option(4, 319, 312, gotoend, 50)
    if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1)) then
        fallout.giq_option(4, 319, 313, anger, 51)
    end
end

function goto03()
    fallout.gsay_reply(319, 314)
    fallout.giq_option(4, 319, 315, gotoend, 50)
    fallout.giq_option(4, 319, 316, goto07, 50)
end

function goto04()
    fallout.gsay_reply(319, 317)
    fallout.giq_option(4, 319, 318, goto07, 50)
    fallout.giq_option(4, 319, 319, goto06, 50)
    fallout.giq_option(4, 319, 320, anger, 51)
    fallout.giq_option(4, 319, 321, gotoend, 50)
end

function goto05()
    fallout.gsay_reply(319, 322)
    fallout.giq_option(4, 319, 323, gotoend, 50)
    fallout.giq_option(4, 319, 324, goto08, 50)
    fallout.giq_option(4, 319, 325, goto09, 50)
end

function goto06()
    fallout.gsay_reply(319, 326)
    fallout.giq_option(4, 319, 327, goto11, 50)
    fallout.giq_option(4, 319, 328, goto11, 50)
    if fallout.local_var(6) ~= 1 then
        fallout.giq_option(4, 319, 329, goto12, 50)
    end
    fallout.giq_option(4, 319, 330, goto07, 50)
end

function goto07()
    fallout.gsay_reply(319, 331)
    if fallout.local_var(6) ~= 1 then
        fallout.giq_option(4, 319, 332, goto12, 50)
    end
    fallout.giq_option(4, 319, 333, goto09, 50)
    if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1)) then
        fallout.giq_option(4, 319, 334, goto01, 51)
    end
    fallout.giq_option(4, 319, 335, goto05, 50)
end

function goto08()
    fallout.gsay_message(319, 336, 50)
end

function goto09()
    fallout.gsay_reply(319, 337)
    if fallout.local_var(6) ~= 1 then
        fallout.giq_option(4, 319, 338, goto12, 49)
    end
    fallout.giq_option(4, 319, 339, DownReact, 51)
    fallout.giq_option(4, 319, 341, goto01, 51)
    fallout.giq_option(4, 319, 342, goto10, 50)
end

function goto10()
    fallout.gsay_message(319, 343, 50)
end

function goto11()
    fallout.gsay_reply(319, 344)
    fallout.giq_option(4, 319, 345, gotoend, 50)
    fallout.giq_option(4, 319, 346, goto13, 50)
    fallout.giq_option(4, 319, 347, DownReact, 51)
end

function goto12()
    fallout.set_local_var(6, 1)
    item = fallout.create_object_sid(215, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), item)
    fallout.gsay_reply(319, 348)
    fallout.giq_option(4, 319, 349, gotoend, 50)
    fallout.giq_option(4, 319, 350, DownReact, 51)
end

function goto13()
    fallout.gsay_reply(319, 351)
    if fallout.local_var(6) ~= 1 then
        fallout.giq_option(4, 319, 352, goto12, 49)
    end
    fallout.giq_option(4, 319, 349, gotoend, 50)
    fallout.giq_option(4, 319, 353, anger, 51)
end

function goto14()
    fallout.gsay_reply(319, 301)
    fallout.giq_option(-3, 319, 302, goto01, 50)
    fallout.giq_option(4, 319, 303, goto02, 50)
    fallout.giq_option(4, 319, 330, goto15, 50)
    fallout.giq_option(4, 319, 306, anger, 51)
end

function goto15()
    fallout.gsay_reply(319, 359)
    fallout.giq_option(4, 319, 360, goto07, 50)
    fallout.giq_option(4, 319, 361, anger, 51)
    fallout.giq_option(4, 319, 362, DownReact, 51)
end

function goto16()
    fallout.gsay_reply(319, 364)
    fallout.giq_option(4, 319, 365, goto17, 50)
    fallout.giq_option(4, 319, 366, goto16b, 50)
    fallout.giq_option(4, 319, 367, gotoend, 50)
    fallout.giq_option(-3, 319, 302, goto01, 50)
end

function goto16b()
    if fallout.local_var(6) ~= 1 then
        goto12()
    else
        goto18()
    end
end

function goto17()
    fallout.gsay_reply(319, 368)
    fallout.giq_option(4, 319, 369, gotoend, 50)
    fallout.giq_option(4, 319, 316, goto07, 50)
end

function goto18()
    fallout.gsay_reply(319, 374)
    fallout.giq_option(4, 319, 369, gotoend, 50)
    fallout.giq_option(4, 319, 350, DownReact, 51)
end

function goto19()
    fallout.gsay_reply(319, 374)
    fallout.giq_option(4, 319, 369, gotoend, 50)
    fallout.giq_option(4, 319, 350, DownReact, 51)
end

function goto20()
    fallout.gsay_reply(319, 377)
    fallout.giq_option(4, 319, 378, gotoend, 50)
    fallout.giq_option(4, 319, 379, goto20b, 49)
    fallout.giq_option(-3, 319, 302, goto01, 50)
end

function goto20b()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, -10)) then
        goto21()
    else
        goto01()
    end
end

function goto21()
    reaction.UpReact()
    fallout.gsay_reply(319, 380)
    fallout.giq_option(4, 319, 381, goto17, 50)
    fallout.giq_option(4, 319, 382, goto16b, 50)
    fallout.giq_option(4, 319, 383, gotoend, 50)
end

function anger()
    reaction.DownReact()
    goto01()
end

function gotoend()
end

function gotostory()
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
return exports
