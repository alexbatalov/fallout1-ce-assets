local fallout = require("fallout")
local misc = require("lib.misc")
local reaction = require("lib.reaction")
local reputation = require("lib.reputation")
local time = require("lib.time")

local start
local pickup_p_proc
local talk_p_proc
local critter_p_proc
local damage_p_proc
local destroy_p_proc
local look_at_p_proc
local garretend
local garretcbt
local goodstuff
local neutstuff
local badstuff
local reward
local done
local garret00a
local garret00b
local garret00c
local garret00ca
local garret01a
local garret01c
local garret02a
local garret02c
local garret03c
local garret04
local give_flare
local give_cola

local hostile = false
local initialized = false
local moving = false
local indlog = false
local robbed = false
local flare_count = 0
local cola_count = 0
local cash = 0
local target_hex = 20113

function start()
    if not initialized then
        local self_obj = fallout.self_obj()
        if fallout.local_var(7) == 0 then
            fallout.set_local_var(7, fallout.tile_num(self_obj))
        end
        misc.set_team(self_obj, 30)
        misc.set_ai(self_obj, 78)
        fallout.set_external_var("Garret_ptr", self_obj)
        initialized = true
    end

    local script_action = fallout.script_action()
    if script_action == 14 then
        damage_p_proc()
    elseif script_action == 11 then
        talk_p_proc()
    elseif script_action == 21 then
        look_at_p_proc()
    elseif script_action == 4 then
        pickup_p_proc()
    elseif script_action == 12 then
        critter_p_proc()
    elseif script_action == 18 then
        destroy_p_proc()
    end
end

function pickup_p_proc()
    hostile = true
end

local STUFF <const> = {
    [38] = 1,
    [39] = 1,
    [87] = 1,
    [53] = 1,
    [40] = 2,
    [25] = 2,
    [26] = 2,
    [27] = 2,
    [35] = 4,
    [36] = 4,
}

function talk_p_proc()
    if fallout.local_var(8) == 0 and fallout.global_var(60) & 2 ~= 0 then
        fallout.set_local_var(8, 1)
        fallout.float_msg(fallout.self_obj(), fallout.message_str(102, 201), 0)
        fallout.display_msg(fallout.message_str(102, 202))

        local dude_obj = fallout.dude_obj()
        for pid, qty in ipairs(STUFF) do
            local item_obj = fallout.create_object_sid(pid, 0, 0, -1)
            fallout.add_mult_objs_to_inven(dude_obj, item_obj, qty)
        end
    else
        if moving then
            fallout.display_msg(fallout.message_str(102, 200))
        else
            if time.is_day() then
                reaction.get_reaction()
                if fallout.local_var(4) ~= 0 then
                    garret02a()
                else
                    fallout.set_local_var(4, 1)
                    if fallout.local_var(1) >= 2 then
                        garret04()
                    else
                        garret01a()
                    end
                end
            else
                garret00b()
            end
        end
    end
end

function critter_p_proc()
    local self_obj = fallout.self_obj()
    local dude_obj = fallout.dude_obj()
    if fallout.global_var(249) and fallout.obj_can_see_obj(self_obj, dude_obj) then
        fallout.attack(dude_obj, 0, 1, 0, 0, 30000, 0, 0)
    else
        local self_tile_num = fallout.tile_num(self_obj)
        if hostile then
            fallout.set_global_var(249, 1)
            fallout.attack(dude_obj, 0, 1, 0, 0, 30000, 0, 0)
        end
        if fallout.global_var(60) & 1 ~= 0 then
            if fallout.local_var(5) == 0 then
                moving = true
                fallout.float_msg(self_obj, fallout.message_str(102, 114), 0)
                fallout.set_local_var(5, 1)
            elseif fallout.local_var(5) == 1 then
                moving = true
                if self_tile_num ~= target_hex then
                    fallout.animate_move_obj_to_tile(self_obj, target_hex, 0)
                else
                    fallout.set_local_var(5, 2)
                    fallout.use_obj(fallout.external_var("Fridge_ptr"))
                end
            elseif fallout.local_var(5) == 2 then
                moving = true
                if fallout.tile_distance_objs(self_obj, fallout.dude_obj()) < 5 then
                    reward()
                    fallout.set_local_var(5, 3)
                    fallout.use_obj(fallout.external_var("Fridge_ptr"))
                end
            elseif fallout.local_var(5) == 3 then
                moving = true
                target_hex = fallout.local_var(7)
                if self_tile_num ~= target_hex then
                    fallout.animate_move_obj_to_tile(self_obj, target_hex, 0)
                else
                    done()
                end
            end
        end
    end
end

function damage_p_proc()
    fallout.set_global_var(249, 1)
end

function destroy_p_proc()
    fallout.set_global_var(249, 1)
    fallout.set_global_var(607, 3)
    reputation.inc_evil_critter()
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(102, 100))
end

function garretend()
end

function garretcbt()
    hostile = true
end

function goodstuff()
    cash = cash + 100
    fallout.add_mult_objs_to_inven(fallout.dude_obj(), fallout.create_object_sid(41, 0, 0, -1), 100)
    neutstuff()
    badstuff()
end

function neutstuff()
    local dude_obj = fallout.dude_obj()
    local fridge_obj = fallout.external_var("Fridge_ptr")
    cash = cash + 50
    fallout.add_mult_objs_to_inven(dude_obj, fallout.create_object_sid(41, 0, 0, -1), 50)
    if fallout.obj_is_carrying_obj_pid(fridge_obj, 94) ~= 0 then
        fallout.display_msg(fallout.message_str(102, 204))
        local shotgun_obj = fallout.obj_carrying_pid_obj(fridge_obj, 94)
        fallout.rm_obj_from_inven(fridge_obj, shotgun_obj)
        fallout.add_obj_to_inven(dude_obj, shotgun_obj)
    else
        robbed = true
    end
    if fallout.obj_is_carrying_obj_pid(fridge_obj, 95) ~= 0 then
        fallout.display_msg(fallout.message_str(102, 205))
        local shells_obj = fallout.obj_carrying_pid_obj(fridge_obj, 95)
        fallout.rm_obj_from_inven(fridge_obj, shells_obj)
        fallout.add_obj_to_inven(dude_obj, shells_obj)
    else
        robbed = true
    end
    if fallout.obj_is_carrying_obj_pid(fridge_obj, 95) ~= 0 then
        local shells_obj = fallout.obj_carrying_pid_obj(fridge_obj, 95)
        fallout.rm_obj_from_inven(fridge_obj, shells_obj)
        fallout.add_obj_to_inven(dude_obj, shells_obj)
    else
        robbed = true
    end
end

function badstuff()
    cash = cash + 50
    fallout.add_mult_objs_to_inven(fallout.dude_obj(), fallout.create_object_sid(41, 0, 0, -1), 50)
    flare_count = 0
    give_flare()
    give_flare()
    give_flare()
    give_flare()
    cola_count = 0
    give_cola()
    give_cola()
    give_cola()
    give_cola()
end

function reward()
    cash = 0
    robbed = false
    fallout.display_msg(fallout.message_str(102, 203))
    if fallout.local_var(1) >= 3 then
        goodstuff()
    elseif fallout.local_var(1) >= 2 then
        neutstuff()
    else
        badstuff()
    end
    if flare_count ~= 0 then
        if flare_count > 1 then
            fallout.display_msg(fallout.message_str(102, 206))
        else
            fallout.display_msg(fallout.message_str(102, 207))
        end
    end
    if cola_count ~= 0 then
        if cola_count > 1 then
            fallout.display_msg(fallout.message_str(102, 208))
        else
            fallout.display_msg(fallout.message_str(102, 209))
        end
    end
    fallout.display_msg("$" .. cash)
    if robbed then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(102, 121), 0)
    else
        fallout.float_msg(fallout.self_obj(), fallout.message_str(102, 201), 0)
    end
end

function done()
    moving = false
    fallout.set_local_var(5, 4)
end

function garret00a()
    fallout.gsay_reply(102, 101)
    fallout.giq_option(4, 102, 102, garretend, 50)
    fallout.giq_option(4, 102, 103, garret01a, 50)
    fallout.giq_option(5, 102, 104, garret02a, 50)
    fallout.giq_option(-3, 102, 112, garretend, 50)
end

function garret00b()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(102, 105), 0)
    garretend()
end

function garret00c()
    fallout.gsay_reply(102, 109)
    fallout.giq_option(3, 102, 110, garret01c, 50)
    fallout.giq_option(5, 102, 111, garret00ca, 50)
    fallout.giq_option(-3, 102, 112, garret02c, 50)
end

function garret00ca()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        garret03c()
    else
        garret02c()
    end
end

function garret01a()
    if indlog then
        fallout.gsay_message(102, 113, 50)
    else
        fallout.float_msg(fallout.self_obj(), fallout.message_str(102, 113), 0)
    end
    garretend()
end

function garret01c()
    fallout.gsay_message(102, 115, 50)
    reaction.DownReact()
    garretend()
end

function garret02a()
    reaction.DownReact()
    if indlog then
        fallout.gsay_message(102, 116, 50)
    else
        fallout.float_msg(fallout.self_obj(), fallout.message_str(102, 116), 0)
    end
    garretend()
end

function garret02c()
    fallout.gsay_message(102, 117, 50)
    garretend()
end

function garret03c()
    fallout.gsay_message(102, 118, 50)
    fallout.display_msg(fallout.message_str(102, 119))
    fallout.gsay_message(102, 120, 50)
    garretend()
end

function garret04()
    fallout.start_gdialog(102, fallout.self_obj(), 4, -1, -1)
    fallout.gsay_start()
    indlog = true
    garret00a()
    indlog = false
    fallout.gsay_end()
    fallout.end_dialogue()
end

function give_flare()
    local fridge_obj = fallout.external_var("Fridge_ptr")
    if fallout.obj_is_carrying_obj_pid(fridge_obj, 79) ~= 0 then
        flare_count = flare_count + 1
        local flare_obj = fallout.obj_carrying_pid_obj(fridge_obj, 79)
        fallout.rm_obj_from_inven(fridge_obj, flare_obj)
        fallout.add_obj_to_inven(fallout.dude_obj(), flare_obj)
    else
        robbed = true
    end
end

function give_cola()
    local fridge_obj = fallout.external_var("Fridge_ptr")
    if fallout.obj_is_carrying_obj_pid(fridge_obj, 106) ~= 0 then
        cola_count = cola_count + 1
        local cola_obj = fallout.obj_carrying_pid_obj(fridge_obj, 106)
        fallout.rm_obj_from_inven(fridge_obj, cola_obj)
        fallout.add_obj_to_inven(fallout.dude_obj(), cola_obj)
    else
        robbed = true
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
