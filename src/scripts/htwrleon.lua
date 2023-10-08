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
local damage_p_proc
local Leon01
local Leon01a
local Leon02
local Leon03
local Leon04
local Leon04a
local Leon05
local Leon06
local Leon07
local Leon08
local Leon08a
local Leon09
local LeonEnd
local LeonKickOut
local LeonPerformDump
local LeonCombat

local hostile = 0
local Only_Once = 1
local visible = 1

local exit_line = 0

function start()
    if Only_Once then
        Only_Once = 0
        if fallout.global_var(111) == 5 then
            fallout.set_obj_visibility(fallout.self_obj(), 1)
            visible = 0
        end
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 42)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 16)
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
                    else
                        if fallout.script_action() == 14 then
                            damage_p_proc()
                        end
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
    if visible == 0 then
        fallout.script_overrides()
    else
        if hostile then
            hostile = 0
            fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
        end
        if fallout.map_var(5) == 1 then
            if (fallout.obj_can_hear_obj(fallout.self_obj(), fallout.dude_obj()) == 1) or (fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) == 1) then
                combat()
            end
        else
            if fallout.map_var(1) == 1 then
                LeonPerformDump()
            end
        end
        if time.is_morning() or time.is_day() then
            if fallout.tile_num(fallout.self_obj()) ~= 22120 then
                fallout.animate_move_obj_to_tile(fallout.self_obj(), 22120, 0)
            end
        else
            if fallout.tile_num(fallout.self_obj()) ~= 16519 then
                fallout.animate_move_obj_to_tile(fallout.self_obj(), 16519, 0)
            end
        end
        if fallout.tile_distance_objs(fallout.self_obj(), fallout.dude_obj()) < 6 then
            if (fallout.local_var(5) == 0) and (fallout.tile_num(fallout.self_obj()) == 22120) then
                fallout.set_local_var(5, 1)
                fallout.dialogue_system_enter()
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
    reaction.get_reaction()
    if time.is_night() then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(866, 141), 2)
    else
        if fallout.global_var(248) == 1 then
            fallout.float_msg(fallout.self_obj(), fallout.message_str(866, 142), 2)
            combat()
        else
            if fallout.local_var(4) == 0 then
                fallout.set_local_var(4, 1)
                fallout.start_gdialog(866, fallout.self_obj(), 4, -1, -1)
                fallout.gsay_start()
                Leon01()
                fallout.gsay_end()
                fallout.end_dialogue()
            else
                fallout.start_gdialog(866, fallout.self_obj(), 4, -1, -1)
                fallout.gsay_start()
                Leon08()
                fallout.gsay_end()
                fallout.end_dialogue()
            end
        end
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
        fallout.set_global_var(159, fallout.global_var(159) + 1)
        if (fallout.global_var(159) % 2) == 0 then
            fallout.set_global_var(155, fallout.global_var(155) - 1)
        end
    end
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(866, 100))
end

function damage_p_proc()
    fallout.set_map_var(5, 1)
end

function Leon01()
    fallout.gsay_reply(866, 101)
    fallout.giq_option(4, 866, 102, Leon01a, 50)
    fallout.giq_option(4, 866, 103, LeonCombat, 51)
    fallout.giq_option(4, 866, 104, Leon03, 50)
    if fallout.global_var(111) == 1 then
        fallout.giq_option(4, 866, 140, Leon04, 50)
    end
    fallout.giq_option(-3, 866, 138, Leon09, 50)
end

function Leon01a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        Leon02()
    else
        Leon04()
    end
end

function Leon02()
    fallout.gsay_reply(866, 105)
    fallout.giq_option(4, 866, 106, LeonEnd, 50)
    fallout.giq_option(4, 866, 107, Leon03, 50)
end

function Leon03()
    fallout.gsay_reply(866, 108)
    fallout.giq_option(4, 866, 109, LeonCombat, 51)
    fallout.giq_option(4, 866, 110, LeonKickOut, 50)
    fallout.giq_option(4, 866, 111, LeonCombat, 51)
end

function Leon04()
    fallout.gsay_reply(866, 112)
    fallout.giq_option(4, 866, 113, Leon03, 50)
    fallout.giq_option(4, 866, 114, Leon04a, 50)
    if fallout.global_var(111) == 1 then
        fallout.giq_option(4, 866, 115, Leon06, 50)
    end
end

function Leon04a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        Leon02()
    else
        Leon05()
    end
end

function Leon05()
    fallout.gsay_reply(866, 116)
    fallout.giq_option(4, 866, 117, Leon03, 50)
    if fallout.global_var(111) == 1 then
        fallout.giq_option(4, 866, 118, Leon06, 50)
    end
    fallout.giq_option(4, 866, 119, Leon03, 50)
    fallout.giq_option(4, 866, 120, LeonKickOut, 50)
end

function Leon06()
    fallout.gsay_message(866, 121, 50)
    fallout.gsay_message(866, 122, 50)
    fallout.gsay_reply(866, 123)
    fallout.giq_option(4, 866, 124, Leon07, 50)
    fallout.giq_option(4, 866, 125, LeonCombat, 51)
    fallout.giq_option(4, 866, 126, Leon03, 50)
end

function Leon07()
    fallout.gsay_reply(866, 127)
    fallout.giq_option(4, 866, 128, Leon03, 50)
    fallout.giq_option(4, 866, 129, LeonKickOut, 50)
end

function Leon08()
    fallout.gsay_reply(866, 130)
    fallout.giq_option(4, 866, 131, LeonCombat, 51)
    fallout.giq_option(4, 866, 132, LeonKickOut, 50)
    fallout.giq_option(4, 866, 133, Leon08a, 50)
end

function Leon08a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, -20)) then
        Leon02()
    else
        Leon04()
    end
end

function Leon09()
    fallout.gsay_reply(866, 134)
    fallout.giq_option(4, 866, 135, LeonCombat, 51)
    fallout.giq_option(4, 866, 136, LeonKickOut, 50)
    fallout.giq_option(4, 866, 137, LeonKickOut, 50)
    fallout.giq_option(-3, 866, 139, LeonKickOut, 50)
end

function LeonEnd()
end

function LeonKickOut()
    fallout.set_map_var(1, 1)
end

function LeonPerformDump()
    fallout.set_map_var(1, 0)
    fallout.set_map_var(3, 0)
    fallout.gfade_out(1000)
    fallout.obj_close(fallout.external_var("Front_Door_Ptr"))
    fallout.set_local_var(5, 0)
    fallout.move_to(fallout.dude_obj(), 21931, 0)
    fallout.gfade_in(1000)
end

function LeonCombat()
    fallout.set_local_var(5, 1)
    combat()
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
exports.damage_p_proc = damage_p_proc
return exports
