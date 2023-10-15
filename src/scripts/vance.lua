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
local Vance01
local Vance02
local Vance02a
local Vance03
local Vance04
local Vance05
local Vance06
local Vance07
local Vance08
local Vance09
local Vance10
local Vance11
local Vance11a
local Vance12
local Vance13
local Vance14
local Vance15
local VanceEnd
local Barter
local Get_Stuff
local Put_Stuff

local hostile = 0
local initialized = false
local kickOut = 0
local initiateDialogue = 1

local exit_line = 0

function start()
    local v0 = 0
    fallout.gdialog_set_barter_mod(-20)
    if not initialized then
        initialized = true
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 81)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 4)
    end
    if fallout.script_action() == 21 then
        look_at_p_proc()
    else
        if fallout.script_action() == 4 then
            pickup_p_proc()
        else
            if fallout.script_action() == 11 then
                talk_p_proc()
            else
                if fallout.script_action() == 12 then
                    critter_p_proc()
                else
                    if fallout.script_action() == 18 then
                        destroy_p_proc()
                    end
                end
            end
        end
    end
end

function combat()
    hostile = 1
end

function critter_p_proc()
    if hostile then
        hostile = 0
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    end
    if (initiateDialogue == 1) and (fallout.tile_distance_objs(fallout.self_obj(), fallout.dude_obj()) <= 4) then
        initiateDialogue = 0
        fallout.dialogue_system_enter()
    end
    if kickOut == 1 then
        kickOut = 0
        initiateDialogue = 1
        fallout.gfade_out(500)
        fallout.move_to(fallout.dude_obj(), 16265, 0)
        fallout.gfade_in(500)
    end
end

function pickup_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        hostile = 1
    end
end

function talk_p_proc()
    Get_Stuff()
    reaction.get_reaction()
    if fallout.global_var(248) == 1 then
        fallout.start_gdialog(822, fallout.self_obj(), 4, -1, -1)
        fallout.gsay_start()
        Vance12()
        fallout.gsay_end()
        fallout.end_dialogue()
    else
        if fallout.local_var(1) == 1 then
            fallout.start_gdialog(822, fallout.self_obj(), 4, -1, -1)
            fallout.gsay_start()
            Vance11()
            fallout.gsay_end()
            fallout.end_dialogue()
        else
            if (fallout.local_var(4) == 0) or (fallout.global_var(236) == 0) then
                fallout.set_local_var(4, 1)
                fallout.start_gdialog(822, fallout.self_obj(), 4, -1, -1)
                fallout.gsay_start()
                Vance01()
                fallout.gsay_end()
                fallout.end_dialogue()
            else
                fallout.start_gdialog(822, fallout.self_obj(), 4, -1, -1)
                fallout.gsay_start()
                Vance06()
                fallout.gsay_end()
                fallout.end_dialogue()
            end
        end
    end
    Put_Stuff()
end

function destroy_p_proc()
    reputation.inc_good_critter()
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(822, 100))
end

function Vance01()
    fallout.gsay_reply(822, 101)
    fallout.giq_option(-3, 822, 102, Vance05, 50)
    if fallout.global_var(236) == 1 then
        fallout.giq_option(4, 822, 105, Vance05, 50)
    end
    fallout.giq_option(4, 822, 103, Vance02, 50)
    fallout.giq_option(4, 822, 104, Vance03, 50)
    fallout.giq_option(4, 822, 106, Vance04, 50)
end

function Vance02()
    fallout.gsay_reply(822, 107)
    fallout.giq_option(4, 822, 108, Vance03, 50)
    fallout.giq_option(4, 822, 109, Vance02a, 50)
    fallout.giq_option(4, 822, 111, Vance04, 50)
end

function Vance02a()
    if (fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, -30)) == 1) or fallout.is_success(fallout.do_check(fallout.dude_obj(), 3, -3)) then
        Vance05()
    else
        Vance03()
    end
end

function Vance03()
    fallout.gsay_reply(822, 112)
    fallout.giq_option(4, 822, 113, Vance13, 51)
    fallout.giq_option(4, 822, 114, Vance14, 50)
end

function Vance04()
    fallout.gsay_reply(822, 115)
    fallout.giq_option(4, 822, 116, Vance13, 51)
    fallout.giq_option(4, 822, 117, Vance14, 50)
end

function Vance05()
    Barter()
end

function Vance06()
    fallout.gsay_reply(822, 120)
    fallout.giq_option(-3, 822, 121, Barter, 50)
    fallout.giq_option(4, 822, 122, Barter, 50)
    fallout.giq_option(4, 822, 123, Vance07, 50)
    fallout.giq_option(4, 822, 124, Vance08, 50)
    fallout.giq_option(4, 822, 125, Vance09, 50)
    fallout.giq_option(4, 822, 126, Vance15, 50)
end

function Vance07()
    fallout.gsay_reply(822, 127)
    fallout.giq_option(4, 822, 128, Vance13, 51)
    fallout.giq_option(4, 822, 129, Vance14, 50)
end

function Vance08()
    fallout.gsay_reply(822, 130)
    fallout.giq_option(4, 822, 131, Vance13, 51)
    fallout.giq_option(4, 822, 132, Vance10, 50)
    fallout.giq_option(4, 822, 133, Vance15, 50)
end

function Vance09()
    fallout.gsay_reply(822, 134)
    fallout.giq_option(4, 822, 135, Barter, 50)
    fallout.giq_option(4, 822, 136, Vance07, 51)
    fallout.giq_option(4, 822, 137, Vance15, 50)
end

function Vance10()
    fallout.gsay_reply(822, 138)
    fallout.giq_option(4, 822, 139, Barter, 50)
    fallout.giq_option(4, 822, 140, Vance15, 50)
end

function Vance11()
    fallout.gsay_reply(822, 141)
    fallout.giq_option(4, 822, 142, Vance13, 51)
    fallout.giq_option(4, 822, 143, Vance14, 50)
    fallout.giq_option(4, 822, 144, Vance11a, 49)
end

function Vance11a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, -20)) == 1 then
        Vance02()
    else
        Vance13()
    end
end

function Vance12()
    fallout.gsay_reply(822, 145)
    fallout.giq_option(-3, 822, 146, Vance13, 50)
    fallout.giq_option(-3, 822, 147, Vance14, 50)
    fallout.giq_option(4, 822, 148, Vance13, 50)
    fallout.giq_option(4, 822, 149, Vance14, 50)
end

function Vance13()
    reaction.BottomReact()
    combat()
end

function Vance14()
    kickOut = 1
end

function Vance15()
end

function VanceEnd()
end

function Barter()
    fallout.set_global_var(236, 1)
    fallout.gsay_message(822, 118, 50)
    fallout.gdialog_mod_barter(-20)
    fallout.gsay_reply(822, 150)
    fallout.giq_option(4, 822, 151, VanceEnd, 50)
    fallout.giq_option(-3, 822, 152, VanceEnd, 50)
end

function Get_Stuff()
    fallout.move_obj_inven_to_obj(fallout.external_var("Vance_Box_Ptr"), fallout.self_obj())
end

function Put_Stuff()
    fallout.move_obj_inven_to_obj(fallout.self_obj(), fallout.external_var("Vance_Box_Ptr"))
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
return exports
