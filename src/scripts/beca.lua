local fallout = require("fallout")

local start
local critter_p_proc
local destroy_p_proc
local look_at_p_proc
local pickup_p_proc
local talk_p_proc
local show_true_name
local show_false_name
local Beca00
local Beca01
local Beca02
local BecaCombat
local BecaEnd

local hostile = 0
local initialized = 0

function start()
    if not(initialized) then
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 47)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 27)
        initialized = 1
    else
        if fallout.script_action() == 12 then
            critter_p_proc()
        else
            if fallout.script_action() == 18 then
                destroy_p_proc()
            else
                if fallout.script_action() == 21 then
                    look_at_p_proc()
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

function critter_p_proc()
    if fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) and (fallout.global_var(136) < 41) then
        hostile = 1
    end
    if hostile then
        hostile = 0
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    end
end

function destroy_p_proc()
    fallout.set_global_var(136, fallout.global_var(136) - 1)
    if fallout.source_obj() == fallout.dude_obj() then
        if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1)) then
            fallout.set_global_var(156, 1)
            fallout.set_global_var(157, 0)
        end
        if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(160) > (3 * fallout.global_var(159))) or (fallout.global_var(157) == 1)) then
            fallout.set_global_var(157, 1)
            fallout.set_global_var(156, 0)
        end
        fallout.set_global_var(159, fallout.global_var(159) + 1)
        if (fallout.global_var(159) % 2) == 0 then
            fallout.set_global_var(155, fallout.global_var(155) - 1)
        end
    end
end

function look_at_p_proc()
    if (fallout.global_var(135) == 2) or (fallout.get_critter_stat(fallout.dude_obj(), 6) > 6) then
        show_true_name()
    else
        if fallout.get_critter_stat(fallout.dude_obj(), 6) < 4 then
            show_false_name()
        else
            if fallout.get_critter_stat(fallout.dude_obj(), 4) < 5 then
                show_false_name()
            else
                if fallout.random(0, 1) then
                    show_false_name()
                else
                    show_true_name()
                end
            end
        end
    end
end

function pickup_p_proc()
    hostile = 1
end

function talk_p_proc()
    if fallout.get_critter_stat(fallout.dude_obj(), 4) < 4 then
        fallout.display_msg(fallout.message_str(766, 175))
    else
        fallout.set_local_var(0, 1)
        if fallout.global_var(135) == 2 then
            Beca02()
        else
            fallout.start_gdialog(281, fallout.self_obj(), 4, -1, -1)
            fallout.gsay_start()
            Beca00()
            fallout.gsay_end()
            fallout.end_dialogue()
        end
    end
end

function show_true_name()
    fallout.script_overrides()
    if fallout.local_var(0) then
        if (fallout.game_time_hour() >= 1900) or (fallout.game_time_hour() < 600) then
            fallout.display_msg(fallout.message_str(281, 100))
        else
            fallout.display_msg(fallout.message_str(281, 101))
        end
    else
        fallout.display_msg(fallout.message_str(281, 104))
    end
end

function show_false_name()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(281, fallout.random(105, 111)))
end

function Beca00()
    fallout.gsay_reply(281, 112)
    fallout.giq_option(4, 281, 113, BecaCombat, 50)
    fallout.giq_option(4, 281, 114, BecaEnd, 50)
    fallout.giq_option(4, 281, 115, Beca01, 50)
end

function Beca01()
    fallout.gsay_message(281, 116, 50)
end

function Beca02()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(281, 117), 2)
end

function BecaCombat()
    hostile = 1
end

function BecaEnd()
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
return exports
