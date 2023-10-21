local fallout = require("fallout")
local reaction = require("lib.reaction")
local reputation = require("lib.reputation")

local start
local do_dialogue
local petrox00
local petrox01
local petrox02
local petrox03
local petrox04
local petrox05
local petrox06
local petrox07
local petrox08
local petrox09
local petrox10
local petroxend
local talk_p_proc
local combat
local Critter_Action
local damage_p_proc

local HOSTILE = 0
local initialized = false

local exit_line = 0

function start()
    if not initialized then
        initialized = true
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 6)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 20)
    end
    if fallout.script_action() == 11 then
        talk_p_proc()
    else
        if fallout.script_action() == 21 then
            fallout.script_overrides()
            fallout.display_msg(fallout.message_str(139, 100))
        else
            if fallout.script_action() == 4 then
                HOSTILE = 1
            else
                if fallout.script_action() == 12 then
                    Critter_Action()
                    if HOSTILE then
                        HOSTILE = 0
                        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
                    end
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
    fallout.start_gdialog(139, fallout.self_obj(), 4, -1, -1)
    fallout.gsay_start()
    if fallout.local_var(4) == 5 then
        petrox10()
    else
        fallout.set_local_var(4, fallout.local_var(4) + 1)
        petrox00()
    end
    fallout.gsay_end()
    fallout.end_dialogue()
end

function petrox00()
    fallout.gsay_reply(139, 101)
    fallout.giq_option(4, 139, fallout.message_str(139, 102) .. fallout.proto_data(fallout.obj_pid(fallout.dude_obj()), 1) .. fallout.message_str(139, 103), petrox01, 50)
    fallout.giq_option(5, 139, 104, petrox02, 50)
    fallout.giq_option(-3, 139, 105, petrox03, 50)
end

function petrox01()
    fallout.gsay_reply(139, 106)
    fallout.giq_option(4, 139, 107, petrox04, 50)
    fallout.giq_option(4, 139, 108, petroxend, 50)
    fallout.giq_option(4, 139, 109, petrox05, 50)
end

function petrox02()
    fallout.gsay_reply(139, 110)
    fallout.giq_option(4, 139, 111, petrox07, 50)
    fallout.giq_option(4, 139, 112, petrox08, 50)
end

function petrox03()
    fallout.gsay_message(139, 113, 50)
end

function petrox04()
    fallout.gsay_reply(139, 114)
    fallout.giq_option(4, 139, 115, petrox06, 50)
    fallout.giq_option(4, 139, 116, petroxend, 50)
end

function petrox05()
    fallout.gsay_reply(139, 117)
    fallout.giq_option(4, 139, 118, petrox07, 50)
    fallout.giq_option(4, 139, 119, petrox08, 50)
end

function petrox06()
    fallout.gsay_message(139, 120, 50)
    combat()
end

function petrox07()
    fallout.gsay_reply(139, 121)
    fallout.giq_option(4, 139, 122, petrox08, 50)
end

function petrox08()
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 1 then
        fallout.gsay_reply(139, 124)
        fallout.giq_option(4, 139, 125, petrox09, 50)
        fallout.giq_option(4, 139, 127, petrox09, 50)
    else
        fallout.gsay_message(139, 123, 50)
    end
end

function petrox09()
    fallout.gsay_message(139, 126, 50)
end

function petrox10()
    fallout.gsay_message(139, 128, 50)
end

function petroxend()
end

function talk_p_proc()
    if fallout.global_var(116) == 1 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(136, fallout.random(102, 106)), 8)
    else
        do_dialogue()
    end
end

function combat()
    if fallout.global_var(116) == 1 then
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 87)
    end
    HOSTILE = 1
end

function Critter_Action()
    local v0 = 0
    if fallout.global_var(26) == 2 then
        fallout.set_global_var(254, 1)
    else
        if fallout.global_var(116) ~= 0 then
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
            if fallout.global_var(213) ~= 0 then
                fallout.set_global_var(254, 1)
            end
            if fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) then
                if fallout.global_var(214) ~= 0 then
                    fallout.set_global_var(254, 1)
                end
            end
            if fallout.map_var(2) == 1 then
                fallout.set_global_var(254, 1)
            end
        end
    end
    if fallout.global_var(254) and fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) then
        HOSTILE = 1
    end
    if fallout.tile_distance_objs(fallout.self_obj(), fallout.dude_obj()) > 12 then
        HOSTILE = 0
    end
end

function damage_p_proc()
    if fallout.global_var(116) == 0 then
        fallout.set_global_var(254, 1)
    end
end

local exports = {}
exports.start = start
exports.talk_p_proc = talk_p_proc
exports.damage_p_proc = damage_p_proc
return exports
