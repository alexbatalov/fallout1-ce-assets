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
local timed_event_p_proc
local BarterGuy00
local BarterGuy00a
local BarterGuy01
local BarterGuy02
local BarterGuy02a
local BarterGuy03
local BarterGuy04
local BarterGuy05
local BarterGuy06
local BarterGuy07
local BarterGuy08
local BarterGuy09
local BarterGuy10
local BarterGuy11
local BarterGuy12
local BarterGuy13
local BarterGuy14
local BarterGuyEnd

local hostile = 0
local initialized = false
local Caught_Stealing = 0
local Here_To_Shop = 0
local Go_Balistic = 0

local exit_line = 0

function start()
    if not initialized then
        initialized = true
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 20)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 69)
        fallout.set_external_var("Shopkepper_Ptr", fallout.self_obj())
    end
    if fallout.script_action() == 21 then
        look_at_p_proc()
    else
        if fallout.script_action() == 22 then
            timed_event_p_proc()
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
end

function combat()
    hostile = 1
end

function critter_p_proc()
    if hostile then
        hostile = 0
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    end
end

function pickup_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        hostile = 1
    end
end

function talk_p_proc()
    local v0 = 0
    local v1 = 0
    reaction.get_reaction()
    v1 = fallout.obj_carrying_pid_obj(fallout.self_obj(), 113)
    fallout.rm_obj_from_inven(fallout.self_obj(), v1)
    fallout.move_obj_inven_to_obj(fallout.external_var("Shop_Ptr"), fallout.self_obj())
    fallout.start_gdialog(843, fallout.self_obj(), 4, -1, -1)
    fallout.gsay_start()
    if Caught_Stealing then
        BarterGuy00()
    else
        if (fallout.obj_item_subtype(fallout.critter_inven_obj(fallout.dude_obj(), 1)) == 3) or (fallout.obj_item_subtype(fallout.critter_inven_obj(fallout.dude_obj(), 2)) == 3) or (fallout.global_var(195) == 1) then
            BarterGuy02()
        else
            if fallout.obj_pid(fallout.critter_inven_obj(fallout.dude_obj(), 0)) == 113 then
                BarterGuy07()
            else
                BarterGuy10()
            end
        end
    end
    fallout.gsay_end()
    fallout.end_dialogue()
    fallout.move_obj_inven_to_obj(fallout.self_obj(), fallout.external_var("Shop_Ptr"))
    fallout.add_obj_to_inven(fallout.self_obj(), v1)
    fallout.wield_obj_critter(fallout.self_obj(), v1)
    if Go_Balistic then
        v0 = fallout.create_object_sid(12, 0, 0, -1)
        fallout.add_obj_to_inven(fallout.self_obj(), v0)
        fallout.wield_obj_critter(fallout.self_obj(), v0)
    end
end

function destroy_p_proc()
    reputation.inc_good_critter()
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(843, 100))
end

function timed_event_p_proc()
    if fallout.fixed_param() == 1 then
        Here_To_Shop = 1
        fallout.dialogue_system_enter()
    else
        if fallout.fixed_param() == 2 then
            Caught_Stealing = 1
            fallout.dialogue_system_enter()
        end
    end
end

function BarterGuy00()
    fallout.gsay_reply(843, 101)
    fallout.giq_option(-3, 843, 102, BarterGuy01, 50)
    fallout.giq_option(4, 843, 103, BarterGuy01, 50)
    fallout.giq_option(5, 843, 104, BarterGuy00a, 50)
end

function BarterGuy00a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        combat()
    else
        BarterGuy01()
    end
end

function BarterGuy01()
    fallout.gsay_message(843, 105, 51)
    combat()
end

function BarterGuy02()
    fallout.gsay_reply(843, 106)
    fallout.giq_option(-3, 843, 107, BarterGuyEnd, 50)
    fallout.giq_option(4, 843, 108, BarterGuy03, 50)
    fallout.giq_option(6, 843, 109, BarterGuy02a, 50)
end

function BarterGuy02a()
    if fallout.global_var(195) == 1 then
        BarterGuy04()
    else
        BarterGuy05()
    end
end

function BarterGuy03()
    fallout.gsay_message(843, 110, 50)
end

function BarterGuy04()
    fallout.gsay_reply(843, 111)
    fallout.giq_option(6, 843, 112, BarterGuy01, 50)
    fallout.giq_option(6, 843, 113, BarterGuyEnd, 50)
end

function BarterGuy05()
    fallout.gsay_reply(843, 114)
    fallout.giq_option(6, 843, 115, BarterGuy00a, 50)
    fallout.giq_option(6, 843, 116, BarterGuy06, 50)
end

function BarterGuy06()
    fallout.gsay_message(843, 117, 50)
end

function BarterGuy07()
    fallout.gsay_reply(843, 118)
    fallout.giq_option(-3, 843, 119, BarterGuy08, 50)
    fallout.giq_option(4, 843, 120, BarterGuy12, 50)
    fallout.giq_option(4, 843, 121, BarterGuy09, 50)
end

function BarterGuy08()
    fallout.gsay_reply(843, 122)
    fallout.giq_option(-3, 843, 123, BarterGuyEnd, 50)
end

function BarterGuy09()
    fallout.gsay_message(843, 124, 50)
end

function BarterGuy10()
    fallout.gsay_reply(843, 125)
    fallout.giq_option(-3, 843, 126, BarterGuy08, 50)
    fallout.giq_option(4, 843, 127, BarterGuy13, 50)
    fallout.giq_option(5, 843, 128, BarterGuy11, 50)
end

function BarterGuy11()
    fallout.gsay_reply(843, 129)
    fallout.giq_option(4, 843, 130, BarterGuyEnd, 50)
    fallout.giq_option(4, 843, 131, BarterGuy01, 50)
    fallout.giq_option(4, 843, 132, BarterGuy13, 50)
end

function BarterGuy12()
    fallout.gsay_reply(843, 133)
    fallout.giq_option(4, 843, 134, BarterGuyEnd, 50)
end

function BarterGuy13()
    fallout.gsay_reply(843, 135)
    fallout.giq_option(4, 843, 136, BarterGuy14, 50)
end

function BarterGuy14()
    fallout.gdialog_mod_barter(-10)
    fallout.gsay_message(843, 137, 50)
end

function BarterGuyEnd()
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
exports.timed_event_p_proc = timed_event_p_proc
return exports
