local fallout = require("fallout")
local time = require("lib.time")

local start
local do_dialogue
local Wife01
local Wife02
local Wife03
local Wife00n
local WifeEnd
local critter_p_proc
local talk_p_proc
local pickup_p_proc
local destroy_p_proc
local damage_p_proc

local HOSTILE = 0
local Only_Once = 1

function start()
    if Only_Once then
        Only_Once = 0
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 2)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 6)
    end
    if fallout.script_action() == 12 then
        critter_p_proc()
    else
        if fallout.script_action() == 11 then
            talk_p_proc()
        else
            if fallout.script_action() == 4 then
                pickup_p_proc()
            else
                if fallout.script_action() == 18 then
                    destroy_p_proc()
                else
                    if fallout.script_action() == 14 then
                        damage_p_proc()
                    end
                end
            end
        end
    end
end

function do_dialogue()
    if time.is_night() then
        Wife00n()
    else
        fallout.start_gdialog(119, fallout.self_obj(), 4, -1, -1)
        fallout.gsay_start()
        Wife01()
        fallout.gsay_end()
        fallout.end_dialogue()
    end
end

function Wife01()
    fallout.gsay_reply(119, 100)
    fallout.giq_option(4, 119, 101, Wife02, 50)
    fallout.giq_option(4, 119, 107, WifeEnd, 50)
    fallout.giq_option(-3, 119, 102, Wife03, 50)
end

function Wife02()
    fallout.gsay_message(119, 103, 50)
end

function Wife03()
    fallout.gsay_message(119, 104, 50)
end

function Wife00n()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(119, 105), 8)
end

function WifeEnd()
end

function critter_p_proc()
    if fallout.map_var(2) == 1 then
        fallout.set_local_var(0, fallout.local_var(0) + 1)
        fallout.set_map_var(2, 0)
        if fallout.local_var(0) < 3 then
            fallout.float_msg(fallout.self_obj(), fallout.message_str(129, 308), 2)
        else
            HOSTILE = 1
        end
    end
    if fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) then
        if fallout.global_var(246) == 1 then
            HOSTILE = 1
        end
    end
    if HOSTILE then
        HOSTILE = 0
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    end
end

function talk_p_proc()
    do_dialogue()
end

function pickup_p_proc()
    HOSTILE = 1
end

function destroy_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.set_global_var(246, 1)
    end
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

function damage_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.set_global_var(246, 1)
    end
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.talk_p_proc = talk_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.damage_p_proc = damage_p_proc
return exports
