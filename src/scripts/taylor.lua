local fallout = require("fallout")

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

local hostile = 0
local initialized = 0
local round_counter = 0

local get_reaction
local ReactToLevel
local LevelToReact
local UpReact
local DownReact
local BottomReact
local TopReact
local BigUpReact
local BigDownReact
local UpReactLevel
local DownReactLevel
local Goodbyes

local exit_line = 0

function start()
    if not(initialized) then
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 49)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 30)
        initialized = 1
    else
        if fallout.script_action() == 13 then
            combat_p_proc()
        else
            if fallout.script_action() == 12 then
                critter_p_proc()
            else
                if fallout.script_action() == 14 then
                    damage_p_proc()
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
        hostile = 0
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
        fallout.display_msg(fallout.message_str(256, 101))
    else
        fallout.display_msg(fallout.message_str(256, 100))
    end
end

function pickup_p_proc()
    hostile = 1
end

function talk_p_proc()
    local v0 = 0
    get_reaction()
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
        hostile = 1
    else
        if (fallout.external_var("Tine_barter") ~= 0) and ((fallout.local_var(5) == 1) or (fallout.global_var(251) == 1)) then
            fallout.float_msg(fallout.self_obj(), fallout.message_str(669, 104), 2)
        else
            fallout.start_gdialog(256, fallout.self_obj(), 4, -1, -1)
            fallout.gsay_start()
            if fallout.external_var("Tine_barter") == 1 then
                Tine_barter1()
            else
                if fallout.external_var("Tine_barter") == 2 then
                    Tine_barter2()
                else
                    if fallout.local_var(4) then
                        Tine07()
                    else
                        Tine01()
                    end
                end
            end
            fallout.gsay_end()
            fallout.end_dialogue()
        end
    end
    if fallout.external_var("Tine_barter") == 1 then
        fallout.move_obj_inven_to_obj(fallout.self_obj(), fallout.external_var("AdyStor1_ptr"))
    else
        if fallout.external_var("Tine_barter") == 2 then
            fallout.move_obj_inven_to_obj(fallout.self_obj(), fallout.external_var("AdyStor2_ptr"))
        else
            if v0 == 1 then
                fallout.move_obj_inven_to_obj(fallout.self_obj(), fallout.external_var("AdyStor1_ptr"))
            else
                fallout.move_obj_inven_to_obj(fallout.self_obj(), fallout.external_var("AdyStor2_ptr"))
            end
        end
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
    if not(fallout.local_var(4)) then
        fallout.giq_option(4, 256, fallout.message_str(256, 104) .. fallout.proto_data(fallout.obj_pid(fallout.dude_obj()), 1) .. fallout.message_str(256, 105), Tine04, 50)
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

function get_reaction()
    if fallout.local_var(2) == 0 then
        fallout.set_local_var(0, 50)
        fallout.set_local_var(1, 2)
        fallout.set_local_var(2, 1)
        fallout.set_local_var(0, fallout.local_var(0) + (5 * fallout.get_critter_stat(fallout.dude_obj(), 3)) - 25)
        fallout.set_local_var(0, fallout.local_var(0) + (10 * fallout.has_trait(0, fallout.dude_obj(), 10)))
        if fallout.has_trait(0, fallout.dude_obj(), 39) then
            if fallout.global_var(155) > 0 then
                fallout.set_local_var(0, fallout.local_var(0) + fallout.global_var(155))
            else
                fallout.set_local_var(0, fallout.local_var(0) - fallout.global_var(155))
            end
        else
            if fallout.local_var(3) == 1 then
                fallout.set_local_var(0, fallout.local_var(0) - fallout.global_var(155))
            else
                fallout.set_local_var(0, fallout.local_var(0) + fallout.global_var(155))
            end
        end
        if fallout.global_var(158) > 2 then
            fallout.set_local_var(0, fallout.local_var(0) - 30)
        end
        if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(160) > (3 * fallout.global_var(159))) or (fallout.global_var(157) == 1)) then
            fallout.set_local_var(0, fallout.local_var(0) + 20)
        end
        if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1)) then
            fallout.set_local_var(0, fallout.local_var(0) - 20)
        end
        ReactToLevel()
    end
end

function ReactToLevel()
    if fallout.local_var(0) <= 25 then
        fallout.set_local_var(1, 1)
    else
        if fallout.local_var(0) <= 75 then
            fallout.set_local_var(1, 2)
        else
            fallout.set_local_var(1, 3)
        end
    end
end

function LevelToReact()
    if fallout.local_var(1) == 1 then
        fallout.set_local_var(0, fallout.random(1, 25))
    else
        if fallout.local_var(1) == 2 then
            fallout.set_local_var(0, fallout.random(26, 75))
        else
            fallout.set_local_var(0, fallout.random(76, 100))
        end
    end
end

function UpReact()
    fallout.set_local_var(0, fallout.local_var(0) + 10)
    ReactToLevel()
end

function DownReact()
    fallout.set_local_var(0, fallout.local_var(0) - 10)
    ReactToLevel()
end

function BottomReact()
    fallout.set_local_var(1, 1)
    fallout.set_local_var(0, 1)
end

function TopReact()
    fallout.set_local_var(0, 100)
    fallout.set_local_var(1, 3)
end

function BigUpReact()
    fallout.set_local_var(0, fallout.local_var(0) + 25)
    ReactToLevel()
end

function BigDownReact()
    fallout.set_local_var(0, fallout.local_var(0) - 25)
    ReactToLevel()
end

function UpReactLevel()
    fallout.set_local_var(1, fallout.local_var(1) + 1)
    if fallout.local_var(1) > 3 then
        fallout.set_local_var(1, 3)
    end
    LevelToReact()
end

function DownReactLevel()
    fallout.set_local_var(1, fallout.local_var(1) - 1)
    if fallout.local_var(1) < 1 then
        fallout.set_local_var(1, 1)
    end
    LevelToReact()
end

function Goodbyes()
    exit_line = fallout.message_str(634, fallout.random(100, 105))
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
