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
local flee_dude
local Duc01
local Duc02
local Duc03
local Duc04
local Duc05
local Duc06
local Duc07
local Duc08
local Duc09
local Duc10
local DucBarter
local DucEnd

local known = 0
local initialized = 0
local Tandi_seed = 0
local Tandi_rescued = 0

local exit_line = 0

function start()
    if not(initialized) then
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 2)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 6)
        known = fallout.global_var(333)
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
    if (fallout.global_var(289) == 1) and (fallout.tile_distance_objs(fallout.dude_obj(), fallout.self_obj()) < 8) then
        flee_dude()
    end
end

function damage_p_proc()
    fallout.set_global_var(289, 1)
end

function destroy_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        reputation.inc_good_critter()
    end
    fallout.set_global_var(331, 1)
    fallout.set_global_var(289, 1)
end

function look_at_p_proc()
    fallout.script_overrides()
    if not(known) then
        fallout.display_msg(fallout.message_str(243, 100))
    else
        fallout.display_msg(fallout.message_str(243, 101))
    end
end

function pickup_p_proc()
    fallout.set_global_var(289, 1)
end

function talk_p_proc()
    if fallout.global_var(289) == 1 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(669, fallout.random(100, 105)), 0)
    else
        fallout.start_gdialog(243, fallout.self_obj(), 4, -1, -1)
        fallout.gsay_start()
        reaction.get_reaction()
        if (fallout.global_var(26) == 1) and (Tandi_seed == 0) then
            Duc09()
        else
            if (fallout.global_var(26) == 2) and (Tandi_rescued == 0) then
                Duc10()
            else
                if not(known) then
                    if fallout.local_var(1) > 1 then
                        Duc01()
                    else
                        Duc06()
                    end
                else
                    if fallout.local_var(1) > 1 then
                        Duc07()
                    else
                        Duc08()
                    end
                end
            end
        end
        fallout.gsay_end()
        fallout.end_dialogue()
    end
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

function Duc01()
    fallout.gsay_reply(243, 102)
    known = 1
    fallout.set_global_var(333, known)
    fallout.giq_option(4, 243, 103, Duc02, 50)
    fallout.giq_option(4, 243, 104, Duc03, 50)
    fallout.giq_option(-3, 243, 105, Duc04, 50)
end

function Duc02()
    fallout.gsay_reply(243, 106)
    fallout.giq_option(0, 634, 106, DucBarter, 49)
end

function Duc03()
    fallout.gsay_reply(243, 107)
    fallout.giq_option(4, 243, 108, Duc05, 50)
    fallout.giq_option(4, 243, 109, DucEnd, 50)
end

function Duc04()
    fallout.gsay_message(243, 110, 50)
end

function Duc05()
    fallout.gsay_message(243, 111, 50)
    fallout.game_time_advance(fallout.game_ticks(86400))
    if fallout.global_var(68) < 1 then
        fallout.set_global_var(68, 1)
    end
    fallout.load_map(26, 1)
end

function Duc06()
    fallout.gsay_reply(243, 113)
    fallout.giq_option(4, 243, 114, Duc04, 51)
    fallout.giq_option(4, 243, fallout.message_str(243, 115) .. fallout.proto_data(fallout.obj_pid(fallout.dude_obj()), 1) .. fallout.message_str(243, 116), Duc08, 50)
    fallout.giq_option(-3, 243, 117, Duc04, 50)
end

function Duc07()
    fallout.gsay_reply(243, 118)
    fallout.giq_option(4, 243, 119, Duc05, 50)
    fallout.giq_option(4, 243, 120, Duc02, 50)
    fallout.giq_option(4, 243, 121, DucEnd, 50)
end

function Duc08()
    fallout.gsay_reply(243, 122)
    known = 1
    fallout.set_global_var(333, known)
    fallout.giq_option(6, 243, 123, DucEnd, 50)
    fallout.giq_option(6, 243, 124, Duc02, 50)
    fallout.giq_option(-3, 243, 125, Duc04, 50)
end

function Duc09()
    fallout.gsay_message(243, 126, 50)
    Tandi_seed = 1
end

function Duc10()
    fallout.gsay_message(243, 127, 49)
    Tandi_rescued = 1
    reaction.UpReact()
end

function DucBarter()
    fallout.gdialog_mod_barter(0)
    fallout.giq_option(0, 634, 100, DucEnd, 50)
end

function DucEnd()
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
