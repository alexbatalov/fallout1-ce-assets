local fallout = require("fallout")
local reputation = require("lib.reputation")

local start
local lasher00
local lasher01
local lasher02
local lasher03
local lasher04
local lasher05
local lasher06
local lasher06a
local lasher07
local lasher07a
local lasher08
local lasher08a
local lasher09
local lasher10
local lasher10a
local lasher11
local lasher12
local lasher13
local lasher14
local lasher14a
local lasher15
local lasher16
local lasher17
local lasher17a
local lasher18
local lasher19
local lasher20_1
local lasher20_2
local lasher21
local lasher22
local lasher23
local lasher24
local lasher25
local lasher26
local lasher26a
local lasher27
local lasher28
local lasher29
local lasher30
local lasher31
local lasher32
local lasher33
local lasher34
local lasher35
local lasher36
local lasher37
local lasher38
local lasher39
local lasher40_1
local lasher40_2
local lasher41_1
local lasher41_2
local lasher42
local lasher43
local lasher44
local lasherend
local combat

local Hostile = 0
local Lasher_Abuse = 0
local initialized = false

function start()
    if not initialized then
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 20)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 83)
        initialized = true
    end
    if (fallout.script_action() == 21) or (fallout.script_action() == 3) then
        fallout.script_overrides()
        fallout.display_msg(fallout.message_str(384, 100))
    else
        if fallout.script_action() == 4 then
            Hostile = 1
        else
            if fallout.script_action() == 18 then
                reputation.inc_evil_critter()
            else
                if fallout.script_action() == 12 then
                    if (fallout.local_var(1) == 0) and fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) then
                        fallout.set_local_var(1, 1)
                        fallout.dialogue_system_enter()
                    else
                        if fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) and ((fallout.obj_item_subtype(fallout.critter_inven_obj(fallout.dude_obj(), 1)) == 3) or (fallout.obj_item_subtype(fallout.critter_inven_obj(fallout.dude_obj(), 2)) == 3)) then
                            Hostile = 1
                        end
                    end
                    if Hostile then
                        Hostile = 0
                        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
                    end
                else
                    if fallout.script_action() == 11 then
                        fallout.script_overrides()
                        if fallout.obj_pid(fallout.critter_inven_obj(fallout.dude_obj(), 0)) == 113 then
                            if (fallout.obj_item_subtype(fallout.critter_inven_obj(fallout.dude_obj(), 1)) == 3) or (fallout.obj_item_subtype(fallout.critter_inven_obj(fallout.dude_obj(), 2)) == 3) then
                                fallout.start_gdialog(384, fallout.self_obj(), 4, -1, -1)
                                fallout.gsay_start()
                                lasher04()
                                fallout.gsay_end()
                                fallout.end_dialogue()
                            else
                                fallout.start_gdialog(384, fallout.self_obj(), 4, -1, -1)
                                fallout.gsay_start()
                                lasher05()
                                fallout.gsay_end()
                                fallout.end_dialogue()
                            end
                        else
                            if (fallout.obj_item_subtype(fallout.critter_inven_obj(fallout.dude_obj(), 1)) == 3) or (fallout.obj_item_subtype(fallout.critter_inven_obj(fallout.dude_obj(), 2)) == 3) then
                                fallout.start_gdialog(384, fallout.self_obj(), 4, -1, -1)
                                fallout.gsay_start()
                                lasher06()
                                fallout.gsay_end()
                                fallout.end_dialogue()
                            else
                                if fallout.global_var(195) == 1 then
                                    fallout.start_gdialog(384, fallout.self_obj(), 4, -1, -1)
                                    fallout.gsay_start()
                                    lasher00()
                                    fallout.gsay_end()
                                    fallout.end_dialogue()
                                else
                                    if fallout.global_var(158) > 2 then
                                        fallout.start_gdialog(384, fallout.self_obj(), 4, -1, -1)
                                        fallout.gsay_start()
                                        lasher01()
                                        fallout.gsay_end()
                                        fallout.end_dialogue()
                                    else
                                        if reputation.has_rep_berserker() then
                                            fallout.start_gdialog(384, fallout.self_obj(), 4, -1, -1)
                                            fallout.gsay_start()
                                            lasher02()
                                            fallout.gsay_end()
                                            fallout.end_dialogue()
                                        else
                                            if fallout.local_var(0) == 1 then
                                                fallout.start_gdialog(384, fallout.self_obj(), 4, -1, -1)
                                                fallout.gsay_start()
                                                lasher03()
                                                fallout.gsay_end()
                                                fallout.end_dialogue()
                                            else
                                                fallout.start_gdialog(384, fallout.self_obj(), 4, -1, -1)
                                                fallout.gsay_start()
                                                lasher07()
                                                fallout.gsay_end()
                                                fallout.end_dialogue()
                                            end
                                        end
                                    end
                                end
                            end
                        end
                        fallout.set_local_var(0, 1)
                    end
                end
            end
        end
    end
end

function lasher00()
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        fallout.gsay_reply(384, 101)
    else
        fallout.gsay_reply(384, 102)
    end
    fallout.gsay_option(384, 223, lasherend, 50)
end

function lasher01()
    fallout.gsay_message(384, 103, 50)
    combat()
end

function lasher02()
    fallout.gsay_message(384, 104, 50)
    combat()
end

function lasher03()
    fallout.gsay_reply(384, 105)
    fallout.gsay_option(384, 223, lasherend, 50)
end

function lasher04()
    fallout.gsay_reply(384, 106)
    fallout.giq_option(7, 384, 107, lasher08, 50)
    fallout.giq_option(4, 384, 108, lasher09, 50)
    fallout.giq_option(4, 384, 109, lasher10, 50)
    fallout.giq_option(4, 384, 110, lasher11, 50)
    if Lasher_Abuse then
        fallout.giq_option(4, 384, 111, lasher12, 50)
    end
    if reputation.has_rep_berserker() then
        fallout.giq_option(4, 384, 112, lasher02, 50)
    end
    fallout.giq_option(-3, 384, 113, lasher13, 50)
end

function lasher05()
    fallout.gsay_reply(384, 114)
    fallout.giq_option(7, 384, 115, lasher14, 50)
    fallout.giq_option(7, 384, 116, lasher15, 50)
    if Lasher_Abuse then
        fallout.giq_option(4, 384, 117, lasher12, 50)
    end
    fallout.giq_option(4, 384, 118, lasher16, 50)
    fallout.giq_option(4, 384, 119, lasher11, 50)
    fallout.giq_option(4, 384, 109, lasher10, 50)
    if reputation.has_rep_berserker() then
        fallout.giq_option(4, 384, 120, lasher02, 50)
    end
    fallout.giq_option(-3, 384, 121, lasher13, 50)
end

function lasher06()
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        fallout.gsay_reply(384, 122)
    else
        fallout.gsay_reply(384, 123)
    end
    fallout.giq_option(7, 384, 124, lasher06a, 50)
    fallout.giq_option(7, 384, 125, lasher15, 50)
    if Lasher_Abuse then
        fallout.giq_option(4, 384, 126, lasher12, 50)
    end
    fallout.giq_option(4, 384, 127, lasher16, 50)
    fallout.giq_option(4, 384, 128, lasher11, 50)
    fallout.giq_option(4, 384, 109, lasher10, 50)
    if reputation.has_rep_berserker() then
        fallout.giq_option(4, 384, 129, lasher02, 50)
    end
    fallout.giq_option(-3, 384, 130, lasher13, 50)
end

function lasher06a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        lasher17()
    else
        lasher18()
    end
end

function lasher07()
    fallout.gsay_reply(384, 131)
    fallout.giq_option(7, 384, 132, lasher07a, 50)
    if Lasher_Abuse then
        fallout.giq_option(4, 384, 133, lasher12, 50)
    end
    fallout.giq_option(4, 384, 134, lasher19, 50)
    fallout.giq_option(4, 384, 109, lasher10, 50)
    fallout.giq_option(4, 384, 135, lasher11, 50)
    if reputation.has_rep_berserker() then
        fallout.giq_option(4, 384, 136, lasher02, 50)
    end
    fallout.giq_option(-3, 384, 137, lasher13, 50)
end

function lasher07a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        lasher17()
    else
        lasher18()
    end
end

function lasher08()
    fallout.gsay_reply(384, 138)
    fallout.giq_option(7, 384, 139, lasher08a, 50)
    if Lasher_Abuse then
        fallout.giq_option(4, 384, 140, lasher12, 50)
    end
    fallout.giq_option(4, 384, 141, lasher19, 50)
    fallout.giq_option(4, 384, 142, lasher22, 50)
    if reputation.has_rep_berserker() then
        fallout.giq_option(4, 384, 143, lasher13, 50)
    end
end

function lasher08a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        lasher20_1()
    else
        lasher18()
    end
end

function lasher09()
    fallout.gsay_reply(384, 144)
    fallout.gsay_option(384, 223, lasherend, 50)
end

function lasher10()
    fallout.gsay_reply(384, 145)
    fallout.giq_option(7, 384, 146, lasher10a, 50)
    if Lasher_Abuse then
        fallout.giq_option(4, 384, 147, lasher26, 50)
    end
    fallout.giq_option(4, 384, 148, lasher27, 50)
    fallout.giq_option(4, 384, 149, lasher28, 50)
    if reputation.has_rep_berserker() then
        fallout.giq_option(4, 384, 150, lasher29, 50)
    end
end

function lasher10a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        lasher24()
    else
        lasher25()
    end
end

function lasher11()
    fallout.gsay_reply(384, 151)
    fallout.giq_option(4, 384, 152, lasher09, 50)
    fallout.giq_option(4, 384, 153, lasher30, 50)
    if reputation.has_rep_berserker() then
        fallout.giq_option(4, 384, 154, lasher02, 50)
    end
end

function lasher12()
    fallout.gsay_reply(384, 155)
    fallout.giq_option(7, 384, 156, lasher31, 50)
    fallout.giq_option(4, 384, 157, lasher30, 50)
    fallout.giq_option(4, 384, 158, lasher02, 50)
    fallout.giq_option(4, 384, 159, lasher32, 50)
    if reputation.has_rep_berserker() then
        fallout.giq_option(4, 384, 160, lasher33, 50)
    end
end

function lasher13()
    fallout.gsay_message(384, 161, 50)
end

function lasher14()
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        fallout.gsay_reply(384, 163)
    else
        fallout.gsay_reply(384, 162)
    end
    fallout.giq_option(7, 384, 164, lasher31, 50)
    fallout.giq_option(4, 384, 165, lasher30, 50)
    fallout.giq_option(4, 384, 166, lasher02, 50)
    if reputation.has_rep_berserker() then
        fallout.giq_option(4, 384, 167, lasher33, 50)
    end
end

function lasher14a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        lasher34()
    else
        lasher18()
    end
end

function lasher15()
    fallout.gsay_reply(384, 168)
    fallout.giq_option(7, 384, 169, lasher18, 50)
    fallout.giq_option(4, 384, 170, lasher35, 50)
    fallout.giq_option(4, 384, 171, lasher36, 50)
    fallout.giq_option(4, 384, 172, lasher09, 50)
    if reputation.has_rep_berserker() then
        fallout.giq_option(4, 384, 173, lasher37, 50)
    end
end

function lasher16()
    fallout.gsay_message(384, 174, 50)
end

function lasher17()
    fallout.gsay_reply(384, 175)
    if fallout.global_var(196) == 1 then
        fallout.giq_option(7, 384, 176, lasher17a, 50)
    end
    fallout.giq_option(4, 384, 177, lasher40_1, 50)
    fallout.giq_option(4, 384, 178, lasher41_1, 50)
    fallout.giq_option(4, 384, 179, lasher12, 50)
    if reputation.has_rep_berserker() then
        fallout.giq_option(4, 384, 180, lasher35, 50)
    end
end

function lasher17a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        lasher38()
    else
        lasher39()
    end
end

function lasher18()
    fallout.gsay_message(384, 181, 50)
end

function lasher19()
    fallout.gsay_message(384, 182, 50)
end

function lasher20_1()
    fallout.gsay_message(384, fallout.message_str(384, 183) .. fallout.message_str(384, 183), 50)
end

function lasher20_2()
end

function lasher21()
    fallout.gsay_message(384, 186, 50)
end

function lasher22()
    fallout.gsay_message(384, 187, 50)
end

function lasher23()
    fallout.gsay_message(384, 188, 50)
end

function lasher24()
    local v0 = 0
    v0 = fallout.create_object_sid(142, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), v0)
    fallout.gsay_message(384, 189, 50)
end

function lasher25()
    fallout.gsay_message(384, 190, 50)
end

function lasher26()
    fallout.gsay_reply(384, 191)
    fallout.giq_option(7, 384, 192, lasher26a, 50)
    fallout.giq_option(4, 384, 193, lasher25, 50)
    fallout.giq_option(4, 384, 194, lasher27, 50)
    fallout.giq_option(4, 384, 195, lasher28, 50)
    if reputation.has_rep_berserker() then
        fallout.giq_option(4, 384, 196, lasher23, 50)
    end
end

function lasher26a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        lasher24()
    else
        lasher25()
    end
end

function lasher27()
    fallout.gsay_message(384, 197, 50)
end

function lasher28()
    local v0 = 0
    v0 = fallout.create_object_sid(142, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), v0)
    fallout.gsay_message(384, 198, 50)
end

function lasher29()
    fallout.gsay_message(384, 199, 50)
end

function lasher30()
    fallout.gsay_message(384, 200, 50)
end

function lasher31()
    fallout.gsay_message(384, 201, 50)
end

function lasher32()
    fallout.gsay_reply(384, 202)
    fallout.giq_option(7, 384, 203, lasher21, 50)
    fallout.giq_option(4, 384, 204, lasher42, 50)
    fallout.giq_option(4, 384, 205, lasher43, 50)
    fallout.giq_option(4, 384, 206, lasher44, 50)
    fallout.giq_option(4, 384, 207, lasher28, 50)
    if reputation.has_rep_berserker() then
        fallout.giq_option(4, 384, 208, lasher35, 50)
    end
end

function lasher33()
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 1 then
        fallout.gsay_message(384, 209, 50)
    else
        fallout.gsay_message(384, 210, 50)
    end
end

function lasher34()
    fallout.gsay_message(384, 211, 50)
end

function lasher35()
    fallout.gsay_message(384, 212, 50)
end

function lasher36()
    fallout.gsay_message(384, 213, 50)
end

function lasher37()
    fallout.gsay_message(384, 214, 50)
end

function lasher38()
    fallout.gsay_message(384, 224, 50)
end

function lasher39()
    fallout.gsay_message(384, 215, 50)
end

function lasher40_1()
    fallout.gsay_message(384, fallout.message_str(384, 216) .. fallout.message_str(384, 217), 50)
end

function lasher40_2()
end

function lasher41_1()
    fallout.gsay_message(384, fallout.message_str(384, 218) .. fallout.message_str(384, 219), 50)
end

function lasher41_2()
end

function lasher42()
    fallout.gsay_message(384, 220, 50)
end

function lasher43()
    fallout.gsay_message(384, 221, 50)
end

function lasher44()
    fallout.gsay_message(384, 222, 50)
end

function lasherend()
end

function combat()
    Hostile = 1
end

local exports = {}
exports.start = start
return exports
