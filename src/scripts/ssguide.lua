local fallout = require("fallout")
local reaction = require("lib.reaction")
local reputation = require("lib.reputation")

local start
local look_at_p_proc
local description_p_proc
local talk_p_proc
local critter_p_proc
local damage_p_proc
local destroy_p_proc
local pickup_p_proc
local DialogWeapon
local DialogFirstTime
local DialogSubsequent
local DialogExit
local DialogWeapon1
local DialogWeapon2
local DialogWeapon3
local DialogWeapon4
local DialogMain
local DialogMain1
local DialogMain2
local DialogMain3
local DialogMain4
local DialogMain5
local DialogMain6
local DialogMain7
local DialogMain8
local DialogMain9
local DialogMain10
local DialogSpecial1
local DialogSpecial2
local DialogSpecial3
local DialogSpecial4

local Initialize = 1
local Hostile = 0
local DisplayMessage = 0
local Hurt = 0
local Equipment = 0
local Barter = 0
local Bartered = 0
local Place = 0
local World = 0
local Yourself = 0
local Vault = 0
local Vaulted = 0

local exit_line = 0

function start()
    if Initialize == 1 then
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 2)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 6)
        Initialize = 0
    end
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(211, 100))
end

function description_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(211, 100))
end

function talk_p_proc()
    if fallout.global_var(246) == 1 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(669, fallout.random(100, 105)), 2)
    else
        reaction.get_reaction()
        fallout.start_gdialog(211, fallout.self_obj(), -1, -1, -1)
        fallout.gsay_start()
        if (fallout.obj_item_subtype(fallout.critter_inven_obj(fallout.dude_obj(), 1)) == 3) or (fallout.obj_item_subtype(fallout.critter_inven_obj(fallout.dude_obj(), 2)) == 3) then
            DialogWeapon()
        else
            if fallout.local_var(4) == 0 then
                fallout.set_local_var(4, 1)
                DialogFirstTime()
            else
                DialogSubsequent()
            end
        end
        fallout.gsay_end()
        fallout.end_dialogue()
        Hurt = 0
        Equipment = 0
        Barter = 0
        Bartered = 0
        Place = 0
        World = 0
        Yourself = 0
        Vault = 0
        Vaulted = 0
    end
end

function critter_p_proc()
    if fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) then
        if fallout.global_var(246) == 1 then
            fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
        end
    end
end

function damage_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.set_global_var(246, 1)
    end
end

function destroy_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.set_global_var(246, 1)
        reputation.inc_good_critter()
    end
end

function pickup_p_proc()
    if fallout.local_var(6) == 0 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(211, 151), 2)
        fallout.set_local_var(6, 1)
    else
        fallout.set_global_var(246, 1)
    end
end

function DialogWeapon()
    fallout.gsay_reply(211, 101)
    fallout.giq_option(-3, 211, 102, DialogWeapon1, 50)
    fallout.giq_option(4, 211, 103, DialogWeapon2, 50)
    fallout.giq_option(4, 211, 104, DialogWeapon3, 50)
    fallout.giq_option(4, 211, 105, DialogWeapon4, 50)
end

function DialogFirstTime()
    fallout.gsay_reply(211, 111)
    DisplayMessage = 125
    fallout.giq_option(-3, 211, 112, DialogSpecial1, 50)
    fallout.giq_option(4, 211, 113, DialogMain5, 50)
    fallout.giq_option(4, 211, 114, DialogMain, 50)
    fallout.giq_option(5, 211, 115, DialogMain8, 50)
    if fallout.global_var(43) == 1 then
        fallout.giq_option(4, 211, 116, DialogMain9, 50)
    end
    if fallout.global_var(26) == 1 then
        fallout.giq_option(4, 211, 117, DialogMain10, 50)
    end
    fallout.giq_option(4, 211, 118, DialogExit, 50)
end

function DialogSubsequent()
    local v0 = 0
    v0 = fallout.game_time_hour()
    fallout.gsay_reply(211, 144)
    DisplayMessage = 125
    fallout.giq_option(-3, 211, 112, DialogSpecial1, 50)
    if (v0 > 1800) or (v0 < 800) then
        fallout.giq_option(4, 211, 145, DialogSpecial4, 50)
    else
        fallout.giq_option(4, 211, 113, DialogMain5, 50)
    end
    fallout.giq_option(4, 211, 114, DialogMain, 50)
    fallout.giq_option(5, 211, 115, DialogMain8, 50)
    if fallout.global_var(43) == 1 then
        fallout.giq_option(4, 211, 116, DialogMain9, 50)
    end
    if fallout.global_var(26) == 1 then
        fallout.giq_option(4, 211, 117, DialogMain10, 50)
    end
    fallout.giq_option(4, 211, 118, DialogExit, 50)
end

function DialogExit()
end

function DialogWeapon1()
    fallout.display_msg(fallout.message_str(211, 106))
end

function DialogWeapon2()
    fallout.gsay_reply(211, 107)
    fallout.giq_option(4, 211, 108, DialogExit, 50)
end

function DialogWeapon3()
    fallout.gsay_reply(211, 109)
    fallout.giq_option(4, 211, 110, DialogExit, 50)
end

function DialogWeapon4()
    fallout.gsay_reply(211, 109)
    fallout.giq_option(4, 211, 110, DialogExit, 50)
end

function DialogMain()
    fallout.gsay_reply(211, DisplayMessage)
    if Hurt == 0 then
        fallout.giq_option(4, 211, 126, DialogMain1, 50)
    end
    if Equipment == 0 then
        fallout.giq_option(4, 211, 127, DialogMain2, 50)
    else
        if Barter == 1 then
            fallout.giq_option(4, 211, 134, DialogMain6, 50)
        end
    end
    if Place == 0 then
        fallout.giq_option(4, 211, 128, DialogMain3, 50)
    end
    if World == 0 then
        fallout.giq_option(4, 211, 129, DialogMain4, 50)
    end
    if Yourself == 0 then
        fallout.giq_option(4, 211, 130, DialogMain5, 50)
    else
        if Vault == 1 then
            fallout.giq_option(4, 211, 138, DialogMain7, 50)
        end
    end
    fallout.giq_option(4, 211, 131, DialogExit, 50)
    if (fallout.local_var(5) == 0) and ((Hurt == 1) and (Equipment == 1) and (Place == 1) and (World == 1) and (Yourself == 1) and (Bartered == 1) and (Vaulted == 1)) then
        fallout.set_local_var(5, 1)
        fallout.give_exp_points(250)
        fallout.display_msg(fallout.message_str(211, 150))
    end
end

function DialogMain1()
    Hurt = 1
    DisplayMessage = 132
    DialogMain()
end

function DialogMain2()
    Equipment = 1
    DisplayMessage = 133
    Barter = 1
    DialogMain()
end

function DialogMain3()
    Place = 1
    DisplayMessage = 135
    DialogMain()
end

function DialogMain4()
    World = 1
    DisplayMessage = 136
    DialogMain()
end

function DialogMain5()
    Yourself = 1
    DisplayMessage = 137
    Vault = 1
    DialogMain()
end

function DialogMain6()
    Barter = 0
    DisplayMessage = 139
    Bartered = 1
    DialogMain()
end

function DialogMain7()
    Vault = 0
    DisplayMessage = 140
    Vaulted = 1
    DialogMain()
end

function DialogMain8()
    DisplayMessage = 143
    DialogMain()
end

function DialogMain9()
    DisplayMessage = 141
    DialogMain()
end

function DialogMain10()
    DisplayMessage = 142
    DialogMain()
end

function DialogSpecial1()
    fallout.gsay_reply(211, 119)
    fallout.giq_option(-3, 211, 120, DialogSpecial2, 50)
end

function DialogSpecial2()
    fallout.gsay_reply(211, 121)
    fallout.giq_option(-3, 211, 122, DialogSpecial3, 50)
end

function DialogSpecial3()
    fallout.gsay_reply(211, 123)
    fallout.giq_option(-3, 211, 124, DialogExit, 50)
end

function DialogSpecial4()
    fallout.gsay_reply(211, 146)
    fallout.giq_option(4, 211, 147, DialogExit, 50)
end

local exports = {}
exports.start = start
exports.look_at_p_proc = look_at_p_proc
exports.description_p_proc = description_p_proc
exports.talk_p_proc = talk_p_proc
exports.critter_p_proc = critter_p_proc
exports.damage_p_proc = damage_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.pickup_p_proc = pickup_p_proc
return exports
