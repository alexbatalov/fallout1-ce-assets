local fallout = require("fallout")
local reputation = require("lib.reputation")
local time = require("lib.time")

local start
local talk_p_proc
local critter_p_proc
local damage_p_proc
local destroy_p_proc
local look_at_p_proc
local end_employment
local hiring
local follow_player
local vasquez01
local vasquez00
local vasquezend
local vasquez10
local vasquez02
local vasquez03
local vasquez04
local vasquez05
local vasquez06
local vasquez07
local vasquez08
local vasquez09

local known = false
local warned = false
local following = false
local hire_date = 0

function start()
    local script_action = fallout.script_action()
    if script_action == 11 then
        talk_p_proc()
    elseif script_action == 18 then
        destroy_p_proc()
    elseif script_action == 21 or script_action == 3 then
        look_at_p_proc()
    elseif script_action == 12 then
        critter_p_proc()
    elseif script_action == 14 then
        damage_p_proc()
    end
end

function talk_p_proc()
    fallout.start_gdialog(436, fallout.self_obj(), 4, -1, -1)
    fallout.gsay_start()
    if following then
        vasquez06()
    else
        if known then
            vasquez07()
        else
            vasquez00()
        end
    end
    fallout.gsay_end()
    fallout.end_dialogue()
end

function critter_p_proc()
    if following then
        if time.game_time_in_days() - hire_date > 7 then
            end_employment()
        else
            follow_player()
        end
    end
end

function damage_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        if not warned then
            vasquez10()
        end
    end
end

function destroy_p_proc()
    reputation.inc_good_critter()
end

function look_at_p_proc()
    fallout.script_overrides()
    if known then
        fallout.display_msg(fallout.message_str(436, 100))
    else
        fallout.display_msg(fallout.message_str(436, 101))
    end
end

function end_employment()
    following = false
end

function hiring()
    vasquez05()
end

function follow_player()
    local dude_obj = fallout.dude_obj()
    local self_obj = fallout.self_obj()
    if fallout.tile_distance_objs(self_obj, dude_obj) > 3 then
        fallout.animate_move_obj_to_tile(self_obj, fallout.tile_num(dude_obj), 0)
    else
        if fallout.anim_busy(self_obj) ~= 0 then
            fallout.animate_move_obj_to_tile(self_obj, fallout.tile_num(self_obj), 0)
        end
    end
end

function vasquez01()
    fallout.gsay_message(436, 105, 50)
end

function vasquez00()
    fallout.gsay_reply(436, 102)
    fallout.giq_option(4, 436, 103, vasquez02, 50)
    fallout.giq_option(-3, 436, 104, vasquez01, 50)
end

function vasquezend()
end

function vasquez10()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(436, 126), 0)
    warned = true
end

function vasquez02()
    known = true
    fallout.gsay_reply(436, 106)
    fallout.giq_option(4, 436, 107, vasquez03, 50)
    fallout.giq_option(4, 436, 108, vasquezend, 50)
end

function vasquez03()
    fallout.gsay_reply(436, 109)
    fallout.giq_option(4, 436, 110, hiring, 50)
    fallout.giq_option(4, 436, 111, vasquezend, 50)
end

function vasquez04()
    fallout.gsay_message(436, 112, 50)
end

function vasquez05()
    fallout.gsay_message(436, 113, 50)
    following = true
    hire_date = time.game_time_in_days()
end

function vasquez06()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(436, fallout.random(114, 118)), 0)
end

function vasquez07()
    fallout.gsay_reply(436, 119)
    fallout.giq_option(4, 436, 120, vasquez09, 50)
    fallout.giq_option(4, 436, 121, vasquezend, 50)
    fallout.giq_option(-3, 436, 122, vasquez08, 50)
end

function vasquez08()
    fallout.gsay_message(436, 123, 50)
end

function vasquez09()
    fallout.gsay_reply(436, 124)
    fallout.giq_option(4, 436, 125, hiring, 50)
end

local exports = {}
exports.start = start
exports.talk_p_proc = talk_p_proc
exports.critter_p_proc = critter_p_proc
exports.damage_p_proc = damage_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
return exports
