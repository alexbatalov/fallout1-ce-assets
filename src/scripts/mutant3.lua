local fallout = require("fallout")

local start
local timeforwhat
local supercbt
local superx

local Hostile = 0
local init_teams = 0
local couple_of_minutes = 0

function start()
    if not(init_teams) then
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 34)
        init_teams = 1
    else
        if fallout.script_action() == 22 then
            timeforwhat()
        else
            if fallout.script_action() == 4 then
                Hostile = 1
            else
                if fallout.script_action() == 12 then
                    if Hostile then
                        Hostile = 0
                        fallout.attack_complex(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
                    else
                        if fallout.global_var(13) == 0 then
                            fallout.set_obj_visibility(fallout.self_obj(), 1)
                        else
                            if fallout.local_var(0) ~= 1 then
                                couple_of_minutes = 150 + fallout.random(1, 60)
                                fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(couple_of_minutes), 0)
                            end
                        end
                    end
                else
                    if fallout.script_action() == 18 then
                        fallout.set_global_var(35, fallout.global_var(35) + 1)
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
                    else
                        if fallout.script_action() == 21 then
                            fallout.display_msg(fallout.message_str(232, 100))
                        end
                    end
                end
            end
        end
    end
end

function timeforwhat()
    if fallout.local_var(0) == 1 then
        fallout.animate_move_obj_to_tile(fallout.self_obj(), 16929, 0)
        fallout.set_local_var(0, 0)
    else
        fallout.animate_move_obj_to_tile(fallout.self_obj(), 10917, 0)
        fallout.set_local_var(0, 1)
        fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(40), 0)
    end
end

function supercbt()
    Hostile = 1
end

function superx()
    supercbt()
end

local exports = {}
exports.start = start
return exports
