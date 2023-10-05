local fallout = require("fallout")

local start
local critter_p_proc
local destroy_p_proc
local look_at_p_proc
local pickup_p_proc
local talk_p_proc
local Orfeo0
local Orfeo1
local Orfeo2
local Orfeo3
local Orfeoend
local combat

local initialized = 0
local hostile = 0

function start()
    if not(initialized) then
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 20)
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
    if hostile then
        hostile = 0
        fallout.attack_complex(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
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
    if fallout.local_var(0) then
        fallout.script_overrides()
        fallout.display_msg(fallout.message_str(269, 100))
    end
end

function pickup_p_proc()
    hostile = 1
end

function talk_p_proc()
    fallout.script_overrides()
    if fallout.local_var(0) then
        Orfeo3()
    else
        fallout.set_local_var(0, 1)
        fallout.start_gdialog(269, fallout.self_obj(), 4, -1, -1)
        fallout.gsay_start()
        Orfeo0()
        fallout.gsay_end()
        fallout.end_dialogue()
    end
end

function Orfeo0()
    fallout.gsay_reply(269, 101)
    fallout.giq_option(-3, 269, 102, combat, 50)
    fallout.giq_option(4, 269, 103, Orfeo1, 50)
    fallout.giq_option(4, 269, 104, Orfeo2, 50)
end

function Orfeo1()
    fallout.gsay_message(269, 105, 50)
    combat()
end

function Orfeo2()
    fallout.gsay_message(269, 106, 50)
    combat()
end

function Orfeo3()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(269, 107), 0)
    combat()
end

function Orfeoend()
end

function combat()
    hostile = hostile + 1
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
return exports
