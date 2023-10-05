local fallout = require("fallout")

local Start
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
local DialogMain1
local DialogMain2
local DialogMain3
local DialogMain4
local DialogMain5
local DialogMain6

local Initialize = 1
local Hostile = 0

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

function Start()
    local v0 = 0
    if Initialize then
        if fallout.obj_is_carrying_obj_pid(fallout.self_obj(), 41) == 0 then
            fallout.item_caps_adjust(fallout.self_obj(), fallout.random(2, 20))
        end
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 89)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 29)
        if fallout.local_var(6) == 0 then
            fallout.set_map_var(1, fallout.map_var(1) + 1)
            fallout.set_local_var(6, 1)
        end
        if fallout.global_var(613) == 9103 then
            v0 = fallout.global_var(268)
            if v0 == 0 then
                fallout.set_external_var("RegGuard1", fallout.self_obj())
            else
                if v0 == 1 then
                    fallout.set_external_var("RegGuard2", fallout.self_obj())
                end
            end
            v0 = v0 + 1
            fallout.set_global_var(268, v0)
        else
            fallout.set_external_var("RegGuard1", 0)
            fallout.set_external_var("RegGuard2", 0)
        end
        Initialize = 0
    end
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(252, 100))
end

function description_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(252, 100))
end

function talk_p_proc()
    if (fallout.global_var(251) == 1) or (fallout.global_var(616) == 1) or (fallout.global_var(613) == 9103) then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(669, fallout.random(100, 105)), 2)
    else
        get_reaction()
        fallout.start_gdialog(252, fallout.self_obj(), -1, -1, -1)
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
    end
end

function critter_p_proc()
    if fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) then
        if (fallout.global_var(613) == 9103) and (fallout.local_var(5) == 0) then
            fallout.attack_complex(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
            fallout.set_global_var(616, 1)
        else
            if (fallout.global_var(251) == 1) or (fallout.global_var(616) == 1) then
                fallout.attack_complex(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
            else
                if fallout.global_var(613) ~= 9103 then
                    if fallout.map_var(0) == 0 then
                        fallout.set_map_var(0, 1)
                        fallout.dialogue_system_enter()
                    end
                end
            end
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
        if fallout.source_obj() == fallout.dude_obj() then
            if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1)) then
                fallout.set_global_var(156, 1)
                fallout.set_global_var(157, 0)
            end
            if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(160) > (3 * fallout.global_var(159))) or (fallout.global_var(157) == 1)) then
                fallout.set_global_var(157, 1)
                fallout.set_global_var(156, 0)
            end
            fallout.set_global_var(160, fallout.global_var(160) + 1)
            if (fallout.global_var(160) % 6) == 0 then
                fallout.set_global_var(155, fallout.global_var(155) + 1)
            end
        end
    end
    if fallout.map_var(1) == 0 then
        fallout.terminate_combat()
    end
end

function pickup_p_proc()
    fallout.set_global_var(616, 1)
end

function DialogWeapon()
    fallout.gsay_message(252, 131, 50)
end

function DialogFirstTime()
    fallout.gsay_reply(252, 103)
    fallout.giq_option(-3, 252, 106, DialogMain1, 50)
    fallout.giq_option(4, 252, 104, DialogMain1, 50)
    fallout.giq_option(4, 252, 105, DialogMain2, 50)
end

function DialogSubsequent()
    fallout.gsay_reply(252, 111)
    fallout.giq_option(-3, 252, 106, DialogMain1, 50)
    fallout.giq_option(4, 252, 104, DialogMain1, 50)
    fallout.giq_option(4, 252, 105, DialogMain2, 50)
    fallout.giq_option(4, 252, 114, DialogExit, 50)
end

function DialogExit()
end

function DialogMain1()
    if fallout.global_var(128) == 0 then
        fallout.gsay_message(252, 107, 50)
    else
        fallout.gsay_message(252, 110, 50)
    end
end

function DialogMain2()
    if fallout.local_var(1) < 2 then
        fallout.gsay_message(252, 116, 50)
    else
        fallout.gsay_reply(252, 117)
        fallout.giq_option(-3, 252, 106, DialogExit, 50)
        fallout.giq_option(4, 252, 118, DialogMain3, 50)
        fallout.giq_option(4, 252, 119, DialogMain4, 50)
        fallout.giq_option(5, 252, 120, DialogMain5, 50)
        fallout.giq_option(6, 252, 121, DialogMain6, 50)
        fallout.giq_option(4, 252, 114, DialogExit, 50)
    end
end

function DialogMain3()
    fallout.gsay_message(252, 123, 50)
    DialogMain2()
end

function DialogMain4()
    fallout.gsay_message(252, 124, 50)
    DialogMain2()
end

function DialogMain5()
    if fallout.global_var(128) == 0 then
        fallout.gsay_message(252, 125, 50)
    else
        if fallout.global_var(128) == 1 then
            fallout.gsay_message(252, 126, 50)
        else
            fallout.gsay_message(252, 127, 50)
        end
    end
end

function DialogMain6()
    fallout.gsay_message(252, 128, 50)
    fallout.gsay_message(252, 129, 50)
    DialogMain2()
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
exports.look_at_p_proc = look_at_p_proc
exports.description_p_proc = description_p_proc
exports.talk_p_proc = talk_p_proc
exports.critter_p_proc = critter_p_proc
exports.damage_p_proc = damage_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.pickup_p_proc = pickup_p_proc
return exports
