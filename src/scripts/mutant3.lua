local fallout = require("fallout")
local reputation = require("lib.reputation")

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
                        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
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
                        reputation.inc_evil_critter()
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
