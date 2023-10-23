local fallout = require("fallout")
local reputation = require("lib.reputation")

local start
local combat_p_proc
local critter_p_proc
local damage_p_proc
local description_p_proc
local destroy_p_proc
local look_at_p_proc
local talk_p_proc
local pickup_p_proc
local Cook01

local hostile = false
local initialized = false
local round_counter = 0

function start()
    if not initialized then
        local self_obj = fallout.self_obj()
        fallout.critter_add_trait(self_obj, 1, 6, 2)
        fallout.critter_add_trait(self_obj, 1, 5, 6)
        initialized = true
    end

    local script_action = fallout.script_action()
    if script_action == 13 then
        combat_p_proc()
    elseif script_action == 12 then
        critter_p_proc()
    elseif script_action == 14 then
        damage_p_proc()
    elseif script_action == 3 then
        description_p_proc()
    elseif script_action == 18 then
        destroy_p_proc()
    elseif script_action == 21 then
        look_at_p_proc()
    elseif script_action == 4 then
        pickup_p_proc()
    elseif script_action == 11 then
        talk_p_proc()
    end
end

function combat_p_proc()
    if fallout.fixed_param() == 4 then
        round_counter = round_counter + 1
    end
    if round_counter > 3 then
        if fallout.global_var(246) == 0 then
            fallout.set_global_var(246, 1)
            fallout.set_global_var(155, fallout.global_var(155) - 5)
        end
    end
end

function critter_p_proc()
    if fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) then
        if fallout.global_var(246) == 1 then
            hostile = true
        end
    end
    if hostile then
        hostile = false
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    end
end

function damage_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.set_local_var(1, 1)
    end
end

function description_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(114, 100))
end

function destroy_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.set_global_var(246, 1)
    end
    reputation.inc_good_critter()
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(114, 100))
end

function talk_p_proc()
    if fallout.global_var(246) or fallout.local_var(1) == 1 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(669, fallout.random(100, 105)), 0)
    else
        if fallout.is_success(fallout.do_check(fallout.dude_obj(), 6, 0)) and fallout.local_var(0) == 0 then
            fallout.start_gdialog(114, fallout.self_obj(), 4, -1, -1)
            fallout.gsay_start()
            fallout.gsay_reply(114, 101)
            fallout.gsay_option(114, 102, Cook01, 50)
            fallout.gsay_end()
            fallout.end_dialogue()
        else
            fallout.float_msg(fallout.self_obj(), fallout.message_str(114, 103), 8)
        end
        fallout.set_local_var(0, 1)
    end
end

function pickup_p_proc()
    fallout.set_local_var(1, 1)
end

function Cook01()
    fallout.set_global_var(155, fallout.global_var(155) + 1)
    fallout.gsay_message(114, 104, 50)
end

local exports = {}
exports.start = start
exports.combat_p_proc = combat_p_proc
exports.critter_p_proc = critter_p_proc
exports.damage_p_proc = damage_p_proc
exports.description_p_proc = description_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
exports.talk_p_proc = talk_p_proc
exports.pickup_p_proc = pickup_p_proc
return exports
