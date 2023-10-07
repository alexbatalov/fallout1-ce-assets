local fallout = require("fallout")

local start
local KnightARandom
local critter_p_proc
local pickup_p_proc
local talk_p_proc
local destroy_p_proc
local look_at_p_proc

local hostile = 0
local only_once = 1

function start()
    if only_once then
        only_once = 0
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 44)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 64)
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
                    end
                end
            end
        end
    end
    if fallout.script_action() == 11 then
        KnightARandom()
    end
end

function KnightARandom()
    local v0 = 0
    local v1 = 0
    if not(v0) then
        v0 = fallout.random(1, 8)
    end
    if v0 > 8 then
        v0 = 1
    end
    v1 = fallout.message_str(329, 101)
    if v0 == 2 then
        v1 = fallout.message_str(329, 102)
    else
        if v0 == 3 then
            v1 = fallout.message_str(329, 103)
        else
            if v0 == 4 then
                v1 = fallout.message_str(329, 104)
            else
                if v0 == 5 then
                    v1 = fallout.message_str(329, 105)
                else
                    if v0 == 6 then
                        v1 = fallout.message_str(329, 106)
                    else
                        if v0 == 7 then
                            v1 = fallout.message_str(329, 107)
                        else
                            if v0 == 8 then
                                v1 = fallout.message_str(329, 108)
                            else
                                v0 = 1
                            end
                        end
                    end
                end
            end
        end
    end
    v0 = v0 + 1
    fallout.float_msg(fallout.self_obj(), v1, 0)
end

function critter_p_proc()
    if fallout.global_var(250) then
        hostile = 1
    end
    if fallout.tile_distance_objs(fallout.self_obj(), fallout.dude_obj()) > 12 then
        hostile = 0
    end
    if hostile then
        fallout.set_global_var(250, 1)
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
    KnightARandom()
end

function destroy_p_proc()
    fallout.set_global_var(250, 1)
    fallout.rm_timer_event(fallout.self_obj())
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

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(329, 100))
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
return exports
