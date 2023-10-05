local fallout = require("fallout")

local start
local do_dialogue
local zack00
local zack01
local zack02
local zack03
local zack04
local zack05

local HEREBEFORE = 0

function start()
    local v0 = 0
    if fallout.script_action() == 11 then
        do_dialogue()
        detach()
    else
        if fallout.script_action() == 21 then
            fallout.script_overrides()
            fallout.display_msg("You see Zack Barstow, an Initiate of the Childred of the Cathedral.")
            detach()
        else
            if fallout.script_action() == 12 then
                detach()
            else
                if fallout.script_action() == 13 then
                    detach()
                end
            end
        end
    end
end

function do_dialogue()
    fallout.start_gdialog(-1, fallout.self_obj(), 4, -1, -1)
    fallout.sayStart()
    if HEREBEFORE then
        zack05()
    else
        HEREBEFORE = 1
        zack00()
    end
    fallout.sayEnd()
    fallout.end_dialogue()
end

function zack00()
    fallout.sayReply(0, "Welcome to the Children of the Cathedral. How might I help you today?")
    if -fallout.get_critter_stat(fallout.dude_obj(), 4) >= -5 then
        fallout.sayOption("Urrrooo?", zack04)
    end
    if fallout.get_critter_stat(fallout.dude_obj(), 4) >= 14 then
        fallout.sayOption("What is the meaning of the universe?", zack04)
    end
    if fallout.get_critter_stat(fallout.dude_obj(), 4) >= 6 then
        fallout.sayOption("I'm hurt pretty bad. Think you can help me?", zack03)
    end
    if fallout.get_critter_stat(fallout.dude_obj(), 4) >= 10 then
        fallout.sayOption("How do you fix the water pump?", zack02)
    end
    if fallout.get_critter_stat(fallout.dude_obj(), 4) >= 6 then
        fallout.sayOption("Can you tell me something about this place?", zack01)
    end
end

function zack01()
    fallout.sayMessage(0, "I am ill-suited for that. Perhaps if you talk to Laura, she will be willing give you the information you need to know.")
end

function zack02()
    fallout.sayMessage(0, "Oh, fixing water pumps is easy. It's just a flag.")
end

function zack03()
    fallout.sayMessage(0, "I don't have the tools to assist you with that problem. Please talk to one of my superiors.")
end

function zack04()
    fallout.sayMessage(0, "Oh, that. That's just a flag.")
end

function zack05()
    fallout.sayMessage(0, "Please consult with Laura. I have told you all I know.")
end

local exports = {}
exports.start = start
return exports
