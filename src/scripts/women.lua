local fallout = require("fallout")
local reputation = require("lib.reputation")

local start
local critter_p_proc
local talk_p_proc
local destroy_p_proc
local look_at_p_proc

local initialized = false

function start()
    if not initialized then
        local self_obj = fallout.self_obj()
        fallout.critter_add_trait(self_obj, 1, 6, 44)
        fallout.critter_add_trait(self_obj, 1, 5, 5)
        initialized = true
    end

    local script_action = fallout.script_action()
    if script_action == 21 then
        look_at_p_proc()
    elseif script_action == 11 then
        talk_p_proc()
    elseif script_action == 12 then
        critter_p_proc()
    elseif script_action == 18 then
        destroy_p_proc()
    end
end

function critter_p_proc()
    if fallout.global_var(114) == 1 and fallout.global_var(115) <= 12 or fallout.global_var(115) <= 6 then
        if fallout.local_var(0) == 0 then
            fallout.set_local_var(0, 1)
            local xp = 200
            fallout.display_msg(fallout.message_str(238, 100) .. xp .. fallout.message_str(238, 103))
            fallout.set_global_var(155, fallout.global_var(155) + 1)
            fallout.give_exp_points(xp)
        end
    else
        local signal_women = fallout.external_var("signal_women")
        if signal_women == 2 then
            fallout.set_external_var("signal_women", signal_women - 1)
            fallout.float_msg(fallout.self_obj(), fallout.message_str(738, 101), 2)
        elseif signal_women == 1 then
            fallout.set_external_var("signal_women", signal_women - 1)
            fallout.float_msg(fallout.self_obj(), fallout.message_str(738, 102), 2)
        end
    end
end

function talk_p_proc()
    if fallout.local_var(0) == 1 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(738, 104), 2)
    else
        fallout.float_msg(fallout.self_obj(), fallout.message_str(738, fallout.random(102, 103)), 2)
    end
end

function destroy_p_proc()
    fallout.set_external_var("women_killed", fallout.external_var("women_killed") + 1)
    if fallout.external_var("women_killed") > 1 then
        fallout.set_global_var(155, fallout.global_var(155) - 1)
    end
    reputation.inc_good_critter()
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(738, 100))
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.talk_p_proc = talk_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
return exports
