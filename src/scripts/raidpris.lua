local fallout = require("fallout")
local misc = require("lib.misc")
local reaction = require("lib.reaction")
local reputation = require("lib.reputation")

local start
local pickup_p_proc
local talk_p_proc
local destroy_p_proc
local look_at_p_proc
local prisoner00
local prisoner01
local prisoner02
local prisoner03
local prisoner04
local prisonerend
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
    if script_action == 11 then
        talk_p_proc()
    elseif script_action == 21 then
        look_at_p_proc()
    elseif script_action == 12 then
        critter_p_proc()
    elseif script_action == 4 then
        pickup_p_proc()
    elseif script_action == 14 then
        damage_p_proc()
    elseif script_action == 18 then
        destroy_p_proc()
    end
end

function pickup_p_proc()
    hostile = true
end

function talk_p_proc()
    fallout.set_local_var(3, 1)
    reaction.get_reaction()
    fallout.start_gdialog(138, fallout.self_obj(), 4, -1, -1)
    fallout.gsay_start()
    if fallout.local_var(4) ~= 0 then
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

function critter_p_proc()
    local self_obj = fallout.self_obj()
    local dude_obj = fallout.dude_obj()
    local distance_self_to_dude = fallout.tile_distance_objs(self_obj, dude_obj)
    if fallout.global_var(26) == 2 then
        fallout.set_global_var(254, 1)
    else
        if fallout.global_var(116) ~= 0 then
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
            if fallout.obj_can_see_obj(self_obj, dude_obj) then
                if fallout.global_var(214) ~= 0 then
                    fallout.set_global_var(254, 1)
                end
            end
            if fallout.map_var(2) == 1 then
                fallout.set_global_var(254, 1)
            end
        end
    end
    if fallout.global_var(254) ~= 0 and fallout.obj_can_see_obj(self_obj, dude_obj) then
        hostile = true
    end
    if distance_self_to_dude > 12 then
        hostile = false
    end
    if hostile then
        hostile = false
        fallout.attack(dude_obj, 0, 1, 0, 0, 30000, 0, 0)
    end
end

function damage_p_proc()
    if fallout.global_var(116) == 0 then
        fallout.set_global_var(254, 1)
    end
end

function destroy_p_proc()
    reputation.inc_evil_critter()
    fallout.set_global_var(254, 1)
    fallout.set_global_var(611, 0)
    fallout.set_global_var(115, fallout.global_var(115) - 1)
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(138, 100))
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
