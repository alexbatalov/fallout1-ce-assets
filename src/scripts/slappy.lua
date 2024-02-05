local fallout = require("fallout")
local misc = require("lib.misc")
local reaction = require("lib.reaction")
local reputation = require("lib.reputation")
local time = require("lib.time")

local start
local critter_p_proc
local pickup_p_proc
local talk_p_proc
local destroy_p_proc
local look_at_p_proc
local Slappy01
local Slappy02
local Slappy03
local Slappy04
local Slappy05
local Slappy06
local Slappy07
local Slappy08
local Slappy09
local Slappy10
local Slappy11
local SlappyEnd
local SlappyClaw

local hostile = false
local initialized = false
local lastBabble = 0

function start()
    if not initialized then
        local self_obj = fallout.self_obj()
        misc.set_team(self_obj, 41)
        fallout.critter_add_trait(self_obj, 1, 5, 53)
        initialized = true
    end

    local script_action = fallout.script_action()
    if script_action == 21 then
        look_at_p_proc()
    elseif script_action == 4 then
        pickup_p_proc()
    elseif script_action == 11 then
        talk_p_proc()
    elseif script_action == 12 then
        critter_p_proc()
    elseif script_action == 18 then
        destroy_p_proc()
    end
end

function critter_p_proc()
    local dude_obj = fallout.dude_obj()
    local self_obj = fallout.self_obj()
    local self_tile_num = fallout.tile_num(fallout.self_obj())
    if hostile then
        hostile = false
        fallout.attack(dude_obj, 0, 1, 0, 0, 30000, 0, 0)
    end
    if fallout.tile_distance_objs(self_obj, dude_obj) <= 20 then
        if time.game_time_in_seconds() - lastBabble >= 10 then
            lastBabble = time.game_time_in_seconds()
            fallout.float_msg(self_obj, fallout.message_str(842, fallout.random(101, 107)), 2)
        end
    end
    if self_tile_num == 25131 then
        fallout.reg_anim_func(1, 1)
        fallout.reg_anim_obj_move_to_tile(self_obj, 25331, -1)
        fallout.reg_anim_func(3, 0)
    elseif self_tile_num == 25331 then
        fallout.reg_anim_func(1, 1)
        fallout.reg_anim_obj_move_to_tile(self_obj, 25132, -1)
        fallout.reg_anim_func(3, 0)
    elseif self_tile_num == 25132 then
        fallout.reg_anim_func(1, 1)
        fallout.reg_anim_obj_move_to_tile(self_obj, 24932, -1)
        fallout.reg_anim_func(3, 0)
    elseif self_tile_num == 24932 then
        fallout.reg_anim_func(1, 1)
        fallout.reg_anim_obj_move_to_tile(self_obj, 25131, -1)
        fallout.reg_anim_func(3, 0)
    end
end

function pickup_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        hostile = true
    end
end

function talk_p_proc()
    reaction.get_reaction()
    if fallout.global_var(226) == 5 then
        Slappy10()
    else
        fallout.start_gdialog(842, fallout.self_obj(), 4, -1, -1)
        fallout.gsay_start()
        Slappy01()
        fallout.gsay_end()
        fallout.end_dialogue()
    end
end

function destroy_p_proc()
    reputation.inc_good_critter()
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(842, 100))
end

function Slappy01()
    fallout.gsay_reply(842, 108)
    if fallout.global_var(226) == 3 then
        fallout.giq_option(4, 842, 109, Slappy03, 50)
    end
    if fallout.global_var(226) == 2 then
        fallout.giq_option(4, 842, 110, Slappy11, 50)
    end
    fallout.giq_option(4, 842, 111, Slappy04, 50)
    fallout.giq_option(4, 842, 112, Slappy05, 50)
    fallout.giq_option(-3, 842, 113, Slappy02, 50)
end

function Slappy02()
    fallout.gsay_reply(842, 114)
    fallout.giq_option(-3, 842, 115, SlappyEnd, 50)
end

function Slappy03()
    fallout.gsay_reply(842, 116)
    fallout.giq_option(4, 842, 117, Slappy06, 50)
    fallout.giq_option(4, 842, 118, Slappy05, 50)
    fallout.giq_option(4, 842, 119, Slappy09, 50)
end

function Slappy04()
    fallout.gsay_reply(842, 120)
    fallout.giq_option(4, 842, 121, Slappy08, 50)
    fallout.giq_option(4, 842, 122, SlappyEnd, 50)
end

function Slappy05()
    fallout.gsay_reply(842, 123)
    fallout.giq_option(4, 842, 124, SlappyEnd, 50)
end

function Slappy06()
    fallout.gsay_reply(842, 125)
    fallout.giq_option(4, 842, 126, Slappy07, 50)
    fallout.giq_option(4, 842, 127, SlappyEnd, 50)
end

function Slappy07()
    fallout.gsay_reply(842, 128)
    fallout.giq_option(4, 842, 129, SlappyClaw, 50)
    fallout.giq_option(4, 842, 130, SlappyEnd, 50)
end

function Slappy08()
    fallout.gsay_reply(842, 131)
    fallout.giq_option(4, 842, 132, SlappyEnd, 50)
end

function Slappy09()
    fallout.gsay_message(842, 133, 50)
end

function Slappy10()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(842, 134), 2)
end

function Slappy11()
    fallout.gsay_reply(842, 135)
    fallout.giq_option(4, 842, 136, SlappyEnd, 50)
end

function SlappyEnd()
end

function SlappyClaw()
    if fallout.local_var(4) == 0 then
        fallout.set_local_var(4, 1)
        fallout.give_exp_points(800)
        fallout.display_msg(fallout.message_str(766, 103) .. 800 .. fallout.message_str(766, 104))
    end
    fallout.load_map(37, 0)
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
return exports
