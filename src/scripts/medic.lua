local fallout = require("fallout")
local reaction = require("lib.reaction")
local reputation = require("lib.reputation")

local start
local critter_p_proc
local damage_p_proc
local destroy_p_proc
local look_at_p_proc
local pickup_p_proc
local talk_p_proc
local Medic00
local Medic01
local Medic02
local Medic03
local Medic04
local Medic04a
local Medic05
local Medic06
local Medic07
local Medic08
local Medic08a
local Medic09
local Medic10
local Medic11
local Medic12
local Medic13
local Medic14
local Medic15
local Medic16
local Medic17
local Medic18
local Medic19
local Medic20
local Medic21
local Medic22
local Medic23
local Medic24
local flee_dude
local pushdrugs
local medicend

local damage = 0
local intensity = 0
local removal = 0
local rndx = 0
local rads = 0
local initialized = 0
local player_hits = 0
local player_max_hits = 0
local home_tile = 13881

local exit_line = 0

function start()
    if not(initialized) then
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 1)
        initialized = 1
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

function critter_p_proc()
    if fallout.local_var(5) then
        if fallout.tile_distance_objs(fallout.self_obj(), fallout.dude_obj()) < 8 then
            flee_dude()
        else
            if fallout.tile_distance(fallout.tile_num(fallout.dude_obj()), home_tile) > 4 then
                fallout.animate_move_obj_to_tile(fallout.self_obj(), home_tile, 0)
            end
        end
    else
        if fallout.tile_num(fallout.self_obj()) ~= home_tile then
            fallout.animate_move_obj_to_tile(fallout.self_obj(), home_tile, 0)
        end
    end
end

function damage_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.set_local_var(4, 1)
        fallout.set_local_var(5, 1)
    end
end

function destroy_p_proc()
    reputation.inc_good_critter()
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.set_global_var(261, 1)
    end
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(184, 136))
end

function pickup_p_proc()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(184, 160), 0)
    fallout.set_local_var(5, 1)
end

function talk_p_proc()
    if not(fallout.local_var(4)) then
        reaction.get_reaction()
        fallout.start_gdialog(184, fallout.self_obj(), 4, -1, -1)
        fallout.gsay_start()
        player_hits = fallout.get_critter_stat(fallout.dude_obj(), 35)
        player_max_hits = fallout.get_critter_stat(fallout.dude_obj(), 7)
        if (fallout.local_var(5) == 1) or (fallout.global_var(261) == 1) then
            Medic00()
        else
            damage = player_max_hits - player_hits
            if damage > 7 then
                Medic03()
            else
                if fallout.global_var(101) == 2 then
                    Medic24()
                else
                    Medic04()
                end
            end
        end
        fallout.gsay_end()
        fallout.end_dialogue()
    else
        fallout.display_msg(fallout.message_str(184, 159))
    end
end

function Medic00()
    fallout.gsay_reply(184, 100)
    fallout.giq_option(4, 184, 101, Medic01, -10)
    fallout.giq_option(-3, 184, 102, Medic02, -10)
end

function Medic01()
    fallout.set_local_var(4, 1)
    fallout.gsay_message(184, 103, -10)
end

function Medic02()
    fallout.set_local_var(4, 1)
    fallout.gsay_message(184, 104, -10)
end

function Medic03()
    fallout.gsay_message(184, 105, 0)
    Medic16()
end

function Medic04()
    fallout.gsay_reply(184, fallout.message_str(184, 106) .. fallout.proto_data(fallout.obj_pid(fallout.dude_obj()), 1) .. fallout.message_str(184, 107))
    fallout.giq_option(4, 184, 108, Medic06, 0)
    fallout.giq_option(4, 184, 109, Medic04a, 0)
    fallout.giq_option(-3, 184, 110, Medic05, 0)
end

function Medic04a()
    if damage > 3 then
        Medic14()
    else
        Medic13()
    end
end

function Medic05()
    fallout.gsay_message(184, 111, 0)
    pushdrugs()
end

function Medic06()
    fallout.gsay_message(184, 112, 0)
end

function Medic07()
    fallout.gsay_reply(184, 113)
    fallout.giq_option(4, 184, 114, Medic04a, 0)
    fallout.giq_option(4, 184, 115, Medic08, 0)
    fallout.giq_option(4, 184, 116, Medic11, 0)
    fallout.giq_option(-3, 184, 117, Medic12, 0)
    fallout.giq_option(-3, 184, 118, Medic15, 0)
end

function Medic08()
    fallout.gsay_reply(184, 119)
    fallout.giq_option(4, 184, 120, medicend, 0)
    fallout.giq_option(6, 184, 121, Medic08a, 0)
end

function Medic08a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        Medic10()
    else
        Medic09()
    end
end

function Medic09()
    fallout.gsay_message(184, 122, 0)
end

function Medic10()
    fallout.gsay_reply(184, 123)
    fallout.giq_option(4, 184, 124, pushdrugs, 0)
end

function Medic11()
    fallout.gsay_message(184, 125, 0)
end

function Medic12()
    fallout.gsay_reply(184, 126)
    Medic04a()
end

function Medic13()
    fallout.gsay_message(184, 127, 0)
end

function Medic14()
    fallout.gsay_message(184, 128, 0)
    Medic16()
end

function Medic15()
    fallout.gsay_message(184, 129, 0)
end

function Medic16()
    fallout.gsay_reply(184, 130)
    Medic17()
end

function Medic17()
    fallout.gfade_out(600)
    fallout.game_time_advance(fallout.game_ticks(damage * 10))
    fallout.critter_heal(fallout.dude_obj(), damage)
    fallout.gfade_in(600)
    fallout.gsay_message(184, 131, 0)
    if fallout.get_critter_stat(fallout.dude_obj(), 37) > 30 then
        Medic18()
    end
end

function Medic18()
    removal = 70 + fallout.random(1, 6) + fallout.random(1, 6) + fallout.random(1, 6)
    rads = fallout.get_critter_stat(fallout.dude_obj(), 37)
    rndx = rads * 20
    if rads > 400 then
        intensity = fallout.message_str(184, 132)
    else
        if rads > 200 then
            intensity = fallout.message_str(184, 133)
        else
            if rads > 100 then
                intensity = fallout.message_str(184, 134)
            else
                if rads > 30 then
                    intensity = fallout.message_str(184, 135)
                end
            end
        end
    end
    fallout.gsay_reply(184, intensity)
    fallout.giq_option(4, 184, 138, Medic19, 0)
    fallout.giq_option(4, 184, 139, Medic22, 0)
    fallout.giq_option(4, 184, 140, Medic20, 0)
    fallout.giq_option(6, 184, 141, Medic21, 0)
    fallout.giq_option(-3, 184, 142, Medic19, 0)
    fallout.giq_option(-3, 184, 143, Medic22, 0)
end

function Medic19()
    fallout.gsay_message(184, 144, 0)
end

function Medic20()
    fallout.gsay_reply(184, fallout.message_str(184, 145) .. rndx .. fallout.message_str(184, 146))
    fallout.giq_option(4, 184, 147, Medic19, 0)
    fallout.giq_option(4, 184, 148, Medic22, 0)
end

function Medic21()
    fallout.gsay_reply(184, fallout.message_str(184, 149) .. rndx .. fallout.message_str(184, 150) .. removal .. fallout.message_str(184, 151))
    fallout.giq_option(4, 184, 152, Medic19, 0)
    fallout.giq_option(4, 184, 153, Medic22, 0)
end

function Medic22()
    fallout.gsay_message(184, fallout.random(154, 155), 0)
    Medic23()
    fallout.radiation_inc(fallout.dude_obj(), -removal)
end

function Medic23()
    fallout.gfade_out(600)
    fallout.game_time_advance(fallout.game_ticks(rndx))
    fallout.gfade_in(600)
    fallout.gsay_message(184, 156, 0)
end

function Medic24()
    fallout.gsay_reply(184, 157)
    fallout.giq_option(4, 184, 109, Medic04a, 50)
    fallout.giq_option(4, 634, 103, medicend, 50)
    fallout.giq_option(-3, 184, 110, Medic05, 50)
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
    fallout.animate_move_obj_to_tile(fallout.self_obj(), v0, 1)
end

function pushdrugs()
    local v0 = 0
    v0 = fallout.create_object_sid(40, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), v0)
end

function medicend()
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.damage_p_proc = damage_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
return exports
