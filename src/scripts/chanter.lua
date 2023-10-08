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

local Chant07

function start()
    if Only_Once then
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 20)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 69)
        Only_Once = 0
    end
    if (fallout.script_action() == 21) or (fallout.script_action() == 3) then
        fallout.script_overrides()
        fallout.display_msg(fallout.message_str(398, 100))
    else
        if fallout.script_action() == 12 then
            if Hostile then
                Hostile = 0
                fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
            end
        else
            if fallout.script_action() == 4 then
                Hostile = 1
            else
                if fallout.script_action() == 18 then
                    reputation.inc_good_critter()
                else
                    if fallout.script_action() == 11 then
                        fallout.script_overrides()
                        if fallout.global_var(195) == 1 then
                            fallout.float_msg(fallout.self_obj(), fallout.message_str(398, 101), 0)
                        else
                            fallout.start_gdialog(398, fallout.self_obj(), 4, -1, -1)
                            fallout.gsay_start()
                            Chant01()
                            fallout.gsay_end()
                            fallout.end_dialogue()
                        end
                    end
                end
            end
        end
    end
end

function Chant01()
    fallout.gsay_reply(398, 102)
    fallout.giq_option(7, 398, 103, Chant02, 50)
    fallout.giq_option(4, 398, 104, Chant03, 50)
    fallout.giq_option(4, 398, 105, Chant04, 50)
    if fallout.global_var(194) == 1 then
        fallout.giq_option(4, 398, 106, Chant05, 50)
    end
    if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1)) then
        fallout.giq_option(4, 398, 107, Chant05, 50)
    end
    fallout.giq_option(-3, 398, 108, Chant06, 50)
end

function Chant02()
    fallout.gsay_message(398, 109, 50)
end

function Chant03()
    fallout.gsay_message(398, 110, 50)
end

function Chant04()
    fallout.gsay_message(398, 111, 50)
end

function Chant05()
    fallout.gsay_message(398, 112, 50)
end

function Chant06()
    fallout.gsay_message(398, 113, 49)
end

function ChantEnd()
end

function Combat()
    Hostile = 1
end

function Chant07()
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        fallout.gsay_message(398, 114, 49)
    else
        fallout.gsay_message(398, 115, 49)
    end
end

local exports = {}
exports.start = start
return exports
