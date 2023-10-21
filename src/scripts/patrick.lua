local fallout = require("fallout")
local reputation = require("lib.reputation")

local start
local critter_p_proc
local destroy_p_proc
local look_at_p_proc
local pickup_p_proc
local talk_p_proc
local flee_dude
local Patrick01
local Patrick02
local Patrick03
local Patrick04
local Patrick05
local Patrick06
local Patrick06a
local Patrick07
local Patrick08
local Patrick09
local Patrick10
local Patrick11
local Patrick12
local Patrick13
local Patrick14
local Patrick15
local Patrick16
local Patrick17
local PatrickCombat
local PatrickEnd

local hostile = 0
local initialized = false
local known = 0
local scared = 0

function start()
    if not initialized then
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 87)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 2)
        initialized = true
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
    if scared then
        if fallout.tile_distance_objs(fallout.self_obj(), fallout.dude_obj()) < 8 then
            flee_dude()
        end
    else
        if hostile then
            hostile = 0
            scared = 1
            fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
        end
    end
end

function destroy_p_proc()
    fallout.set_global_var(297, 1)
    reputation.inc_good_critter()
end

function look_at_p_proc()
    fallout.script_overrides()
    known = fallout.global_var(330)
    if known then
        fallout.display_msg(fallout.message_str(667, 101))
    else
        fallout.display_msg(fallout.message_str(667, 100))
    end
end

function pickup_p_proc()
    hostile = 1
end

function talk_p_proc()
    known = fallout.global_var(330)
    if scared then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(669, fallout.random(100, 105)), 2)
    else
        fallout.start_gdialog(667, fallout.self_obj(), 4, -1, -1)
        fallout.gsay_start()
        if known then
            Patrick17()
        else
            Patrick01()
        end
        fallout.gsay_end()
        fallout.end_dialogue()
    end
end

function flee_dude()
    local v0 = 0
    local v1 = 0
    local v2 = 0
    while v1 < 5 do
        if fallout.tile_distance(fallout.tile_num(fallout.dude_obj()), fallout.tile_num_in_direction(fallout.tile_num(fallout.self_obj()), v1, 3)) > v2 then
            v0 = fallout.tile_num_in_direction(fallout.tile_num(fallout.self_obj()), v1, 3)
            v2 = fallout.tile_distance(fallout.tile_num(fallout.dude_obj()), v0)
        end
        v1 = v1 + 1
    end
    fallout.animate_move_obj_to_tile(fallout.self_obj(), v0, 1)
end

function Patrick01()
    known = 1
    fallout.set_global_var(330, known)
    fallout.gsay_reply(667, 102)
    fallout.giq_option(4, 667, 103, Patrick02, 50)
    fallout.giq_option(4, 667, 104, Patrick03, 50)
    if (fallout.global_var(101) == 0) and (fallout.obj_is_carrying_obj_pid(fallout.dude_obj(), 55) == 0) then
        fallout.giq_option(4, 667, 105, Patrick04, 50)
    end
    if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1)) then
        fallout.giq_option(4, 667, 106, PatrickCombat, 51)
    end
    fallout.giq_option(-3, 667, 107, PatrickEnd, 50)
end

function Patrick02()
    fallout.gsay_reply(667, 108)
    fallout.giq_option(4, 667, 109, Patrick05, 50)
    fallout.giq_option(4, 667, 110, Patrick06, 50)
    fallout.giq_option(4, 667, 111, Patrick05, 50)
    fallout.giq_option(4, 667, 112, PatrickEnd, 50)
end

function Patrick03()
    fallout.gsay_reply(667, 113)
    fallout.giq_option(4, 667, 114, PatrickEnd, 50)
    fallout.giq_option(4, 667, 115, Patrick05, 50)
end

function Patrick04()
    fallout.gsay_reply(667, 116)
    if fallout.get_critter_stat(fallout.dude_obj(), 4) > 6 then
        fallout.giq_option(7, 667, 117, Patrick07, 50)
    else
        fallout.giq_option(4, 667, 118, Patrick07, 50)
    end
end

function Patrick05()
    fallout.gsay_reply(667, 119)
    fallout.giq_option(4, 667, 120, Patrick08, 50)
    fallout.giq_option(4, 667, 121, Patrick09, 50)
    fallout.giq_option(4, 667, 110, Patrick06, 50)
    fallout.giq_option(4, 667, 122, PatrickEnd, 50)
end

function Patrick06()
    fallout.gsay_reply(667, 123)
    if fallout.global_var(68) < 1 then
        fallout.set_global_var(68, 1)
    end
    if fallout.global_var(71) < 1 then
        fallout.set_global_var(71, 1)
    end
    if fallout.global_var(73) < 1 then
        fallout.set_global_var(71, 1)
    end
    if fallout.global_var(72) < 1 then
        fallout.set_global_var(72, 1)
    end
    Patrick06a()
end

function Patrick06a()
    fallout.giq_option(4, 667, 124, Patrick10, 50)
    fallout.giq_option(4, 667, 125, Patrick11, 50)
    fallout.giq_option(4, 667, 126, Patrick12, 50)
    fallout.giq_option(4, 667, 127, Patrick13, 50)
    fallout.giq_option(4, 634, 100, PatrickEnd, 50)
end

function Patrick07()
    fallout.gsay_reply(667, 128)
    fallout.giq_option(4, 634, 100, PatrickEnd, 50)
    fallout.giq_option(4, 667, 115, Patrick05, 50)
end

function Patrick08()
    fallout.gsay_reply(667, 129)
    if (fallout.global_var(101) == 0) and (fallout.obj_is_carrying_obj_pid(fallout.dude_obj(), 55) == 0) then
        fallout.giq_option(4, 667, 130, Patrick07, 50)
    end
    fallout.giq_option(4, 667, 110, Patrick05, 50)
    fallout.giq_option(4, 667, 112, PatrickEnd, 50)
end

function Patrick09()
    fallout.gsay_reply(667, 131)
    if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 14, 0)) then
        fallout.giq_option(7, 667, 132, Patrick15, 49)
    end
    fallout.giq_option(4, 667, 133, Patrick05, 50)
    fallout.giq_option(4, 667, 122, PatrickEnd, 50)
end

function Patrick10()
    if fallout.global_var(13) == 1 then
        fallout.gsay_reply(667, 141)
    else
        if fallout.global_var(26) == 27 then
            fallout.gsay_reply(667, 135)
        else
            fallout.gsay_reply(667, 134)
        end
    end
    Patrick06a()
end

function Patrick11()
    if fallout.global_var(13) == 1 then
        fallout.gsay_reply(667, 141)
    else
        if fallout.global_var(37) ~= 0 then
            if fallout.global_var(38) ~= 0 then
                fallout.gsay_reply(667, 138)
            else
                fallout.gsay_reply(667, 137)
            end
        else
            fallout.gsay_reply(667, 136)
        end
    end
    Patrick06a()
end

function Patrick12()
    if fallout.global_var(13) == 1 then
        fallout.gsay_reply(667, 141)
    else
        fallout.gsay_reply(667, 139)
    end
    Patrick06a()
end

function Patrick13()
    if fallout.global_var(13) == 1 then
        fallout.gsay_reply(667, 141)
    else
        fallout.gsay_reply(667, 140)
    end
    if fallout.get_critter_stat(fallout.dude_obj(), 4) > 5 then
        fallout.giq_option(6, 667, 142, Patrick14, 50)
    else
        Patrick06a()
    end
end

function Patrick14()
    fallout.gsay_reply(667, 143)
    Patrick06a()
end

function Patrick15()
    fallout.gsay_reply(667, 144)
    fallout.giq_option(4, 667, 145, Patrick16, 49)
    fallout.giq_option(4, 667, 146, PatrickEnd, 50)
end

function Patrick16()
    fallout.gfade_out(600)
    fallout.set_critter_stat(fallout.dude_obj(), 3, 1)
    fallout.gfade_in(600)
    fallout.gsay_message(667, 147, 49)
end

function Patrick17()
    fallout.gsay_reply(667, 148)
    fallout.giq_option(4, 667, 149, Patrick06, 50)
    fallout.giq_option(4, 667, 150, PatrickEnd, 50)
    fallout.giq_option(-3, 667, 107, PatrickEnd, 50)
end

function PatrickCombat()
    hostile = 1
end

function PatrickEnd()
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
return exports
