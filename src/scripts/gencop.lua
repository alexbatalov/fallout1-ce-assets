local fallout = require("fallout")
local reaction = require("lib.reaction")
local reputation = require("lib.reputation")

local start
local combat
local critter_p_proc
local pickup_p_proc
local talk_p_proc
local destroy_p_proc
local damage_p_proc
local combat_p_proc
local look_at_p_proc
local Cop00
local Cop01
local Cop02

local hostile = 0
local initialized = false

local exit_line = 0

function start()
    if not initialized then
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 40)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 86)
    end
    if fallout.script_action() == 21 then
        look_at_p_proc()
    else
        if fallout.script_action() == 4 then
            pickup_p_proc()
        else
            if fallout.script_action() == 11 then
                talk_p_proc()
            else
                if fallout.script_action() == 12 then
                    critter_p_proc()
                else
                    if fallout.script_action() == 18 then
                        destroy_p_proc()
                    end
                end
            end
        end
    end
end

function combat()
    hostile = 1
end

function critter_p_proc()
    if hostile then
        hostile = 0
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    end
    if fallout.global_var(248) == 1 then
        hostile = 1
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    end
end

function pickup_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        hostile = 1
    end
end

function talk_p_proc()
    reaction.get_reaction()
    if fallout.cur_map_index() == 36 then
        Cop01()
    else
        if fallout.cur_map_index() == 38 then
            Cop00()
        else
            Cop02()
        end
    end
end

function destroy_p_proc()
    reputation.inc_good_critter()
end

function damage_p_proc()
    local v0 = 0
    v0 = fallout.obj_pid(fallout.source_obj())
    if fallout.party_member_obj(v0) ~= 0 then
        fallout.set_global_var(248, 1)
    end
end

function combat_p_proc()
    if fallout.global_var(248) == 1 then
        hostile = 1
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    end
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(573, 100))
end

function Cop00()
    if fallout.random(0, 3) == 1 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(573, fallout.random(101, 106)), 2)
    else
        if fallout.global_var(158) > 2 then
            fallout.float_msg(fallout.self_obj(), fallout.message_str(573, fallout.random(113, 116)), 2)
        else
            if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1)) then
                if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
                    fallout.float_msg(fallout.self_obj(), fallout.message_str(573, fallout.random(110, 112)), 2)
                else
                    fallout.float_msg(fallout.self_obj(), fallout.message_str(573, fallout.random(110, 111)), 2)
                end
            else
                if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(160) > (3 * fallout.global_var(159))) or (fallout.global_var(157) == 1)) then
                    fallout.float_msg(fallout.self_obj(), fallout.message_str(573, fallout.random(117, 118)), 2)
                else
                    if (fallout.obj_item_subtype(fallout.critter_inven_obj(fallout.dude_obj(), 1)) == 3) or (fallout.obj_item_subtype(fallout.critter_inven_obj(fallout.dude_obj(), 2)) == 3) then
                        fallout.float_msg(fallout.self_obj(), fallout.message_str(573, fallout.random(107, 109)), 2)
                    else
                        if fallout.global_var(44) == 2 then
                            fallout.float_msg(fallout.self_obj(), fallout.message_str(573, 119), 2)
                        else
                            fallout.float_msg(fallout.self_obj(), fallout.message_str(573, fallout.random(101, 106)), 2)
                        end
                    end
                end
            end
        end
    end
end

function Cop01()
    if fallout.random(0, 3) == 1 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(573, fallout.random(120, 129)), 2)
    else
        if (fallout.obj_item_subtype(fallout.critter_inven_obj(fallout.dude_obj(), 1)) == 3) or (fallout.obj_item_subtype(fallout.critter_inven_obj(fallout.dude_obj(), 2)) == 3) then
            fallout.float_msg(fallout.self_obj(), fallout.message_str(573, fallout.random(130, 133)), 2)
        else
            if fallout.obj_pid(fallout.critter_inven_obj(fallout.dude_obj(), 0)) == 3 then
                fallout.float_msg(fallout.self_obj(), fallout.message_str(573, 134), 2)
            else
                if fallout.global_var(198) == 1 then
                    fallout.float_msg(fallout.self_obj(), fallout.message_str(573, fallout.random(135, 137)), 2)
                else
                    if fallout.global_var(201) == 1 then
                        fallout.float_msg(fallout.self_obj(), fallout.message_str(573, 138), 2)
                    else
                        if fallout.global_var(200) == 1 then
                            fallout.float_msg(fallout.self_obj(), fallout.message_str(573, 139), 2)
                        else
                            if fallout.global_var(199) == 1 then
                                fallout.float_msg(fallout.self_obj(), fallout.message_str(573, 140), 2)
                            else
                                if fallout.global_var(202) == 1 then
                                    fallout.float_msg(fallout.self_obj(), fallout.message_str(573, fallout.random(141, 143)), 2)
                                else
                                    fallout.float_msg(fallout.self_obj(), fallout.message_str(573, fallout.random(120, 129)), 2)
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

function Cop02()
    if fallout.random(0, 3) == 1 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(573, 144), 2)
    else
        if fallout.global_var(198) == 1 then
            fallout.float_msg(fallout.self_obj(), fallout.message_str(573, fallout.random(155, 157)), 2)
        else
            if fallout.global_var(201) == 1 then
                fallout.float_msg(fallout.self_obj(), fallout.message_str(573, 158), 2)
            else
                if fallout.global_var(200) == 1 then
                    fallout.float_msg(fallout.self_obj(), fallout.message_str(573, 159), 2)
                else
                    if fallout.global_var(199) == 1 then
                        fallout.float_msg(fallout.self_obj(), fallout.message_str(573, 160), 2)
                    else
                        if fallout.global_var(202) == 1 then
                            fallout.float_msg(fallout.self_obj(), fallout.message_str(573, fallout.random(161, 163)), 2)
                        else
                            fallout.float_msg(fallout.self_obj(), fallout.message_str(573, fallout.random(144, 154)), 2)
                        end
                    end
                end
            end
        end
    end
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.damage_p_proc = damage_p_proc
exports.combat_p_proc = combat_p_proc
exports.look_at_p_proc = look_at_p_proc
return exports
