local fallout = require("fallout")

local start
local spies
local guilt
local talk_p_proc

local Hostile = 0
local init_teams = 0

function start()
    if not(init_teams) then
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 31)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 41)
        init_teams = 1
    end
    if fallout.script_action() == 11 then
        talk_p_proc()
    else
        if (fallout.script_action() == 21) or (fallout.script_action() == 3) then
            fallout.script_overrides()
            fallout.display_msg(fallout.message_str(109, 100))
        else
            if fallout.script_action() == 4 then
                Hostile = 1
            else
                if fallout.script_action() == 12 then
                    if Hostile then
                        Hostile = 0
                        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
                    else
                        if fallout.local_var(0) == 0 then
                            if (fallout.global_var(30) == 1) and (fallout.global_var(31) ~= 2) then
                                if fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) and (fallout.tile_distance_objs(fallout.self_obj(), fallout.dude_obj()) < 5) then
                                    fallout.set_local_var(0, 1)
                                    guilt()
                                end
                            end
                        end
                    end
                else
                    if fallout.script_action() == 18 then
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
                end
            end
        end
    end
end

function spies()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(109, 101), 0)
end

function guilt()
    if fallout.random(0, 1) then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(109, 200), 0)
    else
        fallout.float_msg(fallout.self_obj(), fallout.message_str(109, 201), 0)
    end
end

function talk_p_proc()
    if (fallout.global_var(30) == 1) and (fallout.global_var(31) ~= 2) then
        guilt()
    else
        spies()
    end
end

local exports = {}
exports.start = start
exports.talk_p_proc = talk_p_proc
return exports
