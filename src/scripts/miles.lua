local fallout = require("fallout")
local reaction = require("lib.reaction")
local reputation = require("lib.reputation")

local Start
local look_at_p_proc
local description_p_proc
local talk_p_proc
local damage_p_proc
local destroy_p_proc
local critter_p_proc
local pickup_p_proc
local Miles01
local Miles02
local Miles03
local Miles04
local Miles05
local Miles06
local Miles07
local Miles08
local Miles09
local Miles11
local Miles12
local Miles13
local Miles14
local Miles15
local Miles16
local Miles17
local Miles17a
local Miles18
local Miles19
local Miles22
local Miles22a
local Miles23
local Miles24
local Miles25
local Miles27
local Miles28
local Miles29
local MilesEnd

local Initialize = 1
local DisplayMessage = 100

local exit_line = 0

function Start()
    if Initialize then
        if fallout.obj_is_carrying_obj_pid(fallout.self_obj(), 41) == 0 then
            fallout.item_caps_adjust(fallout.self_obj(), fallout.random(500, 750))
        end
        if (fallout.global_var(613) == 9103) or (fallout.global_var(613) == 9102) then
            fallout.critter_add_trait(fallout.self_obj(), 1, 6, 0)
        else
            fallout.critter_add_trait(fallout.self_obj(), 1, 6, 49)
        end
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 6)
        Initialize = 0
    end
end

function look_at_p_proc()
    fallout.script_overrides()
    if fallout.local_var(4) == 1 then
        fallout.display_msg(fallout.message_str(249, 100))
    else
        fallout.display_msg(fallout.message_str(249, 101))
    end
end

function description_p_proc()
    fallout.script_overrides()
    if fallout.local_var(4) == 1 then
        fallout.display_msg(fallout.message_str(249, 100))
    else
        fallout.display_msg(fallout.message_str(249, 101))
    end
end

function talk_p_proc()
    if fallout.global_var(251) == 1 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(669, fallout.random(100, 105)), 2)
    else
        if (fallout.local_var(4) == 1) and (fallout.get_critter_stat(fallout.dude_obj(), 4) < 4) then
            fallout.float_msg(fallout.self_obj(), fallout.message_str(249, 152), 0)
        else
            if fallout.local_var(5) == 2 then
                fallout.float_msg(fallout.self_obj(), fallout.message_str(249, 152), 0)
            else
                reaction.get_reaction()
                fallout.start_gdialog(249, fallout.self_obj(), -1, -1, -1)
                fallout.gsay_start()
                if fallout.local_var(4) == 0 then
                    Miles01()
                else
                    if fallout.global_var(138) == 0 then
                        DisplayMessage = 118
                        Miles04()
                    else
                        if fallout.global_var(138) == 1 then
                            Miles13()
                        else
                            if fallout.global_var(138) == 9302 then
                                Miles18()
                            else
                                if fallout.global_var(138) == 9303 then
                                    Miles19()
                                else
                                    if fallout.global_var(138) == 9304 then
                                        if fallout.local_var(5) == 0 then
                                            if fallout.obj_is_carrying_obj_pid(fallout.dude_obj(), 3) then
                                                Miles22()
                                            else
                                                Miles22a()
                                            end
                                        else
                                            if fallout.local_var(5) == 9305 then
                                                if fallout.obj_is_carrying_obj_pid(fallout.dude_obj(), 3) then
                                                    Miles24()
                                                else
                                                    Miles29()
                                                end
                                            else
                                                if fallout.obj_is_carrying_obj_pid(fallout.dude_obj(), 3) then
                                                    Miles28()
                                                else
                                                    Miles29()
                                                end
                                            end
                                        end
                                    end
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
end

function damage_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.set_global_var(251, 1)
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 49)
    end
end

function destroy_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.set_global_var(251, 1)
        reputation.inc_good_critter()
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 49)
    end
end

function critter_p_proc()
    if fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) then
        if fallout.global_var(251) == 1 then
            fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
        end
    end
end

function pickup_p_proc()
    fallout.set_global_var(251, 1)
end

function Miles01()
    fallout.gsay_reply(249, 102)
    fallout.giq_option(4, 249, 103, Miles02, 50)
    fallout.giq_option(4, 249, 104, Miles03, 50)
    fallout.giq_option(-3, 249, 105, Miles09, 50)
    fallout.set_local_var(4, 1)
end

function Miles02()
    fallout.gsay_message(249, 106, 50)
end

function Miles03()
    DisplayMessage = 107
    Miles04()
end

function Miles04()
    fallout.gsay_reply(249, DisplayMessage)
    fallout.gsay_option(249, 108, Miles05, 50)
    fallout.gsay_option(249, 109, Miles06, 50)
    fallout.gsay_option(249, 110, Miles07, 50)
    fallout.gsay_option(249, 111, Miles08, 50)
end

function Miles05()
    fallout.gsay_reply(249, 112)
    fallout.gsay_option(249, 113, Miles11, 50)
end

function Miles06()
    DisplayMessage = 114
    Miles04()
end

function Miles07()
    DisplayMessage = 115
    Miles04()
end

function Miles08()
    fallout.gsay_message(249, 116, 50)
end

function Miles09()
    fallout.gsay_message(249, 117, 50)
end

function Miles11()
    fallout.gsay_reply(249, 119)
    fallout.gsay_option(249, 120, Miles12, 50)
    fallout.gsay_option(249, 121, MilesEnd, 50)
end

function Miles12()
    fallout.gsay_message(249, 122, 50)
    fallout.set_global_var(138, 1)
end

function Miles13()
    fallout.gsay_reply(249, 123)
    if fallout.obj_is_carrying_obj_pid(fallout.dude_obj(), 98) then
        fallout.gsay_option(249, 124, Miles15, 50)
    else
        fallout.gsay_option(249, 125, Miles14, 50)
    end
end

function Miles14()
    fallout.gsay_message(249, 126, 50)
end

function Miles15()
    fallout.gsay_reply(249, 127)
    fallout.set_global_var(138, 9302)
    fallout.gsay_option(249, 128, Miles16, 50)
    fallout.gsay_option(249, 129, MilesEnd, 50)
end

function Miles16()
    fallout.gsay_reply(249, 130)
    fallout.gsay_option(249, 131, Miles17, 50)
    fallout.gsay_option(249, 132, Miles17a, 50)
end

function Miles17()
    local v0 = 0
    fallout.gsay_message(249, 133, 50)
    v0 = fallout.obj_carrying_pid_obj(fallout.dude_obj(), 98)
    fallout.rm_obj_from_inven(fallout.dude_obj(), v0)
    fallout.destroy_object(v0)
    fallout.item_caps_adjust(fallout.dude_obj(), 125)
    v0 = fallout.create_object_sid(40, 0, 0, -1)
    fallout.add_mult_objs_to_inven(fallout.dude_obj(), v0, 3)
    fallout.set_global_var(138, 9304)
    fallout.gsay_message(249, 137, 50)
end

function Miles17a()
    local v0 = 0
    reaction.UpReactLevel()
    fallout.gsay_message(249, 133, 50)
    v0 = fallout.obj_carrying_pid_obj(fallout.dude_obj(), 98)
    fallout.rm_obj_from_inven(fallout.dude_obj(), v0)
    fallout.destroy_object(v0)
    fallout.item_caps_adjust(fallout.dude_obj(), 150)
    v0 = fallout.create_object_sid(40, 0, 0, -1)
    fallout.add_mult_objs_to_inven(fallout.dude_obj(), v0, 4)
    fallout.set_global_var(138, 9304)
    fallout.gsay_message(249, 137, 50)
end

function Miles18()
    fallout.gsay_reply(249, 134)
    fallout.gsay_option(249, 128, Miles16, 50)
    fallout.gsay_option(249, 129, MilesEnd, 50)
end

function Miles19()
    local v0 = 0
    fallout.gsay_message(249, 135, 50)
    fallout.gsay_message(249, 136, 50)
    v0 = fallout.obj_carrying_pid_obj(fallout.dude_obj(), 98)
    fallout.rm_obj_from_inven(fallout.dude_obj(), v0)
    fallout.destroy_object(v0)
    fallout.item_caps_adjust(fallout.dude_obj(), 250)
    v0 = fallout.create_object_sid(40, 0, 0, -1)
    fallout.add_mult_objs_to_inven(fallout.dude_obj(), v0, 6)
    fallout.set_global_var(138, 9304)
    fallout.gsay_message(249, 137, 50)
end

function Miles22()
    fallout.gsay_reply(249, 138)
    fallout.set_local_var(5, 9305)
    fallout.set_global_var(615, 1)
    fallout.gsay_option(249, 139, MilesEnd, 50)
    fallout.gsay_option(249, 140, Miles23, 50)
end

function Miles22a()
    fallout.gsay_message(249, 153, 50)
end

function Miles23()
    fallout.gsay_message(249, 141, 50)
end

function Miles24()
    fallout.gsay_reply(249, 142)
    if fallout.obj_is_carrying_obj_pid(fallout.dude_obj(), 237) then
        fallout.gsay_option(249, 143, Miles25, 50)
    else
        fallout.gsay_option(249, 144, MilesEnd, 50)
    end
end

function Miles25()
    local v0 = 0
    fallout.gsay_reply(249, 145)
    v0 = fallout.obj_carrying_pid_obj(fallout.dude_obj(), 237)
    fallout.rm_obj_from_inven(fallout.dude_obj(), v0)
    fallout.add_obj_to_inven(fallout.self_obj(), v0)
    fallout.set_local_var(5, 9306)
    fallout.gsay_option(249, 146, Miles28, 50)
    fallout.gsay_option(249, 147, Miles27, 50)
end

function Miles27()
    fallout.gsay_message(249, 148, 50)
end

function Miles28()
    local v0 = 0
    local v1 = 0
    fallout.gsay_message(249, 149, 50)
    fallout.gfade_out(600)
    fallout.game_time_advance(10 * 60 * 60 * 24)
    fallout.gfade_in(600)
    fallout.gsay_message(249, 150, 50)
    v1 = fallout.create_object_sid(42, 0, 0, -1)
    fallout.move_obj_inven_to_obj(fallout.dude_obj(), v1)
    fallout.move_obj_inven_to_obj(v1, fallout.dude_obj())
    v0 = fallout.obj_carrying_pid_obj(fallout.dude_obj(), 3)
    fallout.rm_obj_from_inven(fallout.dude_obj(), v0)
    fallout.destroy_object(v0)
    fallout.destroy_object(v1)
    v0 = fallout.create_object_sid(232, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), v0)
    fallout.set_local_var(5, 2)
end

function Miles29()
    fallout.gsay_message(249, 151, 50)
end

function MilesEnd()
end

local exports = {}
exports.look_at_p_proc = look_at_p_proc
exports.description_p_proc = description_p_proc
exports.talk_p_proc = talk_p_proc
exports.damage_p_proc = damage_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.critter_p_proc = critter_p_proc
exports.pickup_p_proc = pickup_p_proc
return exports
