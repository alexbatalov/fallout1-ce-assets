local fallout = require("fallout")
local time = require("lib.time")

--
-- Some unreferenced imported varables found.
-- Because of it it is impossible to specify
-- the real names of global variables.
--

local g0 = 0
local g1 = 0
local g2 = 0
local g3 = 0
local g4 = 0
local g5 = 0
local g6 = 0

local start
local combat_p_proc
local critter_p_proc
local damage_p_proc
local destroy_p_proc
local pickup_p_proc
local talk_p_proc
local GenSupr00
local GenSupr03
local GenSupr03a
local GenSupr03b
local GenSupr04
local GenSupr05
local GenSupr06
local GenSupr07
local GenSupr08
local GenSuprAlert
local GenSuprxx
local set_alert_tile

-- ?import? variable initialized
-- ?import? variable hostile
-- ?import? variable round_counter
-- ?import? variable home_tile
-- ?import? variable alert_tile
-- ?import? variable night_tile
-- ?import? variable valid_target

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

-- ?import? variable exit_line

function start()
    if not(g0) then
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 34)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 48)
        set_alert_tile()
        if fallout.global_var(146) then
            fallout.move_to(fallout.self_obj(), g4, 1)
        else
            if time.is_night() then
                fallout.move_to(fallout.self_obj(), g5, 1)
            end
        end
        g0 = 1
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

function combat_p_proc()
    if fallout.fixed_param() == 4 then
        g2 = g2 + 1
    end
    if g2 > 2 then
        GenSuprAlert()
    end
    if fallout.fixed_param() == 2 then
        if fallout.global_var(276) then
            if fallout.random(0, 3) == 3 then
                fallout.critter_injure(fallout.dude_obj(), 1)
            end
        end
    end
end

function critter_p_proc()
    if g1 and fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) then
        g1 = 0
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    else
        if fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) then
            if fallout.global_var(146) then
                g1 = 1
            else
                if not(fallout.external_var("ignoring_dude")) then
                    if fallout.tile_distance_objs(fallout.self_obj(), fallout.dude_obj()) < 12 then
                        fallout.dialogue_system_enter()
                    end
                end
            end
        end
        if fallout.global_var(146) then
            if fallout.elevation(fallout.self_obj()) == 0 then
                if fallout.tile_num(fallout.self_obj()) ~= 14520 then
                    fallout.animate_move_obj_to_tile(fallout.self_obj(), 14520, 0)
                else
                    fallout.move_to(fallout.self_obj(), 14520, 1)
                end
            else
                if fallout.tile_num(fallout.self_obj()) ~= g4 then
                    fallout.animate_move_obj_to_tile(fallout.self_obj(), g4, 0)
                end
            end
        else
            if time.is_night() then
                if fallout.elevation(fallout.self_obj()) == 0 then
                    if fallout.tile_num(fallout.self_obj()) ~= 14520 then
                        fallout.animate_move_obj_to_tile(fallout.self_obj(), 14520, 0)
                    else
                        fallout.move_to(fallout.self_obj(), 14520, 1)
                    end
                else
                    if fallout.tile_num(fallout.self_obj()) ~= g5 then
                        fallout.animate_move_obj_to_tile(fallout.self_obj(), g5, 0)
                    end
                end
            else
                if fallout.tile_num(fallout.self_obj()) ~= fallout.local_var(4) then
                    fallout.animate_move_obj_to_tile(fallout.self_obj(), fallout.local_var(4), 0)
                end
            end
        end
    end
    if (fallout.global_var(273) >= 1) and (fallout.global_var(273) <= 3) then
        fallout.kill_critter(fallout.self_obj(), 35)
    end
end

function damage_p_proc()
    fallout.set_external_var("radio_room_attacked", 1)
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
        fallout.set_global_var(160, fallout.global_var(160) + 1)
        if (fallout.global_var(160) % 6) == 0 then
            fallout.set_global_var(155, fallout.global_var(155) + 1)
        end
    end
end

function pickup_p_proc()
    g1 = 1
end

function talk_p_proc()
    if fallout.global_var(54) then
        GenSupr08()
    else
        if (fallout.obj_item_subtype(fallout.critter_inven_obj(fallout.dude_obj(), 1)) == 3) or (fallout.obj_item_subtype(fallout.critter_inven_obj(fallout.dude_obj(), 2)) == 3) and not(g1) then
            if fallout.random(0, 5) == 5 then
                GenSupr00()
            else
                g1 = 1
            end
        else
            fallout.start_gdialog(433, fallout.self_obj(), 4, -1, -1)
            fallout.gsay_start()
            GenSupr03()
            fallout.gsay_end()
            fallout.end_dialogue()
        end
    end
end

function GenSupr00()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(433, fallout.random(101, 103)), 0)
    g1 = 1
end

function GenSupr03()
    fallout.gsay_reply(433, fallout.random(104, 106))
    fallout.giq_option(-3, 433, 107, GenSupr04, 0)
    fallout.giq_option(4, 433, 108, GenSupr04, 0)
    fallout.giq_option(5, 433, 109, GenSupr05, 0)
    fallout.giq_option(6, 433, 110, GenSupr03a, 0)
    if fallout.obj_pid(fallout.critter_inven_obj(fallout.dude_obj(), 0)) == 113 then
        fallout.giq_option(6, 433, 111, GenSupr03b, 0)
    end
end

function GenSupr03a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        GenSupr07()
    else
        GenSupr06()
    end
end

function GenSupr03b()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 25)) then
        GenSupr07()
    else
        GenSupr06()
    end
end

function GenSupr04()
    g1 = 1
    fallout.gsay_message(433, fallout.random(112, 114), 0)
end

function GenSupr05()
    fallout.gsay_reply(433, 115)
    fallout.giq_option(5, 433, 116, GenSuprxx, 0)
    fallout.giq_option(5, 433, 117, GenSuprAlert, 0)
end

function GenSupr06()
    g1 = 1
    fallout.gsay_message(433, fallout.random(118, 120), 0)
end

function GenSupr07()
    fallout.set_external_var("ignoring_dude", 1)
    fallout.gsay_message(433, fallout.random(121, 123), 0)
end

function GenSupr08()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(433, fallout.random(124, 127)), 0)
    g1 = 1
end

function GenSuprAlert()
    fallout.set_global_var(146, 1)
    g1 = 1
end

function GenSuprxx()
    fallout.set_global_var(57, 2)
    fallout.load_map(32, 5)
end

function set_alert_tile()
    if not(fallout.local_var(4)) then
        fallout.set_local_var(4, fallout.tile_num(fallout.self_obj()))
    end
    if fallout.local_var(4) == 23065 then
        g4 = 21917
        g5 = 26274
    else
        if fallout.local_var(4) == 22466 then
            g4 = 21922
            g5 = 27476
        else
            if fallout.local_var(4) == 22470 then
                g4 = 22318
                g5 = 27472
            end
        end
    end
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
    g6 = fallout.message_str(634, fallout.random(100, 105))
end

local exports = {}
exports.start = start
exports.combat_p_proc = combat_p_proc
exports.critter_p_proc = critter_p_proc
exports.damage_p_proc = damage_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
return exports
