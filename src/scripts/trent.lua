local fallout = require("fallout")
local reaction = require("lib.reaction")
local reputation = require("lib.reputation")

local start
local critter_p_proc
local damage_p_proc
local destroy_p_proc
local pickup_p_proc
local use_obj_on_p_proc
local talk_p_proc
local Trent00
local Trent01
local Trent02
local Trent03
local Trent04
local Trent05
local Trent06
local Trent07
local Trent08
local Trent09
local Trent10
local Trent11
local Trent12
local Trent13
local Trent14
local Trent15
local Trent16
local Trent17
local Trent18
local Trent19
local Trent20
local Trent21
local Trent22
local Trent23
local Trent24
local flee_dude
local give_money

local calm = 0
local initialized = false
local known = 0
local scared = 0
local close2dude = 0
local dest_tile = 0
local direction = 0
local prev_dist = 0

local exit_line = 0

function start()
    if not initialized and fallout.metarule(14, 0) then
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 35)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 2)
        initialized = true
    else
        if fallout.script_action() == 12 then
            critter_p_proc()
        else
            if fallout.script_action() == 14 then
                damage_p_proc()
            else
                if fallout.script_action() == 18 then
                    destroy_p_proc()
                else
                    if fallout.script_action() == 4 then
                        pickup_p_proc()
                    else
                        if fallout.script_action() == 7 then
                            use_obj_on_p_proc()
                        else
                            if fallout.script_action() == 11 then
                                talk_p_proc()
                            end
                        end
                    end
                end
            end
        end
    end
end

function critter_p_proc()
    if scared and (fallout.tile_distance_objs(fallout.self_obj(), fallout.dude_obj()) < 60) then
        flee_dude()
    else
        if not(close2dude) then
            if fallout.tile_distance_objs(fallout.dude_obj(), fallout.self_obj()) <= 2 then
                close2dude = 1
            else
                direction = fallout.rotation_to_tile(fallout.tile_num(fallout.dude_obj()) % 200, fallout.tile_num(fallout.dude_obj()) // 200)
                dest_tile = fallout.tile_num_in_direction(fallout.tile_num(fallout.dude_obj()), direction, 1)
                fallout.animate_move_obj_to_tile(fallout.self_obj(), dest_tile, 1)
                if (fallout.random(1, 18) == 1) and not(calm) then
                    fallout.float_msg(fallout.self_obj(), fallout.message_str(703, 141), 0)
                end
            end
        else
            if not(scared) then
                if fallout.random(1, 4) == 1 then
                    fallout.anim(fallout.self_obj(), 1000, fallout.rotation_to_tile(fallout.tile_num(fallout.self_obj()), fallout.tile_num(fallout.dude_obj())))
                end
            end
        end
    end
end

function damage_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        scared = 1
    end
    fallout.script_overrides()
    flee_dude()
end

function destroy_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        reputation.inc_good_critter()
    end
end

function pickup_p_proc()
    scared = 1
end

function use_obj_on_p_proc()
    if (fallout.obj_pid(fallout.obj_being_used_with()) == 81) or (fallout.obj_pid(fallout.obj_being_used_with()) == 103) or (fallout.obj_pid(fallout.obj_being_used_with()) == 126) then
        fallout.destroy_object(fallout.obj_being_used_with())
        if fallout.obj_is_carrying_obj_pid(fallout.self_obj(), 41) == 100 then
            if scared then
                Trent21()
            else
                Trent22()
            end
        else
            if scared then
                Trent23()
            else
                Trent24()
            end
        end
        calm = 1
        scared = 0
    end
end

function talk_p_proc()
    if (scared == 1) or (fallout.global_var(155) < -20) then
        Trent00()
    else
        fallout.start_gdialog(703, fallout.self_obj(), 4, -1, -1)
        fallout.gsay_start()
        reaction.get_reaction()
        if calm then
            Trent16()
        else
            if known then
                Trent02()
            else
                Trent01()
            end
        end
        fallout.gsay_end()
        fallout.end_dialogue()
    end
end

function Trent00()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(703, 100), 0)
end

function Trent01()
    known = 1
    fallout.gsay_reply(703, 101)
    if fallout.global_var(106) == 1 then
        fallout.giq_option(7, 703, 102, Trent03, 50)
    end
    fallout.giq_option(4, 703, 103, Trent04, 50)
    fallout.giq_option(4, 703, 104, Trent03, 50)
    fallout.giq_option(4, 703, 105, Trent05, 51)
    if (fallout.global_var(101) == 0) and (fallout.obj_is_carrying_obj_pid(fallout.dude_obj(), 55) == 0) then
        fallout.giq_option(4, 703, 106, Trent06, 50)
    end
    if fallout.global_var(100) == 1 then
        fallout.giq_option(4, 703, 107, Trent07, 50)
    end
    fallout.giq_option(-3, 703, 108, Trent08, 51)
end

function Trent02()
    fallout.gsay_reply(703, 109)
    fallout.giq_option(4, 703, 103, Trent04, 50)
    fallout.giq_option(4, 703, 104, Trent03, 50)
end

function Trent03()
    fallout.gsay_reply(703, 111)
    fallout.giq_option(4, 703, 112, Trent11, 50)
    fallout.giq_option(4, 703, 113, Trent12, 50)
    fallout.giq_option(4, 703, 114, Trent11, 50)
    fallout.giq_option(4, 703, 115, Trent13, 50)
end

function Trent04()
    fallout.gsay_reply(703, 116)
    fallout.giq_option(4, 703, 117, Trent11, 50)
    fallout.giq_option(4, 703, 118, Trent14, 50)
    if fallout.global_var(100) == 1 then
        fallout.giq_option(4, 703, 119, Trent07, 50)
    end
    fallout.giq_option(4, 703, 120, Trent15, 50)
end

function Trent05()
    local v0 = 0
    local v1 = 0
    calm = 0
    scared = 1
    fallout.gsay_message(703, 121, 51)
    if fallout.obj_is_carrying_obj_pid(fallout.self_obj(), 18) then
        v0 = fallout.obj_carrying_pid_obj(fallout.self_obj(), 18)
        fallout.rm_obj_from_inven(fallout.self_obj(), v0)
        fallout.add_obj_to_inven(fallout.dude_obj(), v0)
    end
    if fallout.obj_is_carrying_obj_pid(fallout.self_obj(), 31) then
        v0 = fallout.obj_carrying_pid_obj(fallout.self_obj(), 31)
        fallout.rm_obj_from_inven(fallout.self_obj(), v0)
        fallout.add_obj_to_inven(fallout.dude_obj(), v0)
    end
    if fallout.obj_is_carrying_obj_pid(fallout.self_obj(), 111) then
        v0 = fallout.obj_carrying_pid_obj(fallout.self_obj(), 111)
        fallout.rm_obj_from_inven(fallout.self_obj(), v0)
        fallout.add_obj_to_inven(fallout.dude_obj(), v0)
    end
    if fallout.obj_is_carrying_obj_pid(fallout.self_obj(), 4) then
        v0 = fallout.obj_carrying_pid_obj(fallout.self_obj(), 4)
        fallout.rm_obj_from_inven(fallout.self_obj(), v0)
        fallout.add_obj_to_inven(fallout.dude_obj(), v0)
    end
end

function Trent06()
    fallout.gsay_message(703, 122, 50)
end

function Trent07()
    scared = 1
    fallout.gsay_message(703, 123, 50)
end

function Trent08()
    fallout.gsay_message(703, 124, 51)
end

function Trent09()
    fallout.gsay_message(703, 125, 50)
end

function Trent10()
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        fallout.gsay_message(703, 142, 50)
    else
        fallout.gsay_message(703, 143, 50)
    end
end

function Trent11()
    fallout.gsay_message(703, 127, 50)
end

function Trent12()
    fallout.gsay_message(703, 128, 50)
end

function Trent13()
    fallout.gsay_message(703, 129, 50)
end

function Trent14()
    fallout.gsay_message(703, 130, 50)
end

function Trent15()
    fallout.gsay_message(703, 131, 50)
end

function Trent16()
    fallout.gsay_reply(703, 132)
    if fallout.global_var(106) == 1 then
        fallout.giq_option(7, 703, 102, Trent17, 50)
    end
    fallout.giq_option(4, 703, 103, Trent18, 50)
    fallout.giq_option(4, 703, 105, Trent05, 51)
    if (fallout.global_var(101) == 0) and (fallout.obj_is_carrying_obj_pid(fallout.dude_obj(), 55) == 0) then
        fallout.giq_option(4, 703, 106, Trent19, 50)
    end
    if fallout.global_var(100) == 1 then
        fallout.giq_option(4, 703, 107, Trent20, 50)
    end
    fallout.giq_option(-3, 703, 108, Trent10, 50)
end

function Trent17()
    fallout.gsay_message(703, 133, 50)
end

function Trent18()
    fallout.gsay_message(703, 134, 50)
end

function Trent19()
    fallout.gsay_message(703, 135, 50)
end

function Trent20()
    fallout.gsay_message(703, 136, 50)
end

function Trent21()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(703, 137), 3)
    give_money()
end

function Trent22()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(703, 138), 3)
    give_money()
end

function Trent23()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(703, 138), 3)
    give_money()
end

function Trent24()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(703, 139), 3)
    give_money()
end

function flee_dude()
    direction = 0
    prev_dist = 0
    while direction < 5 do
        if fallout.tile_distance(fallout.tile_num(fallout.dude_obj()), fallout.tile_num_in_direction(fallout.tile_num(fallout.self_obj()), direction, 3)) > prev_dist then
            dest_tile = fallout.tile_num_in_direction(fallout.tile_num(fallout.self_obj()), direction, 3)
            prev_dist = fallout.tile_distance(fallout.tile_num(fallout.dude_obj()), dest_tile)
        end
        direction = direction + 1
    end
    fallout.animate_move_obj_to_tile(fallout.self_obj(), dest_tile, 1)
end

function give_money()
    local v0 = 0
    local v1 = 0
    if fallout.obj_is_carrying_obj_pid(fallout.self_obj(), 41) then
        v0 = fallout.obj_carrying_pid_obj(fallout.self_obj(), 41)
        v1 = fallout.rm_mult_objs_from_inven(fallout.self_obj(), v0, 100)
        fallout.add_mult_objs_to_inven(fallout.dude_obj(), v0, v1)
    end
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.damage_p_proc = damage_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.use_obj_on_p_proc = use_obj_on_p_proc
exports.talk_p_proc = talk_p_proc
return exports
