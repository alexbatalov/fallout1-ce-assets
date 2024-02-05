local fallout = require("fallout")
local misc = require("lib.misc")
local reputation = require("lib.reputation")

local start
local critter_p_proc
local destroy_p_proc
local description_p_proc
local pickup_p_proc
local talk_p_proc

local initialized = false
local hostile = false
local line103flag = false

function start()
    if not initialized then
        local self_obj = fallout.self_obj()
        misc.set_team(self_obj, 13)
        if fallout.global_var(104) == 2 then
            fallout.kill_critter(self_obj, 62)
        end
        initialized = true
    end

    local script_action = fallout.script_action()
    if script_action == 12 then
        critter_p_proc()
    elseif script_action == 3 then
        description_p_proc()
    elseif script_action == 18 then
        destroy_p_proc()
    elseif script_action == 11 then
        talk_p_proc()
    end
end

function critter_p_proc()
    if hostile then
        hostile = false
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    else
        if fallout.external_var("Gizmo_is_angry") ~= 0 then
            fallout.set_external_var("Gizmo_is_angry", 0)
            hostile = true
        elseif fallout.external_var("show_to_door") ~= 0 then
            local self_obj = fallout.self_obj()
            if fallout.tile_distance_objs(fallout.dude_obj(), fallout.external_var("Gizmo_ptr")) > 8 then
                if fallout.tile_num(self_obj) ~= 16520 then
                    fallout.animate_move_obj_to_tile(self_obj, 16520, 0)
                else
                    fallout.anim(self_obj, 1000, 2)
                    line103flag = false
                    fallout.set_external_var("show_to_door", 0)
                end
            else
                if fallout.tile_num(self_obj) ~= 18720 then
                    fallout.animate_move_obj_to_tile(self_obj, 18720, 0)
                elseif not line103flag then
                    line103flag = true
                    fallout.display_msg(fallout.message_str(622, 103))
                end
            end
        end
    end
end

function destroy_p_proc()
    reputation.inc_evil_critter()
end

function description_p_proc()
    local dude_obj = fallout.dude_obj()
    if fallout.is_success(fallout.do_check(dude_obj, 1, fallout.has_trait(0, dude_obj, 0))) then
        fallout.display_msg(fallout.message_str(622, 100))
    end
end

function pickup_p_proc()
    hostile = true
end

function talk_p_proc()
    fallout.display_msg(fallout.message_str(622, 101))
    local amount = fallout.external_var("payment")
    if amount > 0 then
        fallout.use_obj(fallout.dude_obj())
        local item_obj = fallout.create_object_sid(41, 0, 0, -1)
        fallout.add_mult_objs_to_inven(fallout.dude_obj(), item_obj, amount)
        fallout.display_msg(fallout.message_str(622, 102))
        fallout.set_external_var("payment", 0)
    end
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.description_p_proc = description_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
return exports
