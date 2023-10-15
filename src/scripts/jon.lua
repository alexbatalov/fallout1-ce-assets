local fallout = require("fallout")
local reaction = require("lib.reaction")
local reputation = require("lib.reputation")

local start
local look_at_p_proc
local description_p_proc
local talk_p_proc
local damage_p_proc
local destroy_p_proc
local critter_p_proc
local pickup_p_proc
local Zim00
local Zim01
local Zim02
local Zim03
local Zim03a
local Zim04
local Zim05
local Zim06
local Zim07
local Zim08
local Zim08a
local Zim09
local Zim10
local Zim11
local Zim12
local Zim13
local Zim14
local Zim15
local Zim16
local Zim17
local Zim18
local Zim19
local Zim20
local Zim21
local Zim22
local Zim23
local Zim24
local Zim25
local Zim26
local Zim27
local ZimEnd

local initialized = false
local DisplayMessage = 0

local exit_line = 0

function start()
    if not initialized then
        if fallout.obj_is_carrying_obj_pid(fallout.self_obj(), 41) == 0 then
            fallout.item_caps_adjust(fallout.self_obj(), fallout.random(50, 150))
        end
        if fallout.global_var(613) == 9103 then
            if fallout.global_var(612) ~= 9003 then
                fallout.critter_add_trait(fallout.self_obj(), 1, 6, 89)
            else
                fallout.critter_add_trait(fallout.self_obj(), 1, 6, 0)
            end
        else
            fallout.critter_add_trait(fallout.self_obj(), 1, 6, 49)
        end
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 6)
        fallout.set_external_var("JonPtr", fallout.self_obj())
        initialized = true
    end
end

function look_at_p_proc()
    fallout.script_overrides()
    if fallout.local_var(4) == 1 then
        fallout.display_msg(fallout.message_str(288, 176))
    else
        fallout.display_msg(fallout.message_str(288, 175))
    end
end

function description_p_proc()
    fallout.script_overrides()
    if fallout.local_var(4) == 1 then
        fallout.display_msg(fallout.message_str(288, 176))
    else
        fallout.display_msg(fallout.message_str(288, 175))
    end
end

function talk_p_proc()
    if fallout.global_var(251) == 1 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(669, fallout.random(100, 105)), 2)
    else
        if (fallout.local_var(4) == 1) and (fallout.get_critter_stat(fallout.dude_obj(), 4) < 4) then
            fallout.float_msg(fallout.self_obj(), fallout.message_str(288, 139), 0)
        else
            if fallout.global_var(612) == 2 then
                fallout.float_msg(fallout.self_obj(), fallout.message_str(288, fallout.random(183, 187)), 0)
            else
                reaction.get_reaction()
                fallout.start_gdialog(288, fallout.self_obj(), -1, -1, -1)
                fallout.gsay_start()
                DisplayMessage = 100
                if fallout.local_var(4) == 0 then
                    Zim00()
                else
                    if fallout.global_var(612) == 0 then
                        Zim01()
                    else
                        if fallout.obj_is_carrying_obj_pid(fallout.dude_obj(), 238) then
                            if fallout.global_var(612) == 9001 then
                                Zim24()
                            else
                                Zim27()
                            end
                        else
                            if fallout.global_var(612) == 1 then
                                Zim17()
                            else
                                if fallout.global_var(612) == 9001 then
                                    Zim19()
                                else
                                    if fallout.global_var(612) == 9002 then
                                        Zim21()
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
        if fallout.global_var(616) ~= 1 then
            fallout.set_global_var(251, 1)
            fallout.critter_add_trait(fallout.self_obj(), 1, 6, 49)
        end
    end
end

function destroy_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        if fallout.global_var(616) ~= 1 then
            fallout.set_global_var(251, 1)
            fallout.critter_add_trait(fallout.self_obj(), 1, 6, 49)
        end
        reputation.inc_good_critter()
    end
end

function critter_p_proc()
    if fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) then
        if (fallout.global_var(613) == 9103) and (fallout.global_var(612) ~= 9003) then
            fallout.critter_add_trait(fallout.self_obj(), 1, 6, 89)
            fallout.float_msg(fallout.self_obj(), fallout.message_str(288, 174), 2)
            fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
        else
            if fallout.global_var(251) == 1 then
                fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
            end
        end
    end
    if fallout.global_var(616) == 1 then
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 89)
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    end
end

function pickup_p_proc()
    fallout.set_global_var(251, 1)
end

function Zim00()
    DisplayMessage = 182
    fallout.gsay_reply(288, 100)
    fallout.giq_option(4, 288, 181, Zim01, 50)
    fallout.giq_option(-3, 288, 104, Zim13, 50)
    fallout.set_local_var(4, 1)
end

function Zim01()
    fallout.gsay_reply(288, DisplayMessage)
    fallout.giq_option(4, 288, 101, Zim02, 50)
    fallout.giq_option(4, 288, 102, Zim14, 50)
    if fallout.obj_is_carrying_obj_pid(fallout.dude_obj(), 238) then
        fallout.giq_option(4, 288, 178, Zim26, 50)
    end
    fallout.giq_option(4, 288, 103, ZimEnd, 50)
    fallout.giq_option(-3, 288, 104, Zim13, 50)
end

function Zim02()
    fallout.gsay_reply(288, 105)
    fallout.gsay_option(288, 106, Zim03, 50)
    fallout.gsay_option(288, 107, Zim03, 50)
    fallout.gsay_option(288, 108, Zim04, 50)
end

function Zim03()
    fallout.gsay_reply(288, 109)
    fallout.gsay_option(288, 110, Zim04, 50)
    fallout.gsay_option(288, 111, Zim13, 50)
    fallout.gsay_option(288, 112, Zim03a, 50)
end

function Zim03a()
    fallout.set_global_var(612, 1)
end

function Zim04()
    fallout.gsay_reply(288, 113)
    fallout.gsay_option(288, 114, Zim07, 50)
    fallout.gsay_option(288, 115, Zim05, 50)
    fallout.gsay_option(288, 116, Zim05, 50)
end

function Zim05()
    fallout.gsay_reply(288, 117)
    fallout.gsay_option(288, 118, Zim06, 50)
    fallout.gsay_option(288, 119, Zim07, 50)
end

function Zim06()
    fallout.gsay_reply(288, 120)
    fallout.gsay_option(288, 121, Zim07, 50)
    fallout.gsay_option(288, 122, Zim11, 50)
end

function Zim07()
    fallout.gsay_reply(288, 123)
    fallout.gsay_option(288, 124, Zim09, 50)
    fallout.gsay_option(288, 125, Zim08, 50)
    fallout.gsay_option(288, 126, Zim10, 50)
end

function Zim08()
    fallout.gsay_reply(288, 127)
    fallout.gsay_option(288, 128, Zim09, 50)
    fallout.gsay_option(288, 129, Zim10, 50)
    fallout.gsay_option(288, 130, Zim08a, 50)
end

function Zim08a()
    reaction.BottomReact()
    fallout.set_global_var(612, 1)
end

function Zim09()
    fallout.gsay_reply(288, 131)
    fallout.gsay_option(288, 132, Zim10, 50)
    fallout.gsay_option(288, 133, Zim08a, 50)
    fallout.set_global_var(612, 1)
end

function Zim10()
    fallout.gsay_message(288, 134, 50)
    fallout.set_global_var(612, 9001)
end

function Zim11()
    fallout.gsay_reply(288, 135)
    fallout.gsay_option(288, 136, Zim16, 50)
    fallout.gsay_option(288, 137, Zim08a, 50)
end

function Zim12()
    fallout.gsay_message(288, 138, 50)
    reaction.BottomReact()
    fallout.set_global_var(616, 1)
    fallout.gfade_out(600)
    fallout.move_to(fallout.dude_obj(), 9097, 0)
    fallout.gfade_in(600)
end

function Zim13()
    fallout.gsay_message(288, 139, 50)
end

function Zim14()
    fallout.gsay_reply(288, 140)
    fallout.gsay_option(288, 141, Zim15, 50)
    fallout.gsay_option(288, 142, Zim12, 50)
end

function Zim15()
    fallout.gsay_reply(288, 143)
    fallout.gsay_option(288, 144, Zim03, 50)
    fallout.gsay_option(288, 145, Zim03, 50)
    fallout.gsay_option(288, 146, Zim04, 50)
    fallout.gsay_option(288, 147, Zim12, 50)
end

function Zim16()
    fallout.gsay_reply(288, 148)
    fallout.gsay_option(288, 149, Zim07, 50)
    fallout.gsay_option(288, 150, Zim07, 50)
    fallout.gsay_option(288, 151, Zim08a, 50)
end

function Zim17()
    fallout.gsay_reply(288, 152)
    fallout.gsay_option(288, 153, Zim18, 50)
    fallout.gsay_option(288, 154, Zim14, 50)
    fallout.gsay_option(288, 155, ZimEnd, 50)
end

function Zim18()
    fallout.gsay_message(288, 156, 50)
    fallout.set_global_var(612, 9001)
end

function Zim19()
    fallout.gsay_reply(288, 157)
    fallout.gsay_option(288, 158, Zim12, 50)
    fallout.gsay_option(288, 159, Zim20, 50)
    fallout.gsay_option(288, 160, Zim13, 50)
end

function Zim20()
    fallout.gsay_message(288, 161, 50)
end

function Zim21()
    fallout.gsay_reply(288, 162)
    fallout.gsay_option(288, 163, Zim22, 50)
    fallout.gsay_option(288, 164, Zim23, 50)
    fallout.gsay_option(288, 165, Zim22, 50)
    fallout.set_global_var(612, 2)
end

function Zim22()
    fallout.gsay_message(288, 166, 50)
    reaction.TopReact()
    fallout.item_caps_adjust(fallout.dude_obj(), 2000)
end

function Zim23()
    fallout.gsay_message(288, 167, 50)
    reaction.TopReact()
    fallout.item_caps_adjust(fallout.dude_obj(), 2500)
end

function Zim24()
    fallout.gsay_reply(288, 168)
    fallout.gsay_option(288, 169, Zim25, 50)
    fallout.gsay_option(288, 170, Zim26, 50)
end

function Zim25()
    fallout.gsay_reply(288, 171)
    fallout.gsay_option(288, 172, Zim26, 50)
end

function Zim26()
    local v0 = 0
    v0 = fallout.obj_carrying_pid_obj(fallout.dude_obj(), 238)
    fallout.rm_obj_from_inven(fallout.dude_obj(), v0)
    fallout.gsay_message(288, 173, 50)
    fallout.set_global_var(612, 9003)
    if fallout.global_var(613) == 9102 then
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 0)
        fallout.set_global_var(613, 9103)
    else
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 0)
    end
end

function Zim27()
    fallout.gsay_reply(288, 177)
    fallout.gsay_option(288, 178, Zim26, 50)
    fallout.gsay_option(288, 179, ZimEnd, 50)
end

function ZimEnd()
end

local exports = {}
exports.start = start
exports.look_at_p_proc = look_at_p_proc
exports.description_p_proc = description_p_proc
exports.talk_p_proc = talk_p_proc
exports.damage_p_proc = damage_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.critter_p_proc = critter_p_proc
exports.pickup_p_proc = pickup_p_proc
return exports
