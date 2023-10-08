local fallout = require("fallout")
local reputation = require("lib.reputation")

local start
local critter_p_proc
local destroy_p_proc
local look_at_p_proc
local talk_p_proc
local Jason01
local Jason02
local Jason03
local Jason04
local Jason05
local Jason06
local Jason07
local Jason08
local Jason09
local Jason10
local Jason11
local Jason12
local Jason13
local Jason14
local Jason15
local Jason16
local Jason17
local Jason18
local Jason19
local Jason20
local Jason21
local Jason22
local Jason23
local follow_player

local following = 0
local initialized = 0

function start()
    if not(initialized) then
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 49)
        initialized = 1
    else
        if fallout.script_action() == 12 then
            critter_p_proc()
        else
            if fallout.script_action() == 18 then
                destroy_p_proc()
            else
                if fallout.script_action() == 21 then
                    look_at_p_proc()
                else
                    if fallout.script_action() == 11 then
                        talk_p_proc()
                    end
                end
            end
        end
    end
end

function critter_p_proc()
    if following then
        follow_player()
    end
end

function destroy_p_proc()
    reputation.inc_good_critter()
end

function look_at_p_proc()
    fallout.script_overrides()
    if not(fallout.local_var(1)) then
        fallout.display_msg(fallout.message_str(382, 101))
    else
        fallout.display_msg(fallout.message_str(382, 100))
    end
end

function talk_p_proc()
    fallout.start_gdialog(382, fallout.self_obj(), 4, -1, -1)
    fallout.gsay_start()
    if fallout.cur_map_index() == 45 then
        if following then
            Jason23()
        else
            Jason19()
        end
    end
    if fallout.local_var(0) then
        Jason18()
    else
        if fallout.local_var(1) then
            Jason16()
        else
            Jason01()
        end
    end
    fallout.gsay_end()
    fallout.end_dialogue()
end

function Jason01()
    fallout.gsay_reply(382, 102)
    fallout.giq_option(4, 382, 103, Jason05, 50)
    fallout.giq_option(4, 382, 104, Jason13, 50)
    fallout.giq_option(4, 382, 105, Jason08, 50)
    fallout.giq_option(4, 382, 106, Jason07, 50)
    fallout.giq_option(-3, 382, 107, Jason02, 50)
end

function Jason02()
    fallout.gsay_message(382, 108, 50)
end

function Jason03()
    fallout.gsay_message(382, 109, 50)
    fallout.gsay_message(382, 110, 50)
end

function Jason04()
    fallout.gsay_message(382, 111, 50)
    fallout.gsay_message(382, 112, 50)
end

function Jason05()
    fallout.gsay_reply(382, 113)
    fallout.giq_option(4, 382, 114, Jason06, 50)
    fallout.giq_option(4, 382, 115, Jason14, 50)
end

function Jason06()
    fallout.gsay_reply(382, 116)
    fallout.giq_option(4, 382, 117, Jason07, 50)
    fallout.giq_option(4, 382, 118, Jason08, 50)
    fallout.giq_option(6, 382, 119, Jason15, 50)
end

function Jason07()
    fallout.gsay_reply(382, 120)
    fallout.giq_option(4, 382, 121, Jason12, 50)
    fallout.giq_option(4, 382, 122, Jason08, 50)
end

function Jason08()
    fallout.gsay_reply(382, 123)
    fallout.giq_option(4, 382, 124, Jason12, 50)
end

function Jason09()
    fallout.gsay_reply(382, 125)
    fallout.giq_option(4, 382, 126, Jason10, 50)
    fallout.giq_option(4, 382, 127, Jason11, 50)
end

function Jason10()
    fallout.gsay_message(382, 128, 50)
end

function Jason11()
    fallout.gsay_message(382, 129, 50)
end

function Jason12()
    fallout.gsay_message(382, 130, 50)
end

function Jason13()
    fallout.gsay_message(382, 131, 50)
    fallout.set_local_var(0, 1)
end

function Jason14()
    fallout.gsay_message(382, 132, 50)
    Jason10()
end

function Jason15()
    fallout.gsay_message(382, 133, 50)
    Jason11()
end

function Jason16()
    fallout.gsay_reply(382, 134)
    fallout.giq_option(4, 382, 135, Jason08, 50)
    fallout.giq_option(4, 382, 136, Jason17, 50)
end

function Jason17()
    fallout.gsay_message(382, 137, 50)
end

function Jason18()
    fallout.gsay_message(382, 138, 50)
end

function Jason19()
    fallout.gsay_reply(382, 139)
    fallout.giq_option(-3, 382, 140, Jason20, 50)
    fallout.giq_option(4, 382, 141, Jason20, 50)
    fallout.giq_option(4, 382, 142, Jason21, 50)
    fallout.giq_option(4, 382, 143, Jason22, 50)
end

function Jason20()
    fallout.gsay_message(382, 144, 50)
    fallout.critter_add_trait(fallout.self_obj(), 1, 6, 0)
    following = 1
end

function Jason21()
    fallout.gsay_message(382, 145, 50)
end

function Jason22()
    fallout.gsay_reply(382, 146)
    fallout.giq_option(4, 382, 147, Jason20, 50)
    fallout.giq_option(4, 382, 148, Jason21, 50)
end

function Jason23()
    fallout.gsay_message(382, 149, 50)
end

function follow_player()
    if fallout.tile_distance_objs(fallout.self_obj(), fallout.dude_obj()) > 7 then
        fallout.animate_move_obj_to_tile(fallout.self_obj(), fallout.tile_num(fallout.dude_obj()), 1)
    else
        if fallout.tile_distance_objs(fallout.self_obj(), fallout.dude_obj()) > 3 then
            fallout.animate_move_obj_to_tile(fallout.self_obj(), fallout.tile_num(fallout.dude_obj()), 0)
        else
            fallout.animate_move_obj_to_tile(fallout.self_obj(), fallout.tile_num(fallout.self_obj()), 0)
        end
    end
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
exports.talk_p_proc = talk_p_proc
return exports
