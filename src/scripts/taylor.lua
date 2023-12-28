local fallout = require("fallout")
local reaction = require("lib.reaction")
local reputation = require("lib.reputation")

local start
local combat_p_proc
local critter_p_proc
local damage_p_proc
local destroy_p_proc
local look_at_p_proc
local pickup_p_proc
local talk_p_proc
local Tine01
local Tine02
local Tine03
local Tine04
local Tine05
local Tine06
local Tine07
local Tine08
local TineBarter
local Tine_barter1
local Tine_barter2
local TineEnd

local hostile = false
local initialized = false
local round_counter = 0

function start()
    if not initialized then
        local self_obj = fallout.self_obj()
        fallout.critter_add_trait(self_obj, 1, 6, 49)
        fallout.critter_add_trait(self_obj, 1, 5, 30)
        initialized = true
    end

    local script_action = fallout.script_action()
    if script_action == 13 then
        combat_p_proc()
    elseif script_action == 12 then
        critter_p_proc()
    elseif script_action == 14 then
        damage_p_proc()
    elseif script_action == 18 then
        destroy_p_proc()
    elseif script_action == 21 then
        look_at_p_proc()
    elseif script_action == 4 then
        pickup_p_proc()
    elseif script_action == 11 then
        talk_p_proc()
    end
end

function combat_p_proc()
    if fallout.fixed_param() == 4 then
        if fallout.elevation(fallout.self_obj()) == 0 then
            round_counter = round_counter + 1
            if round_counter > 3 then
                if fallout.global_var(251) == 0 then
                    fallout.set_global_var(251, 1)
                    fallout.set_global_var(155, fallout.global_var(155) - 5)
                end
            end
        end
    end
end

function critter_p_proc()
    if hostile then
        hostile = false
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    else
        if fallout.external_var("Tine_barter") ~= 0 then
            fallout.dialogue_system_enter()
        end
    end
end

function damage_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.set_local_var(5, 1)
    end
end

function destroy_p_proc()
    reputation.inc_good_critter()
end

function look_at_p_proc()
    fallout.script_overrides()
    if fallout.local_var(4) ~= 0 then
        fallout.display_msg(fallout.message_str(256, 101))
    else
        fallout.display_msg(fallout.message_str(256, 100))
    end
end

function pickup_p_proc()
    hostile = true
end

function talk_p_proc()
    local v0 = 0
    reaction.get_reaction()
    v0 = fallout.random(0, 1)
    if fallout.external_var("Tine_barter") == 0 then
        if v0 == 1 then
            fallout.move_obj_inven_to_obj(fallout.external_var("AdyStor1_ptr"), fallout.self_obj())
        else
            fallout.move_obj_inven_to_obj(fallout.external_var("AdyStor2_ptr"), fallout.self_obj())
        end
    end
    if fallout.external_var("Tine_barter") == -1 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(37, 136), 2)
        hostile = true
    else
        if (fallout.external_var("Tine_barter") ~= 0) and ((fallout.local_var(5) == 1) or (fallout.global_var(251) == 1)) then
            fallout.float_msg(fallout.self_obj(), fallout.message_str(669, 104), 2)
        else
            fallout.start_gdialog(256, fallout.self_obj(), 4, -1, -1)
            fallout.gsay_start()
            if fallout.external_var("Tine_barter") == 1 then
                Tine_barter1()
            elseif fallout.external_var("Tine_barter") == 2 then
                Tine_barter2()
            elseif fallout.local_var(4) ~= 0 then
                Tine07()
            else
                Tine01()
            end
            fallout.gsay_end()
            fallout.end_dialogue()
        end
    end
    if fallout.external_var("Tine_barter") == 1 then
        fallout.move_obj_inven_to_obj(fallout.self_obj(), fallout.external_var("AdyStor1_ptr"))
    elseif fallout.external_var("Tine_barter") == 2 then
        fallout.move_obj_inven_to_obj(fallout.self_obj(), fallout.external_var("AdyStor2_ptr"))
    elseif v0 == 1 then
        fallout.move_obj_inven_to_obj(fallout.self_obj(), fallout.external_var("AdyStor1_ptr"))
    else
        fallout.move_obj_inven_to_obj(fallout.self_obj(), fallout.external_var("AdyStor2_ptr"))
    end
    fallout.set_external_var("Tine_barter", 0)
end

function Tine01()
    if fallout.local_var(1) < 2 then
        fallout.gsay_reply(256, 102)
    else
        fallout.gsay_reply(256, 103)
    end
    Tine02()
end

function Tine02()
    if fallout.local_var(4) == 0 then
        fallout.giq_option(4, 256,
            fallout.message_str(256, 104) ..
            fallout.proto_data(fallout.obj_pid(fallout.dude_obj()), 1) .. fallout.message_str(256, 105), Tine04, 50)
    end
    fallout.giq_option(4, 256, 106, Tine03, 50)
    fallout.giq_option(4, 256, 107, Tine05, 50)
    fallout.giq_option(4, 256, 108, Tine08, 50)
    fallout.giq_option(0, 256, 109, Tine06, 50)
end

function Tine03()
    if fallout.local_var(1) < 2 then
        fallout.gsay_reply(256, 110)
    else
        fallout.gsay_reply(256, 111)
    end
    Tine02()
end

function Tine04()
    fallout.set_local_var(4, 1)
    if fallout.local_var(1) < 2 then
        fallout.gsay_reply(256, 112)
    else
        fallout.gsay_reply(256, 113)
    end
    Tine02()
end

function Tine05()
    fallout.gdialog_mod_barter(0)
    fallout.gsay_message(256, 114, 50)
end

function Tine06()
    if fallout.local_var(1) < 2 then
        fallout.gsay_message(256, 115, 50)
    else
        fallout.gsay_message(256, 116, 50)
    end
end

function Tine07()
    if fallout.local_var(1) < 2 then
        fallout.gsay_reply(256, 117)
    else
        fallout.gsay_reply(256, 118)
    end
    Tine02()
end

function Tine08()
    if fallout.local_var(0) < 2 then
        fallout.gsay_reply(256, 119)
    else
        fallout.gsay_reply(256, 120)
    end
    Tine02()
end

function TineBarter()
    fallout.gdialog_mod_barter(20)
    fallout.gsay_message(634, 100, 50)
end

function Tine_barter1()
    fallout.move_obj_inven_to_obj(fallout.external_var("AdyStor1_ptr"), fallout.self_obj())
    fallout.gsay_reply(617, 293)
    fallout.giq_option(0, 634, 106, TineBarter, 50)
end

function Tine_barter2()
    fallout.move_obj_inven_to_obj(fallout.external_var("AdyStor2_ptr"), fallout.self_obj())
    fallout.gsay_reply(617, 293)
    fallout.giq_option(0, 634, 106, TineBarter, 50)
end

function TineEnd()
end

local exports = {}
exports.start = start
exports.combat_p_proc = combat_p_proc
exports.critter_p_proc = critter_p_proc
exports.damage_p_proc = damage_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
return exports
