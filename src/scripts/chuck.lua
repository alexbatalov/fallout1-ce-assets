local fallout = require("fallout")
local reaction = require("lib.reaction")
local reputation = require("lib.reputation")

local start
local damage_p_proc
local destroy_p_proc
local look_at_p_proc
local talk_p_proc
local critter_p_proc
local pickup_p_proc
local Chuck01
local Chuck02
local Chuck03
local Chuck04
local Chuck05
local Chuck06
local Chuck07
local Chuck08
local Chuck09
local Chuck10
local Chuck11
local Chuck12
local Chuck13
local Chuck14
local Chuck15
local Chuck16
local Chuck17
local Chuck18
local Chuck19
local Chuck20
local Chuck21
local Chuck22
local Chuck23
local ChuckCards
local ChuckCards2
local ChuckBye
local ChuckEnd

local initialized = false

function start()
    if not initialized then
        local self_obj = fallout.self_obj()
        if fallout.obj_is_carrying_obj_pid(self_obj, 41) == 0 then
            local coins = fallout.create_object_sid(41, 0, 0, -1)
            fallout.add_mult_objs_to_inven(self_obj, coins, fallout.random(0, 20))
            if fallout.global_var(613) == 9103 or fallout.global_var(613) == 9102 then
                fallout.critter_add_trait(self_obj, 1, 6, 0)
            else
                fallout.critter_add_trait(self_obj, 1, 6, 49)
            end
        end
        initialized = true
    end

    local script_action = fallout.script_action()
    if script_action == 18 then
        destroy_p_proc()
    elseif script_action == 21 then
        look_at_p_proc()
    elseif script_action == 11 then
        talk_p_proc()
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

function look_at_p_proc()
    fallout.script_overrides()
    if fallout.local_var(4) ~= 0 then
        fallout.display_msg(fallout.message_str(664, 101))
    else
        fallout.display_msg(fallout.message_str(664, 100))
    end
end

function talk_p_proc()
    reaction.get_reaction()
    fallout.start_gdialog(664, fallout.self_obj(), 4, -1, -1)
    fallout.gsay_start()
    if fallout.local_var(4) ~= 0 then
        Chuck22()
    else
        Chuck01()
    end
    fallout.gsay_end()
    fallout.end_dialogue()
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

function Chuck01()
    fallout.set_local_var(4, 1)
    fallout.gsay_reply(664, 102)
    fallout.giq_option(-3, 664, 103, Chuck02, 50)
    fallout.giq_option(4, 664, 104, Chuck03, 50)
    fallout.giq_option(4, 664, 105, Chuck04, 50)
    fallout.giq_option(6, 664, 106, Chuck05, 50)
end

function Chuck02()
    fallout.gsay_message(664, 107, 50)
end

function Chuck03()
    fallout.gsay_reply(664, 108)
    fallout.giq_option(4, 664, 109, Chuck09, 50)
    fallout.giq_option(4, 664, 110, Chuck14, 50)
    fallout.giq_option(6, 664, 111, Chuck15, 49)
end

function Chuck04()
    fallout.gsay_reply(664, 112)
    fallout.giq_option(4, 664, 113, Chuck14, 50)
    fallout.giq_option(4, 664, 114, Chuck18, 50)
    fallout.giq_option(4, 664, 115, ChuckBye, 50)
end

function Chuck05()
    fallout.gsay_reply(664, 117)
    fallout.giq_option(4, 664, 118, ChuckBye, 50)
    fallout.giq_option(4, 664, 119, ChuckCards, 50)
end

function Chuck06()
    reaction.DownReact()
    fallout.gsay_reply(664, 128)
    fallout.giq_option(4, 664, 129, Chuck07, 51)
    fallout.giq_option(4, 664, 130, Chuck08, 50)
end

function Chuck07()
    reaction.DownReact()
    fallout.set_local_var(5, 4)
    fallout.gsay_message(664, 131, 51)
end

function Chuck08()
    reaction.UpReact()
    fallout.gsay_message(664, 132, 50)
end

function Chuck09()
    fallout.gsay_reply(664, 133)
    fallout.giq_option(4, 664, 134, ChuckBye, 50)
    fallout.giq_option(4, 664, 135, Chuck10, 50)
    fallout.giq_option(6, 664, 136, Chuck19, 50)
end

function Chuck10()
    fallout.gsay_reply(664, 137)
    fallout.giq_option(4, 664, 138, ChuckBye, 50)
    fallout.giq_option(4, 664, 139, Chuck11, 50)
end

function Chuck11()
    fallout.gsay_reply(664, 140)
    fallout.giq_option(4, 664, 134, ChuckBye, 50)
    fallout.giq_option(4, 664, 141, Chuck12, 51)
    fallout.giq_option(4, 664, 142, Chuck13, 50)
end

function Chuck12()
    fallout.gsay_reply(664, 143)
    fallout.giq_option(4, 664, 144, Chuck07, 51)
    fallout.giq_option(5, 664, 145, reaction.UpReact, 50)
    fallout.giq_option(4, 664, 146, ChuckBye, 50)
end

function Chuck13()
    fallout.gsay_reply(664, 147)
    fallout.giq_option(4, 664, 148, ChuckCards, 49)
    fallout.giq_option(4, 664, 144, Chuck07, 51)
end

function Chuck14()
    fallout.gsay_reply(664, 149)
    fallout.giq_option(4, 664, 150, ChuckEnd, 50)
    fallout.giq_option(4, 664, 151, Chuck10, 50)
end

function Chuck15()
    fallout.gsay_reply(664, 152)
    fallout.giq_option(4, 664, 153, ChuckBye, 50)
    fallout.giq_option(4, 664, 150, ChuckEnd, 50)
    fallout.giq_option(6, 664, 154, Chuck16, 50)
end

function Chuck16()
    fallout.gsay_reply(664, 155)
    fallout.giq_option(4, 664, 156, ChuckBye, 50)
    fallout.giq_option(6, 664, 157, Chuck17, 50)
end

function Chuck17()
    fallout.gsay_reply(664, 158)
    fallout.giq_option(4, 664, 159, ChuckBye, 50)
    fallout.giq_option(4, 664, 150, reaction.DownReact, 51)
end

function Chuck18()
    fallout.set_local_var(6, 1)
    fallout.gsay_reply(664, 160)
    fallout.giq_option(4, 664, 146, ChuckBye, 50)
    fallout.giq_option(4, 664, 161, ChuckCards, 50)
end

function Chuck19()
    fallout.gsay_reply(664, 162)
    fallout.giq_option(4, 664, 146, ChuckBye, 50)
    fallout.giq_option(6, 664, 163, Chuck20, 50)
    fallout.giq_option(6, 664, 164, Chuck21, 50)
end

function Chuck20()
    fallout.gsay_reply(664, 165)
    fallout.giq_option(4, 664, 146, ChuckBye, 50)
    fallout.giq_option(6, 664, 164, Chuck21, 50)
end

function Chuck21()
    fallout.gsay_reply(664, 166)
    fallout.giq_option(0, 664, 125, ChuckBye, 50)
end

function Chuck22()
    fallout.gsay_reply(664, fallout.random(167, 169))
    fallout.giq_option(-3, 664, 103, Chuck02, 50)
    fallout.giq_option(4, 664, 170, Chuck23, 50)
    if fallout.local_var(5) < 4 then
        fallout.giq_option(4, 664, 171, ChuckCards, 50)
    end
    if fallout.local_var(6) == 0 then
        fallout.giq_option(4, 664, 172, Chuck18, 50)
    end
end

function Chuck23()
    fallout.gsay_reply(664, 173)
    fallout.giq_option(0, 664, 125, ChuckBye, 50)
end

function ChuckCards()
    fallout.gsay_reply(664, 120)
    fallout.giq_option(0, 664, 125, ChuckCards2, 50)
end

function ChuckCards2()
    if fallout.local_var(5) == 0 then
        if fallout.global_var(74) < 1 then
            fallout.gsay_reply(664, 121)
        else
            fallout.set_local_var(5, 1)
        end
    end
    if fallout.local_var(5) == 1 then
        if fallout.global_var(78) < 1 then
            fallout.gsay_reply(664, 122)
        else
            fallout.set_local_var(5, 2)
        end
    end
    if fallout.local_var(5) == 2 then
        if fallout.global_var(79) < 1 then
            fallout.gsay_reply(664, 123)
        else
            fallout.set_local_var(5, 3)
        end
    end
    if fallout.local_var(5) >= 3 then
        fallout.gsay_reply(664, 124)
        fallout.set_critter_stat(fallout.dude_obj(), 6, 1)
    end
    fallout.set_local_var(5, fallout.local_var(5) + 1)
    fallout.giq_option(4, 664, 126, ChuckBye, 50)
    fallout.giq_option(4, 664, 127, Chuck06, 50)
end

function ChuckBye()
    fallout.gsay_message(664, 116, 50)
end

function ChuckEnd()
end

local exports = {}
exports.start = start
exports.damage_p_proc = damage_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
exports.talk_p_proc = talk_p_proc
exports.critter_p_proc = critter_p_proc
exports.pickup_p_proc = pickup_p_proc
return exports
