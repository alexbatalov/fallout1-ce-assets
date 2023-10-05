local fallout = require("fallout")

local start
local critter_p_proc
local destroy_p_proc
local description_p_proc
local pickup_p_proc
local talk_p_proc

local initialized = 0
local hostile = 0
local line103flag = 0

function start()
    if not(initialized) then
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 13)
        if fallout.global_var(104) == 2 then
            fallout.kill_critter(fallout.self_obj(), 62)
        end
        initialized = 1
    else
        if fallout.script_action() == 12 then
            critter_p_proc()
        else
            if fallout.script_action() == 3 then
                description_p_proc()
            else
                if fallout.script_action() == 18 then
                    destroy_p_proc()
                else
                    if fallout.script_action() == 11 then
                        talk_p_proc()
                    end
                end
            end
        end
    end
end

function critter_p_proc()
    if hostile then
        hostile = 0
        fallout.attack_complex(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    else
        if fallout.external_var("Gizmo_is_angry") then
            fallout.set_external_var("Gizmo_is_angry", 0)
            hostile = 1
        else
            if fallout.external_var("show_to_door") then
                if fallout.tile_distance_objs(fallout.dude_obj(), fallout.external_var("Gizmo_ptr")) > 8 then
                    if fallout.tile_num(fallout.self_obj()) ~= 16520 then
                        fallout.animate_move_obj_to_tile(fallout.self_obj(), 16520, 0)
                    else
                        fallout.anim(fallout.self_obj(), 1000, 2)
                        line103flag = 0
                        fallout.set_external_var("show_to_door", 0)
                    end
                else
                    if fallout.tile_num(fallout.self_obj()) ~= 18720 then
                        fallout.animate_move_obj_to_tile(fallout.self_obj(), 18720, 0)
                    else
                        if not(line103flag) then
                            line103flag = 1
                            fallout.display_msg(fallout.message_str(622, 103))
                        end
                    end
                end
            end
        end
    end
end

function destroy_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1)) then
            fallout.set_global_var(156, 1)
            fallout.set_global_var(157, 0)
        end
        if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(160) > (3 * fallout.global_var(159))) or (fallout.global_var(157) == 1)) then
            fallout.set_global_var(157, 1)
            fallout.set_global_var(156, 0)
        end
        fallout.set_global_var(160, fallout.global_var(160) + 1)
        if (fallout.global_var(160) % 6) == 0 then
            fallout.set_global_var(155, fallout.global_var(155) + 1)
        end
    end
end

function description_p_proc()
    if fallout.is_success(fallout.do_check(fallout.dude_obj(), 1, fallout.has_trait(0, fallout.dude_obj(), 0))) then
        fallout.display_msg(fallout.message_str(622, 100))
    end
end

function pickup_p_proc()
    hostile = 1
end

function talk_p_proc()
    local v0 = 0
    fallout.display_msg(fallout.message_str(622, 101))
    if fallout.external_var("payment") > 0 then
        fallout.use_obj(fallout.dude_obj())
        v0 = fallout.create_object_sid(41, 0, 0, -1)
        fallout.add_mult_objs_to_inven(fallout.dude_obj(), v0, fallout.external_var("payment"))
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
