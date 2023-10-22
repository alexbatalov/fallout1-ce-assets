local fallout = require("fallout")
local reputation = require("lib.reputation")

local start
local pickup_p_proc
local talk_p_proc
local critter_p_proc
local damage_p_proc
local destroy_p_proc
local look_at_p_proc
local Nightkin01
local Nightkin01a
local Nightkin02
local Nightkin03
local Nightkin04
local Nightkin05
local Nightkin05a
local Nightkin06
local Nightkin07
local Nightkinend
local Combat

local hostile = false
local initialized = false

function start()
    if not initialized then
        local self_obj = fallout.self_obj()
        fallout.critter_add_trait(self_obj, 1, 6, 20)
        fallout.critter_add_trait(self_obj, 1, 5, 66)
        initialized = true
    end

    local script_action = fallout.script_action()
    if script_action == 21 or script_action == 3 then
        look_at_p_proc()
    elseif script_action == 18 then
        destroy_p_proc()
    elseif script_action == 14 then
        damage_p_proc()
    elseif script_action == 12 then
        critter_p_proc()
    elseif script_action == 4 then
        pickup_p_proc()
    elseif script_action == 11 then
        talk_p_proc()
    end
end

function pickup_p_proc()
    hostile = true
end

function talk_p_proc()
    fallout.script_overrides()
    if fallout.global_var(195) == 1 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(394, 101), 0)
        hostile = true
    else
        fallout.start_gdialog(394, fallout.self_obj(), 4, -1, -1)
        fallout.gsay_start()
        Nightkin01()
        fallout.gsay_end()
        fallout.end_dialogue()
    end
end

function critter_p_proc()
    local dude_obj = fallout.dude_obj()
    local self_obj = fallout.self_obj()
    local self_can_see_dude = fallout.obj_can_see_obj(self_obj, dude_obj)
    if self_can_see_dude
        and fallout.obj_is_carrying_obj_pid(dude_obj, 142) == 0
        and fallout.obj_is_carrying_obj_pid(dude_obj, 141) == 0
        and fallout.obj_pid(fallout.critter_inven_obj(dude_obj, 0)) ~= 113 then
        hostile = true
    end
    if fallout.metarule(16, 0) > 1 and self_can_see_dude then
        hostile = true
    end
    if hostile then
        hostile = false
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    end
end

function damage_p_proc()
    fallout.set_global_var(245, 1)
end

function destroy_p_proc()
    reputation.inc_evil_critter()
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(394, 100))
end

function Nightkin01()
    fallout.gsay_reply(394, 102)
    fallout.giq_option(7, 394, 103, Nightkin01a, 50)
    fallout.giq_option(4, 394, 104, Nightkin04, 50)
    fallout.giq_option(4, 394, 105, Nightkin05, 50)
    if fallout.global_var(194) == 1 then
        fallout.giq_option(4, 394, 106, Nightkin05, 50)
    end
    if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1)) then
        fallout.giq_option(4, 394, 107, Nightkin04, 50)
    end
    fallout.giq_option(-3, 394, 108, Nightkinend, 50)
end

function Nightkin01a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        Nightkin02()
    else
        Nightkin03()
    end
end

function Nightkin02()
    fallout.gsay_reply(394, 109)
    fallout.gsay_option(394, 125, Nightkinend, 50)
end

function Nightkin03()
    fallout.gsay_reply(394, 110)
    Combat()
end

function Nightkin04()
    fallout.gsay_reply(394, 111)
    Combat()
end

function Nightkin05()
    fallout.gsay_reply(394, 112)
    fallout.giq_option(7, 394, 113, Nightkin05a, 50)
    fallout.giq_option(4, 394, 114, Nightkin04, 50)
    fallout.giq_option(4, 394, 115, Nightkin07, 50)
    fallout.giq_option(4, 394, 116, Nightkin07, 50)
    fallout.giq_option(4, 394, 117, Nightkinend, 50)
    if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1)) then
        fallout.giq_option(4, 394, 118, Nightkin04, 50)
    end
end

function Nightkin05a()
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        Nightkin06()
    else
        Nightkin03()
    end
end

function Nightkin06()
    fallout.gsay_reply(394, 119)
    fallout.gsay_option(394, 125, Nightkinend, 50)
end

function Nightkin07()
    fallout.gsay_reply(394, 120)
    fallout.giq_option(4, 394, 121, Nightkin04, 50)
    fallout.giq_option(4, 394, 122, Nightkin04, 50)
    fallout.giq_option(4, 394, 123, Nightkinend, 50)
    if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1)) then
        fallout.giq_option(4, 394, 124, Combat, 50)
    end
end

function Nightkinend()
end

function Combat()
    fallout.set_global_var(195, 1)
    hostile = true
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
