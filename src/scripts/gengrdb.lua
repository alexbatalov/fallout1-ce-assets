local fallout = require("fallout")
local reputation = require("lib.reputation")

--
-- Some unreferenced imported varables found.
-- Because of it it is impossible to specify
-- the real names of global variables.
--

local g0 = 0
local g1 = 0
local g2 = 0
local g3 = 0

local start
local critter_p_proc
local destroy_p_proc
local pickup_p_proc
local talk_p_proc

-- ?import? variable hostile
-- ?import? variable initialized
-- ?import? variable scared
-- ?import? variable flee_dude
-- ?import? variable random_seed_3

function start()
    if not(g1) then
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 35)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, fallout.random(15, 19))
        g0 = fallout.global_var(334)
        g1 = 1
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
    if fallout.tile_distance_objs(fallout.self_obj(), fallout.dude_obj()) < 8 then
        if g2 then
            g3()
        else
            if g0 then
                g0 = 0
                g2 = 1
                fallout.set_global_var(334, 1)
                fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
            end
        end
    end
end

function destroy_p_proc()
    reputation.inc_good_critter()
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.set_external_var("random_seed_2", 1)
    end
end

function pickup_p_proc()
    if not(g2) then
        g0 = 1
        fallout.set_global_var(334, 1)
    end
end

function talk_p_proc()
    if g2 then
        if fallout.external_var("random_seed_2") then
            fallout.float_msg(fallout.self_obj(), fallout.message_str(756, 103), 2)
        else
            fallout.float_msg(fallout.self_obj(), fallout.message_str(756, 104), 3)
        end
    else
        if fallout.external_var("random_seed_2") then
            fallout.float_msg(fallout.self_obj(), fallout.message_str(756, 102), 2)
        else
            if fallout.external_var("random_seed_1") == 0 then
                fallout.float_msg(fallout.self_obj(), fallout.message_str(756, 100), 4)
            else
                fallout.float_msg(fallout.self_obj(), fallout.message_str(756, 101), 3)
            end
        end
    end
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
return exports
