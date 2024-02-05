local fallout = require("fallout")
local misc = require("lib.misc")
local reputation = require("lib.reputation")

local start
local critter_p_proc
local destroy_p_proc
local look_at_p_proc
local pickup_p_proc
local talk_p_proc
local Hunter01
local Hunter02
local Hunter03
local Hunter04
local Hunter05

local mad = false
local hostile = false
local initialized = false
local my_script_mode = false
local pre_fight = false

function start()
    if not initialized then
        local self_obj = fallout.self_obj()
        misc.set_team(self_obj, 29)
        if fallout.cur_map_index() ~= 29 then
            Hunter05()
            fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
            my_script_mode = true
        elseif fallout.global_var(123) == 3 then
            fallout.move_to(self_obj, 7000, 0)
            fallout.set_external_var("removal_ptr", self_obj)
        end
        initialized = true
    end

    local script_action = fallout.script_action()
    if not my_script_mode then
        if script_action == 12 then
            critter_p_proc()
        elseif script_action == 18 then
            destroy_p_proc()
        elseif script_action == 21 then
            look_at_p_proc()
        elseif script_action == 4 then
            pickup_p_proc()
        elseif script_action == 11 then
            talk_p_proc()
        end
    else
        if script_action == 18 then
            destroy_p_proc()
        end
    end
end

function critter_p_proc()
    if hostile then
        hostile = false
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    else
        if fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj())
            and not my_script_mode
            and not pre_fight
            and fallout.global_var(158) > 2 then
            Hunter05()
            pre_fight = true
        end
    end
end

function destroy_p_proc()
    fallout.set_global_var(123, 3)
    reputation.inc_good_critter()
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(241, 100))
end

function pickup_p_proc()
    hostile = true
end

function talk_p_proc()
    fallout.start_gdialog(241, fallout.self_obj(), 4, -1, -1)
    fallout.gsay_start()
    Hunter01()
    fallout.gsay_end()
    fallout.end_dialogue()
end

function Hunter01()
    fallout.gsay_reply(241, 101)
    fallout.giq_option(3, 241, 102, Hunter02, 50)
    fallout.giq_option(3, 241, 103, Hunter03, 50)
    fallout.giq_option(3, 241, 104, Hunter04, 50)
    fallout.giq_option(0, 241, 105, Hunter04, 50)
end

function Hunter02()
    if not mad then
        fallout.gsay_message(241, 106, 50)
        mad = true
    else
        fallout.gsay_message(241, 107, 50)
        hostile = true
    end
end

function Hunter03()
    fallout.gsay_message(241, 108, 50)
end

function Hunter04()
    fallout.gsay_message(241, 109, 50)
end

function Hunter05()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(241, 110), 0)
    hostile = true
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
return exports
