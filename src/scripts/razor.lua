local fallout = require("fallout")
local misc = require("lib.misc")
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
local map_update_p_proc
local Razor01
local Razor02
local Razor03
local Razor04
local Razor04a
local Razor05
local Razor06
local Razor07
local Razor08
local Razor09
local Razor10
local Razor11
local Razor12
local Razor13
local Razor14
local Razor15
local Razor16
local Razor17
local Razor18
local Razor19
local Razor20
local Razor21
local Razor22
local Razor22a
local Razor23
local Razor24
local Razor25
local Razor26
local Razor27
local Razor28
local Razor29
local Razor30
local Razor31
local Razor32
local Razor33
local Razor34
local Razor35
local Razor36
local Razor37
local Razor38
local Razor41
local Razor42
local Razor43
local Razor44
local Razor45
local Razor46
local Razor46a
local Razor47
local Razor47a
local Razor48
local RazorFin
local RazorReg
local RazorEnd
local RemoveBlades

local initialized = false

function start()
    if not initialized then
        local self_obj = fallout.self_obj()
        misc.set_team(self_obj, 47)
        misc.set_ai(self_obj, 27)
        fallout.set_external_var("RazorPtr", self_obj)
        if fallout.global_var(352) == 1 then
            fallout.set_local_var(4, 1)
        end
        initialized = true
    end
end

function look_at_p_proc()
    fallout.script_overrides()
    if fallout.local_var(4) == 1 then
        fallout.display_msg(fallout.message_str(278, 220))
    else
        fallout.display_msg(fallout.message_str(278, 221))
    end
end

function description_p_proc()
    fallout.script_overrides()
    if fallout.local_var(4) == 1 then
        fallout.display_msg(fallout.message_str(278, 220))
    else
        fallout.display_msg(fallout.message_str(278, 221))
    end
end

function talk_p_proc()
    if fallout.global_var(253) == 1 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(669, fallout.random(100, 105)), 2)
    else
        if fallout.global_var(613) == 2 and fallout.local_var(6) == 1 then
            fallout.float_msg(fallout.self_obj(), fallout.message_str(278, fallout.random(215, 217)), 0)
        else
            if fallout.local_var(4) == 1 and fallout.get_critter_stat(fallout.dude_obj(), 4) < 4 then
                fallout.float_msg(fallout.self_obj(), fallout.message_str(278, 222), 0)
            else
                reaction.get_reaction()
                fallout.start_gdialog(278, fallout.self_obj(), -1, -1, -1)
                fallout.gsay_start()
                if fallout.global_var(613) == 2 then
                    if fallout.global_var(350) == 1 then
                        if fallout.global_var(353) == 1 then
                            Razor45()
                        elseif fallout.local_var(4) == 0 then
                            Razor42()
                        else
                            Razor48()
                        end
                    else
                        RazorFin()
                    end
                    fallout.set_local_var(6, 1)
                else
                    if fallout.global_var(614) == 9202 then
                        Razor33()
                    elseif fallout.global_var(612) == 9001 then
                        Razor20()
                    elseif fallout.obj_is_carrying_obj_pid(fallout.dude_obj(), 238) ~= 0 and fallout.global_var(265) ~= 2 then
                        Razor26()
                    elseif fallout.global_var(612) == 9003 then
                        Razor30()
                    elseif fallout.global_var(353) == 1 then
                        Razor46()
                    elseif fallout.global_var(612) == 0 then
                        Razor01()
                    else
                        Razor37()
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
        fallout.set_global_var(253, 1)
    end
end

function destroy_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.set_global_var(253, 1)
        reputation.inc_good_critter()
    end
    fallout.set_global_var(612, 9002)
end

function critter_p_proc()
    if fallout.global_var(352) == 1 then
        fallout.set_local_var(4, 1)
    end
    if fallout.local_var(5) == 1 then
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
        fallout.set_local_var(5, 0)
        fallout.set_global_var(253, 1)
    end
end

function pickup_p_proc()
    fallout.set_global_var(253, 1)
end

function map_update_p_proc()
    if fallout.global_var(352) == 1 then
        fallout.set_local_var(4, 1)
    end
end

function Razor01()
    fallout.gsay_reply(278, 100)
    fallout.giq_option(4, 278, 101, Razor02, 50)
    fallout.giq_option(4, 278, 102, Razor03, 50)
    fallout.giq_option(4, 278, 103, RazorEnd, 50)
    fallout.giq_option(-3, 278, 104, Razor41, 50)
end

function Razor02()
    fallout.gsay_reply(278, 105)
    fallout.gsay_option(278, 106, Razor03, 50)
    fallout.gsay_option(278, 107, Razor04, 50)
    fallout.gsay_option(278,
        fallout.message_str(278, 108) .. fallout.proto_data(fallout.obj_pid(fallout.dude_obj()), 1) .. ".", Razor05, 50)
    fallout.gsay_option(278, 109, RazorEnd, 50)
    fallout.set_local_var(4, 1)
end

function Razor03()
    fallout.gsay_reply(278, 110)
    fallout.gsay_option(278, 111, Razor06, 50)
    fallout.gsay_option(278, 112, Razor07, 50)
    fallout.gsay_option(278, 113, RazorEnd, 50)
end

function Razor04()
    fallout.gsay_reply(278, 114)
    fallout.gsay_option(278, 115, Razor09, 50)
    fallout.gsay_option(278, 116, Razor04a, 50)
    fallout.gsay_option(278, 238, RazorReg, 50)
    fallout.gsay_option(278, 117, RazorEnd, 50)
end

function Razor04a()
    reaction.BottomReact()
end

function Razor05()
    fallout.gsay_reply(278, 118)
    fallout.gsay_option(278, 119, Razor08, 50)
    fallout.gsay_option(278, 120, Razor08, 50)
    fallout.gsay_option(278, 121, RazorEnd, 50)
end

function Razor06()
    fallout.gsay_reply(278, 122)
    fallout.gsay_option(278, 123, Razor09, 50)
    fallout.gsay_option(278, 124, Razor10, 50)
    fallout.gsay_option(278, 125, Razor19, 50)
    fallout.gsay_option(278, 126, RazorEnd, 50)
end

function Razor07()
    fallout.gsay_reply(278, 127)
    fallout.gsay_option(278, 128, Razor09, 50)
    fallout.gsay_option(278, 129, Razor19, 50)
    fallout.gsay_option(278, 130, Razor19, 50)
end

function Razor08()
    fallout.gsay_reply(278, 131)
    fallout.gsay_option(278, 132, Razor04, 50)
    fallout.gsay_option(278, 133, Razor03, 50)
end

function Razor09()
    fallout.gsay_reply(278, 134)
    fallout.gsay_option(278, 135, Razor11, 50)
    fallout.gsay_option(278, 136, RazorEnd, 50)
    fallout.set_global_var(613, 9101)
end

function Razor10()
    fallout.gsay_reply(278, 137)
    fallout.gsay_option(278, 138, Razor12, 50)
    fallout.gsay_option(278, 139, Razor14, 50)
    fallout.gsay_option(278, 238, RazorReg, 50)
end

function Razor11()
    fallout.gsay_reply(278, 140)
    fallout.gsay_option(278, 141, Razor18, 50)
    fallout.gsay_option(278, 238, RazorReg, 50)
    fallout.gsay_option(278, 142, RazorEnd, 50)
end

function Razor12()
    fallout.gsay_reply(278, 143)
    fallout.gsay_option(278, 144, Razor13, 50)
    fallout.gsay_option(278, 145, RazorEnd, 50)
end

function Razor13()
    fallout.gsay_reply(278, 146)
    fallout.gsay_option(278, 147, Razor14, 50)
end

function Razor14()
    fallout.gsay_reply(278, 148)
    fallout.gsay_option(278, 149, Razor15, 50)
    fallout.gsay_option(278, 150, Razor09, 50)
end

function Razor15()
    fallout.gsay_reply(278, 151)
    fallout.gsay_option(278, 152, Razor27, 50)
    fallout.gsay_option(278, 153, Razor17, 50)
end

function Razor16()
    fallout.gsay_reply(278, 154)
    fallout.gsay_option(278, 155, RazorEnd, 50)
    local item_obj = fallout.create_object_sid(238, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), item_obj)
end

function Razor17()
    fallout.gsay_reply(278, 156)
    fallout.gsay_option(278, 157, RazorEnd, 50)
end

function Razor18()
    fallout.gsay_reply(278, 158)
    fallout.gsay_option(278, 159, RazorEnd, 50)
    fallout.set_global_var(613, 9101)
end

function Razor19()
    fallout.gsay_reply(278, 160)
    fallout.gsay_option(278, 161, RazorEnd, 50)
end

function Razor20()
    fallout.gsay_reply(278, 162)
    fallout.giq_option(4, 278, 163, Razor21, 50)
    fallout.giq_option(4, 278, 164, RazorEnd, 50)
    fallout.giq_option(-3, 278, 165, Razor41, 50)
end

function Razor21()
    fallout.gsay_reply(278, 166)
    fallout.gsay_option(278, 167, Razor22, 50)
    fallout.gsay_option(278, 168, Razor07, 50)
    fallout.gsay_option(278, 169, RazorEnd, 50)
end

function Razor22()
    fallout.gsay_reply(278, 170)
    fallout.gsay_option(278, 171, Razor22a, 50)
    fallout.gsay_option(278, 172, Razor23, 50)
end

function Razor22a()
    fallout.set_local_var(5, 1)
end

function Razor23()
    fallout.gsay_reply(278, 173)
    fallout.gsay_option(278, 174, Razor22a, 50)
    fallout.gsay_option(278, 175, Razor24, 50)
end

function Razor24()
    fallout.gsay_reply(278, 176)
    fallout.gsay_option(278, 177, Razor22a, 50)
    fallout.gsay_option(278, 178, Razor25, 50)
end

function Razor25()
    fallout.gsay_reply(278, 179)
    fallout.gsay_option(278, 180, Razor13, 50)
end

function Razor26()
    fallout.gsay_reply(278, 181)
    fallout.giq_option(4, 278, 182, Razor29, 50)
    fallout.giq_option(-3, 278, 183, Razor41, 50)
end

function Razor27()
    fallout.gsay_reply(278, 184)
    fallout.gsay_option(278, 185, Razor28, 50)
    fallout.gsay_option(278, 238, RazorReg, 50)
    fallout.gsay_option(278, 186, RazorEnd, 50)
end

function Razor28()
    fallout.gsay_reply(278, 187)
    fallout.gsay_option(278, 188, Razor16, 50)
    fallout.set_global_var(613, 9101)
end

function Razor29()
    fallout.gsay_message(278, 189, 50)
end

function Razor30()
    fallout.gsay_reply(278, 190)
    fallout.giq_option(4, 278, 191, Razor31, 50)
    fallout.giq_option(-3, 278, 192, Razor41, 50)
end

function Razor31()
    fallout.gsay_reply(278, 193)
    fallout.gsay_option(278, 194, Razor32, 50)
    fallout.gsay_option(278, 195, Razor19, 50)
end

function Razor32()
    fallout.gsay_message(278, 196, 50)
    fallout.set_global_var(613, 9101)
end

function Razor33()
    fallout.gsay_reply(278, 197)
    fallout.giq_option(4, 278, 198, Razor34, 50)
    fallout.giq_option(4, 278, 199, Razor35, 50)
    if fallout.global_var(612) ~= 9003 then
        fallout.giq_option(4, 278, 201, Razor36, 50)
    end
    fallout.giq_option(-3, 278, 200, Razor41, 50)
end

function Razor34()
    fallout.gsay_message(278, 202, 50)
    reaction.TopReact()
    fallout.set_global_var(613, 9104)
    fallout.gfade_out(600)
    fallout.game_time_advance(10 * 60 * 60 * 8)
end

function Razor35()
    fallout.gsay_message(278, 203, 50)
    reaction.TopReact()
    fallout.set_global_var(613, 9103)
    fallout.gfade_out(600)
    fallout.game_time_advance(10 * 60 * 60 * 24)
    fallout.load_map("laadytum.map", 1)
end

function Razor36()
    fallout.gsay_message(278, 204, 50)
    fallout.set_global_var(613, 9102)
end

function Razor37()
    fallout.gsay_reply(278, 205)
    fallout.giq_option(4, 278, 206, RazorEnd, 50)
    fallout.giq_option(4, 278, 207, RazorEnd, 50)
    if fallout.obj_is_carrying_obj_pid(fallout.dude_obj(), 238) ~= 0 then
        fallout.giq_option(4, 278, 208, Razor38, 50)
    end
    fallout.giq_option(4, 278, 209, Razor22a, 50)
    fallout.giq_option(-3, 278, 210, Razor41, 50)
end

function Razor38()
    fallout.gsay_message(278, 211, 50)
end

function Razor41()
    fallout.gsay_message(278, 218, 50)
end

function Razor42()
    fallout.gsay_reply(278, 224)
    fallout.giq_option(4, 278, 225, Razor43, 50)
    fallout.giq_option(-3, 278, 226, Razor41, 50)
end

function Razor43()
    fallout.gsay_reply(278, 227)
    fallout.gsay_option(278, 228, Razor44, 50)
end

function Razor44()
    fallout.gsay_message(278, 229, 50)
    fallout.set_global_var(155, fallout.global_var(155) + 2)
    fallout.display_msg(fallout.message_str(766, 103) .. 500 .. fallout.message_str(766, 104))
    fallout.give_exp_points(500)
end

function Razor45()
    fallout.gsay_message(278, 230, 50)
    fallout.set_global_var(155, fallout.global_var(155) + 2)
    fallout.display_msg(fallout.message_str(766, 103) .. 500 .. fallout.message_str(766, 104))
    fallout.give_exp_points(500)
end

function Razor46()
    fallout.gsay_reply(278, 231)
    fallout.gsay_option(278, 232, Razor46a, 50)
    fallout.gsay_option(278, 233, Razor47, 50)
end

function Razor46a()
    fallout.gsay_message(278, 215, 50)
end

function Razor47()
    fallout.gsay_reply(278, 234)
    fallout.gsay_option(278, 235, Razor47a, 50)
    fallout.gsay_option(278, 236, RazorEnd, 50)
end

function Razor47a()
    fallout.gsay_message(278, 215, 50)
    fallout.set_global_var(613, 9101)
end

function Razor48()
    fallout.gsay_message(278, 237, 50)
    fallout.set_global_var(155, fallout.global_var(155) + 2)
    fallout.display_msg(fallout.message_str(766, 103) .. 500 .. fallout.message_str(766, 104))
    fallout.give_exp_points(500)
end

function RazorFin()
    fallout.gsay_message(278, 223, 50)
end

function RazorReg()
    fallout.gsay_message(278, 239, 50)
    fallout.set_global_var(353, 1)
end

function RazorEnd()
end

function RemoveBlades()
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
exports.map_update_p_proc = map_update_p_proc
return exports
