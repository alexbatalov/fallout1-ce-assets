local fallout = require("fallout")
local misc = require("lib.misc")
local reaction = require("lib.reaction")
local reputation = require("lib.reputation")
local time = require("lib.time")

local start
local critter_p_proc
local pickup_p_proc
local talk_p_proc
local destroy_p_proc
local look_at_p_proc
local damage_p_proc
local FryDialog
local FryCombat
local FryEnd
local Fry00
local Fry01
local Fry02
local Fry03
local Fry04
local Fry05
local Fry06
local Fry07
local Fry08
local Fry09
local Fry10
local Fry11
local Fry12
local Fry13
local Fry14
local Fry15
local Fry16
local Fry17
local Fry18
local Fry19
local Fry20
local Fry21
local Fry22
local Fry23
local Fry24

local hostile = false
local initialized = false

function start()
    if not initialized then
        local self_obj = fallout.self_obj()
        if fallout.global_var(469) == 1 then
            fallout.set_obj_visibility(self_obj, true)
        end
        misc.set_team(self_obj, 40)
        fallout.critter_add_trait(self_obj, 1, 5, 86)
        initialized = true
    end

    local script_action = fallout.script_action()
    if script_action == 21 then
        look_at_p_proc()
    elseif script_action == 4 then
        pickup_p_proc()
    elseif script_action == 11 then
        talk_p_proc()
    elseif script_action == 12 then
        critter_p_proc()
    elseif script_action == 18 then
        destroy_p_proc()
    end
end

function critter_p_proc()
    local self_obj = fallout.self_obj()
    if hostile then
        hostile = false
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    end
    if time.is_morning() or time.is_day() then
        if fallout.tile_num(self_obj) ~= 21508 then
            fallout.animate_move_obj_to_tile(self_obj, 21508, 0)
        else
            if fallout.random(1, 150) == 1 then
                fallout.animate_move_obj_to_tile(self_obj,
                    fallout.tile_num_in_direction(fallout.tile_num(self_obj), fallout.random(0, 5),
                        fallout.random(3, 5)), 0)
            end
        end
    else
        if fallout.tile_num(self_obj) ~= 22280 then
            fallout.animate_move_obj_to_tile(self_obj, 22280, 0)
        end
    end
end

function pickup_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        hostile = true
    end
end

function talk_p_proc()
    reaction.get_reaction()
    FryDialog()
end

function destroy_p_proc()
    reputation.inc_good_critter()
    fallout.set_global_var(469, 1)
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(567, 100))
end

function damage_p_proc()
    local pid = fallout.obj_pid(fallout.source_obj())
    if fallout.party_member_obj(pid) ~= nil then
        fallout.set_global_var(248, 1)
    end
end

function FryDialog()
    if time.is_evening() or time.is_night() then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(567, 146), 3)
    else
        fallout.start_gdialog(567, fallout.self_obj(), 4, -1, -1)
        fallout.gsay_start()
        if fallout.global_var(220) > 2 then
            Fry11()
        elseif fallout.global_var(221) == 1 then
            Fry12()
        elseif fallout.global_var(222) > 2 then
            Fry13()
        elseif fallout.local_var(4) == 0 then
            Fry00()
            fallout.set_local_var(4, 1)
        elseif fallout.global_var(158) > 2 then
            Fry10()
        elseif fallout.local_var(1) == 3 then
            Fry14()
        elseif fallout.local_var(1) == 2 then
            Fry15()
        else
            Fry16()
        end
        fallout.gsay_end()
        fallout.end_dialogue()
    end
end

function FryCombat()
    hostile = true
end

function FryEnd()
end

function Fry00()
    if fallout.global_var(158) > 2 then
        fallout.gsay_reply(567, 101)
    else
        fallout.gsay_reply(567, 102)
    end
    fallout.giq_option(4, 567, 103, Fry01, 50)
    fallout.giq_option(4, 567, 104, FryEnd, 50)
    fallout.giq_option(-3, 567, 105, Fry09, 50)
    fallout.giq_option(-3, 567, 106, Fry09, 50)
end

function Fry01()
    fallout.gsay_reply(567, 107)
    fallout.giq_option(4, 567, 108, Fry02, 50)
    fallout.giq_option(4, 567, 109, Fry03, 50)
end

function Fry02()
    fallout.set_global_var(219, 1)
    fallout.gsay_reply(567, 110)
    if fallout.global_var(106) ~= 2 then
        fallout.set_global_var(106, 1)
    end
    Fry05()
end

function Fry03()
    fallout.set_global_var(219, 1)
    fallout.gsay_reply(567, 111)
    if fallout.global_var(106) ~= 2 then
        fallout.set_global_var(106, 1)
    end
    fallout.giq_option(4, 567, 112, Fry07, 50)
    fallout.giq_option(4, 567, 113, Fry04, 50)
    fallout.giq_option(4, 567, 114, Fry06, 50)
    fallout.giq_option(4, 567, 115, Fry21, 50)
    if fallout.global_var(101) ~= 2 then
        fallout.giq_option(4, 567, 147, Fry23, 50)
    end
    fallout.giq_option(4, 567, 116, Fry08, 50)
end

function Fry04()
    fallout.gsay_reply(567, 117)
    Fry05()
end

function Fry05()
    if fallout.global_var(219) == 1 then
        fallout.giq_option(4, 567, 112, Fry07, 50)
    end
    if fallout.global_var(106) == 1 then
        fallout.giq_option(4, 567, 114, Fry06, 50)
    end
    fallout.giq_option(4, 567, 115, Fry21, 50)
    if fallout.global_var(101) ~= 2 then
        fallout.giq_option(4, 567, 147, Fry23, 50)
    end
    fallout.giq_option(4, 567, 116, Fry08, 50)
end

function Fry06()
    fallout.gsay_reply(567, 118)
    Fry05()
end

function Fry07()
    fallout.gsay_reply(567, 119)
    Fry05()
end

function Fry08()
    fallout.gsay_message(567, 120, 50)
    FryEnd()
end

function Fry09()
    fallout.gsay_message(567, 121, 50)
    FryEnd()
end

function Fry10()
    fallout.gsay_message(567, 122, 50)
    FryEnd()
end

function Fry11()
    fallout.gsay_message(567, 123, 50)
    FryCombat()
end

function Fry12()
    fallout.gsay_message(567, 124, 50)
    FryEnd()
end

function Fry13()
    fallout.gsay_reply(567, 125)
    FryCombat()
end

function Fry14()
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        fallout.gsay_reply(567, 130)
    else
        fallout.gsay_reply(567, 131)
    end
    Fry17()
end

function Fry15()
    fallout.gsay_reply(567, 132)
    Fry17()
end

function Fry16()
    fallout.gsay_reply(567, 133)
    Fry17()
end

function Fry17()
    if fallout.global_var(101) ~= 2 then
        fallout.giq_option(4, 567, 147, Fry24, 50)
    end
    fallout.giq_option(4, 567, 134, Fry18, 49)
    fallout.giq_option(4, 567, 135, Fry19, 50)
    fallout.giq_option(4, 567, 136, Fry20, 50)
    fallout.giq_option(4, 567, 137, Fry21, 49)
    fallout.giq_option(4, 567, 138, FryEnd, 50)
    fallout.giq_option(-3, 567, 139, Fry09, 50)
    fallout.giq_option(-3, 567, 140, Fry09, 50)
end

function Fry18()
    fallout.gsay_reply(567, 141)
    Fry17()
end

function Fry19()
    fallout.gsay_reply(567, 142)
    Fry17()
end

function Fry20()
    fallout.gsay_reply(567, 143)
    Fry17()
end

function Fry21()
    fallout.gsay_reply(567, 144)
    Fry17()
end

function Fry22()
    fallout.gsay_message(567, 145, 50)
    FryEnd()
end

function Fry23()
    fallout.gsay_reply(567, 148)
    Fry05()
end

function Fry24()
    fallout.gsay_reply(567, 148)
    Fry17()
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
