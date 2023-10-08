local fallout = require("fallout")

local start
local critter_p_proc
local destroy_p_proc
local talk_p_proc
local Sarah00
local Sarah01
local sarah02
local Sarah03
local Sarah04
local Sarah05
local Sarah06
local Sarah07
local Sarah08
local Sarah09
local Sarah10
local SarahEnd

local initialized = 0

local exit_line = 0

function start()
    if not(initialized) then
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 34)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 67)
        initialized = 1
    else
        if fallout.script_action() == 12 then
            critter_p_proc()
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

function critter_p_proc()
    if fallout.map_var(8) == 3 then
        if fallout.local_var(4) == 0 then
            if fallout.tile_distance_objs(fallout.self_obj(), fallout.dude_obj()) < 12 then
                if fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) then
                    fallout.dialogue_system_enter()
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
        fallout.set_global_var(159, fallout.global_var(159) + 1)
        if (fallout.global_var(159) % 2) == 0 then
            fallout.set_global_var(155, fallout.global_var(155) - 1)
        end
    end
end

function talk_p_proc()
    if fallout.local_var(4) then
        if fallout.map_var(8) == 3 then
            fallout.float_msg(fallout.self_obj(), fallout.message_str(662, 105), 0)
        else
            if fallout.get_critter_stat(fallout.dude_obj(), 4) < 4 then
                fallout.float_msg(fallout.self_obj(), fallout.message_str(662, 117), 0)
            else
                Sarah10()
            end
        end
    else
        fallout.set_local_var(4, 1)
        fallout.start_gdialog(662, fallout.self_obj(), 4, -1, -1)
        fallout.gsay_start()
        if fallout.map_var(8) == 3 then
            Sarah00()
        else
            Sarah05()
        end
        fallout.gsay_end()
        fallout.end_dialogue()
    end
end

function Sarah00()
    fallout.gsay_reply(662, 100)
    fallout.giq_option(-3, 662, 101, Sarah01, 51)
    fallout.giq_option(4, 662, 102, SarahEnd, 51)
    fallout.giq_option(5, 662, 103, Sarah01, 51)
    fallout.giq_option(7, 662, 104, sarah02, 51)
end

function Sarah01()
    fallout.gsay_message(662, 105, 51)
end

function sarah02()
    fallout.gsay_reply(662, 106)
    fallout.giq_option(7, 662, 107, Sarah03, 51)
    fallout.giq_option(7, 662, 108, Sarah04, 51)
end

function Sarah03()
    fallout.gsay_reply(662, 109)
    fallout.giq_option(7, 662, 110, Sarah01, 51)
    fallout.giq_option(7, 662, 111, Sarah04, 51)
end

function Sarah04()
    fallout.gsay_message(662, 112, 51)
end

function Sarah05()
    fallout.gsay_reply(662, 113)
    fallout.giq_option(-3, 662, 114, Sarah06, 50)
    fallout.giq_option(4, 662, 115, Sarah07, 50)
    fallout.giq_option(6, 662, 116, Sarah09, 50)
end

function Sarah06()
    fallout.gsay_message(662, 117, 50)
end

function Sarah07()
    fallout.gsay_reply(662, 118)
    fallout.giq_option(4, 662, 119, SarahEnd, 50)
    fallout.giq_option(6, 662, 120, Sarah08, 50)
end

function Sarah08()
    fallout.gsay_reply(662, 121)
    fallout.giq_option(4, 662, 119, SarahEnd, 51)
end

function Sarah09()
    fallout.gsay_message(662, 122, 50)
end

function Sarah10()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(662, 123), 0)
end

function SarahEnd()
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.talk_p_proc = talk_p_proc
return exports
