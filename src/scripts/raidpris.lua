local fallout = require("fallout")
local reaction = require("lib.reaction")
local reputation = require("lib.reputation")

local start
local do_dialogue
local prisoner00
local prisoner01
local prisoner02
local prisoner03
local prisoner04
local prisonerend
local Critter_Action
local damage_p_proc

local hostile = 0
local initialized = false

local exit_line = 0

function start()
    if not initialized then
        initialized = true
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 6)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 20)
    end
    if fallout.script_action() == 11 then
        do_dialogue()
    else
        if fallout.script_action() == 21 then
            fallout.script_overrides()
            fallout.display_msg(fallout.message_str(138, 100))
        else
            if fallout.script_action() == 12 then
                Critter_Action()
                if hostile then
                    hostile = 0
                    fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
                end
            else
                if fallout.script_action() == 4 then
                    hostile = 1
                else
                    if fallout.script_action() == 14 then
                        damage_p_proc()
                    else
                        if fallout.script_action() == 18 then
                            reputation.inc_evil_critter()
                            fallout.set_global_var(254, 1)
                            fallout.set_global_var(611, 0)
                            fallout.set_global_var(115, fallout.global_var(115) - 1)
                        end
                    end
                end
            end
        end
    end
end

function do_dialogue()
    fallout.set_local_var(3, 1)
    reaction.get_reaction()
    fallout.start_gdialog(138, fallout.self_obj(), 4, -1, -1)
    fallout.gsay_start()
    if fallout.local_var(4) then
        prisoner03()
    else
        fallout.set_local_var(4, 1)
        prisoner00()
    end
    fallout.gsay_end()
    fallout.end_dialogue()
end

function prisoner00()
    fallout.gsay_reply(138, 101)
    fallout.giq_option(4, 138, 102, prisoner01, 50)
    fallout.giq_option(6, 138, 103, prisoner02, 50)
    fallout.giq_option(-3, 138, 104, prisoner01, 50)
end

function prisoner01()
    fallout.set_local_var(4, 1)
    fallout.gsay_message(138, 105, 50)
end

function prisoner02()
    fallout.gsay_reply(138, 106)
    fallout.giq_option(4, 138, 107, prisonerend, 50)
    fallout.giq_option(4, 138, 108, prisonerend, 50)
end

function prisoner03()
    fallout.gsay_message(138, 109, 50)
end

function prisoner04()
    fallout.gsay_message(138, 110, 50)
end

function prisonerend()
end

function Critter_Action()
    local v0 = 0
    if fallout.global_var(26) == 2 then
        fallout.set_global_var(254, 1)
    else
        if fallout.global_var(116) then
            fallout.set_global_var(254, 0)
            if fallout.tile_distance_objs(fallout.self_obj(), fallout.dude_obj()) < 3 then
                v0 = fallout.tile_num_in_direction(fallout.tile_num(fallout.self_obj()), fallout.random(0, 5), 3)
                if fallout.tile_distance(fallout.tile_num(fallout.self_obj()), v0) > 2 then
                    if fallout.random(0, 9) == 0 then
                        fallout.float_msg(fallout.self_obj(), fallout.message_str(136, fallout.random(102, 106)), 8)
                    end
                    fallout.animate_move_obj_to_tile(fallout.self_obj(), v0, 0)
                end
            end
        else
            if fallout.global_var(213) then
                fallout.set_global_var(254, 1)
            end
            if fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) then
                if fallout.global_var(214) then
                    fallout.set_global_var(254, 1)
                end
            end
            if fallout.map_var(2) == 1 then
                fallout.set_global_var(254, 1)
            end
        end
    end
    if fallout.global_var(254) and fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) then
        hostile = 1
    end
    if fallout.tile_distance_objs(fallout.self_obj(), fallout.dude_obj()) > 12 then
        hostile = 0
    end
end

function damage_p_proc()
    if fallout.global_var(116) == 0 then
        fallout.set_global_var(254, 1)
    end
end

local exports = {}
exports.start = start
exports.damage_p_proc = damage_p_proc
return exports
