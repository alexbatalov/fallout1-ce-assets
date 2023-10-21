local fallout = require("fallout")
local reputation = require("lib.reputation")
local time = require("lib.time")

local start
local critter_p_proc
local destroy_p_proc
local look_at_p_proc
local pickup_p_proc
local talk_p_proc
local show_true_name
local show_false_name
local Dragon00
local Dragon01
local Dragon02
local Dragon03
local Dragon04
local Dragon05
local Dragon06
local Dragon07
local Dragon08
local Dragon09
local Dragon10
local Dragon11
local DragonCombat
local DragonEnd

local hostile = 0
local initialized = false

function start()
    if not initialized then
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 47)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 27)
        initialized = true
    else
        if fallout.script_action() == 12 then
            critter_p_proc()
        else
            if fallout.script_action() == 18 then
                destroy_p_proc()
            else
                if fallout.script_action() == 21 then
                    look_at_p_proc()
                else
                    if fallout.script_action() == 11 then
                        talk_p_proc()
                    end
                end
            end
        end
    end
end

function critter_p_proc()
    if time.is_day() and (fallout.tile_num(fallout.self_obj()) ~= 26746) then
        fallout.animate_move_obj_to_tile(fallout.self_obj(), 26746, 0)
    else
        if time.is_night() and (fallout.tile_num(fallout.self_obj()) ~= 23938) then
            fallout.animate_move_obj_to_tile(fallout.self_obj(), 23938, 0)
        end
    end
    if fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) and (fallout.global_var(136) < 41) then
        hostile = 1
    end
    if hostile then
        hostile = 0
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    end
end

function destroy_p_proc()
    fallout.set_global_var(136, fallout.global_var(136) - 1)
    reputation.inc_good_critter()
end

function look_at_p_proc()
    if (fallout.global_var(135) == 2) or (fallout.get_critter_stat(fallout.dude_obj(), 6) > 6) then
        show_true_name()
    else
        if fallout.get_critter_stat(fallout.dude_obj(), 6) < 4 then
            show_false_name()
        else
            if fallout.get_critter_stat(fallout.dude_obj(), 4) < 5 then
                show_false_name()
            else
                if fallout.random(0, 1) then
                    show_false_name()
                else
                    show_true_name()
                end
            end
        end
    end
end

function pickup_p_proc()
    hostile = 1
end

function talk_p_proc()
    if fallout.get_critter_stat(fallout.dude_obj(), 4) < 4 then
        fallout.display_msg(fallout.message_str(766, 175))
    else
        fallout.start_gdialog(284, fallout.self_obj(), 4, -1, -1)
        fallout.gsay_start()
        fallout.set_local_var(0, 1)
        if time.is_day() then
            Dragon00()
        else
            if fallout.global_var(135) == 1 then
                Dragon07()
            else
                if fallout.global_var(135) == 2 then
                    Dragon11()
                else
                    Dragon01()
                end
            end
        end
        fallout.gsay_end()
        fallout.end_dialogue()
    end
end

function show_true_name()
    fallout.script_overrides()
    if fallout.local_var(0) ~= 0 then
        fallout.display_msg(fallout.message_str(284, 100))
    else
        fallout.display_msg(fallout.message_str(284, 103))
    end
end

function show_false_name()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(284, fallout.random(104, 110)))
end

function Dragon00()
    fallout.gsay_message(284, 111, 50)
end

function Dragon01()
    fallout.gsay_reply(284, 112)
    fallout.giq_option(4, 284, 113, Dragon02, 50)
    fallout.giq_option(4, 284, 114, Dragon06, 50)
    fallout.giq_option(4, 284, 115, DragonCombat, 50)
end

function Dragon02()
    fallout.gsay_reply(284, 116)
    fallout.giq_option(4, 284, 117, Dragon03, 50)
    fallout.giq_option(4, 284, 118, Dragon04, 50)
    fallout.giq_option(4, 284, 119, Dragon05, 50)
end

function Dragon03()
    fallout.gsay_message(284, 120, 50)
    DragonCombat()
end

function Dragon04()
    fallout.gsay_message(284, 121, 50)
end

function Dragon05()
    fallout.gsay_message(284, 122, 50)
    DragonCombat()
end

function Dragon06()
    fallout.gsay_reply(284, 123)
    fallout.giq_option(0, 284, 124, DragonEnd, 50)
    fallout.giq_option(0, 284, 125, DragonCombat, 50)
end

function Dragon07()
    fallout.gsay_reply(284, 126)
    fallout.giq_option(4, 284, 127, DragonCombat, 50)
    fallout.giq_option(4, 284, 128, Dragon08, 50)
    fallout.giq_option(4, 284, 129, Dragon10, 50)
end

function Dragon08()
    if fallout.obj_is_carrying_obj_pid(fallout.dude_obj(), 114) then
        fallout.gsay_message(284, 130, 50)
    else
        Dragon09()
    end
end

function Dragon09()
    fallout.gsay_message(284, 131, 50)
end

function Dragon10()
    fallout.gsay_message(284, 132, 50)
end

function Dragon11()
    fallout.gsay_message(284, 133, 50)
end

function DragonCombat()
    hostile = 1
end

function DragonEnd()
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
return exports
