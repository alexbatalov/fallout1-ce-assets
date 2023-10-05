local fallout = require("fallout")

local start
local do_dialogue
local mutant00
local mutant01
local mutant02
local combat
local Critter_Action

local Hostile = 0
local init_teams = 0
local noevent = 0
local loopcount = 0

function start()
    if not(init_teams) then
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 34)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 79)
        fallout.set_local_var(1, 0)
        init_teams = 1
    end
    if (fallout.script_action() == 11) and (fallout.global_var(35) < 1) then
        if fallout.global_var(306) == 0 then
            do_dialogue()
        else
            fallout.display_msg(fallout.message_str(80, 108))
        end
    else
        if fallout.script_action() == 21 then
            fallout.script_overrides()
            fallout.display_msg(fallout.message_str(80, 101))
        else
            if fallout.script_action() == 4 then
                Hostile = 1
            else
                if fallout.script_action() == 12 then
                    Critter_Action()
                else
                    if fallout.script_action() == 18 then
                        fallout.set_global_var(35, fallout.global_var(35) + 1)
                        if fallout.global_var(35) > fallout.global_var(551) then
                            fallout.set_global_var(155, fallout.global_var(155) + 3)
                            fallout.set_global_var(29, 2)
                            fallout.set_global_var(225, fallout.game_time() // (10 * 60 * 60 * 24))
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

function do_dialogue()
    mutant00()
end

function mutant00()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(80, 102), 3)
end

function mutant01()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(80, 103), 3)
    combat()
end

function mutant02()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(80, 107), 3)
    combat()
end

function combat()
    Hostile = 1
end

function Critter_Action()
    if (fallout.global_var(35) > 0) and fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) then
        Hostile = 1
    end
    if Hostile > 0 then
        Hostile = 0
        fallout.attack_complex(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    else
        if (fallout.global_var(306) == 1) and (fallout.tile_num(fallout.self_obj()) ~= 15507) then
            fallout.animate_move_obj_to_tile(fallout.self_obj(), 15507, 0)
        else
            if (fallout.global_var(306) == 1) and (fallout.tile_num(fallout.self_obj()) == 15507) then
                fallout.set_global_var(306, 2)
            else
                if (fallout.global_var(306) == 2) and (fallout.tile_num(fallout.self_obj()) ~= 12536) then
                    fallout.animate_move_obj_to_tile(fallout.self_obj(), 12536, 0)
                else
                    if (fallout.tile_num(fallout.self_obj()) == 12536) and (fallout.global_var(306) == 2) then
                        fallout.set_obj_visibility(fallout.self_obj(), 1)
                    end
                end
            end
        end
    end
end

local exports = {}
exports.start = start
return exports
