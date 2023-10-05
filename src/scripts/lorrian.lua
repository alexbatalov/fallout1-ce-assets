local fallout = require("fallout")

local start
local do_dialogue
local Lorri01
local Lorri02
local Lorri03
local Lorri04
local Lorri05
local Lorri06
local Lorri07
local Lorri08
local Lorri09
local Lorri10
local Lorri11
local Lorri12
local Lorri13
local Lorri14
local Lorri15
local Lorri16
local Lorri17
local Lorri18
local Lorri19
local Lorri20
local Lorri21
local Lorri22
local Lorri23
local Lorri24
local Lorri25
local Lorri26
local Lorri27

local known = 0

function start()
    if fallout.script_action() == 11 then
        do_dialogue()
    else
        if (fallout.script_action() == 21) or (fallout.script_action() == 3) then
            fallout.script_overrides()
            if known then
                fallout.display_msg(fallout.message_str(174, 100))
            else
                fallout.display_msg(fallout.message_str(174, 101))
            end
        else
            if fallout.script_action() == 22 then
                fallout.attack_complex(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
            end
        end
    end
end

function do_dialogue()
    fallout.start_gdialog(174, fallout.self_obj(), 4, -1, -1)
    fallout.sayStart()
    if known then
        Lorri04()
    else
        Lorri01()
    end
    fallout.sayEnd()
    fallout.end_dialogue()
end

function Lorri01()
    fallout.sayReply(0, fallout.message_str(174, 102))
    if fallout.get_critter_stat(fallout.dude_obj(), 4) >= 4 then
        fallout.sayOption(fallout.message_str(174, 103), Lorri02)
    end
    if fallout.get_critter_stat(fallout.dude_obj(), 4) >= 4 then
        fallout.sayOption(fallout.message_str(174, 104) + fallout.proto_data(fallout.obj_pid(fallout.dude_obj()), 1) + fallout.message_str(174, 105), Lorri03)
    end
    if fallout.get_critter_stat(fallout.dude_obj(), 4) >= -3 then
        fallout.sayOption(fallout.message_str(174, 106), Lorri15)
    end
end

function Lorri02()
    fallout.sayReply(0, fallout.message_str(174, 107))
    if not(known) then
        if fallout.get_critter_stat(fallout.dude_obj(), 4) >= 4 then
            fallout.sayOption(fallout.message_str(174, 108), Lorri03)
        end
    end
    if fallout.get_critter_stat(fallout.dude_obj(), 4) >= 4 then
        fallout.sayOption(fallout.message_str(174, 109), Lorri16)
    end
    if fallout.get_critter_stat(fallout.dude_obj(), 4) >= 4 then
        fallout.sayOption(fallout.message_str(174, 110), Lorri20)
    end
    if fallout.get_critter_stat(fallout.dude_obj(), 4) >= 4 then
        fallout.sayOption(fallout.message_str(174, 111), Lorri04)
    end
    if fallout.get_critter_stat(fallout.dude_obj(), 4) >= 4 then
        fallout.sayOption(fallout.message_str(174, 112), Lorri05)
    end
end

function Lorri03()
    known = 1
    fallout.sayReply(0, fallout.message_str(174, 113))
    if fallout.get_critter_stat(fallout.dude_obj(), 4) >= 4 then
        fallout.sayOption(fallout.message_str(174, 114), Lorri02)
    end
    if fallout.get_critter_stat(fallout.dude_obj(), 4) >= 4 then
        fallout.sayOption(fallout.message_str(174, 115), Lorri05)
    end
end

function Lorri04()
    fallout.sayReply(0, fallout.message_str(174, 116))
    if fallout.get_critter_stat(fallout.dude_obj(), 4) >= 4 then
        fallout.sayOption(fallout.message_str(174, 117), Lorri06)
    end
    if fallout.get_critter_stat(fallout.dude_obj(), 4) >= 4 then
        fallout.sayOption(fallout.message_str(174, 118), Lorri07)
    end
    if fallout.get_critter_stat(fallout.dude_obj(), 4) >= 4 then
        fallout.sayOption(fallout.message_str(174, 119), Lorri02)
    end
end

function Lorri05()
    fallout.sayMessage(0, fallout.message_str(174, 120))
end

function Lorri06()
    fallout.sayReply(0, fallout.message_str(174, 121))
    if fallout.get_critter_stat(fallout.dude_obj(), 4) >= 4 then
        fallout.sayOption(fallout.message_str(174, 122), Lorri08)
    end
    if fallout.get_critter_stat(fallout.dude_obj(), 4) >= 4 then
        fallout.sayOption(fallout.message_str(174, 123), Lorri10)
    end
    if fallout.get_critter_stat(fallout.dude_obj(), 4) >= 4 then
        fallout.sayOption(fallout.message_str(174, 124), Lorri02)
    end
    if fallout.get_critter_stat(fallout.dude_obj(), 4) >= 4 then
        fallout.sayOption(fallout.message_str(174, 125), Lorri05)
    end
end

function Lorri07()
    fallout.sayReply(0, fallout.message_str(174, 126))
    if fallout.get_critter_stat(fallout.dude_obj(), 4) >= 4 then
        fallout.sayOption(fallout.message_str(174, 127), Lorri02)
    end
    if fallout.get_critter_stat(fallout.dude_obj(), 4) >= 4 then
        fallout.sayOption(fallout.message_str(174, 128), Lorri05)
    end
end

function Lorri08()
    fallout.sayMessage(0, fallout.message_str(174, 129))
    fallout.sayReply(0, fallout.message_str(174, 130))
    if fallout.get_critter_stat(fallout.dude_obj(), 4) >= 4 then
        fallout.sayOption(fallout.message_str(174, 131), Lorri09)
    end
    if fallout.get_critter_stat(fallout.dude_obj(), 4) >= 4 then
        fallout.sayOption(fallout.message_str(174, 132), Lorri02)
    end
    if fallout.get_critter_stat(fallout.dude_obj(), 4) >= 4 then
        fallout.sayOption(fallout.message_str(174, 133), Lorri05)
    end
end

function Lorri09()
    fallout.sayReply(0, fallout.message_str(174, 134))
    if fallout.get_critter_stat(fallout.dude_obj(), 4) >= 4 then
        fallout.sayOption(fallout.message_str(174, 135), Lorri12)
    end
    if fallout.get_critter_stat(fallout.dude_obj(), 4) >= 4 then
        fallout.sayOption(fallout.message_str(174, 136), Lorri02)
    end
    if fallout.get_critter_stat(fallout.dude_obj(), 4) >= 4 then
        fallout.sayOption(fallout.message_str(174, 137), Lorri05)
    end
end

function Lorri10()
    fallout.sayReply(0, fallout.message_str(174, 138))
    if fallout.get_critter_stat(fallout.dude_obj(), 4) >= 4 then
        fallout.sayOption(fallout.message_str(174, 139), Lorri11)
    end
    if fallout.get_critter_stat(fallout.dude_obj(), 4) >= 4 then
        fallout.sayOption(fallout.message_str(174, 140), Lorri06)
    end
    if fallout.get_critter_stat(fallout.dude_obj(), 4) >= 4 then
        fallout.sayOption(fallout.message_str(174, 141), Lorri02)
    end
    if fallout.get_critter_stat(fallout.dude_obj(), 4) >= 4 then
        fallout.sayOption(fallout.message_str(174, 142), Lorri05)
    end
end

function Lorri11()
    fallout.sayReply(0, fallout.message_str(174, 143))
    if fallout.get_critter_stat(fallout.dude_obj(), 4) >= 4 then
        fallout.sayOption(fallout.message_str(174, 144), Lorri13)
    end
    if fallout.get_critter_stat(fallout.dude_obj(), 4) >= 4 then
        fallout.sayOption(fallout.message_str(174, 145), Lorri14)
    end
    if fallout.get_critter_stat(fallout.dude_obj(), 4) >= 4 then
        fallout.sayOption(fallout.message_str(174, 146), Lorri02)
    end
    if fallout.get_critter_stat(fallout.dude_obj(), 4) >= 4 then
        fallout.sayOption(fallout.message_str(174, 147), Lorri05)
    end
end

function Lorri12()
    fallout.sayMessage(0, fallout.message_str(174, 148))
end

function Lorri13()
    fallout.sayMessage(0, fallout.message_str(174, 149))
end

function Lorri14()
    fallout.sayReply(0, fallout.message_str(174, 150))
    if fallout.get_critter_stat(fallout.dude_obj(), 4) >= 4 then
        fallout.sayOption(fallout.message_str(174, 151), Lorri02)
    end
    if fallout.get_critter_stat(fallout.dude_obj(), 4) >= 4 then
        fallout.sayOption(fallout.message_str(174, 152), Lorri05)
    end
end

function Lorri15()
    fallout.sayMessage(0, fallout.message_str(174, 153))
end

function Lorri16()
    fallout.sayReply(0, fallout.message_str(174, 154))
    if fallout.get_critter_stat(fallout.dude_obj(), 4) >= 4 then
        fallout.sayOption(fallout.message_str(174, 155), Lorri17)
    end
    if fallout.get_critter_stat(fallout.dude_obj(), 4) >= 4 then
        fallout.sayOption(fallout.message_str(174, 156), Lorri05)
    end
end

function Lorri17()
    fallout.sayMessage(0, fallout.message_str(174, 157))
    fallout.sayReply(0, fallout.message_str(174, 158))
    if fallout.get_critter_stat(fallout.dude_obj(), 4) >= 4 then
        fallout.sayOption(fallout.message_str(174, 159), Lorri18)
    end
    if fallout.get_critter_stat(fallout.dude_obj(), 4) >= 4 then
        fallout.sayOption(fallout.message_str(174, 160), Lorri08)
    end
    if fallout.get_critter_stat(fallout.dude_obj(), 4) >= 4 then
        fallout.sayOption(fallout.message_str(174, 161), Lorri19)
    end
    if fallout.get_critter_stat(fallout.dude_obj(), 4) >= 4 then
        fallout.sayOption(fallout.message_str(174, 162), Lorri27)
    end
    if fallout.get_critter_stat(fallout.dude_obj(), 4) >= 4 then
        fallout.sayOption(fallout.message_str(174, 163), Lorri05)
    end
end

function Lorri18()
    fallout.sayReply(0, fallout.message_str(174, 164))
    if fallout.get_critter_stat(fallout.dude_obj(), 4) >= 4 then
        fallout.sayOption(fallout.message_str(174, 165), Lorri02)
    end
    if fallout.get_critter_stat(fallout.dude_obj(), 4) >= 4 then
        fallout.sayOption(fallout.message_str(174, 166), Lorri05)
    end
end

function Lorri19()
    fallout.sayReply(0, fallout.message_str(174, 167))
    if fallout.get_critter_stat(fallout.dude_obj(), 4) >= 4 then
        fallout.sayOption(fallout.message_str(174, 168), Lorri08)
    end
    if fallout.get_critter_stat(fallout.dude_obj(), 4) >= 4 then
        fallout.sayOption(fallout.message_str(174, 169), Lorri02)
    end
    if fallout.get_critter_stat(fallout.dude_obj(), 4) >= 4 then
        fallout.sayOption(fallout.message_str(174, 170), Lorri05)
    end
end

function Lorri20()
    fallout.sayReply(0, fallout.message_str(174, 171))
    if fallout.get_critter_stat(fallout.dude_obj(), 4) >= 4 then
        fallout.sayOption(fallout.message_str(174, 172), Lorri21)
    end
    if fallout.get_critter_stat(fallout.dude_obj(), 4) >= 4 then
        fallout.sayOption(fallout.message_str(174, 173), Lorri22)
    end
    if fallout.get_critter_stat(fallout.dude_obj(), 4) >= 4 then
        fallout.sayOption(fallout.message_str(174, 174), Lorri23)
    end
    if fallout.get_critter_stat(fallout.dude_obj(), 4) >= 4 then
        fallout.sayOption(fallout.message_str(174, 175), Lorri24)
    end
    if fallout.get_critter_stat(fallout.dude_obj(), 4) >= 4 then
        fallout.sayOption(fallout.message_str(174, 176), Lorri25)
    end
    if fallout.get_critter_stat(fallout.dude_obj(), 4) >= 4 then
        fallout.sayOption(fallout.message_str(174, 177), Lorri05)
    end
end

function Lorri21()
    fallout.sayReply(0, fallout.message_str(174, 178))
    Lorri26()
end

function Lorri22()
    fallout.sayReply(0, fallout.message_str(174, 179))
    Lorri26()
end

function Lorri23()
    fallout.sayReply(0, fallout.message_str(174, 180))
    Lorri26()
end

function Lorri24()
    fallout.sayReply(0, fallout.message_str(174, 181))
    Lorri26()
end

function Lorri25()
    fallout.sayReply(0, fallout.message_str(174, 182))
    Lorri26()
end

function Lorri26()
    if fallout.get_critter_stat(fallout.dude_obj(), 4) >= 4 then
        fallout.sayOption(fallout.message_str(174, 183), Lorri20)
    end
    if fallout.get_critter_stat(fallout.dude_obj(), 4) >= 4 then
        fallout.sayOption(fallout.message_str(174, 184), Lorri02)
    end
    if fallout.get_critter_stat(fallout.dude_obj(), 4) >= 4 then
        fallout.sayOption(fallout.message_str(174, 185), Lorri05)
    end
end

function Lorri27()
    fallout.sayMessage(0, fallout.message_str(174, 186))
end

local exports = {}
exports.start = start
return exports
