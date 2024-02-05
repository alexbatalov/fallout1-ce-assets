local fallout = require("fallout")
local misc = require("lib.misc")
local reaction = require("lib.reaction")
local reputation = require("lib.reputation")

local start
local critter_p_proc
local pickup_p_proc
local talk_p_proc
local destroy_p_proc
local look_at_p_proc
local Maxson01
local Maxson02
local Maxson02a
local Maxson03
local Maxson04
local Maxson04a
local Maxson05
local Maxson06
local Maxson07
local Maxson08
local Maxson08a
local Maxson09
local Maxson09a
local Maxson10
local Maxson11
local Maxson12
local Maxson13
local Maxson14
local Maxson15
local Maxson16
local Maxson17
local Maxson18
local Maxson19
local Maxson20
local Maxson21
local Maxson22
local Maxson23
local Maxson24
local Maxson25
local Maxson26
local Maxson27
local Maxson28
local Maxson29
local Maxson30
local Maxson31
local Maxson32
local Maxson33
local Maxson34
local Maxson35
local MaxsonEnd
local Remove_Player

local hostile = false
local initialized = false
local Denounce_Player = false
local Asked_For_1000 = false

function start()
    if not initialized then
        local self_obj = fallout.self_obj()
        misc.set_team(self_obj, 44)
        fallout.critter_add_trait(self_obj, 1, 5, 80)
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
    if fallout.global_var(250) ~= 0 then
        hostile = true
    end
    if fallout.tile_distance_objs(fallout.self_obj(), fallout.dude_obj()) > 12 then
        hostile = false
    end
    if hostile then
        fallout.set_global_var(250, 1)
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
    reaction.get_reaction()
    fallout.start_gdialog(52, fallout.self_obj(), 4, 12, 5)
    fallout.gsay_start()
    if (fallout.global_var(223) == 1) or (fallout.global_var(223) == 2) then
        Maxson34()
    elseif fallout.global_var(17) == 1 then
        Maxson22()
    elseif fallout.local_var(5) == 1 then
        Maxson22()
    elseif fallout.global_var(78) == 2 then
        Maxson20()
    elseif fallout.local_var(4) == 0 then
        fallout.set_local_var(4, 1)
        Maxson01()
    elseif fallout.local_var(1) == 1 then
        Maxson21()
    else
        Maxson19()
    end
    fallout.gsay_end()
    fallout.end_dialogue()
    if fallout.local_var(8) == 1 then
        fallout.set_local_var(8, 2)
        local xp = 1500
        fallout.display_msg(fallout.message_str(52, 351) .. xp .. fallout.message_str(52, 352))
        fallout.give_exp_points(xp)
    end
    if Denounce_Player then
        Remove_Player()
    end
end

function destroy_p_proc()
    fallout.set_global_var(250, 1)
    fallout.rm_timer_event(fallout.self_obj())
    reputation.inc_good_critter()
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(52, 100))
end

function Maxson01()
    fallout.gsay_reply(52, 106)
    fallout.giq_option(-3, 52, 333, Maxson32, 50)
    if fallout.global_var(106) == 2 then
        fallout.giq_option(4, 52, 300, Maxson14, 50)
    end
    if fallout.global_var(106) == 1 then
        fallout.giq_option(4, 52, 301, Maxson06, 50)
    end
    fallout.giq_option(4, 52, 349, Maxson27, 50)
    fallout.giq_option(4, 52, 350, Maxson18, 50)
end

function Maxson02()
    fallout.gsay_reply(52, 162)
    fallout.giq_option(4, 52, 302, Maxson04, 50)
    fallout.giq_option(4, 52, 303, Maxson09, 50)
    fallout.giq_option(4, 52, 304, Maxson02a, 51)
    fallout.giq_option(4, 52, 305, Maxson08, 50)
end

function Maxson02a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 15, 0)) then
        Asked_For_1000 = true
        Maxson09()
    else
        Maxson12()
    end
end

function Maxson03()
end

function Maxson04()
    fallout.gsay_reply(52, 133)
    fallout.giq_option(4, 52, 306, Maxson04a, 50)
    fallout.giq_option(4, 52, 307, Maxson27, 50)
    fallout.giq_option(4, 52, 308, MaxsonEnd, 50)
end

function Maxson04a()
    fallout.set_map_var(20, 1)
    Maxson05()
end

function Maxson05()
    fallout.gsay_reply(52, 276)
    fallout.giq_option(4, 52, 309, MaxsonEnd, 50)
end

function Maxson06()
    fallout.gsay_reply(52, 122)
    fallout.giq_option(4, 52, 310, Maxson07, 50)
    fallout.giq_option(4, 52, 311, Maxson02, 50)
end

function Maxson07()
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        fallout.gsay_reply(52, 355)
    else
        fallout.gsay_reply(52, 356)
    end
    fallout.giq_option(4, 52, 312, Maxson14, 50)
    fallout.giq_option(4, 52, 313, Maxson13, 50)
end

function Maxson08()
    fallout.gsay_reply(52, 184)
    fallout.giq_option(4, 52, 314, Maxson18, 50)
    fallout.giq_option(4, 52, 315, Maxson04a, 50)
    fallout.giq_option(4, 52, 316, Maxson08a, 50)
end

function Maxson08a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 15, -20)) then
        Maxson04()
    else
        Maxson10()
    end
end

function Maxson09()
    fallout.gsay_reply(52, 223)
    fallout.giq_option(4, 52, 317, Maxson09a, 51)
    fallout.giq_option(4, 52, 318, Maxson18, 50)
    fallout.giq_option(4, 52, 319, MaxsonEnd, 50)
end

function Maxson09a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 15, -10)) then
        Maxson10()
    else
        Maxson11()
    end
end

function Maxson10()
    if Asked_For_1000 then
        fallout.item_caps_adjust(fallout.dude_obj(), 1000)
    else
        fallout.item_caps_adjust(fallout.dude_obj(), 500)
    end
    reaction.DownReact()
    fallout.gsay_reply(52, 226)
    fallout.giq_option(4, 52, 320, MaxsonEnd, 51)
end

function Maxson11()
    fallout.gsay_message(52, 229, 51)
    Denounce_Player = true
end

function Maxson12()
    fallout.gsay_message(52, 229, 51)
    Denounce_Player = true
end

function Maxson13()
    fallout.gsay_message(52, 231, 51)
    Denounce_Player = true
end

function Maxson14()
    fallout.gsay_reply(52, 146)
    fallout.giq_option(4, 52, 321, Maxson02, 50)
end

function Maxson15()
    fallout.gsay_reply(52, 141)
    fallout.giq_option(4, 52, 322, Maxson02, 50)
    fallout.giq_option(4, 52, 323, Maxson16, 50)
end

function Maxson16()
    fallout.gsay_reply(52, 223)
    fallout.giq_option(4, 52, 324, Maxson17, 50)
    fallout.giq_option(4, 52, 325, Maxson18, 50)
    fallout.giq_option(4, 52, 326, Maxson17, 50)
end

function Maxson17()
    fallout.gsay_reply(52, 168)
    fallout.giq_option(4, 52, 327, MaxsonEnd, 51)
end

function Maxson18()
    fallout.gsay_message(52, 222, 50)
end

function Maxson19()
    fallout.gsay_reply(52, 201)
    fallout.giq_option(-3, 52, 333, Maxson32, 50)
    if fallout.global_var(106) == 2 then
        fallout.giq_option(4, 52, 329, Maxson14, 50)
    end
    if fallout.global_var(106) == 1 then
        fallout.giq_option(4, 52, 330, Maxson06, 50)
    end
    fallout.giq_option(4, 52, 332, Maxson27, 50)
    fallout.giq_option(4, 52, 331, Maxson18, 50)
end

function Maxson20()
    fallout.gsay_reply(52, 193)
    fallout.giq_option(-3, 52, 333, Maxson32, 50)
    fallout.giq_option(4, 52, 334, Maxson22, 50)
    fallout.giq_option(4, 52, 335, Maxson27, 50)
    fallout.giq_option(4, 52, 336, Maxson18, 50)
end

function Maxson21()
    fallout.gsay_reply(52, 201)
    fallout.giq_option(-3, 52, 333, Maxson32, 50)
    fallout.giq_option(4, 52, 334, Maxson22, 50)
    fallout.giq_option(4, 52, 335, Maxson27, 50)
    fallout.giq_option(4, 52, 336, Maxson18, 50)
end

function Maxson22()
    local temp = fallout.local_var(7)
    fallout.gsay_reply(52, 205)
    if temp == 0 and fallout.global_var(78) ~= 2 then
        fallout.giq_option(4, 52, 337, Maxson18, 50)
    elseif temp == 0 and fallout.global_var(78) == 2 and fallout.global_var(79) == 2 then
        fallout.giq_option(4, 52, 339, Maxson23, 50)
    elseif temp == 0 and fallout.global_var(78) == 2 and fallout.global_var(79) ~= 2 then
        fallout.giq_option(4, 52, 338, Maxson23, 50)
    end
    if fallout.global_var(17) == 1 then
        fallout.giq_option(4, 52, 400, Maxson35, 50)
    end
    fallout.giq_option(4, 52, 335, Maxson27, 50)
    fallout.giq_option(4, 52, 336, Maxson18, 50)
end

function Maxson23()
    fallout.set_local_var(7, 1)
    fallout.set_local_var(8, 1)
    fallout.gsay_reply(52, 213)
    fallout.giq_option(4, 52, 340, Maxson24, 50)
end

function Maxson24()
    fallout.set_local_var(5, 1)
    fallout.gsay_reply(52, 219)
    fallout.giq_option(4, 52, 341, Maxson25, 50)
    fallout.giq_option(4, 52, 342, Maxson33, 50)
end

function Maxson25()
    fallout.set_map_var(19, 1)
    fallout.gsay_message(52, 221, 50)
end

function Maxson26()
    fallout.gsay_reply(52, 210)
    fallout.giq_option(4, 52, 343, Maxson23, 50)
end

function Maxson27()
    fallout.gsay_reply(52, fallout.random(138, 140))
    if fallout.local_var(6) == 0 then
        fallout.giq_option(4, 52, 344, Maxson28, 50)
    end
    fallout.giq_option(4, 52, 345, Maxson29, 50)
    fallout.giq_option(4, 52, 346, Maxson30, 50)
    fallout.giq_option(4, 52, 347, Maxson31, 50)
    fallout.giq_option(4, 52, 348, Maxson18, 50)
end

function Maxson28()
    fallout.set_local_var(6, 1)
    local item_obj = fallout.create_object_sid(216, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), item_obj)
    fallout.gsay_reply(52, 186)
    fallout.giq_option(4, 52, 349, Maxson27, 50)
    fallout.giq_option(4, 52, 350, Maxson18, 50)
end

function Maxson29()
    fallout.gsay_reply(52, 172)
    fallout.giq_option(4, 52, 349, Maxson27, 50)
    fallout.giq_option(4, 52, 350, Maxson18, 50)
end

function Maxson30()
    fallout.gsay_reply(52, 244)
    fallout.giq_option(4, 52, 349, Maxson27, 50)
    fallout.giq_option(4, 52, 350, Maxson18, 50)
end

function Maxson31()
    fallout.gsay_reply(52, 262)
    fallout.giq_option(4, 52, 349, Maxson27, 50)
    fallout.giq_option(4, 52, 350, Maxson18, 50)
end

function Maxson32()
    fallout.gsay_reply(52, 275)
    fallout.giq_option(4, 52, 349, Maxson27, 50)
    fallout.giq_option(4, 52, 350, Maxson18, 50)
end

function Maxson33()
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        fallout.gsay_reply(52, 357)
    else
        fallout.gsay_reply(52, 358)
    end
    fallout.giq_option(4, 52, 349, Maxson27, 50)
    fallout.giq_option(4, 52, 350, Maxson18, 50)
end

function Maxson34()
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        fallout.gsay_reply(52, 359)
    else
        fallout.gsay_reply(52, 360)
    end
    fallout.giq_option(4, 52, 349, Maxson27, 50)
    fallout.giq_option(4, 52, 350, Maxson18, 50)
end

function Maxson35()
    fallout.gsay_reply(52, 133)
    fallout.giq_option(4, 52, 335, Maxson27, 50)
    fallout.giq_option(4, 52, 336, Maxson18, 50)
end

function MaxsonEnd()
end

function Remove_Player()
    fallout.set_global_var(108, 5)
    fallout.set_global_var(583, 0)
    fallout.set_global_var(584, 0)
    fallout.set_global_var(585, 0)
    fallout.set_global_var(586, 0)
    fallout.load_map(13, 1)
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
return exports
