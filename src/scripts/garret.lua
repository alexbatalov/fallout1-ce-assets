local fallout = require("fallout")

local start
local do_dialogue
local garretend
local garretcbt
local goodstuff
local neutstuff
local badstuff
local reward
local done
local garret00a
local garret00b
local garret00c
local garret00ca
local garret01a
local garret01c
local garret02a
local garret02c
local garret03c
local garret04
local give_flare
local give_cola

local Shotgun_ptr = 0
local Shells_ptr = 0
local Cola_ptr = 0
local Flare_ptr = 0
local Hostile = 0
local init = 0
local maxleash = 9
local noevent = 0
local loopcount = 0
local new_tile = 0
local gavelist = 0
local moving = 0
local stuff = 0
local indlog = 0
local robbed = 0
local flare_count = 0
local cola_count = 0
local cash = 0
local THRONE = 0
local target_hex = 20113
local my_hex = 0

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
    if not(init) then
        if fallout.local_var(7) == 0 then
            fallout.set_local_var(7, fallout.tile_num(fallout.self_obj()))
        end
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 30)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 78)
        fallout.set_external_var("Garret_ptr", fallout.self_obj())
        init = 1
    else
        if fallout.script_action() == 14 then
            fallout.set_global_var(249, 1)
        else
            if fallout.script_action() == 11 then
                do_dialogue()
            else
                if fallout.script_action() == 21 then
                    fallout.script_overrides()
                    fallout.display_msg(fallout.message_str(102, 100))
                else
                    if fallout.script_action() == 4 then
                        Hostile = 1
                    else
                        if fallout.script_action() == 12 then
                            if fallout.global_var(249) and fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) then
                                fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
                            else
                                my_hex = fallout.tile_num(fallout.self_obj())
                                if Hostile > 0 then
                                    fallout.set_global_var(249, 1)
                                    fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
                                end
                                if fallout.global_var(60) & 1 then
                                    if fallout.local_var(5) == 0 then
                                        moving = 1
                                        fallout.float_msg(fallout.self_obj(), fallout.message_str(102, 114), 0)
                                        fallout.set_local_var(5, 1)
                                    else
                                        if fallout.local_var(5) == 1 then
                                            moving = 1
                                            if my_hex ~= target_hex then
                                                fallout.animate_move_obj_to_tile(fallout.self_obj(), target_hex, 0)
                                            else
                                                fallout.set_local_var(5, 2)
                                                fallout.use_obj(fallout.external_var("Fridge_ptr"))
                                            end
                                        else
                                            if fallout.local_var(5) == 2 then
                                                moving = 1
                                                if fallout.tile_distance_objs(fallout.self_obj(), fallout.dude_obj()) < 5 then
                                                    reward()
                                                    fallout.set_local_var(5, 3)
                                                    fallout.use_obj(fallout.external_var("Fridge_ptr"))
                                                end
                                            else
                                                if fallout.local_var(5) == 3 then
                                                    moving = 1
                                                    target_hex = fallout.local_var(7)
                                                    if my_hex ~= target_hex then
                                                        fallout.animate_move_obj_to_tile(fallout.self_obj(), target_hex, 0)
                                                    else
                                                        done()
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        else
                            if fallout.script_action() == 18 then
                                fallout.set_global_var(249, 1)
                                fallout.set_global_var(607, 3)
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
                        end
                    end
                end
            end
        end
    end
end

function do_dialogue()
    if (fallout.local_var(8) == 0) and (fallout.global_var(60) & 2) then
        fallout.set_local_var(8, 1)
        fallout.float_msg(fallout.self_obj(), fallout.message_str(102, 201), 0)
        fallout.display_msg(fallout.message_str(102, 202))
        stuff = fallout.create_object_sid(38, 0, 0, -1)
        fallout.add_obj_to_inven(fallout.dude_obj(), stuff)
        stuff = fallout.create_object_sid(39, 0, 0, -1)
        fallout.add_obj_to_inven(fallout.dude_obj(), stuff)
        stuff = fallout.create_object_sid(87, 0, 0, -1)
        fallout.add_obj_to_inven(fallout.dude_obj(), stuff)
        stuff = fallout.create_object_sid(53, 0, 0, -1)
        fallout.add_obj_to_inven(fallout.dude_obj(), stuff)
        stuff = fallout.create_object_sid(40, 0, 0, -1)
        fallout.add_obj_to_inven(fallout.dude_obj(), stuff)
        stuff = fallout.create_object_sid(40, 0, 0, -1)
        fallout.add_obj_to_inven(fallout.dude_obj(), stuff)
        stuff = fallout.create_object_sid(25, 0, 0, -1)
        fallout.add_obj_to_inven(fallout.dude_obj(), stuff)
        stuff = fallout.create_object_sid(25, 0, 0, -1)
        fallout.add_obj_to_inven(fallout.dude_obj(), stuff)
        stuff = fallout.create_object_sid(26, 0, 0, -1)
        fallout.add_obj_to_inven(fallout.dude_obj(), stuff)
        stuff = fallout.create_object_sid(26, 0, 0, -1)
        fallout.add_obj_to_inven(fallout.dude_obj(), stuff)
        stuff = fallout.create_object_sid(27, 0, 0, -1)
        fallout.add_obj_to_inven(fallout.dude_obj(), stuff)
        stuff = fallout.create_object_sid(27, 0, 0, -1)
        fallout.add_obj_to_inven(fallout.dude_obj(), stuff)
        stuff = fallout.create_object_sid(35, 0, 0, -1)
        fallout.add_obj_to_inven(fallout.dude_obj(), stuff)
        stuff = fallout.create_object_sid(35, 0, 0, -1)
        fallout.add_obj_to_inven(fallout.dude_obj(), stuff)
        stuff = fallout.create_object_sid(35, 0, 0, -1)
        fallout.add_obj_to_inven(fallout.dude_obj(), stuff)
        stuff = fallout.create_object_sid(35, 0, 0, -1)
        fallout.add_obj_to_inven(fallout.dude_obj(), stuff)
        stuff = fallout.create_object_sid(36, 0, 0, -1)
        fallout.add_obj_to_inven(fallout.dude_obj(), stuff)
        stuff = fallout.create_object_sid(36, 0, 0, -1)
        fallout.add_obj_to_inven(fallout.dude_obj(), stuff)
        stuff = fallout.create_object_sid(36, 0, 0, -1)
        fallout.add_obj_to_inven(fallout.dude_obj(), stuff)
        stuff = fallout.create_object_sid(36, 0, 0, -1)
        fallout.add_obj_to_inven(fallout.dude_obj(), stuff)
    else
        if moving then
            fallout.display_msg(fallout.message_str(102, 200))
        else
            if (fallout.game_time_hour() >= 700) and (fallout.game_time_hour() < 1800) then
                get_reaction()
                if fallout.local_var(4) then
                    garret02a()
                else
                    fallout.set_local_var(4, 1)
                    if fallout.local_var(1) >= 2 then
                        garret04()
                    else
                        garret01a()
                    end
                end
            else
                garret00b()
            end
        end
    end
end

function garretend()
end

function garretcbt()
    Hostile = 1
end

function goodstuff()
    cash = cash + 100
    fallout.add_mult_objs_to_inven(fallout.dude_obj(), fallout.create_object_sid(41, 0, 0, -1), 100)
    neutstuff()
    badstuff()
end

function neutstuff()
    cash = cash + 50
    fallout.add_mult_objs_to_inven(fallout.dude_obj(), fallout.create_object_sid(41, 0, 0, -1), 50)
    if fallout.obj_is_carrying_obj_pid(fallout.external_var("Fridge_ptr"), 94) then
        fallout.display_msg(fallout.message_str(102, 204))
        Shotgun_ptr = fallout.obj_carrying_pid_obj(fallout.external_var("Fridge_ptr"), 94)
        fallout.rm_obj_from_inven(fallout.external_var("Fridge_ptr"), Shotgun_ptr)
        fallout.add_obj_to_inven(fallout.dude_obj(), Shotgun_ptr)
    else
        robbed = 1
    end
    if fallout.obj_is_carrying_obj_pid(fallout.external_var("Fridge_ptr"), 95) then
        fallout.display_msg(fallout.message_str(102, 205))
        Shells_ptr = fallout.obj_carrying_pid_obj(fallout.external_var("Fridge_ptr"), 95)
        fallout.rm_obj_from_inven(fallout.external_var("Fridge_ptr"), Shells_ptr)
        fallout.add_obj_to_inven(fallout.dude_obj(), Shells_ptr)
    else
        robbed = 1
    end
    if fallout.obj_is_carrying_obj_pid(fallout.external_var("Fridge_ptr"), 95) then
        Shells_ptr = fallout.obj_carrying_pid_obj(fallout.external_var("Fridge_ptr"), 95)
        fallout.rm_obj_from_inven(fallout.external_var("Fridge_ptr"), Shells_ptr)
        fallout.add_obj_to_inven(fallout.dude_obj(), Shells_ptr)
    else
        robbed = 1
    end
end

function badstuff()
    cash = cash + 50
    fallout.add_mult_objs_to_inven(fallout.dude_obj(), fallout.create_object_sid(41, 0, 0, -1), 50)
    flare_count = 0
    give_flare()
    give_flare()
    give_flare()
    give_flare()
    cola_count = 0
    give_cola()
    give_cola()
    give_cola()
    give_cola()
end

function reward()
    cash = 0
    robbed = 0
    fallout.display_msg(fallout.message_str(102, 203))
    if fallout.local_var(1) >= 3 then
        goodstuff()
    else
        if fallout.local_var(1) >= 2 then
            neutstuff()
        else
            badstuff()
        end
    end
    if flare_count then
        if flare_count > 1 then
            fallout.display_msg(fallout.message_str(102, 206))
        else
            fallout.display_msg(fallout.message_str(102, 207))
        end
    end
    if cola_count then
        if cola_count > 1 then
            fallout.display_msg(fallout.message_str(102, 208))
        else
            fallout.display_msg(fallout.message_str(102, 209))
        end
    end
    fallout.display_msg("$" .. cash)
    if robbed then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(102, 121), 0)
    else
        fallout.float_msg(fallout.self_obj(), fallout.message_str(102, 201), 0)
    end
end

function done()
    moving = 0
    fallout.set_local_var(5, 4)
end

function garret00a()
    fallout.gsay_reply(102, 101)
    fallout.giq_option(4, 102, 102, garretend, 50)
    fallout.giq_option(4, 102, 103, garret01a, 50)
    fallout.giq_option(5, 102, 104, garret02a, 50)
    fallout.giq_option(-3, 102, 112, garretend, 50)
end

function garret00b()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(102, 105), 0)
    garretend()
end

function garret00c()
    fallout.gsay_reply(102, 109)
    fallout.giq_option(3, 102, 110, garret01c, 50)
    fallout.giq_option(5, 102, 111, garret00ca, 50)
    fallout.giq_option(-3, 102, 112, garret02c, 50)
end

function garret00ca()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        garret03c()
    else
        garret02c()
    end
end

function garret01a()
    if indlog then
        fallout.gsay_message(102, 113, 50)
    else
        fallout.float_msg(fallout.self_obj(), fallout.message_str(102, 113), 0)
    end
    garretend()
end

function garret01c()
    fallout.gsay_message(102, 115, 50)
    DownReact()
    garretend()
end

function garret02a()
    DownReact()
    if indlog then
        fallout.gsay_message(102, 116, 50)
    else
        fallout.float_msg(fallout.self_obj(), fallout.message_str(102, 116), 0)
    end
    garretend()
end

function garret02c()
    fallout.gsay_message(102, 117, 50)
    garretend()
end

function garret03c()
    fallout.gsay_message(102, 118, 50)
    fallout.display_msg(fallout.message_str(102, 119))
    fallout.gsay_message(102, 120, 50)
    garretend()
end

function garret04()
    fallout.start_gdialog(102, fallout.self_obj(), 4, -1, -1)
    fallout.gsay_start()
    indlog = 1
    garret00a()
    indlog = 0
    fallout.gsay_end()
    fallout.end_dialogue()
end

function give_flare()
    if fallout.obj_is_carrying_obj_pid(fallout.external_var("Fridge_ptr"), 79) then
        flare_count = flare_count + 1
        Flare_ptr = fallout.obj_carrying_pid_obj(fallout.external_var("Fridge_ptr"), 79)
        fallout.rm_obj_from_inven(fallout.external_var("Fridge_ptr"), Flare_ptr)
        fallout.add_obj_to_inven(fallout.dude_obj(), Flare_ptr)
    else
        robbed = 1
    end
end

function give_cola()
    if fallout.obj_is_carrying_obj_pid(fallout.external_var("Fridge_ptr"), 106) then
        cola_count = cola_count + 1
        Cola_ptr = fallout.obj_carrying_pid_obj(fallout.external_var("Fridge_ptr"), 106)
        fallout.rm_obj_from_inven(fallout.external_var("Fridge_ptr"), Cola_ptr)
        fallout.add_obj_to_inven(fallout.dude_obj(), Cola_ptr)
    else
        robbed = 1
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
    exit_line = fallout.message_str(634, fallout.random(100, 105))
end

local exports = {}
exports.start = start
return exports
