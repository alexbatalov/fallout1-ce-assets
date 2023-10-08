local fallout = require("fallout")
local reputation = require("lib.reputation")

local start
local Chant01
local Chant02
local Chant03
local Chant04
local Chant05
local Chant06
local ChantEnd
local Combat

local Hostile = 0
local Only_Once = 1

function start()
    if Only_Once then
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 20)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 69)
        Only_Once = 0
    end
    if (fallout.script_action() == 21) or (fallout.script_action() == 3) then
        fallout.script_overrides()
        fallout.display_msg(fallout.message_str(396, 100))
    else
        if fallout.script_action() == 18 then
            reputation.inc_good_critter()
        else
            if fallout.script_action() == 4 then
                Hostile = 1
            else
                if fallout.script_action() == 12 then
                    if Hostile then
                        Hostile = 0
                        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
                    end
                end
            end
        end
    end
    if fallout.script_action() == 11 then
        fallout.script_overrides()
        if fallout.global_var(195) == 1 then
            fallout.float_msg(fallout.self_obj(), fallout.message_str(396, 101), 0)
        else
            fallout.start_gdialog(396, fallout.self_obj(), 4, -1, -1)
            fallout.gsay_start()
            Chant01()
            fallout.gsay_end()
            fallout.end_dialogue()
        end
    end
end

function Chant01()
    fallout.gsay_reply(396, 102)
    fallout.giq_option(7, 396, 103, Chant02, 50)
    fallout.giq_option(4, 396, 104, Chant03, 50)
    fallout.giq_option(4, 396, 105, Chant04, 50)
    if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1)) then
        fallout.giq_option(4, 396, 106, Chant05, 50)
    end
    fallout.giq_option(-3, 396, 107, Chant06, 50)
end

function Chant02()
    fallout.gsay_reply(396, 108)
    fallout.gsay_option(396, 113, ChantEnd, 50)
end

function Chant03()
    fallout.gsay_reply(396, 109)
    fallout.gsay_option(396, 113, ChantEnd, 50)
end

function Chant04()
    fallout.gsay_reply(396, 110)
    fallout.gsay_option(396, 113, ChantEnd, 50)
end

function Chant05()
    fallout.gsay_reply(396, 111)
    fallout.gsay_option(396, 113, ChantEnd, 50)
end

function Chant06()
    fallout.gsay_reply(396, 112)
    fallout.gsay_option(396, 113, ChantEnd, 50)
end

function ChantEnd()
end

function Combat()
    Hostile = 1
end

local exports = {}
exports.start = start
return exports
