local fallout = require("fallout")
local misc = require("lib.misc")
local reaction = require("lib.reaction")
local reputation = require("lib.reputation")

local start
local pickup_p_proc
local do_dialogue
local destroy_p_proc
local look_at_p_proc
local gwen00
local gwen01
local gwen02
local gwen03
local gwen04
local gwen05
local gwen06
local gwen07
local gwen08
local gwen10
local gwenend
local talk_p_proc
local combat
local critter_p_proc
local damage_p_proc

local hostile = false
local initialized = false

function start()
    if not initialized then
        local self_obj = fallout.self_obj()
        misc.set_team(self_obj, 6)
        fallout.critter_add_trait(self_obj, 1, 5, 20)
        initialized = true
    end

    local script_action = fallout.script_action()
    if script_action == 21 then
        look_at_p_proc()
    elseif script_action == 11 then
        -- FIXME: Conflicts with `talk_p_proc`.
        do_dialogue()
    elseif script_action == 4 then
        pickup_p_proc()
    elseif script_action == 12 then
        critter_p_proc()
    elseif script_action == 14 then
        damage_p_proc()
    elseif script_action == 18 then
        destroy_p_proc()
    end
end

function pickup_p_proc()
    hostile = true
end

function do_dialogue()
    fallout.set_local_var(3, 1)
    reaction.get_reaction()
    fallout.start_gdialog(141, fallout.self_obj(), 4, -1, -1)
    fallout.gsay_start()
    if fallout.local_var(4) == 5 then
        gwen10()
    else
        fallout.set_local_var(4, fallout.local_var(4) + 1)
        gwen00()
    end
    fallout.gsay_end()
    fallout.end_dialogue()
end

function destroy_p_proc()
    reputation.inc_evil_critter()
    fallout.set_global_var(254, 1)
    fallout.set_global_var(611, 0)
    fallout.set_global_var(115, fallout.global_var(115) - 1)
end

function look_at_p_proc()
    fallout.display_msg(fallout.message_str(141, 100))
    fallout.script_overrides()
end

function gwen00()
    fallout.gsay_reply(141, 101)
    fallout.giq_option(3, 141,
        fallout.message_str(141, 102) ..
        fallout.proto_data(fallout.obj_pid(fallout.dude_obj()), 1) .. fallout.message_str(141, 103), gwen01, 50)
    fallout.giq_option(7, 141, 104, gwen02, 50)
    fallout.giq_option(-3, 141, 105, gwen03, 50)
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        fallout.giq_option(4, 141, 106, gwen07, 50)
    end
end

function gwen01()
    fallout.gsay_reply(141, 107)
    fallout.giq_option(4, 141, 108, gwen04, 50)
    fallout.giq_option(4, 141, 109, gwen08, 50)
    fallout.giq_option(4, 141, 110, gwen05, 50)
    fallout.giq_option(4, 141, 111, gwen06, 50)
end

function gwen02()
    fallout.gsay_message(141, 112, 50)
end

function gwen03()
    fallout.gsay_message(141, 113, 50)
end

function gwen04()
    fallout.gsay_reply(141, 114)
    fallout.giq_option(4, 141, 115, gwenend, 50)
    fallout.giq_option(4, 141, 116, combat, 50)
    fallout.giq_option(4, 141, 117, combat, 50)
end

function gwen05()
    fallout.gsay_message(141, 118, 50)
    combat()
end

function gwen06()
    fallout.gsay_message(141, 119, 50)
    combat()
end

function gwen07()
    fallout.gsay_message(141, 120, 50)
    combat()
end

function gwen08()
    fallout.gsay_message(141, 121, 50)
    combat()
end

function gwen10()
    fallout.gsay_message(141, 122, 50)
end

function gwenend()
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
        misc.set_team(fallout.self_obj(), 87)
    end
    hostile = true
end

function critter_p_proc()
    local self_obj = fallout.self_obj()
    local dude_obj = fallout.dude_obj()
    local distance_self_to_dude = fallout.tile_distance_objs(self_obj, dude_obj)
    local self_can_see_dude = fallout.obj_can_see_obj(self_obj, dude_obj)
    if fallout.global_var(26) == 2 then
        fallout.set_global_var(254, 1)
    elseif fallout.global_var(116) ~= 0 then
        fallout.set_global_var(254, 0)
        if distance_self_to_dude < 3 then
            local self_tile_num = fallout.tile_num(self_obj)
            local dest = fallout.tile_num_in_direction(self_tile_num, fallout.random(0, 5), 3)
            if fallout.tile_distance(self_tile_num, dest) > 2 then
                if fallout.random(0, 9) == 0 then
                    fallout.float_msg(self_obj, fallout.message_str(136, fallout.random(102, 106)), 8)
                end
                fallout.animate_move_obj_to_tile(self_obj, dest, 0)
            end
        end
    else
        if fallout.global_var(213) ~= 0 then
            fallout.set_global_var(254, 1)
        end
        if self_can_see_dude then
            if fallout.global_var(214) ~= 0 then
                fallout.set_global_var(254, 1)
            end
        end
        if fallout.map_var(2) == 1 then
            fallout.set_global_var(254, 1)
        end
    end
    if fallout.global_var(254) ~= 0 and self_can_see_dude then
        hostile = true
    end
    if distance_self_to_dude > 12 then
        hostile = false
    end
    if hostile then
        hostile = false
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    end
end

function damage_p_proc()
    if fallout.global_var(116) == 0 then
        fallout.set_global_var(254, 1)
    end
end

local exports = {}
exports.start = start
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.critter_p_proc = critter_p_proc
exports.damage_p_proc = damage_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
return exports
