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
local Nicole00
local Nicole01
local Nicole02
local Nicole04
local Nicole05
local Nicole06
local Nicole07
local Nicole08
local Nicole08a
local Nicole09
local Nicole10
local Nicole11
local Nicole12
local Nicole13
local Nicole14
local Nicole15
local Nicole16
local Nicole17
local Nicole18
local Nicole19
local Nicole20
local Nicole21
local Nicole21a
local Nicole25
local Nicole26
local Nicole27
local Nicole28
local Nicole29
local Nicole30
local Nicole31
local Nicole32
local Nicole33
local Nicole34
local Nicole35
local Nicole36
local Nicole37
local Nicole39
local Nicole41
local Nicole50
local Nicole51
local Nicole52
local Nicole53
local Nicole54
local Nicole55
local Nicole78
local NicoleMore
local NicoleShowOut
local NicoleEnd

local Initialize = 1
local DisplayMessage = 100

local exit_line = 0

function start()
    if Initialize then
        if fallout.obj_is_carrying_obj_pid(fallout.self_obj(), 41) == 0 then
            fallout.item_caps_adjust(fallout.self_obj(), fallout.random(50, 150))
        end
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 46)
        Initialize = 0
    end
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(54, 100))
end

function description_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(54, 100))
end

function talk_p_proc()
    if fallout.global_var(256) == 1 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(669, fallout.random(100, 105)), 2)
    else
        if (fallout.local_var(4) == 1) and (fallout.get_critter_stat(fallout.dude_obj(), 4) < 4) then
            fallout.float_msg(fallout.self_obj(), fallout.message_str(54, 286), 0)
        else
            if fallout.local_var(2) == 0 then
                fallout.set_local_var(2, 1)
                fallout.set_local_var(1, 3)
                reaction.LevelToReact()
            end
            fallout.start_gdialog(54, fallout.self_obj(), 4, 19, 12)
            fallout.gsay_start()
            if fallout.local_var(4) == 0 then
                Nicole01()
            else
                DisplayMessage = 132
                Nicole00()
            end
            fallout.gsay_end()
            fallout.end_dialogue()
            if fallout.local_var(5) == 1 then
                fallout.gfade_in(600)
                fallout.set_local_var(5, 0)
            end
        end
    end
end

function damage_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.set_global_var(256, 1)
    end
end

function destroy_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.set_global_var(256, 1)
        reputation.inc_good_critter()
    end
end

function critter_p_proc()
    if fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) then
        if fallout.global_var(256) == 1 then
            fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
        end
    end
end

function pickup_p_proc()
    fallout.set_global_var(256, 1)
end

function Nicole00()
    fallout.gsay_reply(54, DisplayMessage)
    fallout.gsay_option(54, 101, Nicole29, 50)
    fallout.gsay_option(54, 102, Nicole02, 50)
    if fallout.global_var(18) == 0 then
        fallout.giq_option(4, 54, 319, Nicole50, 50)
    end
    fallout.gsay_option(54, 131, Nicole14, 50)
end

function Nicole01()
    fallout.gsay_reply(54, 105)
    fallout.giq_option(4, 54, 106, Nicole02, 50)
    fallout.giq_option(4, 54, 107, Nicole11, 51)
    fallout.giq_option(4, 54, 108, Nicole09, 50)
    fallout.giq_option(4, 54, 109, Nicole15, 50)
    fallout.giq_option(-3, 54, 110, Nicole78, 50)
    fallout.set_local_var(4, 1)
end

function Nicole02()
    fallout.gsay_reply(54, 111)
    fallout.gsay_option(54, 112, Nicole04, 50)
end

function Nicole04()
    fallout.gsay_reply(54, 113)
    fallout.gsay_option(54, 114, Nicole05, 50)
    fallout.gsay_option(54, 115, Nicole11, 51)
end

function Nicole05()
    fallout.gsay_reply(54, 116)
    fallout.gsay_option(54, 117, Nicole06, 50)
end

function Nicole06()
    fallout.gsay_reply(54, 118)
    fallout.gsay_option(54, 119, Nicole07, 50)
    fallout.gsay_option(54, 123, Nicole08, 50)
    if fallout.local_var(1) >= 2 then
        fallout.gsay_option(54, 121, Nicole08a, 50)
    else
        fallout.gsay_option(54, 121, Nicole11, 51)
    end
end

function Nicole07()
    fallout.gsay_reply(54, 122)
    fallout.gsay_option(54, 123, Nicole08, 50)
    fallout.gsay_option(54, 124, Nicole28, 50)
    fallout.gsay_option(54, 125, Nicole19, 49)
    if fallout.local_var(1) >= 2 then
        fallout.gsay_option(54, 126, Nicole08a, 50)
    else
        fallout.gsay_option(54, 126, Nicole11, 51)
    end
end

function Nicole08()
    fallout.gsay_message(54, 127, 50)
    DisplayMessage = 129
    NicoleMore()
end

function Nicole08a()
    fallout.gsay_message(54, 128, 50)
    DisplayMessage = 129
    NicoleMore()
end

function Nicole09()
    DisplayMessage = 132
    Nicole00()
end

function Nicole10()
    fallout.gsay_message(54, 133, 50)
    NicoleShowOut()
end

function Nicole11()
    reaction.DownReactLevel()
    fallout.gsay_reply(54, 134)
    fallout.gsay_option(54, 135, Nicole12, 50)
    fallout.gsay_option(54, 136, Nicole13, 50)
end

function Nicole12()
    reaction.BottomReact()
    fallout.gsay_message(54, 137, 50)
    NicoleShowOut()
end

function Nicole13()
    DisplayMessage = 138
    NicoleMore()
end

function Nicole14()
    fallout.gsay_message(54, 141, 50)
end

function Nicole15()
    fallout.gsay_reply(54, 142)
    fallout.gsay_option(54, 143, Nicole16, 50)
end

function Nicole16()
    fallout.gsay_reply(54, 144)
    fallout.gsay_option(54, 145, Nicole17, 50)
    fallout.gsay_option(54, 146, Nicole25, 50)
end

function Nicole17()
    fallout.gsay_reply(54, 147)
    fallout.gsay_option(54, 148, Nicole07, 50)
    fallout.gsay_option(54, 149, Nicole18, 50)
end

function Nicole18()
    fallout.gsay_reply(54, 151)
    fallout.gsay_option(54, 152, Nicole19, 49)
    fallout.gsay_option(54, 153, Nicole20, 50)
end

function Nicole19()
    DisplayMessage = 154
    NicoleMore()
end

function Nicole20()
    fallout.gsay_reply(54, 157)
    fallout.gsay_option(54, 158, Nicole21, 50)
    fallout.gsay_option(54, 159, Nicole21a, 51)
    if fallout.local_var(1) >= 2 then
        fallout.gsay_option(54, 160, Nicole09, 50)
    else
        fallout.gsay_option(54, 160, Nicole10, 51)
    end
    fallout.gsay_option(54, 164, Nicole14, 50)
end

function Nicole21()
    fallout.gsay_reply(54, 161)
    if fallout.local_var(1) >= 2 then
        fallout.gsay_option(54, 163, Nicole09, 50)
    else
        fallout.gsay_option(54, 163, Nicole10, 51)
    end
    fallout.gsay_option(54, 164, Nicole14, 50)
end

function Nicole21a()
    fallout.gsay_reply(54, 162)
    if fallout.local_var(1) >= 2 then
        fallout.gsay_option(54, 163, Nicole09, 50)
    else
        fallout.gsay_option(54, 163, Nicole10, 51)
    end
    fallout.gsay_option(54, 164, Nicole14, 50)
end

function Nicole25()
    fallout.gsay_reply(54, 175)
    fallout.gsay_option(54, 176, Nicole26, 50)
    fallout.gsay_option(54, 177, Nicole11, 50)
    fallout.gsay_option(54, 178, Nicole27, 50)
end

function Nicole26()
    DisplayMessage = 179
    NicoleMore()
end

function Nicole27()
    DisplayMessage = 182
    NicoleMore()
end

function Nicole28()
    fallout.gsay_reply(54, 185)
    fallout.gsay_option(54, 186, Nicole19, 49)
    if fallout.local_var(1) >= 2 then
        fallout.gsay_option(54, 187, Nicole09, 50)
    else
        fallout.gsay_option(54, 187, Nicole10, 51)
    end
    fallout.gsay_option(54, 188, Nicole14, 50)
end

function Nicole29()
    fallout.gsay_reply(54, 189)
    fallout.gsay_option(54, 190, Nicole30, 50)
    fallout.gsay_option(54, 191, Nicole31, 50)
    fallout.gsay_option(54, 192, Nicole04, 50)
end

function Nicole30()
    fallout.gsay_reply(54, 193)
    fallout.gsay_option(54, 194, Nicole31, 50)
    fallout.gsay_option(54, 195, Nicole36, 50)
end

function Nicole31()
    fallout.gsay_reply(54, 196)
    fallout.gsay_option(54, 197, Nicole39, 50)
    fallout.gsay_option(54, 198, Nicole11, 50)
    fallout.gsay_option(54, 199, Nicole32, 50)
    fallout.gsay_option(54, 195, Nicole36, 50)
end

function Nicole32()
    fallout.gsay_reply(54, 201)
    fallout.gsay_option(54, 202, Nicole33, 50)
    fallout.gsay_option(54, 195, Nicole36, 50)
end

function Nicole33()
    fallout.gsay_reply(54, 204)
    fallout.gsay_option(54, 205, Nicole11, 50)
    fallout.gsay_option(54, 206, Nicole34, 50)
    fallout.gsay_option(54, 207, Nicole36, 50)
end

function Nicole34()
    fallout.gsay_reply(54, 208)
    fallout.gsay_option(54, 209, Nicole36, 50)
    fallout.gsay_option(54, 210, Nicole35, 50)
    if fallout.local_var(1) >= 2 then
        fallout.gsay_option(54, 211, Nicole09, 50)
    else
        fallout.gsay_option(54, 211, Nicole10, 51)
    end
    fallout.gsay_option(54, 212, Nicole14, 50)
end

function Nicole35()
    fallout.gsay_message(54, 213, 50)
    reaction.DownReactLevel()
end

function Nicole36()
    fallout.gsay_reply(54, 214)
    fallout.gsay_option(54, 215, Nicole37, 50)
    fallout.gsay_option(54, 216, Nicole41, 50)
end

function Nicole37()
    fallout.gsay_reply(54, 217)
    fallout.gsay_option(54, 218, Nicole39, 50)
    fallout.gsay_option(54, 219, Nicole41, 50)
end

function Nicole39()
    DisplayMessage = 220
    reaction.TopReact()
    NicoleMore()
end

function Nicole41()
    fallout.gsay_reply(54, 223)
    fallout.gsay_option(54, 224, Nicole00, 50)
    fallout.gsay_option(54, 225, NicoleEnd, 50)
end

function Nicole50()
    DisplayMessage = 132
    fallout.gsay_reply(54, 307)
    fallout.gsay_option(54, 320, Nicole51, 50)
    fallout.gsay_option(54, 321, Nicole00, 50)
end

function Nicole51()
    fallout.gsay_reply(54, DisplayMessage)
    fallout.gsay_option(54, 322, Nicole52, 50)
    fallout.gsay_option(54, 323, Nicole53, 50)
    fallout.gsay_option(54, 324, Nicole54, 50)
    fallout.gsay_option(54, 321, Nicole00, 50)
    fallout.gsay_option(54, 326, Nicole14, 50)
end

function Nicole52()
    DisplayMessage = 299
    Nicole51()
end

function Nicole53()
    DisplayMessage = 185
    Nicole51()
end

function Nicole54()
    fallout.gsay_reply(54, 251)
    fallout.gsay_option(54, 325, Nicole55, 50)
    fallout.set_global_var(63, 1)
end

function Nicole55()
    fallout.set_global_var(61, 1)
    fallout.gsay_message(54, 254, 50)
end

function Nicole78()
    fallout.gsay_message(54, 291, 50)
end

function NicoleMore()
    fallout.gsay_reply(54, DisplayMessage)
    if fallout.local_var(1) >= 2 then
        fallout.gsay_option(54, 155, Nicole09, 50)
    else
        fallout.gsay_option(54, 155, Nicole10, 51)
    end
    fallout.gsay_option(54, 131, Nicole14, 50)
end

function NicoleShowOut()
    fallout.gfade_out(600)
    fallout.move_to(fallout.dude_obj(), 23883, 0)
    fallout.set_local_var(5, 1)
end

function NicoleEnd()
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
