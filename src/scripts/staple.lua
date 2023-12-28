local fallout = require("fallout")
local reaction = require("lib.reaction")
local reputation = require("lib.reputation")

local start
local critter_p_proc
local pickup_p_proc
local talk_p_proc
local destroy_p_proc
local damage_p_proc
local look_at_p_proc
local Staple00
local Staple01
local Staple02
local Staple03
local Staple04
local Staple05
local Staple06
local Staple06a
local Staple06b
local Staple06c
local Staple07
local Staple08
local Staple09
local Staple10
local Staple11
local Staple12
local Staple13
local Staple14
local Staple15
local Staple15a
local Staple16
local Staple17
local StapleEnd
local Get_Stuff
local Put_Stuff

local hostile = false
local initialized = false

local STUFF <const> = {
    [73] = 5,
    [76] = 5,
    [80] = 5,
    [86] = 5,
    [102] = 5,
}

function start()
    if not initialized then
        local self_obj = fallout.self_obj()
        fallout.critter_add_trait(self_obj, 1, 6, 70)
        fallout.critter_add_trait(self_obj, 1, 5, 50)
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
    if hostile then
        hostile = false
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    end
end

function pickup_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        hostile = true
    end
end

function talk_p_proc()
    Get_Stuff()
    reaction.get_reaction()
    fallout.gdialog_set_barter_mod(-50)
    if fallout.local_var(4) == 0 then
        fallout.set_local_var(4, 1)
        fallout.start_gdialog(862, fallout.self_obj(), 4, -1, -1)
        fallout.gsay_start()
        Staple00()
        fallout.gsay_end()
        fallout.end_dialogue()
    else
        if fallout.local_var(6) == 1 then
            Staple13()
        else
            fallout.start_gdialog(862, fallout.self_obj(), 4, -1, -1)
            fallout.gsay_start()
            Staple01()
            fallout.gsay_end()
            fallout.end_dialogue()
        end
    end
    Put_Stuff()
end

function destroy_p_proc()
    reputation.inc_good_critter()
end

function damage_p_proc()
    local pid = fallout.obj_pid(fallout.source_obj())
    if fallout.party_member_obj(pid) ~= nil then
        fallout.set_global_var(248, 1)
    end
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(862, 100))
end

function Staple00()
    fallout.gsay_reply(862, 102)
    Staple02()
end

function Staple01()
    fallout.gsay_reply(862, 103)
    Staple02()
end

function Staple02()
    fallout.giq_option(4, 862, 104, Staple03, 50)
    if fallout.global_var(101) ~= 2 and fallout.local_var(5) == 0 then
        fallout.giq_option(4, 862, 105, Staple04, 50)
    end
    if fallout.global_var(615) == 1 then
        fallout.giq_option(4, 862, 130, Staple15, 50)
    end
    fallout.giq_option(4, 862, 106, StapleEnd, 50)
    fallout.giq_option(-3, 862, 125, Staple14, 50)
end

function Staple03()
    fallout.gsay_message(862, 107, 50)
    fallout.gdialog_mod_barter(-50)
    fallout.gsay_reply(862, 127)
    fallout.giq_option(4, 862, 128, StapleEnd, 50)
    fallout.giq_option(-3, 862, 129, StapleEnd, 50)
end

function Staple04()
    fallout.gsay_reply(862, 108)
    fallout.giq_option(4, 862, 109, Staple05, 50)
    fallout.giq_option(4, 862, 110, Staple06, 50)
end

function Staple05()
    fallout.gsay_reply(862, 111)
    fallout.giq_option(4, 862, 112, Staple06, 50)
end

function Staple06()
    fallout.gsay_reply(862, 113)
    fallout.giq_option(4, 862, 114, Staple06a, 50)
    fallout.giq_option(4, 862, 115, Staple06b, 50)
    fallout.giq_option(4, 862, 116, Staple06c, 50)
    fallout.giq_option(4, 862, 117, StapleEnd, 50)
end

function Staple06a()
    if fallout.item_caps_total(fallout.dude_obj()) >= 750 then
        Staple09()
    else
        Staple07()
    end
end

function Staple06b()
    local dude_obj = fallout.dude_obj()
    if fallout.is_success(fallout.do_check(dude_obj, 3, 0)) or fallout.is_success(fallout.roll_vs_skill(dude_obj, 15, 0)) then
        if fallout.item_caps_total(dude_obj) >= 500 then
            Staple10()
        else
            Staple07()
        end
    else
        Staple07()
    end
end

function Staple06c()
    if fallout.is_success(fallout.do_check(fallout.dude_obj(), 0, 0)) then
        Staple11()
    else
        Staple08()
    end
end

function Staple07()
    fallout.gsay_message(862, 118, 50)
end

function Staple08()
    fallout.set_local_var(6, 1)
    fallout.gsay_message(862, 119, 51)
end

function Staple09()
    fallout.item_caps_adjust(fallout.dude_obj(), -750)
    fallout.gsay_message(862, 120, 50)
    Staple12()
end

function Staple10()
    fallout.item_caps_adjust(fallout.dude_obj(), -500)
    fallout.gsay_message(862, 121, 50)
    Staple12()
end

function Staple11()
    fallout.set_local_var(6, 1)
    fallout.gsay_message(862, 122, 51)
    Staple12()
end

function Staple12()
    fallout.set_local_var(5, 1)
    local item_obj = fallout.create_object_sid(230, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), item_obj)
    fallout.gsay_message(862, 123, 50)
end

function Staple13()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(862, 124), 2)
end

function Staple14()
    fallout.gsay_message(862, 126, 50)
end

function Staple15()
    fallout.gsay_reply(862, 131)
    fallout.giq_option(4, 862, 114, Staple15a, 50)
    fallout.giq_option(4, 862, 117, StapleEnd, 50)
end

function Staple15a()
    if fallout.item_caps_total(fallout.dude_obj()) >= 750 then
        Staple16()
    else
        Staple17()
    end
end

function Staple16()
    fallout.item_caps_adjust(fallout.dude_obj(), -750)
    fallout.set_global_var(615, 2)
    local item_obj = fallout.create_object_sid(237, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), item_obj)
    fallout.gsay_message(862, 132, 50)
end

function Staple17()
    fallout.gsay_message(862, 133, 50)
end

function StapleEnd()
end

function Get_Stuff()
    local self_obj = fallout.self_obj()
    for pid, qty in ipairs(STUFF) do
        local item_obj = fallout.create_object_sid(pid, 0, 0, -1)
        fallout.add_mult_objs_to_inven(self_obj, item_obj, qty)
    end
    fallout.item_caps_adjust(self_obj, 500)
end

function Put_Stuff()
    local self_obj = fallout.self_obj()
    for pid, qty in ipairs(STUFF) do
        local item_obj = fallout.obj_carrying_pid_obj(self_obj, pid)
        if item_obj ~= nil then
            fallout.rm_mult_objs_from_inven(self_obj, item_obj, qty)
            fallout.destroy_object(item_obj)
        end
    end
    fallout.item_caps_adjust(self_obj, -fallout.item_caps_total(self_obj))
    fallout.item_caps_adjust(self_obj, 24)
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.damage_p_proc = damage_p_proc
exports.look_at_p_proc = look_at_p_proc
return exports
