local fallout = require("fallout")
local reaction = require("lib.reaction")
local time = require("lib.time")

local start
local combat
local critter_p_proc
local combat_p_proc
local pickup_p_proc
local talk_p_proc
local destroy_p_proc
local look_at_p_proc
local use_skill_on_p_proc
local use_obj_on_p_proc
local Mutant00
local Mutant01
local Mutant02
local Mutant03

local hostile = 0
local Only_Once = 1
local lastBabble = 0
local kill_me = 0

local exit_line = 0

function start()
    if Only_Once then
        Only_Once = 0
        fallout.anim(fallout.self_obj(), 48, 0)
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 34)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 47)
    end
    if fallout.script_action() == 21 then
        look_at_p_proc()
    else
        if fallout.script_action() == 4 then
            pickup_p_proc()
        else
            if fallout.script_action() == 11 then
                talk_p_proc()
            else
                if fallout.script_action() == 12 then
                    critter_p_proc()
                else
                    if fallout.script_action() == 18 then
                        destroy_p_proc()
                    else
                        if fallout.script_action() == 8 then
                            use_skill_on_p_proc()
                        else
                            if fallout.script_action() == 7 then
                                use_obj_on_p_proc()
                            else
                                if fallout.script_action() == 13 then
                                    combat_p_proc()
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

function combat()
    hostile = 1
end

function critter_p_proc()
    if hostile then
        hostile = 0
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    end
    if (fallout.local_var(5) == 0) and ((time.game_time_in_seconds() - lastBabble) >= 10) and (fallout.tile_distance_objs(fallout.self_obj(), fallout.dude_obj()) <= 15) then
        lastBabble = time.game_time_in_seconds()
        fallout.float_msg(fallout.self_obj(), fallout.message_str(848, fallout.random(111, 113)), 2)
    end
end

function combat_p_proc()
    fallout.script_overrides()
end

function pickup_p_proc()
end

function talk_p_proc()
    reaction.get_reaction()
    if fallout.local_var(5) == 1 then
        fallout.display_msg(fallout.message_str(848, 103))
    else
        fallout.start_gdialog(848, fallout.self_obj(), 4, -1, -1)
        fallout.gsay_start()
        Mutant00()
        fallout.gsay_end()
        fallout.end_dialogue()
    end
    if kill_me == 1 then
        kill_me = 0
        fallout.kill_critter(fallout.self_obj(), 48)
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
    fallout.script_overrides()
    if fallout.local_var(5) == 0 then
        fallout.display_msg(fallout.message_str(848, 100))
    else
        fallout.display_msg(fallout.message_str(848, 102))
    end
end

function use_skill_on_p_proc()
    fallout.script_overrides()
    fallout.dialogue_system_enter()
end

function use_obj_on_p_proc()
    fallout.script_overrides()
    fallout.dialogue_system_enter()
end

function Mutant00()
    fallout.gsay_reply(848, 104)
    fallout.giq_option(4, 848, 105, Mutant01, 50)
end

function Mutant01()
    local v0 = 0
    fallout.set_global_var(106, 2)
    fallout.gsay_reply(848, 106)
    v0 = fallout.obj_carrying_pid_obj(fallout.self_obj(), 196)
    if v0 ~= 0 then
        fallout.rm_obj_from_inven(fallout.self_obj(), v0)
        fallout.add_obj_to_inven(fallout.dude_obj(), v0)
    end
    fallout.giq_option(4, 848, 107, Mutant02, 50)
end

function Mutant02()
    fallout.gsay_reply(848, 108)
    fallout.giq_option(4, 848, 109, Mutant03, 50)
end

function Mutant03()
    fallout.set_local_var(5, 1)
    kill_me = 1
    fallout.gsay_message(848, 110, 50)
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.combat_p_proc = combat_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
exports.use_skill_on_p_proc = use_skill_on_p_proc
exports.use_obj_on_p_proc = use_obj_on_p_proc
return exports
