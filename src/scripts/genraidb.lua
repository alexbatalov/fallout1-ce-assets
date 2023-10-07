local fallout = require("fallout")

local start
local critter_p_proc
local destroy_p_proc
local pickup_p_proc
local talk_p_proc

local initialized = 0
local hostile = 0
local scared = 0

function start()
    if not(initialized) then
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 6)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 20)
        initialized = 1
    else
        if fallout.script_action() == 12 then
            critter_p_proc()
        else
            if fallout.script_action() == 18 then
                destroy_p_proc()
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

function critter_p_proc()
    if hostile then
        hostile = 0
        scared = 1
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    end
end

function destroy_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.set_global_var(290, fallout.global_var(290) + 1)
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
    fallout.set_global_var(289, fallout.global_var(289) - 1)
end

function pickup_p_proc()
    hostile = 1
end

function talk_p_proc()
    if scared then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(750, fallout.random(102, 103)), 0)
    else
        fallout.float_msg(fallout.self_obj(), fallout.message_str(750, fallout.random(100, 101)), 0)
    end
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
return exports
