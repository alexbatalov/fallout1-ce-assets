local fallout = require("fallout")
local misc = require("lib.misc")
local reputation = require("lib.reputation")
local time = require("lib.time")

local initialized = false
local hostile = false
local round_counter = 0
local alert_tile = 0
local night_tile = 0

local start
local combat_p_proc
local critter_p_proc
local damage_p_proc
local destroy_p_proc
local pickup_p_proc
local talk_p_proc
local GenSupr00
local GenSupr03
local GenSupr03a
local GenSupr03b
local GenSupr04
local GenSupr05
local GenSupr06
local GenSupr07
local GenSupr08
local GenSuprAlert
local GenSuprxx
local set_alert_tile

function start()
    if not initialized then
        local self_obj = fallout.self_obj()
        misc.set_team(self_obj, 34)
        misc.set_ai(self_obj, 48)
        set_alert_tile()
        if fallout.global_var(146) ~= 0 then
            fallout.move_to(self_obj, alert_tile, 1)
        else
            if time.is_night() then
                fallout.move_to(self_obj, night_tile, 1)
            end
        end
        initialized = true
    end

    local script_action = fallout.script_action()
    if script_action == 13 then
        combat_p_proc()
    elseif script_action == 12 then
        critter_p_proc()
    elseif script_action == 14 then
        damage_p_proc()
    elseif script_action == 18 then
        destroy_p_proc()
    elseif script_action == 4 then
        pickup_p_proc()
    elseif script_action == 11 then
        talk_p_proc()
    end
end

function combat_p_proc()
    if fallout.fixed_param() == 4 then
        round_counter = round_counter + 1
    end
    if round_counter > 2 then
        GenSuprAlert()
    end
    if fallout.fixed_param() == 2 then
        if fallout.global_var(276) ~= 0 then
            if fallout.random(0, 3) == 3 then
                fallout.critter_injure(fallout.dude_obj(), 1)
            end
        end
    end
end

function critter_p_proc()
    local dude_obj = fallout.dude_obj()
    local self_obj = fallout.self_obj()
    if hostile and fallout.obj_can_see_obj(self_obj, dude_obj) then
        hostile = false
        fallout.attack(dude_obj, 0, 1, 0, 0, 30000, 0, 0)
    else
        if fallout.obj_can_see_obj(self_obj, dude_obj) then
            if fallout.global_var(146) ~= 0 then
                hostile = true
            else
                if fallout.external_var("ignoring_dude") == 0 then
                    if fallout.tile_distance_objs(self_obj, dude_obj) < 12 then
                        fallout.dialogue_system_enter()
                    end
                end
            end
        end
        if fallout.global_var(146) ~= 0 then
            if fallout.elevation(self_obj) == 0 then
                if fallout.tile_num(self_obj) ~= 14520 then
                    fallout.animate_move_obj_to_tile(self_obj, 14520, 0)
                else
                    fallout.move_to(self_obj, 14520, 1)
                end
            else
                if fallout.tile_num(self_obj) ~= alert_tile then
                    fallout.animate_move_obj_to_tile(self_obj, alert_tile, 0)
                end
            end
        else
            if time.is_night() then
                if fallout.elevation(self_obj) == 0 then
                    if fallout.tile_num(self_obj) ~= 14520 then
                        fallout.animate_move_obj_to_tile(self_obj, 14520, 0)
                    else
                        fallout.move_to(self_obj, 14520, 1)
                    end
                else
                    if fallout.tile_num(self_obj) ~= night_tile then
                        fallout.animate_move_obj_to_tile(self_obj, night_tile, 0)
                    end
                end
            else
                if fallout.tile_num(self_obj) ~= fallout.local_var(4) then
                    fallout.animate_move_obj_to_tile(self_obj, fallout.local_var(4), 0)
                end
            end
        end
    end
    if fallout.global_var(273) >= 1 and fallout.global_var(273) <= 3 then
        fallout.kill_critter(self_obj, 35)
    end
end

function damage_p_proc()
    fallout.set_external_var("radio_room_attacked", 1)
end

function destroy_p_proc()
    reputation.inc_evil_critter()
end

function pickup_p_proc()
    hostile = true
end

function talk_p_proc()
    if fallout.global_var(54) ~= 0 then
        GenSupr08()
    else
        if misc.is_armed(fallout.dude_obj()) and not hostile then
            if fallout.random(0, 5) == 5 then
                GenSupr00()
            else
                hostile = true
            end
        else
            fallout.start_gdialog(433, fallout.self_obj(), 4, -1, -1)
            fallout.gsay_start()
            GenSupr03()
            fallout.gsay_end()
            fallout.end_dialogue()
        end
    end
end

function GenSupr00()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(433, fallout.random(101, 103)), 0)
    hostile = true
end

function GenSupr03()
    fallout.gsay_reply(433, fallout.random(104, 106))
    fallout.giq_option(-3, 433, 107, GenSupr04, 0)
    fallout.giq_option(4, 433, 108, GenSupr04, 0)
    fallout.giq_option(5, 433, 109, GenSupr05, 0)
    fallout.giq_option(6, 433, 110, GenSupr03a, 0)
    if misc.is_wearing_coc_robe(fallout.dude_obj()) then
        fallout.giq_option(6, 433, 111, GenSupr03b, 0)
    end
end

function GenSupr03a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        GenSupr07()
    else
        GenSupr06()
    end
end

function GenSupr03b()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 25)) then
        GenSupr07()
    else
        GenSupr06()
    end
end

function GenSupr04()
    hostile = true
    fallout.gsay_message(433, fallout.random(112, 114), 0)
end

function GenSupr05()
    fallout.gsay_reply(433, 115)
    fallout.giq_option(5, 433, 116, GenSuprxx, 0)
    fallout.giq_option(5, 433, 117, GenSuprAlert, 0)
end

function GenSupr06()
    hostile = true
    fallout.gsay_message(433, fallout.random(118, 120), 0)
end

function GenSupr07()
    fallout.set_external_var("ignoring_dude", 1)
    fallout.gsay_message(433, fallout.random(121, 123), 0)
end

function GenSupr08()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(433, fallout.random(124, 127)), 0)
    hostile = true
end

function GenSuprAlert()
    fallout.set_global_var(146, 1)
    hostile = true
end

function GenSuprxx()
    fallout.set_global_var(57, 2)
    fallout.load_map(32, 5)
end

function set_alert_tile()
    local tile_num = fallout.local_var(4)
    if tile_num == 0 then
        tile_num = fallout.tile_num(fallout.self_obj())
        fallout.set_local_var(4, tile_num)
    end
    if tile_num == 23065 then
        alert_tile = 21917
        night_tile = 26274
    elseif tile_num == 22466 then
        alert_tile = 21922
        night_tile = 27476
    elseif tile_num == 22470 then
        alert_tile = 22318
        night_tile = 27472
    end
end

local exports = {}
exports.start = start
exports.combat_p_proc = combat_p_proc
exports.critter_p_proc = critter_p_proc
exports.damage_p_proc = damage_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
return exports
