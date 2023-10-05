local fallout = require("fallout")

local start
local do_dialogue
local dumar00
local dumar01
local dumar02
local dumar03
local dumar04
local dumar05
local dumar06
local dumar07
local dumarend

local rndx = 0
local HEREBEFORE = 0
local mad = 0

function start()
    local v0 = 0
    if fallout.script_action() == 11 then
        do_dialogue()
        if mad == 1 then
            fallout.attack_complex(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
        end
    else
        if fallout.script_action() == 21 then
            fallout.script_overrides()
            fallout.display_msg("You see Dumar, an Acrolyte of the Children of the Cathedral.")
        else
            if fallout.script_action() == 3 then
                fallout.script_overrides()
                fallout.display_msg("You see Dumar, an Acrolyte of the Children of the Cathedral.")
            else
                if fallout.script_action() == 14 then
                    fallout.display_msg("Dumar pleads with you so cease your vicious attacks.")
                end
            end
        end
    end
end

function do_dialogue()
    fallout.start_gdialog(-1, fallout.self_obj(), 4, -1, -1)
    fallout.sayStart()
    if HEREBEFORE then
        dumar05()
    else
        HEREBEFORE = 1
        dumar00()
    end
    fallout.sayEnd()
    fallout.end_dialogue()
end

function dumar00()
    fallout.sayReply(0, "Greetings traveler. We have heard tales of one who traverses the Wasteland. How might we be of service to you today?")
    if -fallout.get_critter_stat(fallout.dude_obj(), 4) >= -3 then
        fallout.sayOption("Uh? Arrooo?", dumar04)
    end
    if fallout.get_critter_stat(fallout.dude_obj(), 4) >= 6 then
        fallout.sayOption("The Wasteland is a rough place. I have been injured pretty bad. Can you you help me out with that?", dumar03)
    end
    if fallout.get_critter_stat(fallout.dude_obj(), 4) >= 4 then
        fallout.sayOption("I want you and your kinda slaughtered!", dumar06)
    end
    if fallout.get_critter_stat(fallout.dude_obj(), 4) >= 4 then
        fallout.sayOption("Tell me a story.", dumar07)
    end
    if fallout.get_critter_stat(fallout.dude_obj(), 4) >= 4 then
        fallout.sayOption("Huh? Can't hear you. Can you speak up please?", dumar00)
    end
    if fallout.get_critter_stat(fallout.dude_obj(), 4) >= 5 then
        fallout.sayOption("Who might I consult in order to become a member of this establishment?", dumar05)
    end
    if fallout.get_critter_stat(fallout.dude_obj(), 4) >= 6 then
        fallout.sayOption("I wish to comprehend the wisdom upon which you and your fellow followers have based this establishment of beliefs.", dumar02)
    end
end

function dumar01()
    fallout.sayMessage(0, "I'm sorry, but I am a bit too busy at the moment to relate the entire tale of the Children of the Cathedral. They are having me clean off the pews. Talk to Laura if you need information.")
    dumarend()
end

function dumar02()
    fallout.sayMessage(0, "I am sorry, but your words are far to above me to understand what you said. Perhaps our wiser followers, like Laura, might be able to help you better than I.")
    dumarend()
end

function dumar03()
    fallout.sayMessage(0, "I am truly sorry to hear about your ailment. Alas, I am merely an acrolyte and am unable to assist with your healing. Only the full members are granted training in the healing arts. ")
    dumarend()
end

function dumar04()
    fallout.sayMessage(0, "Ah, child, it seems that you and I are speaking at different levels. Maybe if you talk to Laura, she can help you better than I can. Peace with you child.")
    dumarend()
end

function dumar05()
    fallout.sayMessage(0, "Please talk to Laura. She can help you better than I can.")
    dumarend()
end

function dumar06()
    fallout.sayMessage(0, "We are really a peaceful people. Please do not shed blood within this holy place.")
    mad = 1
    dumarend()
end

function dumar07()
    fallout.sayMessage(0, "Once upon a time, there was a little traveller who walked around the world. He walked up to a young lady named Laura and asked her to tell him a story. The end.")
    dumarend()
end

function dumarend()
end

local exports = {}
exports.start = start
return exports
