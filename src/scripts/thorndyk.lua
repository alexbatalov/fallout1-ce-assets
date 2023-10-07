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
local Thorn00
local Thorn01
local Thorn02
local Thorn02a
local Thorn03
local Thorn03a
local Thorn03b
local Thorn04
local Thorn05
local Thorn06
local Thorn07
local Thorn08
local Thorn09
local Thorn10
local Thorn11
local Thorn12
local Thorn13
local Thorn14
local Thorn15
local Thorn16
local Thorn17
local Thorn17a
local Thorn18
local Thorn18a
local Thorn19
local Thorn20
local Thorn21
local Thorn22
local Thorn22a
local Thorn22b
local Thorn23
local Thorn24
local Thorn25
local Thorn26
local Thorn27
local Thorn28
local Thorn29

local hostile = 0
local Only_Once = 1
local PlayerYellsOuch = 0
local DoctorPostTreatmentResponse = 0
local HealPlayer = 0

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
        fallout.set_external_var("Thorndyke_Ptr", fallout.self_obj())
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 72)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 77)
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
    if (fallout.map_var(6) == 1) and (fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) == 1) then
        combat()
    end
end

function pickup_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        hostile = 1
    end
end

function talk_p_proc()
    local v0 = 0
    get_reaction()
    if fallout.global_var(195) == 1 then
        Thorn00()
    else
        if fallout.local_var(5) == 1 then
            Thorn28()
        else
            if fallout.map_var(0) == 1 then
                Thorn29()
            else
                if (fallout.global_var(158) == 1) or (fallout.global_var(156) == 1) then
                    Thorn01()
                else
                    fallout.start_gdialog(603, fallout.self_obj(), 4, -1, -1)
                    fallout.gsay_start()
                    Thorn02()
                    fallout.gsay_end()
                    fallout.end_dialogue()
                end
            end
        end
    end
    if HealPlayer == 1 then
        HealPlayer = 0
        fallout.set_local_var(6, fallout.game_time() // (10 * 60 * 60))
        if PlayerYellsOuch == 1 then
            PlayerYellsOuch = 0
            fallout.float_msg(fallout.dude_obj(), 168, 9)
        end
        fallout.float_msg(fallout.self_obj(), fallout.message_str(603, DoctorPostTreatmentResponse), 2)
        v0 = fallout.random(5, 15) + 10
        fallout.critter_heal(fallout.dude_obj(), v0)
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
    fallout.display_msg(fallout.message_str(603, 100))
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

function Thorn00()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(603, 101), 2)
    flee_dude()
end

function Thorn01()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(603, 102), 2)
    flee_dude()
end

function Thorn02()
    local v0 = 0
    local v1 = 0
    v0 = fallout.get_critter_stat(fallout.dude_obj(), 35)
    v1 = fallout.get_critter_stat(fallout.dude_obj(), 7)
    if v0 == v1 then
        if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
            fallout.gsay_reply(603, 103)
        else
            fallout.gsay_reply(603, 104)
        end
        fallout.giq_option(7, 603, 105, Thorn02a, 49)
        fallout.giq_option(7, 603, 106, Thorn05, 50)
        fallout.giq_option(4, 603, 107, Thorn06, 50)
        fallout.giq_option(4, 603, 108, Thorn07, 50)
        fallout.giq_option(4, 603, 109, Thorn08, 51)
        fallout.giq_option(-3, 603, 110, Thorn09, 51)
    else
        if (v0 < v1) and (((fallout.game_time() // (10 * 60 * 60)) - fallout.local_var(6)) < 24) then
            if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
                fallout.gsay_reply(603, 111)
            else
                fallout.gsay_reply(603, 112)
            end
            fallout.giq_option(7, 603, 113, Thorn02a, 50)
            fallout.giq_option(7, 603, 114, Thorn05, 50)
            fallout.giq_option(4, 603, 115, Thorn27, 51)
            fallout.giq_option(4, 603, 116, Thorn07, 49)
            fallout.giq_option(4, 603, 117, Thorn08, 51)
            fallout.giq_option(-3, 603, 118, Thorn09, 50)
        else
            if (v0 > (v1 // 2)) and (((fallout.game_time() // (10 * 60 * 60)) - fallout.local_var(6)) > 24) then
                if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
                    fallout.gsay_reply(603, 119)
                else
                    fallout.gsay_reply(603, 120)
                end
                fallout.giq_option(7, 603, 121, Thorn10, 50)
                fallout.giq_option(7, 603, 122, Thorn10, 50)
                fallout.giq_option(4, 603, 123, Thorn11, 50)
                fallout.giq_option(4, 603, 124, Thorn12, 50)
                fallout.giq_option(4, 603, 125, Thorn13, 50)
                fallout.giq_option(4, 603, 126, Thorn14, 50)
                fallout.giq_option(-3, 603, 127, Thorn15, 50)
                fallout.giq_option(-3, 603, 128, Thorn16, 50)
            else
                if (v0 < (v1 // 2)) and (((fallout.game_time() // (10 * 60 * 60)) - fallout.local_var(6)) > 24) then
                    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
                        fallout.gsay_reply(603, 129)
                    else
                        fallout.gsay_reply(603, 130)
                    end
                    fallout.giq_option(7, 603, 131, Thorn10, 50)
                    fallout.giq_option(7, 603, 132, Thorn10, 50)
                    fallout.giq_option(4, 603, 133, Thorn11, 50)
                    fallout.giq_option(4, 603, 124, Thorn12, 50)
                    fallout.giq_option(4, 603, 134, Thorn13, 50)
                    fallout.giq_option(4, 603, 135, Thorn14, 50)
                    fallout.giq_option(-3, 603, 136, Thorn15, 50)
                    fallout.giq_option(-3, 603, 137, Thorn16, 50)
                end
            end
        end
    end
end

function Thorn02a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) == 1 then
        Thorn03()
    else
        Thorn04()
    end
end

function Thorn03()
    fallout.gsay_reply(603, 138)
    fallout.giq_option(7, 603, 139, Thorn03a, 50)
    fallout.giq_option(7, 603, 140, Thorn03b, 50)
    fallout.giq_option(7, 603, 141, Thorn05, 50)
    fallout.giq_option(4, 603, 142, Thorn07, 50)
    fallout.giq_option(4, 603, 143, Thorn19, 50)
end

function Thorn03a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) == 1 then
        Thorn17()
    else
        Thorn04()
    end
end

function Thorn03b()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) == 1 then
        Thorn18()
    else
        Thorn04()
    end
end

function Thorn04()
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        fallout.gsay_message(603, 144, 50)
    else
        fallout.gsay_message(603, 145, 50)
    end
end

function Thorn05()
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        fallout.gsay_message(603, 146, 50)
    else
        fallout.gsay_message(603, 147, 50)
    end
end

function Thorn06()
    fallout.gsay_message(603, 148, 50)
end

function Thorn07()
    fallout.gsay_message(603, 149, 50)
end

function Thorn08()
    fallout.gsay_message(603, 150, 51)
end

function Thorn09()
    fallout.gsay_message(603, 151, 50)
end

function Thorn10()
    fallout.gsay_reply(603, 152)
    fallout.giq_option(7, 603, 153, Thorn20, 51)
    fallout.giq_option(7, 603, 154, Thorn20, 50)
    fallout.giq_option(4, 603, 155, Thorn11, 50)
    fallout.giq_option(4, 603, 156, Thorn12, 49)
    fallout.giq_option(4, 603, 157, Thorn13, 50)
    fallout.giq_option(4, 603, 158, Thorn14, 50)
end

function Thorn11()
    fallout.gsay_reply(603, 159)
    fallout.giq_option(4, 603, 160, Thorn12, 50)
    fallout.giq_option(4, 603, 157, Thorn13, 50)
    fallout.giq_option(4, 603, 162, Thorn24, 51)
    fallout.giq_option(4, 603, 163, Thorn14, 50)
end

function Thorn12()
    DoctorPostTreatmentResponse = 164
    PlayerYellsOuch = 0
    HealPlayer = 1
    fallout.gsay_message(603, 161, 50)
end

function Thorn13()
    fallout.gsay_message(603, 165, 50)
end

function Thorn14()
    fallout.gsay_message(603, 166, 50)
end

function Thorn15()
    DoctorPostTreatmentResponse = 169
    PlayerYellsOuch = 1
    HealPlayer = 1
    fallout.gsay_message(603, 167, 50)
end

function Thorn16()
    fallout.gsay_message(603, 170, 50)
end

function Thorn17()
    fallout.gsay_reply(603, 171)
    fallout.giq_option(7, 603, 172, Thorn17a, 50)
    fallout.giq_option(4, 603, 173, Thorn27, 50)
    fallout.giq_option(4, 603, 174, Thorn27, 50)
    fallout.giq_option(4, 603, 175, Thorn14, 50)
end

function Thorn17a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) == 1 then
        Thorn21()
    else
        Thorn04()
    end
end

function Thorn18()
    fallout.gsay_reply(603, 176)
    fallout.giq_option(7, 603, 177, Thorn18a, 50)
    fallout.giq_option(4, 603, 178, Thorn24, 51)
    fallout.giq_option(4, 603, 179, Thorn27, 50)
    fallout.giq_option(4, 603, 180, Thorn24, 51)
    fallout.giq_option(4, 603, 181, Thorn14, 50)
end

function Thorn18a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) == 1 then
        Thorn22()
    else
        Thorn04()
    end
end

function Thorn19()
    fallout.gsay_message(603, 182, 50)
end

function Thorn20()
    fallout.gsay_reply(603, 183)
    fallout.giq_option(7, 603, 184, Thorn23, 51)
    fallout.giq_option(4, 603, 185, Thorn24, 51)
    fallout.giq_option(4, 603, 186, Thorn12, 49)
    fallout.giq_option(4, 603, 187, Thorn13, 50)
    fallout.giq_option(4, 603, 188, Thorn14, 50)
end

function Thorn21()
    fallout.gsay_reply(603, 189)
    fallout.giq_option(7, 603, 190, Thorn25, 50)
    fallout.giq_option(4, 603, 191, Thorn27, 50)
    fallout.giq_option(4, 603, 192, Thorn27, 50)
    fallout.giq_option(4, 603, 193, Thorn24, 51)
end

function Thorn22()
    fallout.gsay_reply(603, 194)
    fallout.giq_option(7, 603, 195, Thorn22a, 50)
    fallout.giq_option(4, 603, 196, Thorn22b, 50)
    fallout.giq_option(4, 603, 197, Thorn27, 50)
    fallout.giq_option(4, 603, 198, Thorn27, 50)
    fallout.giq_option(4, 603, 199, Thorn24, 51)
end

function Thorn22a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) == 1 then
        Thorn25()
    else
        Thorn04()
    end
end

function Thorn22b()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) == 1 then
        Thorn26()
    else
        Thorn04()
    end
end

function Thorn23()
    fallout.set_local_var(5, 1)
    fallout.gsay_message(603, 200, 51)
end

function Thorn24()
    fallout.set_local_var(5, 1)
    fallout.gsay_message(603, 201, 51)
end

function Thorn25()
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        fallout.gsay_message(603, 202, 50)
    else
        fallout.gsay_message(603, 203, 50)
    end
end

function Thorn26()
    fallout.gsay_reply(603, 204)
    fallout.giq_option(7, 603, 205, Thorn27, 50)
    fallout.giq_option(4, 603, 206, Thorn07, 50)
    fallout.giq_option(4, 603, 207, Thorn24, 51)
    fallout.giq_option(4, 603, 208, Thorn24, 51)
    fallout.giq_option(4, 603, 209, Thorn27, 51)
end

function Thorn27()
    fallout.gsay_message(603, 210, 50)
end

function Thorn28()
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(603, 211), 2)
    else
        fallout.float_msg(fallout.self_obj(), fallout.message_str(603, 212), 2)
    end
end

function Thorn29()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(603, 213), 2)
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
