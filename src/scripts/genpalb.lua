local fallout = require("fallout")
local reputation = require("lib.reputation")

local start
local combat_p_proc
local critter_p_proc
local destroy_p_proc
local pickup_p_proc
local talk_p_proc
local GenPalB00
local GenPalB01
local GenPalB02
local GenPalB03
local GenPalB04
local GenPalB05
local GenPalB06
local GenPalB07
local GenPalB08
local GenPalB09
local GenPalB10
local GenPalB10a
local GenPalB11
local GenPalB12
local GenPalB13
local GenPalB14
local GenPalB15
local GenPalB16
local GenPalB17
local GenPalB18
local GenPalB19
local GenPalB20
local GenPalB20a
local GenPalB21
local GenPalB22
local GenPalB23
local GenPalB24
local GenPalB25
local flee_dude

local annoyed = 0
local hostile = 0
local initialized = 0
local known = 0
local round_counter = 0
local scared = 0

function start()
    if not(initialized) then
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 44)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 65)
        hostile = fallout.global_var(334)
        initialized = 1
    else
        if fallout.script_action() == 13 then
            combat_p_proc()
        else
            if fallout.script_action() == 12 then
                critter_p_proc()
            else
                if fallout.script_action() == 18 then
                    destroy_p_proc()
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

function combat_p_proc()
    if fallout.fixed_param() == 4 then
        round_counter = round_counter + 1
        if fallout.get_critter_stat(fallout.self_obj(), 35) < 10 then
            scared = 1
        end
    end
end

function critter_p_proc()
    if scared then
        if fallout.tile_distance_objs(fallout.self_obj(), fallout.dude_obj()) < 8 then
            flee_dude()
        end
    else
        if hostile then
            hostile = 0
            fallout.set_external_var("random_seed_1", 1)
            fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
        end
    end
end

function destroy_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.set_external_var("random_seed_1", 1)
        reputation.inc_good_critter()
        fallout.set_global_var(250, 1)
    end
end

function pickup_p_proc()
    if not(scared) then
        hostile = 1
        fallout.set_global_var(334, 1)
    end
end

function talk_p_proc()
    if known then
        if annoyed then
            GenPalB23()
        else
            fallout.start_gdialog(759, fallout.self_obj(), 4, -1, -1)
            fallout.gsay_start()
            GenPalB24()
            fallout.gsay_end()
            fallout.end_dialogue()
        end
    else
        if scared then
            GenPalB01()
        else
            if (fallout.external_var("random_seed_1") == 1) or (fallout.global_var(250) == 1) then
                GenPalB00()
            else
                fallout.start_gdialog(759, fallout.self_obj(), 4, -1, -1)
                fallout.gsay_start()
                if fallout.global_var(45) == 2 then
                    GenPalB02()
                else
                    if fallout.global_var(74) >= 1 then
                        if fallout.global_var(155) >= 20 then
                            GenPalB03()
                        else
                            GenPalB04()
                        end
                    else
                        if (fallout.global_var(155) < 20) or (((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1))) or (fallout.global_var(158) > 2) then
                            GenPalB06()
                        else
                            GenPalB05()
                        end
                    end
                end
                fallout.gsay_end()
                fallout.end_dialogue()
            end
        end
    end
end

function GenPalB00()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(759, 100), 2)
    hostile = 1
    fallout.set_global_var(334, 1)
end

function GenPalB01()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(759, 101), 2)
end

function GenPalB02()
    known = 1
    fallout.gsay_reply(759, 102)
    fallout.giq_option(7, 759, 103, GenPalB07, 50)
    fallout.giq_option(4, 759, 104, GenPalB08, 50)
    fallout.giq_option(4, 759, 105, GenPalB09, 50)
    fallout.giq_option(4, 759, 106, GenPalB10, 50)
    fallout.giq_option(-3, 759, 107, GenPalB11, 50)
end

function GenPalB03()
    known = 1
    fallout.gsay_reply(759, 108)
    fallout.giq_option(7, 759, 109, GenPalB12, 50)
    fallout.giq_option(4, 759, 110, GenPalB13, 50)
    fallout.giq_option(4, 759, 111, GenPalB14, 50)
    fallout.giq_option(4, 759, 112, GenPalB15, 50)
    fallout.giq_option(4, 759, 113, GenPalB16, 50)
    fallout.giq_option(-3, 759, 114, GenPalB11, 50)
end

function GenPalB04()
    known = 1
    annoyed = 1
    fallout.gsay_message(759, 115, 51)
end

function GenPalB05()
    known = 1
    fallout.gsay_reply(759, 116)
    if (fallout.global_var(101) == 0) and (fallout.obj_is_carrying_obj_pid(fallout.dude_obj(), 55) == 0) then
        fallout.giq_option(4, 759, fallout.message_str(759, 117) .. fallout.proto_data(fallout.obj_pid(fallout.dude_obj()), 1) .. fallout.message_str(759, 118), GenPalB17, 50)
    end
    fallout.giq_option(4, 759, fallout.message_str(759, 117) .. fallout.proto_data(fallout.obj_pid(fallout.dude_obj()), 1) .. fallout.message_str(759, 119), GenPalB18, 50)
    fallout.giq_option(4, 759, fallout.message_str(759, 117) .. fallout.proto_data(fallout.obj_pid(fallout.dude_obj()), 1) .. fallout.message_str(759, 120), GenPalB19, 50)
    fallout.giq_option(4, 759, fallout.message_str(759, 117) .. fallout.proto_data(fallout.obj_pid(fallout.dude_obj()), 1) .. fallout.message_str(759, 121), GenPalB21, 50)
    fallout.giq_option(4, 759, 122, GenPalB21, 51)
    fallout.giq_option(-3, 759, 123, GenPalB22, 50)
end

function GenPalB06()
    known = 1
    annoyed = 1
    fallout.gsay_message(759, 124, 51)
end

function GenPalB07()
    fallout.gsay_message(759, 125, 50)
end

function GenPalB08()
    fallout.gsay_message(759, 126, 50)
end

function GenPalB09()
    fallout.gsay_message(759, 127, 50)
end

function GenPalB10()
    fallout.gsay_reply(759, 128)
    fallout.giq_option(0, 634, 106, GenPalB10a, 50)
end

function GenPalB10a()
    fallout.gsay_message(759, 129, 50)
end

function GenPalB11()
    fallout.gsay_message(759, 130, 50)
end

function GenPalB12()
    fallout.gsay_reply(759, 131)
    if (fallout.global_var(101) == 0) and (fallout.obj_is_carrying_obj_pid(fallout.dude_obj(), 55) == 0) then
        fallout.giq_option(4, 759, 132, GenPalB17, 50)
    end
    fallout.giq_option(4, 759, 133, GenPalB18, 50)
    fallout.giq_option(4, 759, 134, GenPalB19, 50)
    fallout.giq_option(4, 759, 135, GenPalB20, 50)
    fallout.giq_option(4, 759, 122, GenPalB21, 50)
end

function GenPalB13()
    known = 1
    annoyed = 1
    fallout.gsay_message(759, 136, 51)
end

function GenPalB14()
    fallout.gsay_message(759, 137, 50)
end

function GenPalB15()
    fallout.gsay_message(759, 138, 50)
end

function GenPalB16()
    fallout.gsay_message(759, 139, 50)
    fallout.gfade_out(600)
    fallout.game_time_advance(fallout.game_ticks(fallout.random(86400, 172800)))
    fallout.load_map(13, 0)
    fallout.gfade_in(600)
end

function GenPalB17()
    fallout.gsay_message(759, 140, 50)
end

function GenPalB18()
    fallout.gsay_message(759, 141, 50)
end

function GenPalB19()
    annoyed = 1
    fallout.gsay_message(759, 142, 51)
end

function GenPalB20()
    fallout.gsay_reply(759, 143)
    fallout.giq_option(0, 634, 106, GenPalB20a, 50)
end

function GenPalB20a()
    fallout.gsay_message(759, 144, 50)
end

function GenPalB21()
    hostile = 1
    fallout.set_global_var(334, 1)
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        fallout.gsay_message(759, 145, 51)
    else
        fallout.gsay_message(759, 146, 51)
    end
end

function GenPalB22()
    fallout.gsay_message(759, 147, 50)
end

function GenPalB23()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(759, 148), 2)
end

function GenPalB24()
    fallout.gsay_reply(759, 149)
    if (fallout.global_var(101) == 0) and (fallout.obj_is_carrying_obj_pid(fallout.dude_obj(), 55) == 0) then
        fallout.giq_option(4, 759, 132, GenPalB17, 50)
    end
    fallout.giq_option(4, 759, 133, GenPalB18, 50)
    fallout.giq_option(4, 759, 150, GenPalB25, 50)
    fallout.giq_option(4, 759, 135, GenPalB20, 50)
    fallout.giq_option(4, 759, 122, GenPalB21, 51)
end

function GenPalB25()
    annoyed = 1
    fallout.gsay_message(759, 151, 51)
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

local exports = {}
exports.start = start
exports.combat_p_proc = combat_p_proc
exports.critter_p_proc = critter_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
return exports
