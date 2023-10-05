local fallout = require("fallout")

local start
local Do_Dialogue
local bob0
local bob1
local bob2
local bob3
local bob4
local bob5
local bob6
local bob7
local bob8
local bob9
local bob10
local bob11
local bob12
local bob13
local bob14
local bob15
local bob16
local bobend
local combat
local damage_p_proc
local destroy_p_proc

local Herebefore = 0
local Days = 0
local Met_Casino = 0
local Has_Weapon = 0

function start()
    if (fallout.script_action() == 21) or (fallout.script_action() == 3) then
        fallout.script_overrides()
        fallout.display_msg(fallout.message_str(341, 100))
    else
        if fallout.script_action() == 18 then
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
        else
            if fallout.script_action() == 11 then
                Do_Dialogue()
            else
                if fallout.script_action() == 15 then
                    if ((fallout.game_time() // (10 * 60 * 60 * 24)) - Days) >= 7 then
                        fallout.kill_critter(fallout.self_obj(), 0)
                    end
                end
            end
        end
    end
end

function Do_Dialogue()
    if (Has_Weapon == 0) and ((fallout.obj_item_subtype(fallout.critter_inven_obj(fallout.dude_obj(), 1)) == 3) or (fallout.obj_item_subtype(fallout.critter_inven_obj(fallout.dude_obj(), 2)) == 3)) then
        Has_Weapon = 1
        fallout.start_gdialog(341, fallout.self_obj(), 4, -1, -1)
        fallout.gsay_start()
        bob0()
        fallout.gsay_end()
        fallout.end_dialogue()
    else
        if Met_Casino then
            bob9()
        else
            if Herebefore then
                fallout.start_gdialog(341, fallout.self_obj(), 4, -1, -1)
                fallout.gsay_start()
                bob13()
                fallout.gsay_end()
                fallout.end_dialogue()
            else
                Herebefore = 1
                Days = fallout.game_time() // (10 * 60 * 60 * 24)
                fallout.start_gdialog(341, fallout.self_obj(), 4, -1, -1)
                fallout.gsay_start()
                bob10()
                fallout.gsay_end()
                fallout.end_dialogue()
            end
        end
    end
end

function bob0()
    fallout.gsay_reply(341, 101)
    fallout.giq_option(-3, 341, 102, bob1, 50)
    fallout.giq_option(4, 341, 103, bob2, 50)
    fallout.giq_option(4, 341, 104, bob3, 50)
    fallout.giq_option(5, 341, 105, bob3, 50)
end

function bob1()
    fallout.gsay_message(341, 106, 50)
end

function bob2()
    fallout.gsay_message(341, 107, 50)
end

function bob3()
    fallout.gsay_reply(341, 108)
    fallout.giq_option(4, 341, 109, bob4, 50)
    fallout.giq_option(6, 341, 110, bob5, 50)
end

function bob4()
    if fallout.obj_item_subtype(fallout.critter_inven_obj(fallout.dude_obj(), 1)) == 3 then
        fallout.gsay_message(341, fallout.message_str(341, 111) + fallout.obj_pid(fallout.critter_inven_obj(fallout.dude_obj(), 1)) + fallout.message_str(341, 112), 50)
    else
        fallout.gsay_message(341, fallout.message_str(341, 113) + fallout.obj_pid(fallout.critter_inven_obj(fallout.dude_obj(), 2)) + fallout.message_str(341, 114), 50)
    end
end

function bob5()
    fallout.gsay_reply(341, 115)
    fallout.giq_option(6, 341, 116, bob6, 50)
    fallout.giq_option(6, 341, 117, bob7, 50)
    fallout.giq_option(6, 341, 118, bob8, 50)
    fallout.giq_option(6, 341, 119, bobend, 50)
end

function bob6()
    fallout.gsay_reply(341, 120)
    fallout.giq_option(6, 341, 121, bob7, 50)
    fallout.giq_option(6, 341, 122, bob8, 50)
    fallout.giq_option(6, 341, 123, bobend, 50)
end

function bob7()
    fallout.gsay_reply(341, 124)
    fallout.giq_option(6, 341, 125, bob6, 50)
    fallout.giq_option(6, 341, 126, bob8, 50)
    fallout.giq_option(6, 341, 127, bobend, 50)
end

function bob8()
    fallout.gsay_reply(341, 128)
    fallout.giq_option(6, 341, 129, bob6, 50)
    fallout.giq_option(6, 341, 130, bob7, 50)
    fallout.giq_option(6, 341, 131, bobend, 50)
end

function bob9()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(341, 132), 0)
end

function bob10()
    fallout.gsay_reply(341, 133)
    fallout.giq_option(-3, 341, 134, bob1, 50)
    fallout.giq_option(4, 341, 135, bob2, 50)
    fallout.giq_option(4, 341, 136, bob11, 50)
    fallout.giq_option(5, 341, 137, bob5, 50)
end

function bob11()
    fallout.gsay_reply(341, 138)
    fallout.giq_option(4, 341, 139, bobend, 50)
    fallout.giq_option(6, 341, 140, bob12, 50)
end

function bob12()
    fallout.gsay_reply(341, 141)
    fallout.giq_option(6, 341, 142, bob6, 50)
    fallout.giq_option(6, 341, 143, bob7, 50)
    fallout.giq_option(6, 341, 144, bob8, 50)
    fallout.giq_option(6, 341, 145, bobend, 50)
end

function bob13()
    fallout.gsay_reply(341, 146)
    fallout.giq_option(-3, 341, 147, bob1, 50)
    fallout.giq_option(4, 341, 148, bob14, 50)
    fallout.giq_option(4, 341, 149, bob15, 50)
    fallout.giq_option(6, 341, 150, bob16, 50)
end

function bob14()
    fallout.gsay_message(341, 151, 50)
end

function bob15()
    fallout.gsay_message(341, 152, 50)
end

function bob16()
    fallout.gsay_reply(341, 153)
    fallout.giq_option(6, 341, 154, bob6, 50)
    fallout.giq_option(6, 341, 155, bob7, 50)
    fallout.giq_option(6, 341, 156, bob8, 50)
    fallout.giq_option(6, 341, 157, bobend, 50)
end

function bobend()
end

function combat()
end

function damage_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.set_global_var(247, 1)
    end
end

function destroy_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.set_global_var(247, 1)
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
end

local exports = {}
exports.start = start
exports.damage_p_proc = damage_p_proc
exports.destroy_p_proc = destroy_p_proc
return exports
