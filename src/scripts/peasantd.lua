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

local start
local do_dialogue
local go_inside
local weapon_check
local PeasantD00
local PeasantD01
local PeasantD02
local PeasantD03
local PeasantD04

-- ?import? variable hostile
-- ?import? variable armed
-- ?import? variable initialized
-- ?import? variable growling

fallout.create_external_var("smartass")
fallout.create_external_var("smartass2")

function start()
    if not(g2) then
        fallout.set_external_var("smartass", 0)
        fallout.set_external_var("smartass2", 0)
        g2 = 1
    else
        if fallout.script_action() == 11 then
            do_dialogue()
        else
            if fallout.script_action() == 18 then
                reputation.inc_good_critter()
            else
                if (fallout.script_action() == 21) or (fallout.script_action() == 3) then
                    fallout.script_overrides()
                    fallout.display_msg(fallout.message_str(372, 100))
                else
                    if fallout.script_action() == 12 then
                        if fallout.external_var("smartass2") then
                            PeasantD00()
                        end
                        if not(fallout.external_var("dog_is_angry")) then
                            go_inside()
                        end
                    end
                end
            end
        end
    end
end

function do_dialogue()
    weapon_check()
    if fallout.global_var(5) then
        PeasantD02()
    else
        if not(fallout.external_var("dog_is_angry")) then
            PeasantD04()
        else
            if g1 then
                PeasantD01()
            else
                PeasantD03()
            end
        end
    end
end

function go_inside()
    fallout.animate_move_obj_to_tile(fallout.self_obj(), 15484, 0)
end

function weapon_check()
    if (fallout.obj_item_subtype(fallout.critter_inven_obj(fallout.dude_obj(), 1)) == 3) or (fallout.obj_item_subtype(fallout.critter_inven_obj(fallout.dude_obj(), 2)) == 3) then
        g1 = 1
    else
        g1 = 0
    end
end

function PeasantD00()
    local v0 = 0
    local v1 = 0
    v0 = fallout.random(1, 3)
    if v0 == 1 then
        v1 = fallout.message_str(372, 101)
    else
        if v0 == 2 then
            v1 = fallout.message_str(372, 102)
        else
            v1 = fallout.message_str(372, 103)
        end
    end
    fallout.float_msg(fallout.self_obj(), v1, 0)
    fallout.set_external_var("smartass2", 0)
end

function PeasantD01()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(372, 104), 0)
end

function PeasantD02()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(372, 105), 0)
end

function PeasantD03()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(372, 106), 0)
    fallout.set_external_var("smartass", 1)
end

function PeasantD04()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(372, 107), 0)
end

local exports = {}
exports.start = start
return exports
