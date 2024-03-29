local fallout = require("fallout")
local time = require("lib.time")

local start
local spatial_p_proc
local talk_p_proc
local CrashRm01
local CrashRm02
local CrashRmEnd

function start()
    local script_action = fallout.script_action()
    if script_action == 2 then
        spatial_p_proc()
    elseif script_action == 11 then
        talk_p_proc()
    end
end

function spatial_p_proc()
    if fallout.source_obj() == fallout.dude_obj() and fallout.global_var(168) > time.game_time_in_days() then
        fallout.dialogue_system_enter()
    end
end

function talk_p_proc()
    fallout.start_gdialog(807, fallout.self_obj(), 4, -1, -1)
    fallout.gsay_start()
    fallout.gsay_reply(807, 100)
    fallout.giq_option(0, 807, 101, CrashRm01, 50)
    fallout.giq_option(0, 807, 102, CrashRmEnd, 50)
    fallout.gsay_end()
    fallout.end_dialogue()
    if fallout.local_var(0) == 1 then
        CrashRm02()
    end
end

function CrashRm01()
    fallout.set_local_var(0, 1)
end

function CrashRm02()
    fallout.set_local_var(0, 0)
    fallout.gfade_out(600)
    fallout.game_time_advance(fallout.game_ticks(60 * (60 - (fallout.game_time_hour() % 100))))
    if fallout.game_time_hour() < 1000 then
        fallout.game_time_advance(fallout.game_ticks(36 * (1000 - fallout.game_time_hour())))
    else
        fallout.game_time_advance(fallout.game_ticks(36 * (3400 - fallout.game_time_hour())))
    end
    fallout.critter_heal(fallout.dude_obj(), fallout.random(10, 15))
    fallout.display_msg(fallout.message_str(807, 103))
    if fallout.map_var(3) == 0 and fallout.map_var(0) ~= 2 then
        local jtraider_obj = fallout.create_object_sid(16777449, 17484, 0, 337)
        local sinthia_obj = fallout.external_var("Sinthia_ptr")
        local item_obj
        fallout.set_external_var("JTRaider_ptr", jtraider_obj)
        fallout.move_to(sinthia_obj, 17485, 0)
        fallout.anim(jtraider_obj, 1000, 3)
        fallout.anim(sinthia_obj, 1000, 3)
        item_obj = fallout.create_object_sid(8, 0, 0, -1)
        fallout.add_obj_to_inven(jtraider_obj, item_obj)
        fallout.wield_obj_critter(jtraider_obj, item_obj)
        item_obj = fallout.create_object_sid(1, 0, 0, -1)
        fallout.add_obj_to_inven(jtraider_obj, item_obj)
        fallout.wield_obj_critter(jtraider_obj, item_obj)
        fallout.set_map_var(3, 1)
    end
    fallout.gfade_in(600)
end

function CrashRmEnd()
end

local exports = {}
exports.start = start
exports.spatial_p_proc = spatial_p_proc
exports.talk_p_proc = talk_p_proc
return exports
