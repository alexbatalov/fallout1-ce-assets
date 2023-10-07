local fallout = require("fallout")

local start
local map_enter_p_proc
local map_update_p_proc
local map_exit_p_proc
local Lighting
local Darkness
local AddInBlades
local add_party
local update_party
local remove_party

local party_elevation = 0
local dude_start_hex = 0

fallout.create_external_var("local Ian_ptr")
fallout.create_external_var("local Dog_ptr")
fallout.create_external_var("local Tycho_ptr")
fallout.create_external_var("local Katja_ptr")
fallout.create_external_var("local Tandi_ptr")
fallout.create_external_var("local warned")
fallout.create_external_var("local AdyStor1_ptr")
fallout.create_external_var("local AdyStor2_ptr")
fallout.create_external_var("local Tine_barter")
fallout.create_external_var("local JonPtr")
fallout.create_external_var("local InBladePtr1")
fallout.create_external_var("local InBladePtr2")
fallout.create_external_var("local InBladePtr3")
fallout.create_external_var("local InBladePtr4")
fallout.create_external_var("local InBladePtr5")
fallout.create_external_var("local InBladePtr6")
fallout.create_external_var("local InBladePtr7")
fallout.create_external_var("local InBladePtr8")
fallout.create_external_var("local RazorPtr")
fallout.create_external_var("local RegGuard1")
fallout.create_external_var("local RegGuard2")

local Invasion

function start()
    if fallout.script_action() == 15 then
        map_enter_p_proc()
    else
        if fallout.script_action() == 23 then
            map_update_p_proc()
        else
            if fallout.script_action() == 16 then
                map_exit_p_proc()
            end
        end
    end
end

function map_enter_p_proc()
    if fallout.metarule(14, 0) then
        fallout.display_msg(fallout.message_str(194, 115))
    end
    fallout.set_global_var(594, 1)
    Lighting()
    fallout.override_map_start(100, 53, 0, 2)
    add_party()
end

function map_update_p_proc()
    if fallout.elevation(fallout.dude_obj()) == 1 then
        Darkness()
    else
        Lighting()
    end
    add_party()
    if (fallout.global_var(613) == 9103) and (fallout.map_var(2) == 0) and (fallout.global_var(266) == 1) then
        AddInBlades()
        fallout.gfade_in(600)
    else
        if (fallout.global_var(613) == 9104) and (fallout.map_var(2) == 0) then
            fallout.set_map_var(2, 1)
            fallout.kill_critter(fallout.external_var("JonPtr"), 0)
            fallout.kill_critter_type(16777216 + 3, 0)
            fallout.kill_critter_type(16777216 + 27, 0)
            fallout.kill_critter_type(16777216 + 36, 0)
            fallout.kill_critter_type(16777216 + 112, 0)
            fallout.kill_critter_type(16777216 + 215, 0)
            fallout.kill_critter_type(16777216 + 244, 0)
            fallout.kill_critter_type(16777216 + 245, 0)
            fallout.kill_critter_type(16777216 + 246, 0)
            fallout.kill_critter_type(16777216 + 247, 0)
            fallout.kill_critter_type(16777216 + 248, 0)
            fallout.kill_critter_type(16777216 + 249, 0)
            fallout.kill_critter_type(16777216 + 250, 0)
            fallout.kill_critter_type(16777216 + 251, 0)
            fallout.kill_critter_type(16777216 + 252, 0)
            fallout.kill_critter_type(16777216 + 253, 0)
            fallout.kill_critter_type(16777216 + 254, 0)
            fallout.kill_critter_type(16777216 + 255, 0)
            fallout.kill_critter_type(16777216 + 256, 0)
            fallout.kill_critter_type(16777216 + 257, 0)
            fallout.kill_critter_type(16777216 + 258, 0)
            fallout.kill_critter_type(16777216 + 259, 0)
            fallout.kill_critter_type(16777216 + 260, 0)
            fallout.kill_critter_type(16777216 + 261, 0)
            fallout.kill_critter_type(16777216 + 262, 0)
            fallout.kill_critter_type(16777216 + 263, 0)
            fallout.critter_attempt_placement(fallout.external_var("RazorPtr"), 12700, 0)
            fallout.set_global_var(613, 2)
            fallout.set_global_var(155, fallout.global_var(155) + 2)
            fallout.display_msg(fallout.message_str(766, 103) .. 2000 .. fallout.message_str(766, 104))
            fallout.give_exp_points(2000)
        else
            if (fallout.map_var(1) == 0) and (fallout.global_var(613) == 9103) then
                fallout.gfade_out(600)
                fallout.kill_critter_type(16777216 + 268, 0)
                fallout.critter_attempt_placement(fallout.external_var("RazorPtr"), 12700, 0)
                fallout.set_global_var(613, 2)
                fallout.set_global_var(352, 1)
                fallout.set_global_var(155, fallout.global_var(155) + 2)
                fallout.display_msg(fallout.message_str(766, 103) .. 2000 .. fallout.message_str(766, 104))
                fallout.give_exp_points(2000)
                fallout.gfade_in(600)
            else
                if (fallout.map_var(1) == 0) and (fallout.global_var(613) ~= 2) and (fallout.global_var(351) == 1) then
                    fallout.set_global_var(613, 2)
                    fallout.set_global_var(350, 1)
                end
            end
        end
    end
end

function map_exit_p_proc()
    remove_party()
end

function Lighting()
    local v0 = 0
    v0 = fallout.game_time_hour()
    if (v0 >= 600) and (v0 < 700) then
        fallout.set_light_level(v0 - 600 + 40)
    else
        if (v0 >= 700) and (v0 < 1800) then
            fallout.set_light_level(100)
        else
            if (v0 >= 1800) and (v0 < 1900) then
                fallout.set_light_level(100 - (v0 - 1800))
            else
                fallout.set_light_level(40)
            end
        end
    end
end

function Darkness()
    fallout.set_light_level(40)
end

function AddInBlades()
    fallout.set_map_var(2, 1)
    fallout.critter_attempt_placement(fallout.external_var("InBladePtr1"), 9702, 0)
    fallout.critter_attempt_placement(fallout.external_var("InBladePtr2"), 9700, 0)
    fallout.critter_attempt_placement(fallout.external_var("InBladePtr3"), 9698, 0)
    fallout.critter_attempt_placement(fallout.external_var("InBladePtr4"), 9895, 0)
    fallout.critter_attempt_placement(fallout.external_var("InBladePtr5"), 9696, 0)
    fallout.critter_attempt_placement(fallout.external_var("InBladePtr6"), 26717, 0)
    fallout.critter_attempt_placement(fallout.external_var("InBladePtr7"), 26711, 0)
    fallout.critter_attempt_placement(fallout.external_var("InBladePtr8"), 24492, 0)
end

function add_party()
    local v0 = 0
    local v1 = 0
    party_elevation = fallout.elevation(fallout.dude_obj())
    if fallout.global_var(26) == 5 then
        if fallout.external_var("Tandi_ptr") == 0 then
        end
        fallout.critter_add_trait(fallout.external_var("Tandi_ptr"), 1, 6, 0)
    end
end

function update_party()
    local v0 = 0
    local v1 = 0
    if fallout.elevation(fallout.dude_obj()) ~= party_elevation then
        party_elevation = fallout.elevation(fallout.dude_obj())
        if fallout.global_var(118) == 2 then
            if fallout.external_var("Ian_ptr") == 0 then
            else
                fallout.move_to(fallout.external_var("Ian_ptr"), fallout.tile_num_in_direction(fallout.tile_num(fallout.dude_obj()), 1, 2), fallout.elevation(fallout.dude_obj()))
            end
        end
        if fallout.global_var(5) then
            if fallout.external_var("Dog_ptr") == 0 then
            else
                fallout.move_to(fallout.external_var("Dog_ptr"), fallout.tile_num_in_direction(fallout.tile_num(fallout.dude_obj()), 2, 1), fallout.elevation(fallout.dude_obj()))
            end
        end
        if fallout.global_var(121) == 2 then
            if fallout.external_var("Tycho_ptr") == 0 then
            else
                fallout.move_to(fallout.external_var("Tycho_ptr"), fallout.tile_num_in_direction(fallout.tile_num(fallout.dude_obj()), 3, 2), fallout.elevation(fallout.dude_obj()))
            end
        end
        if fallout.global_var(244) == 2 then
            if fallout.external_var("Katja_ptr") == 0 then
            else
                fallout.move_to(fallout.external_var("Katja_ptr"), fallout.tile_num_in_direction(fallout.tile_num(fallout.dude_obj()), 4, 2), fallout.elevation(fallout.dude_obj()))
            end
        end
        if fallout.global_var(26) == 5 then
            if fallout.external_var("Tandi_ptr") == 0 then
            else
                fallout.move_to(fallout.external_var("Tandi_ptr"), fallout.tile_num_in_direction(fallout.tile_num(fallout.dude_obj()), 4, 4), fallout.elevation(fallout.dude_obj()))
            end
        end
    end
end

function remove_party()
    if fallout.global_var(118) == 2 then
        fallout.set_global_var(118, 2)
    end
    if fallout.global_var(5) then
        fallout.set_global_var(5, 1)
    end
    if fallout.global_var(121) == 2 then
        fallout.set_global_var(121, 2)
    end
    if fallout.global_var(244) == 2 then
        fallout.set_global_var(244, 2)
    end
    if fallout.global_var(26) == 5 then
    end
end

function Invasion()
    if not(fallout.global_var(18) == 2) then
        if fallout.global_var(149) > (fallout.game_time() // (10 * 60 * 60 * 24)) then
            fallout.set_global_var(13, 1)
        end
        if fallout.global_var(150) > (fallout.game_time() // (10 * 60 * 60 * 24)) then
            fallout.set_global_var(14, 1)
        end
        if fallout.global_var(151) > (fallout.game_time() // (10 * 60 * 60 * 24)) then
            fallout.set_global_var(16, 1)
        end
        if fallout.global_var(152) > (fallout.game_time() // (10 * 60 * 60 * 24)) then
            fallout.set_global_var(15, 1)
        end
        if fallout.global_var(153) > (fallout.game_time() // (10 * 60 * 60 * 24)) then
            fallout.set_global_var(12, 1)
        end
        if fallout.global_var(154) <= 0 then
            fallout.set_global_var(11, 1)
        end
        if fallout.global_var(148) > (fallout.game_time() // (10 * 60 * 60 * 24)) then
            fallout.set_global_var(7, 1)
        end
    end
end

local exports = {}
exports.start = start
exports.map_enter_p_proc = map_enter_p_proc
exports.map_update_p_proc = map_update_p_proc
exports.map_exit_p_proc = map_exit_p_proc
return exports
