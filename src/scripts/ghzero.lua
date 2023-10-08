local fallout = require("fallout")
local reputation = require("lib.reputation")

local start
local do_dialogue
local ghoulend
local ghoulcbt
local ghoul00

local Hostile = 0
local init_teams = 0

function start()
    if not(init_teams) then
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 30)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 42)
        init_teams = 1
    end
    if fallout.script_action() == 11 then
        do_dialogue()
    else
        if (fallout.script_action() == 21) or (fallout.script_action() == 3) then
            fallout.script_overrides()
            fallout.display_msg(fallout.message_str(75, 100))
        else
            if fallout.script_action() == 4 then
                Hostile = 1
            else
                if fallout.script_action() == 12 then
                    if Hostile then
                        Hostile = 0
                        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
                    end
                else
                    if fallout.script_action() == 18 then
                        reputation.inc_evil_critter()
                    end
                end
            end
        end
    end
end

function do_dialogue()
    fallout.start_gdialog(75, fallout.self_obj(), 4, -1, -1)
    fallout.gsay_start()
    ghoul00()
    fallout.gsay_end()
    fallout.end_dialogue()
end

function ghoulend()
end

function ghoulcbt()
    Hostile = 1
end

function ghoul00()
    fallout.gsay_message(75, 101, 50)
    ghoulend()
end

local exports = {}
exports.start = start
return exports
