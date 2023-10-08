local fallout = require("fallout")
local reaction = require("lib.reaction")

local start
local combat
local critter_p_proc
local pickup_p_proc
local talk_p_proc
local destroy_p_proc
local look_at_p_proc
local combat_p_proc
local damage_p_proc

local hostile = 0
local Only_Once = 1
local beingShown = 0

local exit_line = 0

function start()
    if Only_Once then
        Only_Once = 0
        fallout.set_external_var("Fry_Stub_Ptr", fallout.self_obj())
        fallout.set_obj_visibility(fallout.self_obj(), 1)
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 0)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 86)
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
                        if fallout.script_action() == 13 then
                            combat_p_proc()
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
end

function pickup_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        hostile = 1
    end
end

function talk_p_proc()
    reaction.get_reaction()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(914, 101), 2)
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
    fallout.set_global_var(469, 1)
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(914, 100))
end

function combat_p_proc()
    if fallout.map_var(54) == 1 then
        fallout.script_overrides()
    end
end

function damage_p_proc()
    local v0 = 0
    v0 = fallout.obj_pid(fallout.source_obj())
    if (fallout.party_member_obj(v0) ~= 0) and (fallout.map_var(52) == 0) then
        fallout.set_global_var(248, 1)
    end
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
exports.combat_p_proc = combat_p_proc
exports.damage_p_proc = damage_p_proc
return exports
