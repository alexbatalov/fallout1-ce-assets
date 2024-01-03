local fallout = require("fallout")
local reaction = require("lib.reaction")
local reputation = require("lib.reputation")

local start
local combat
local critter_p_proc
local pickup_p_proc
local talk_p_proc
local destroy_p_proc
local look_at_p_proc
local damage_p_proc
local Demetre00
local Demetre01
local Demetre02
local Demetre03
local Demetre04
local Demetre05
local Demetre06
local Demetre07
local Demetre08
local Demetre09
local Demetre10
local Demetre11
local Demetre12
local Demetre13
local Demetre14
local Demetre15
local Demetre16
local Demetre17
local Demetre17a
local Demetre17b
local Demetre18
local Demetre19
local Demetre20
local Demetre20a
local Demetre21
local Demetre22
local Demetre23
local Demetre24
local Demetre25
local Demetre26
local Demetre27
local Demetre28
local Demetre29
local Demetre30
local Demetre31
local Demetre31a
local Demetre31b
local Demetre31c
local Demetre32
local Demetre33
local Demetre33a
local Demetre34
local Demetre35
local Demetre35a
local Demetre36
local Demetre37
local Demetre38
local Demetre39
local Demetre40
local Demetre41
local Demetre42
local Demetre43
local DemetreEnd

local hostile = false
local initialized = false

function start()
    if not initialized then
        local self_obj = fallout.self_obj()
        fallout.critter_add_trait(self_obj, 1, 6, 36)
        fallout.critter_add_trait(self_obj, 1, 5, 1)
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

function combat()
    hostile = true
    fallout.set_map_var(24, 1)
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
    reaction.get_reaction()
    if fallout.map_var(24) == 1 then
        Demetre10()
    else
        if fallout.map_var(25) == 1 then
            if fallout.local_var(5) == 0 then
                fallout.start_gdialog(566, fallout.self_obj(), 4, -1, -1)
                fallout.gsay_start()
                Demetre20()
                fallout.gsay_end()
                fallout.end_dialogue()
            else
                Demetre20()
            end
        else
            if fallout.global_var(204) == 3 then
                Demetre30()
            else
                if fallout.local_var(4) == 0 then
                    fallout.start_gdialog(566, fallout.self_obj(), 4, -1, -1)
                    fallout.gsay_start()
                    Demetre00()
                    fallout.gsay_end()
                    fallout.end_dialogue()
                else
                    if fallout.map_var(26) == 0 then
                        fallout.start_gdialog(566, fallout.self_obj(), 4, -1, -1)
                        fallout.gsay_start()
                        Demetre27()
                        fallout.gsay_end()
                        fallout.end_dialogue()
                    else
                        if (fallout.map_var(26) == 1) and (fallout.global_var(204) ~= 4) then
                            fallout.start_gdialog(566, fallout.self_obj(), 4, -1, -1)
                            fallout.gsay_start()
                            Demetre40()
                            fallout.gsay_end()
                            fallout.end_dialogue()
                        else
                            if (fallout.map_var(26) == 1) and (fallout.global_var(204) == 4) then
                                fallout.start_gdialog(566, fallout.self_obj(), 4, -1, -1)
                                fallout.gsay_start()
                                Demetre28()
                                fallout.gsay_end()
                                fallout.end_dialogue()
                            end
                        end
                    end
                end
            end
        end
    end
    fallout.set_local_var(4, 1)
end

function destroy_p_proc()
    reputation.inc_good_critter()
    fallout.set_map_var(28, 1)
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(566, 100))
end

function damage_p_proc()
    local pid = fallout.obj_pid(fallout.source_obj())
    if fallout.party_member_obj(pid) ~= 0 then
        fallout.set_global_var(248, 1)
    end
end

function Demetre00()
    local strength = fallout.get_critter_stat(fallout.dude_obj(), 0)
    if strength < 4 then
        fallout.gsay_reply(566, fallout.message_str(566, 101) .. " " .. fallout.message_str(566, 102))
    elseif strength >= 4 and strength < 6 then
        fallout.gsay_reply(566, fallout.message_str(566, 101) .. " " .. fallout.message_str(566, 103))
    elseif strength >= 6 and strength < 8 then
        fallout.gsay_reply(566, fallout.message_str(566, 101) .. " " .. fallout.message_str(566, 104))
    elseif strength >= 8 and strength < 10 then
        fallout.gsay_reply(566, fallout.message_str(566, 101) .. " " .. fallout.message_str(566, 105))
    else
        fallout.gsay_reply(566, fallout.message_str(566, 101) .. " " .. fallout.message_str(566, 106))
    end
    fallout.giq_option(4, 566, 107, Demetre01, 49)
    fallout.giq_option(4, 566, 108, Demetre01, 50)
    fallout.giq_option(-3, 566, 109, Demetre01, 50)
end

function Demetre01()
    fallout.gsay_reply(566, 110)
    if reputation.has_rep_berserker() then
        fallout.giq_option(4, 566, 112, Demetre13, 50)
    else
        fallout.giq_option(4, 566, 111, Demetre02, 50)
    end
    fallout.giq_option(4, 566, 113, Demetre12, 50)
    if fallout.local_var(7) == 0 then
        fallout.giq_option(4, 566, 114, Demetre31a, 50)
    end
    if fallout.global_var(106) == 1 then
        fallout.giq_option(4, 566, 115, Demetre15, 50)
    end
    fallout.giq_option(4, 566, 116, DemetreEnd, 50)
    fallout.giq_option(-3, 566, 117, Demetre21, 50)
end

function Demetre02()
    fallout.gsay_reply(566, 118)
    fallout.giq_option(4, 566, 119, Demetre03, 50)
    fallout.giq_option(4, 566, 120, Demetre05, 50)
    fallout.giq_option(4, 566, 121, Demetre09, 50)
    fallout.giq_option(4, 566, 122, Demetre04, 50)
end

function Demetre03()
    fallout.set_map_var(26, 1)
    fallout.gsay_message(566, 123, 50)
end

function Demetre04()
    fallout.gsay_message(566, 124, 50)
end

function Demetre05()
    fallout.gsay_reply(566, 125)
    fallout.giq_option(4, 566, 126, Demetre08, 50)
    fallout.giq_option(4, 566, 127, Demetre07, 50)
    fallout.giq_option(4, 566, 128, Demetre06, 50)
    fallout.giq_option(4, 566, 129, Demetre07, 50)
end

function Demetre06()
    fallout.set_map_var(26, 1)
    fallout.gsay_message(566, 130, 50)
end

function Demetre07()
    fallout.set_map_var(26, 1)
    fallout.gsay_message(566, 131, 50)
end

function Demetre08()
    fallout.gsay_message(566, 132, 50)
end

function Demetre09()
    fallout.gsay_reply(566, 133)
    fallout.giq_option(4, 566, 134, DemetreEnd, 50)
    fallout.giq_option(4, 566, 135, Demetre11, 50)
end

function Demetre10()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(566, fallout.random(136, 138)), 2)
end

function Demetre11()
    fallout.set_map_var(26, 1)
    fallout.gsay_message(566, 139, 50)
end

function Demetre12()
    fallout.gsay_message(566, 140, 50)
end

function Demetre13()
    fallout.set_map_var(26, 1)
    fallout.gsay_message(566, 141, 50)
end

function Demetre14()
    fallout.gsay_reply(566, 142)
    fallout.giq_option(4, 566, 143, Demetre02, 50)
    fallout.giq_option(4, 566, 144, Demetre12, 50)
end

function Demetre15()
    fallout.gsay_reply(566, 145)
    fallout.giq_option(5, 566, 146, Demetre16, 50)
    if (fallout.map_var(4) == 1) and (fallout.global_var(106) == 1) then
        fallout.giq_option(4, 566, 147, Demetre17, 50)
    end
    fallout.giq_option(4, 566, 148, DemetreEnd, 50)
end

function Demetre16()
    fallout.gsay_reply(566, 149)
    fallout.giq_option(4, 566, 150, Demetre02, 50)
    if fallout.map_var(4) == 1 and fallout.global_var(106) == 1 then
        fallout.giq_option(4, 566, 151, Demetre17, 50)
    end
    fallout.giq_option(4, 566, 152, DemetreEnd, 50)
end

function Demetre17()
    fallout.gsay_reply(566, 153)
    fallout.giq_option(7, 566, 154, Demetre18, 50)
    fallout.giq_option(4, 566, 155, Demetre17a, 50)
    fallout.giq_option(4, 566, 156, Demetre17b, 51)
end

function Demetre17a()
    if fallout.global_var(100) == 2 then
        DemetreEnd()
    else
        Demetre19()
    end
end

function Demetre17b()
    reaction.BigDownReact()
    DemetreEnd()
end

function Demetre18()
    fallout.gsay_reply(566, 157)
    fallout.giq_option(4, 566, 158, Demetre17a, 50)
end

function Demetre19()
    fallout.gsay_message(566, 159, 50)
end

function Demetre20()
    if fallout.local_var(5) == 0 then
        fallout.set_local_var(5, 1)
        fallout.gsay_reply(566, 160)
        fallout.giq_option(4, 566, 161, DemetreEnd, 51)
        fallout.giq_option(4, 566, 162, Demetre25, 51)
        fallout.giq_option(4, 566, 163, Demetre20a, 51)
        fallout.giq_option(-3, 566, 164, Demetre22, 51)
    else
        if fallout.local_var(5) <= 5 then
            fallout.float_msg(fallout.self_obj(), fallout.message_str(566, 164 + fallout.local_var(5)), 2)
            fallout.set_local_var(5, fallout.local_var(5) + 1)
        else
            fallout.display_msg(fallout.message_str(566, 170))
        end
    end
end

function Demetre20a()
    if fallout.is_success(fallout.do_check(fallout.dude_obj(), 3, -5)) then
        Demetre24()
    else
        Demetre23()
    end
end

function Demetre21()
    fallout.gsay_reply(566, 171)
    fallout.giq_option(-3, 566, 172, DemetreEnd, 50)
    fallout.giq_option(-3, 566, 173, DemetreEnd, 50)
end

function Demetre22()
    fallout.gsay_message(566, 174, 51)
end

function Demetre23()
    fallout.gsay_message(566, 175, 51)
end

function Demetre24()
    fallout.gsay_message(566, 176, 50)
end

function Demetre25()
    fallout.gsay_message(566, 177, 51)
end

function Demetre26()
end

function Demetre27()
    fallout.gsay_reply(566, 184)
    if reputation.has_rep_berserker() then
        fallout.giq_option(4, 566, 186, Demetre13, 50)
    else
        fallout.giq_option(4, 566, 185, Demetre02, 50)
    end
    fallout.giq_option(4, 566, 187, Demetre12, 50)
    if fallout.local_var(7) == 0 then
        fallout.giq_option(4, 566, 188, Demetre31a, 50)
    end
    if fallout.global_var(106) == 1 then
        fallout.giq_option(4, 566, 189, Demetre15, 50)
    end
    fallout.giq_option(4, 566, 190, DemetreEnd, 50)
    fallout.giq_option(-3, 566, 191, Demetre21, 50)
end

function Demetre28()
    fallout.gsay_reply(566, 192)
    fallout.giq_option(4, 566, 193, Demetre33, 50)
    if fallout.local_var(7) == 0 then
        fallout.giq_option(4, 566, 194, Demetre31a, 50)
    end
    if fallout.global_var(106) == 1 then
        fallout.giq_option(4, 566, 195, Demetre15, 50)
    end
    fallout.giq_option(4, 566, 196, Demetre39, 50)
    fallout.giq_option(4, 566, 197, DemetreEnd, 50)
end

function Demetre29()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(566, 198), 2)
    fallout.set_map_var(25, 1)
end

function Demetre30()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(566, 199), 2)
    fallout.set_map_var(25, 1)
end

function Demetre31()
    if fallout.local_var(1) == 1 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(566, 201), 2)
    else
        fallout.gsay_reply(566, 200)
        if fallout.local_var(7) == 0 then
            fallout.giq_option(4, 566, 202, Demetre31a, 50)
        end
        if fallout.global_var(106) == 1 then
            fallout.giq_option(4, 566, 203, Demetre15, 50)
        end
        if fallout.local_var(8) == 0 then
            fallout.giq_option(4, 566, 204, Demetre31b, 51)
        else
            fallout.giq_option(4, 566, 205, Demetre31c, 51)
        end
        fallout.giq_option(4, 566, 206, DemetreEnd, 50)
        fallout.giq_option(-3, 566, 207, Demetre21, 50)
    end
end

function Demetre31a()
    fallout.set_local_var(7, 1)
    Demetre14()
end

function Demetre31b()
    fallout.set_local_var(8, 1)
    reaction.DownReact()
    Demetre32()
end

function Demetre31c()
    fallout.set_map_var(25, 1)
    DemetreEnd()
end

function Demetre32()
    fallout.gsay_message(566, 208, 51)
end

function Demetre33()
    if fallout.local_var(9) == 0 then
        fallout.set_local_var(9, 1)
        fallout.gsay_reply(566, 209)
        fallout.giq_option(4, 566, 211, Demetre34, 50)
        fallout.giq_option(4, 566, 212, Demetre33a, 51)
        fallout.giq_option(4, 566, 213, DemetreEnd, 50)
    else
        fallout.gsay_message(566, 210, 50)
    end
end

function Demetre33a()
    fallout.set_map_var(25, 1)
    fallout.set_map_var(24, 1)
    Demetre35()
end

function Demetre34()
    fallout.gsay_reply(566, 214)
    fallout.giq_option(4, 566, 215, Demetre37, 51)
    fallout.giq_option(4, 566, 216, DemetreEnd, 50)
end

function Demetre35()
    fallout.gsay_reply(566, 217)
    fallout.giq_option(4, 566, 218, Demetre36, 51)
    fallout.giq_option(4, 566, 219, Demetre35a, 51)
end

function Demetre35a()
    fallout.set_map_var(24, 1)
    combat()
end

function Demetre36()
    fallout.set_map_var(25, 1)
    fallout.gsay_message(566, 220, 51)
end

function Demetre37()
    fallout.gsay_reply(566, 221)
    fallout.giq_option(4, 566, 222, combat, 51)
    fallout.giq_option(4, 566, 223, Demetre38, 50)
    fallout.giq_option(4, 566, 224, DemetreEnd, 50)
end

function Demetre38()
    fallout.gsay_reply(566, 225)
    fallout.giq_option(4, 566, 226, DemetreEnd, 50)
    fallout.giq_option(4, 566, 227, combat, 51)
end

function Demetre39()
    fallout.gsay_message(566, 228, 50)
end

function Demetre40()
    fallout.gsay_reply(566, 229)
    fallout.giq_option(4, 566, 230, Demetre41, 50)
    fallout.giq_option(4, 566, 231, Demetre43, 50)
    if fallout.local_var(7) == 0 then
        fallout.giq_option(4, 566, 232, Demetre31a, 50)
    end
    if fallout.global_var(106) == 1 then
        fallout.giq_option(4, 566, 233, Demetre15, 50)
    end
    fallout.giq_option(4, 566, 234, DemetreEnd, 50)
    fallout.giq_option(-3, 566, 235, Demetre21, 50)
    fallout.giq_option(-3, 566, 236, Demetre42, 50)
end

function Demetre41()
    if fallout.local_var(10) == 0 then
        local item_obj = fallout.create_object_sid(25, 0, 0, -1)
        fallout.add_obj_to_inven(fallout.dude_obj(), item_obj)
        fallout.set_local_var(10, 1)
        fallout.gsay_message(566, 237, 50)
    else
        fallout.gsay_message(566, 238, 50)
    end
end

function Demetre42()
    fallout.gsay_message(566, 239, 50)
end

function Demetre43()
    fallout.gsay_message(566, 240, 50)
end

function DemetreEnd()
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
