local fallout = require("fallout")

local start
local combat
local critter_p_proc
local pickup_p_proc
local talk_p_proc
local destroy_p_proc
local look_at_p_proc
local zamin
local goto00
local goto01
local goto02
local goto03

local my_tile = 0
local lesson_ptr = 0
local hostile = 0
local Only_Once = 1
local DISGUISED = 0
local ARMED = 0
local PICK = 0

function start()
    if Only_Once then
        Only_Once = 0
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 34)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 48)
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
                if fallout.script_action() == 22 then
                    if hostile < 1 then
                        lesson_ptr = lesson_ptr + 1
                        fallout.set_local_var(1, lesson_ptr)
                        goto00()
                    end
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
end

function combat()
    hostile = 1
end

function critter_p_proc()
    if hostile then
        hostile = 0
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    end
    my_tile = fallout.tile_num(fallout.self_obj())
    if my_tile == 12098 then
        fallout.move_to(fallout.self_obj(), 7000, 0)
    else
        if fallout.tile_distance(my_tile, fallout.tile_num(fallout.dude_obj())) < 12 then
            if fallout.local_var(2) ~= 1 then
                fallout.set_local_var(2, 1)
                lesson_ptr = 0
                fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(1), 0)
            end
        end
    end
    if fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) then
        zamin()
        if (ARMED == 1) or (DISGUISED == 0) then
            combat()
        end
    end
end

function pickup_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        hostile = 1
    end
end

function talk_p_proc()
    zamin()
    if (ARMED == 1) or (DISGUISED == 0) then
        combat()
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

function look_at_p_proc()
    fallout.script_overrides()
end

function zamin()
    DISGUISED = 0
    ARMED = 0
    if (fallout.obj_item_subtype(fallout.critter_inven_obj(fallout.dude_obj(), 1)) == 3) or (fallout.obj_item_subtype(fallout.critter_inven_obj(fallout.dude_obj(), 2)) == 3) then
        ARMED = 1
    end
    if fallout.obj_pid(fallout.critter_inven_obj(fallout.dude_obj(), 0)) == 113 then
        if fallout.metarule(16, 0) > 1 then
            DISGUISED = 0
        else
            DISGUISED = 1
        end
    end
end

function goto00()
    PICK = lesson_ptr
    if PICK == 1 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(694, 101), 2)
    else
        if PICK == 2 then
            fallout.float_msg(fallout.external_var("patient"), fallout.message_str(694, 102), 8)
        else
            if PICK == 3 then
                fallout.float_msg(fallout.self_obj(), fallout.message_str(694, 103), 2)
            else
                if PICK == 4 then
                    goto01()
                else
                    if PICK == 5 then
                        goto02()
                    else
                        if PICK == 6 then
                            fallout.float_msg(fallout.external_var("patient"), fallout.message_str(694, 108), 8)
                        else
                            if PICK == 7 then
                                fallout.float_msg(fallout.self_obj(), fallout.message_str(694, 109), 2)
                            else
                                if PICK == 8 then
                                    fallout.float_msg(fallout.external_var("patient"), fallout.message_str(694, 110), 8)
                                else
                                    if PICK == 9 then
                                        goto03()
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(3), 1)
end

function goto01()
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        fallout.float_msg(fallout.external_var("patient"), fallout.message_str(694, 104), 8)
    else
        fallout.float_msg(fallout.external_var("patient"), fallout.message_str(694, 105), 8)
    end
end

function goto02()
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(694, 106), 2)
    else
        fallout.float_msg(fallout.self_obj(), fallout.message_str(694, 107), 2)
    end
end

function goto03()
    fallout.set_external_var("lets_go", 1)
    fallout.animate_move_obj_to_tile(fallout.self_obj(), 12098, 0)
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
return exports
