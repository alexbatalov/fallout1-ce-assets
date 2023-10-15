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
local DialogExit
local DialogMain
local Dumb
local DialogMainExit
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
local DialogMain11
local DialogMain12
local DialogMain13

local initialized = false
local Hostile = 0
local DisplayMessage = 100

local exit_line = 0

function start()
    local v0 = 0
    if not initialized then
        if fallout.obj_is_carrying_obj_pid(fallout.self_obj(), 41) == 0 then
            fallout.item_caps_adjust(fallout.self_obj(), fallout.random(10, 100))
        end
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 89)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 29)
        if fallout.local_var(7) == 0 then
            fallout.set_map_var(1, fallout.map_var(1) + 1)
            fallout.set_local_var(7, 1)
            fallout.set_global_var(351, 1)
        end
        initialized = true
    end
end

function look_at_p_proc()
    fallout.script_overrides()
    if fallout.local_var(4) == 1 then
        fallout.display_msg(fallout.message_str(255, 100))
    else
        fallout.display_msg(fallout.message_str(255, 101))
    end
end

function description_p_proc()
    fallout.script_overrides()
    if fallout.local_var(4) == 1 then
        fallout.display_msg(fallout.message_str(255, 100))
    else
        fallout.display_msg(fallout.message_str(255, 101))
    end
end

function talk_p_proc()
    if (fallout.global_var(251) == 1) or (fallout.global_var(616) == 1) then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(669, fallout.random(100, 105)), 2)
    else
        if (fallout.local_var(4) == 1) and (fallout.get_critter_stat(fallout.dude_obj(), 4) < 4) then
            fallout.float_msg(fallout.self_obj(), fallout.message_str(255, 127), 0)
        else
            if fallout.global_var(128) == 2 then
                fallout.float_msg(fallout.self_obj(), fallout.message_str(255, 147), 0)
            else
                reaction.get_reaction()
                fallout.start_gdialog(255, fallout.self_obj(), -1, -1, -1)
                fallout.gsay_start()
                if (fallout.obj_item_subtype(fallout.critter_inven_obj(fallout.dude_obj(), 1)) == 3) or (fallout.obj_item_subtype(fallout.critter_inven_obj(fallout.dude_obj(), 2)) == 3) then
                    DialogWeapon()
                else
                    if fallout.local_var(4) == 0 then
                        if fallout.local_var(1) < 2 then
                            DisplayMessage = 102
                        else
                            DisplayMessage = 103
                        end
                        DialogMain()
                    else
                        if fallout.global_var(128) == 0 then
                            if fallout.local_var(1) < 2 then
                                DisplayMessage = 122
                            end
                            if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
                                DisplayMessage = 123
                            else
                                DisplayMessage = 124
                            end
                            DialogMain()
                        else
                            DisplayMessage = 141
                            DialogMain11()
                        end
                    end
                end
                fallout.gsay_end()
                fallout.end_dialogue()
            end
        end
    end
end

function critter_p_proc()
    if fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) then
        if (fallout.global_var(251) == 1) or (fallout.global_var(616) == 1) then
            fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
        end
    end
end

function damage_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.set_global_var(616, 1)
    end
end

function destroy_p_proc()
    fallout.set_map_var(1, fallout.map_var(1) - 1)
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.set_global_var(616, 1)
        reputation.inc_evil_critter()
    end
    if fallout.map_var(1) == 0 then
        fallout.terminate_combat()
    end
end

function pickup_p_proc()
    fallout.set_global_var(616, 1)
end

function DialogWeapon()
    fallout.gsay_message(255, 125, 50)
end

function DialogExit()
end

function DialogMain()
    fallout.gsay_reply(255, DisplayMessage)
    fallout.giq_option(4, 255, 105, DialogMain1, 50)
    fallout.giq_option(4, 255, 106, DialogMain2, 50)
    fallout.giq_option(4, 255, 107, DialogMain5, 50)
    if fallout.local_var(5) == 1 then
        fallout.giq_option(4, 255, 108, DialogMain6, 50)
    end
    if fallout.local_var(6) == 1 then
        fallout.giq_option(4, 255, 109, DialogMain7, 50)
    end
    if fallout.global_var(128) == 0 then
        fallout.giq_option(4, 255, 110, DialogMain8, 50)
    end
    fallout.giq_option(4, 255, 111, DialogMainExit, 50)
    fallout.giq_option(-3, 255, 126, Dumb, 50)
end

function Dumb()
    fallout.set_local_var(4, 1)
    fallout.gsay_message(255, 127, 50)
end

function DialogMainExit()
    if fallout.local_var(1) < 2 then
        fallout.gsay_message(255, 120, 50)
    else
        fallout.gsay_message(255, 121, 50)
    end
end

function DialogMain1()
    fallout.set_local_var(4, 1)
    if fallout.local_var(1) < 2 then
        DisplayMessage = 116
    else
        fallout.set_local_var(5, 1)
        DisplayMessage = 117
    end
    DialogMain()
end

function DialogMain2()
    fallout.gsay_reply(255, 112)
    fallout.giq_option(4, 255, 113, DialogMain3, 50)
    fallout.giq_option(4, 255, 114, DialogMain4, 50)
    fallout.giq_option(4, 255, 115, DialogMainExit, 50)
end

function DialogMain3()
    DisplayMessage = 128
    DialogMain()
end

function DialogMain4()
    DisplayMessage = 129
    DialogMain()
end

function DialogMain5()
    fallout.gsay_message(255, 118, 50)
    fallout.set_local_var(6, 1)
    DisplayMessage = 119
    DialogMain()
end

function DialogMain6()
    fallout.gsay_message(255, 130, 50)
    DisplayMessage = 131
    DialogMain()
end

function DialogMain7()
    DisplayMessage = 132
    DialogMain()
end

function DialogMain8()
    fallout.gsay_reply(255, 133)
    fallout.giq_option(4, 255, 134, DialogMain10, 50)
    fallout.giq_option(4, 255, 135, DialogMain9, 50)
    fallout.giq_option(4, 255, 136, DialogExit, 50)
end

function DialogMain9()
    DisplayMessage = 137
    DialogMain()
end

function DialogMain10()
    fallout.gsay_reply(255, 138)
    fallout.giq_option(4, 255, 139, DialogMain9, 50)
    fallout.giq_option(4, 255, 140, DialogExit, 50)
end

function DialogMain11()
    fallout.gsay_reply(255, DisplayMessage)
    fallout.giq_option(4, 255, 140, DialogMain12, 50)
    fallout.giq_option(4, 255, 141, DialogMain13, 50)
    fallout.giq_option(4, 255, 142, DialogExit, 50)
end

function DialogMain12()
    DisplayMessage = 145
    DialogMain11()
end

function DialogMain13()
    DisplayMessage = 146
    DialogMain11()
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
