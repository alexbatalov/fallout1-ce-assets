local fallout = require("fallout")

local start
local combat
local critter_p_proc
local pickup_p_proc
local talk_p_proc
local destroy_p_proc
local look_at_p_proc
local flee_dude
local damage_p_proc
local Flower00
local Flower01
local Flower02
local Flower03
local Flower03a
local Flower04
local Flower04a
local Flower05
local Flower05a
local Flower06
local Flower07
local Flower08
local Flower09
local Flower10
local Flower11
local Flower12
local Flower13
local Flower14

local hostile = 0
local Only_Once = 1

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
    if Only_Once then
        Only_Once = 0
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 72)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 68)
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
        fallout.attack_complex(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    end
    if (fallout.map_var(6) == 1) and (fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) == 1) then
        fallout.critter_set_flee_state(fallout.self_obj(), 1)
    end
end

function pickup_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        hostile = 1
    end
end

function talk_p_proc()
    get_reaction()
    if (fallout.global_var(195) == 1) or (fallout.map_var(0) == 1) then
        Flower00()
    else
        if fallout.global_var(158) == 1 then
            Flower01()
        else
            if fallout.obj_is_carrying_obj_pid(fallout.dude_obj(), 117) == 1 then
                fallout.float_msg(fallout.self_obj(), fallout.message_str(588, 114), 2)
            else
                fallout.start_gdialog(588, fallout.self_obj(), 4, -1, -1)
                fallout.gsay_start()
                Flower02()
                fallout.gsay_end()
                fallout.end_dialogue()
            end
        end
    end
end

function destroy_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.set_global_var(158, fallout.global_var(158) + 1)
        fallout.set_global_var(155, fallout.global_var(155) - 1)
    end
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
    fallout.display_msg(fallout.message_str(588, 100))
end

function flee_dude()
    local v0 = 0
    local v1 = 0
    local v2 = 0
    while v1 < 5 do
        if fallout.tile_distance(fallout.tile_num(fallout.dude_obj()), fallout.tile_num_in_direction(fallout.tile_num(fallout.self_obj()), v1, 3)) > v2 then
            v0 = fallout.tile_num_in_direction(fallout.tile_num(fallout.self_obj()), v1, 3)
            v2 = fallout.tile_distance(fallout.tile_num(fallout.dude_obj()), v0)
        end
        v1 = v1 + 1
    end
    fallout.animate_move_obj_to_tile(fallout.self_obj(), v0, 0)
end

function damage_p_proc()
    local v0 = 0
    v0 = fallout.obj_pid(fallout.source_obj())
    if fallout.party_member_obj(v0) ~= 0 then
        fallout.set_map_var(6, 1)
    end
end

function Flower00()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(588, 101), 2)
    flee_dude()
end

function Flower01()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(588, 102), 2)
    flee_dude()
end

function Flower02()
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        fallout.gsay_reply(588, 103)
    else
        fallout.gsay_reply(588, 104)
    end
    fallout.giq_option(7, 588, 106, Flower03, 50)
    fallout.giq_option(7, 588, 107, Flower04, 50)
    fallout.giq_option(4, 588, 108, Flower05, 50)
    fallout.giq_option(4, 588, 109, Flower06, 49)
    fallout.giq_option(4, 588, 110, Flower07, 51)
    fallout.giq_option(4, 588, 111, Flower07, 51)
    fallout.giq_option(-3, 588, 112, Flower08, 49)
    fallout.giq_option(-3, 588, 113, Flower09, 51)
end

function Flower03()
    fallout.gsay_reply(588, 115)
    fallout.giq_option(7, 588, 116, Flower03a, 49)
    fallout.giq_option(7, 588, 107, Flower04, 50)
    fallout.giq_option(4, 588, 109, Flower06, 49)
    fallout.giq_option(4, 588, 110, Flower07, 51)
    fallout.giq_option(4, 588, 119, Flower07, 51)
end

function Flower03a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 20)) == 1 then
        Flower10()
    else
        Flower11()
    end
end

function Flower04()
    fallout.gsay_reply(588, 121)
    fallout.giq_option(7, 588, 123, Flower12, 50)
    fallout.giq_option(7, 588, 124, Flower04a, 49)
    fallout.giq_option(4, 588, 125, Flower05, 50)
    fallout.giq_option(4, 588, 126, Flower06, 49)
    fallout.giq_option(4, 588, 110, Flower07, 51)
    fallout.giq_option(4, 588, 119, Flower07, 51)
end

function Flower04a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) == 1 then
        Flower13()
    else
        Flower11()
    end
end

function Flower05()
    fallout.gsay_reply(588, 129)
    fallout.giq_option(7, 588, 130, Flower05a, 49)
    fallout.giq_option(7, 588, 131, Flower04a, 49)
    fallout.giq_option(4, 588, 132, Flower06, 49)
    fallout.giq_option(4, 588, 110, Flower07, 51)
    fallout.giq_option(4, 588, 119, Flower07, 51)
end

function Flower05a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) == 1 then
        Flower14()
    else
        Flower11()
    end
end

function Flower06()
    local v0 = 0
    v0 = fallout.create_object_sid(117, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), v0)
    fallout.gsay_message(588, 135, 49)
end

function Flower07()
    fallout.gsay_message(588, 136, 51)
    flee_dude()
end

function Flower08()
    local v0 = 0
    v0 = fallout.create_object_sid(117, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), v0)
    fallout.gsay_message(588, 137, 49)
end

function Flower09()
    fallout.gsay_message(588, 138, 51)
    flee_dude()
end

function Flower10()
    local v0 = 0
    v0 = fallout.create_object_sid(117, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), v0)
    fallout.gsay_message(588, 139, 49)
end

function Flower11()
    fallout.gsay_message(588, 140, 51)
    flee_dude()
end

function Flower12()
    fallout.gsay_reply(588, 141)
    fallout.giq_option(7, 588, 142, Flower05a, 50)
    fallout.giq_option(7, 588, 143, Flower04a, 50)
    fallout.giq_option(4, 588, 144, Flower06, 49)
    fallout.giq_option(4, 588, 145, Flower07, 51)
    fallout.giq_option(4, 588, 146, Flower07, 51)
end

function Flower13()
    fallout.gsay_reply(588, 147)
    fallout.giq_option(7, 588, 148, Flower11, 50)
    fallout.giq_option(4, 588, 149, Flower06, 49)
    fallout.giq_option(4, 588, 150, Flower07, 51)
    fallout.giq_option(4, 588, 151, Flower07, 51)
end

function Flower14()
    fallout.set_global_var(281, 1)
    fallout.gsay_reply(588, 152)
    fallout.giq_option(7, 588, 153, Flower11, 50)
    fallout.giq_option(4, 588, 154, Flower06, 49)
    fallout.giq_option(4, 588, 155, Flower07, 51)
    fallout.giq_option(4, 588, 151, Flower07, 51)
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
exports.critter_p_proc = critter_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
exports.damage_p_proc = damage_p_proc
return exports
