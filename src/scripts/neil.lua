local fallout = require("fallout")

local start
local critter_p_proc
local destroy_p_proc
local look_at_p_proc
local pickup_p_proc
local talk_p_proc
local Neil00
local Neil01
local Neil02
local Neil03
local Neil04
local Neil05
local Neil06
local Neil07
local Neil08
local Neil09
local Neil10
local Neil11
local Neil12
local Neil13
local Neil14
local Neil15
local Neil16
local Neil16a
local Neil17
local Neil18
local Neil19
local Neil20
local Neil21
local Neil22
local Neil23
local Neil24
local Neil25
local Neil26
local Neil27
local Neil28
local Neil29
local Neil30
local Neil31
local NeilQuest
local NeilCombat
local NeilEnd

local hostile = 0
local initialized = 0

function start()
    if not(initialized) then
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 46)
        initialized = 1
    else
        if fallout.script_action() == 12 then
            critter_p_proc()
        else
            if fallout.script_action() == 18 then
                destroy_p_proc()
            else
                if fallout.script_action() == 21 then
                    look_at_p_proc()
                else
                    if fallout.script_action() == 4 then
                        pickup_p_proc()
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

function critter_p_proc()
    if hostile then
        hostile = 0
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
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
    if fallout.local_var(4) then
        fallout.display_msg(fallout.message_str(271, 100))
    else
        fallout.display_msg(fallout.message_str(271, 101))
    end
end

function pickup_p_proc()
    hostile = 1
end

function talk_p_proc()
    fallout.set_local_var(4, 1)
    if (fallout.game_time_hour() >= 1900) or (fallout.game_time_hour() < 600) then
        Neil00()
    else
        if fallout.global_var(133) == 1 then
            Neil27()
        else
            if (fallout.global_var(133) == 2) and (fallout.local_var(5) == 0) then
                fallout.set_local_var(5, 1)
                fallout.start_gdialog(271, fallout.self_obj(), 4, -1, -1)
                fallout.gsay_start()
                Neil28()
                fallout.gsay_end()
                fallout.end_dialogue()
            else
                if (fallout.global_var(132) == 1) and (fallout.local_var(6) == 0) then
                    Neil31()
                else
                    fallout.start_gdialog(271, fallout.self_obj(), 4, -1, -1)
                    fallout.gsay_start()
                    Neil01()
                    fallout.gsay_end()
                    fallout.end_dialogue()
                end
            end
        end
    end
end

function Neil00()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(271, 102), 2)
end

function Neil01()
    fallout.gsay_reply(271, 103)
    fallout.giq_option(-3, 271, 104, Neil02, 50)
    fallout.giq_option(-3, 271, 105, Neil03, 50)
    fallout.giq_option(-3, 271, 106, NeilCombat, 50)
    fallout.giq_option(4, 271, fallout.message_str(271, 107) .. fallout.proto_data(fallout.obj_pid(fallout.dude_obj()), 1) .. fallout.message_str(271, 108), Neil07, 50)
    fallout.giq_option(4, 271, fallout.message_str(271, 109) .. fallout.proto_data(fallout.obj_pid(fallout.dude_obj()), 1) .. fallout.message_str(271, 110), NeilCombat, 50)
    fallout.giq_option(5, 271, 111, Neil16, 50)
    fallout.giq_option(6, 271, 112, Neil24, 50)
    fallout.giq_option(8, 271, 113, Neil26, 50)
end

function Neil02()
    fallout.gsay_reply(271, 114)
    fallout.giq_option(0, 271, 115, Neil03, 50)
    fallout.giq_option(0, 271, 116, NeilCombat, 50)
    fallout.giq_option(0, 271, 117, Neil04, 50)
end

function Neil03()
    fallout.gsay_message(271, 118, 50)
end

function Neil04()
    fallout.gsay_reply(271, 119)
    fallout.giq_option(0, 271, 120, Neil05, 50)
    fallout.giq_option(0, 271, 121, Neil06, 50)
end

function Neil05()
    fallout.gsay_message(271, 122, 50)
    fallout.set_global_var(133, 1)
end

function Neil06()
    fallout.gsay_message(271, 123, 50)
end

function Neil07()
    fallout.gsay_reply(271, 124)
    fallout.giq_option(4, 271, 125, Neil08, 50)
    fallout.giq_option(4, 271, 126, Neil14, 50)
    fallout.giq_option(4, 271, 127, Neil15, 50)
end

function Neil08()
    fallout.gsay_reply(271, 128)
    fallout.giq_option(4, 271, 129, Neil09, 50)
    fallout.giq_option(4, 271, 130, NeilEnd, 50)
    fallout.giq_option(4, 271, 131, NeilCombat, 50)
    fallout.giq_option(4, 271, 132, Neil13, 50)
end

function Neil09()
    fallout.gsay_reply(271, 133)
    fallout.giq_option(4, 271, 134, NeilQuest, 50)
    fallout.giq_option(4, 271, 135, Neil10, 50)
    fallout.giq_option(4, 271, 136, Neil13, 50)
end

function Neil10()
    fallout.gsay_reply(271, 137)
    fallout.giq_option(4, 271, 138, Neil11, 50)
    fallout.giq_option(4, 271, 139, NeilEnd, 50)
    fallout.giq_option(4, 271, 140, NeilCombat, 50)
end

function Neil11()
    fallout.gsay_reply(271, 141)
    fallout.giq_option(4, 271, 142, Neil12, 50)
    fallout.giq_option(4, 271, 143, Neil13, 50)
end

function Neil12()
    fallout.gsay_message(271, 144, 50)
    NeilQuest()
end

function Neil13()
    fallout.gsay_message(271, 145, 50)
    NeilCombat()
end

function Neil14()
    fallout.gsay_reply(271, 146)
    fallout.giq_option(4, 271, 147, Neil09, 50)
    fallout.giq_option(4, 271, 148, NeilEnd, 50)
    fallout.giq_option(4, 271, 149, NeilCombat, 50)
    fallout.giq_option(4, 271, 150, Neil13, 50)
end

function Neil15()
    fallout.gsay_reply(271, 151)
    fallout.giq_option(4, 271, 152, Neil09, 50)
    fallout.giq_option(4, 271, 153, NeilCombat, 50)
    fallout.giq_option(4, 271, 154, Neil13, 50)
end

function Neil16()
    fallout.gsay_reply(271, 155)
    fallout.giq_option(5, 271, 156, Neil17, 50)
    fallout.giq_option(5, 271, 157, Neil18, 50)
    fallout.giq_option(5, 271, 158, Neil16a, 50)
end

function Neil16a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        Neil19()
    else
        Neil23()
    end
end

function Neil17()
    local v0 = 0
    fallout.item_caps_adjust(fallout.dude_obj(), 200)
    fallout.gsay_message(271, fallout.message_str(271, 159) .. " " .. fallout.message_str(271, 160), 50)
    NeilCombat()
end

function Neil18()
    fallout.gsay_message(271, 161, 50)
end

function Neil19()
    fallout.gsay_reply(271, 162)
    fallout.giq_option(5, 271, 163, Neil20, 50)
    fallout.giq_option(5, 271, 164, Neil21, 50)
    fallout.giq_option(5, 271, 165, Neil22, 50)
    fallout.giq_option(5, 271, 166, NeilCombat, 50)
    fallout.giq_option(5, 271, 167, NeilEnd, 50)
end

function Neil20()
    fallout.gsay_reply(271, 168)
    fallout.giq_option(5, 271, 169, Neil21, 50)
    fallout.giq_option(5, 271, 170, Neil22, 50)
    fallout.giq_option(5, 271, 171, NeilCombat, 50)
    fallout.giq_option(5, 271, 172, NeilEnd, 50)
end

function Neil21()
    fallout.gsay_reply(271, 173)
    fallout.giq_option(5, 271, 174, Neil20, 50)
    fallout.giq_option(5, 271, 175, Neil22, 50)
    fallout.giq_option(5, 271, 176, NeilCombat, 50)
    fallout.giq_option(5, 271, 177, NeilEnd, 50)
end

function Neil22()
    fallout.gsay_reply(271, 178)
    fallout.giq_option(5, 271, 179, Neil20, 50)
    fallout.giq_option(5, 271, 180, Neil21, 50)
    fallout.giq_option(5, 271, 181, NeilCombat, 50)
    fallout.giq_option(5, 271, 182, NeilEnd, 50)
end

function Neil23()
    fallout.gsay_message(271, 183, 50)
    NeilCombat()
end

function Neil24()
    fallout.gsay_reply(271, 184)
    fallout.giq_option(6, 271, 185, Neil08, 50)
    fallout.giq_option(6, 271, 186, Neil14, 50)
    fallout.giq_option(6, 271, 187, Neil25, 50)
    fallout.giq_option(6, 271, 188, NeilEnd, 50)
end

function Neil25()
    fallout.gsay_message(271, 189, 50)
end

function Neil26()
    fallout.gsay_message(271, 190, 50)
end

function Neil27()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(271, 191), 8)
end

function Neil28()
    fallout.gsay_reply(271, 192)
    fallout.giq_option(4, 271, 193, Neil29, 50)
    fallout.giq_option(4, 271, 194, NeilEnd, 50)
end

function Neil29()
    fallout.gsay_reply(271, 195)
    fallout.giq_option(4, 271, 196, Neil30, 50)
    fallout.giq_option(4, 271, 197, NeilEnd, 50)
end

function Neil30()
    fallout.gsay_reply(271, 198)
    fallout.gfade_out(20)
    fallout.game_time_advance(fallout.game_ticks(24 * 3600))
    fallout.set_global_var(132, 1)
    fallout.gfade_in(20)
    fallout.giq_option(4, 271, 199, Neil31, 50)
end

function Neil31()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(271, 200), 8)
end

function NeilQuest()
    fallout.set_global_var(133, 1)
end

function NeilCombat()
    hostile = 1
end

function NeilEnd()
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
return exports
